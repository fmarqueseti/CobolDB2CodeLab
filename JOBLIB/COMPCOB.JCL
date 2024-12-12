//EAD703XX JOB 'COMPCOB',CLASS=C,MSGCLASS=X,NOTIFY=&SYSUID
//*************************************************************
//*  JOB UTILIZADO PARA COMPILAR PROGRAMAS COBOL
//*************************************************************
// JCLLIB ORDER=SYS1.GERAL.PROCLIB
//COBCOMP  EXEC DFHCOBLB,LIB1=GR.EAD703,NOME='PROG01',LIB2=GR.GERAL
//LKED.SYSIN    DD   *
  NAME  PROG01(R)
