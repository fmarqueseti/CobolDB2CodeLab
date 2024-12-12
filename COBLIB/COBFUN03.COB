      ******************************************************************
      * DATA     : 2024-12-13                                          *
      * AUTOR    : EAD703 - FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)   *
      * OBJETIVO : EXIBIR TODOS (USO DE CURSOR) OS FUNCIONARIOS (DB2)  *
      *            TRATAMENTO PARA EMAIL EM BRANCO                     *
      * CPD      : ESCOLA DE PROGRAMADORES                             *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBFUN02.
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
           EXEC SQL
               DECLARE FUNCTEMP CURSOR FOR
                  SELECT CODFUN,
                         NOMEFUN,
                         SALARIOFUN,
                         DEPTOFUN,
                         ADMISSFUN,
                         IDADEFUN,
                         EMAILFUN

                       FROM EAD703.FUNCIONARIOS
                       ORDER BY CODFUN
           END-EXEC.
      *
       77  WK-INDICATOR-EMAIL PIC S9(4) COMP VALUE ZEROES.
       77  WK-SALARIO-EDIT    PIC ZZZ.ZZ9,99 VALUE ZEROES.
       77  WK-IDADE-EDIT      PIC ZZZ9       VALUE ZEROES.
       77  WK-SQLCODE-EDIT    PIC -999       VALUE ZEROES.
      *
       PROCEDURE DIVISION.
       000-PRINCIPAL SECTION.
       001-PRINCIPAL.
           PERFORM 101-INICIAR.
           PERFORM 201-PROCESSAR UNTIL SQLCODE = 100.
           PERFORM 901-FINALIZAR.
           GOBACK.
      ******************************************************************
       100-INICIAR SECTION.
       101-INICIAR.
           EXEC SQL
               OPEN FUNCTEMP
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT
      *
           EVALUATE SQLCODE
               WHEN 0
                   PERFORM 301-LER-FUNCIONARIOS
               WHEN 100
                   DISPLAY 'FIM DA TABELA'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ABERTURA DO CURSOR'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
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
           DISPLAY '****************************************'.
      *
           PERFORM 301-LER-FUNCIONARIOS.
      ******************************************************************
       300-LER-FUNCIONARIOS SECTION.
       301-LER-FUNCIONARIOS.
           MOVE SPACES TO DB2-NOMEFUN-TEXT DB2-EMAILFUN-TEXT.
      *
           EXEC SQL
               FETCH FUNCTEMP
                   INTO :DB2-CODFUN,
                        :DB2-NOMEFUN,
                        :DB2-SALARIOFUN,
                        :DB2-DEPTOFUN,
                        :DB2-ADMISSFUN,
                        :DB2-IDADEFUN,
                        :DB2-EMAILFUN :WK-INDICATOR-EMAIL
           END-EXEC.
      *
           IF WK-INDICATOR-EMAIL = -1
               MOVE SPACES TO DB2-EMAILFUN-TEXT
           END-IF.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   CONTINUE
               WHEN 100
                   DISPLAY 'FIM DO CURSOR'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NO FETCH DO CURSOR'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      ******************************************************************
       900-FINALIZAR SECTION.
       901-FINALIZAR.
           EXEC SQL
               CLOSE FUNCTEMP
           END-EXEC.
      ******************************************************************
       END PROGRAM COBFUN02.
