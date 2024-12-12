//EADXXXXX JOB 'COMPDB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID
//*-------------------------------------------------------------------*
//*      JOB DE EXECUCAO   DE PROGRAMA COBOL COM DB2 BATCH            *
//*-------------------------------------------------------------------*
//EXECDB   EXEC PGM=IKJEFT01,DYNAMNBR=20
//STEPLIB  DD   DSN=DSN810.SDSNLOAD,DISP=SHR
//DBRMLIB  DD   DSN=DSN810.DBRMLIB.DATA,DISP=SHR
//SYSTSPRT DD   SYSOUT=*
//SYSPRINT DD   SYSOUT=*
//*YSOUT   DD   SYSOUT=*
//SYSTSIN  DD   *
  DSN  SYSTEM(DB8G)
  RUN PROGRAM(EADXXXXX) PLAN(EADXXXXX) -
       LIB('GR.GERAL.LOADLIB')
  END
//*************************************************
//*  INCLUIR ABAIXO OS DEMAIS ARQUIVOS DO SEU JOB *
//*************************************************
//SYSIN  DD  *
