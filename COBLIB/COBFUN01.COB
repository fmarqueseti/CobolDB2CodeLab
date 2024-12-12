      ******************************************************************
      * DATA     : 2024-12-13                                          *
      * AUTOR    : EAD703 - FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)   *
      * OBJETIVO : LER E EXIBIR UM FUNCIONARIO (DB2)                   *
      * CPD      : ESCOLA DE PROGRAMADORES                             *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBFUN01.
       AUTHOR. FABIO MARQUES.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       DATA DIVISION.
       FILE SECTION.
      *
       WORKING-STORAGE SECTION.
           EXEC SQL
               INCLUDE BOOKFUNC
           END-EXEC.
      *
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
      *
       77  WK-SALARIO-EDIT    PIC ZZZ.ZZ9,99 VALUE ZEROES.
       77  WK-IDADE-EDIT      PIC ZZZ9       VALUE ZEROES.
       77  WK-SQLCODE-EDIT    PIC -999       VALUE ZEROES.
       77  WK-ACCEPT-CODFUN   PIC X(4)       VALUE SPACES.
      *
       PROCEDURE DIVISION.
       000-PRINCIPAL SECTION.
       001-PRINCIPAL.
           PERFORM 101-INICIAR.
           IF SQLCODE = 0
               PERFORM 201-PROCESSAR
           END-IF.
           PERFORM 901-FINALIZAR.
           GOBACK.
      ******************************************************************
       100-INICIAR SECTION.
       101-INICIAR.
           ACCEPT WK-ACCEPT-CODFUN FROM SYSIN.
           PERFORM 301-LER-FUNCIONARIOS.
      ******************************************************************
       200-PROCESSAR SECTION.
       201-PROCESSAR.
           MOVE DB2-SALARIOFUN TO WK-SALARIO-EDIT.
           MOVE DB2-IDADEFUN   TO WK-IDADE-EDIT.
      *
           DISPLAY 'CODIGO       : ' DB2-CODFUN.
           DISPLAY 'NOME         : ' DB2-NOMEFUN-TEXT.
           DISPLAY 'SALARIO      : ' WK-SALARIO-EDIT.
           DISPLAY 'DEPARTAMENTO : ' DB2-DEPTOFUN.
           DISPLAY 'ADMISSAO     : ' DB2-ADMISSFUN.
           DISPLAY 'IDADE        : ' WK-IDADE-EDIT.
           DISPLAY 'EMAIL        : ' DB2-EMAILFUN-TEXT.
      ******************************************************************
       300-LER-FUNCIONARIOS SECTION.
       301-LER-FUNCIONARIOS.
           MOVE WK-ACCEPT-CODFUN TO DB2-CODFUN.
      *
           EXEC SQL
               SELECT *
                   INTO :REG-FUNCIONARIOS
                   FROM EAD703.FUNCIONARIOS
                   WHERE  CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   CONTINUE
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN  ' NAO EXISTE.'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NO COMANDO SELECT FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      ******************************************************************
       900-FINALIZAR SECTION.
       901-FINALIZAR.
           EXIT.
      ******************************************************************
       END PROGRAM COBFUN01.
