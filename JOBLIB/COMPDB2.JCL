//EADXXXXX JOB 'COMPDB2',MSGCLASS=X,CLASS=C,NOTIFY=&SYSUID
//*-------------------------------------------------------------------*
//*      JOB DE COMPILACAO DE PROGRAMA COBOL COM DB2 BATCH            *
//*      NAME = SEU PROGRAMA  -   INSTR = SUA CHAVE
//*-------------------------------------------------------------------*
//         JCLLIB ORDER=GR.GERAL.PROCLIB
//COMPDB2B EXEC DFHCODB2,NAME=EADXXXXX,INSTR=EADXXX
//LKED.SYSIN    DD   *
  NAME EADXXXXX(R)
//*
//BIND.SYSTSIN  DD *
DSN  SYSTEM(DB8G)
BIND PLAN(EADXXXX) MEM(EADXXXX) ACT(REP) ISOLATION(CS) -
       LIB('DSN810.DBRMLIB.DATA')
END
//*
