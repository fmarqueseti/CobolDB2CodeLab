      ******************************************************************
      * DATA     : 2024-12-13                                          *
      * AUTOR    : EAD703 - FABIO MARQUES (FMARQUES@FMARQUES.ETI.BR)   *
      * OBJETIVO : INCLUSAO, ALTERACAO E EXCLUSAO DE FUNCIONARIOS (DB2)*
      * CPD      : ESCOLA DE PROGRAMADORES                             *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBFUN04.
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
       77  WK-SALARIO-EDIT         PIC ZZZ.ZZ9,99 VALUE ZEROES.
       77  WK-IDADE-EDIT           PIC ZZZ9       VALUE ZEROES.
       77  WK-SQLCODE-EDIT         PIC -999       VALUE ZEROES.
       77  WK-POSICAO              PIC 99         VALUE ZEROES.
      *
       01  WK-ACCEPT.
           05 WK-FUNCAO-ACCEPT     PIC X          VALUE SPACES.
           05 WK-CODFUN-ACCEPT     PIC X(4)       VALUE SPACES.
           05 WK-NOMEFUN-ACCEPT    PIC X(30)      VALUE SPACES.
           05 WK-SALARIOFUN-ACCEPT PIC 9(6)V99    VALUE ZEROES.
           05 WK-DEPTOFUN-ACCEPT   PIC X(3)       VALUE SPACES.
           05 WK-ADMISSFUN-ACCEPT  PIC X(10)      VALUE SPACES.
           05 WK-IDADEFUN-ACCEPT   PIC 99         VALUE ZEROES.
       77  WK-EMAILFUN-ACCEPT      PIC X(30)      VALUE SPACES.
      *
       PROCEDURE DIVISION.
       000-PRINCIPAL SECTION.
       001-PRINCIPAL.
           PERFORM 101-INICIAR.
           PERFORM 201-PROCESSAR.
           PERFORM 901-FINALIZAR.
           GOBACK.
      ******************************************************************
       100-INICIAR SECTION.
       101-INICIAR.
           ACCEPT WK-ACCEPT          FROM SYSIN.
           ACCEPT WK-ACCEPT          FROM SYSIN.
           ACCEPT WK-EMAILFUN-ACCEPT FROM SYSIN.
      ******************************************************************
       200-PROCESSAR SECTION.
       201-PROCESSAR.
      *
           EVALUATE WK-FUNCAO-ACCEPT
               WHEN 'I'
                   PERFORM 202-INCLUSAO
               WHEN 'E'
                   PERFORM 203-EXCLUSAO
               WHEN 'A'
                   PERFORM 204-ALTERACAO
               WHEN OTHER
                   DISPLAY 'FUNCAO ' WK-FUNCAO-ACCEPT
                           ' INVALIDA'
           END-EVALUATE.
      *
       202-INCLUSAO.
           MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
           MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.
           MOVE WK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.
           MOVE WK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.
           MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.
           MOVE WK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.
           MOVE WK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.
      *
           PERFORM 205-CONTA-NOMEFUN.
           PERFORM 206-CONTA-EMAILFUN.
      *
           EXEC SQL
               INSERT INTO EAD703.FUNCIONARIOS
               VALUES ( :DB2-CODFUN,
                        :DB2-NOMEFUN,
                        :DB2-SALARIOFUN,
                        :DB2-DEPTOFUN,
                        :DB2-ADMISSFUN,
                        :DB2-IDADEFUN,
                        :DB2-EMAILFUN )
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' FOI INCLUIDO'
               WHEN -803
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' JA EXISTE'
               WHEN -530
                   DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA INCLUSAO DE FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      ******************************************************************
      *
       203-EXCLUSAO.
           MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
      *
           EXEC SQL
               DELETE FROM EAD703.FUNCIONARIOS
                   WHERE CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' FOI EXCLUIDO'
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA EXCLUSAO DE FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       204-ALTERACAO.
           MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
           MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.
           MOVE WK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.
           MOVE WK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.
           MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.
           MOVE WK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.
           MOVE WK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.
      *
           MOVE DB2-SALARIOFUN       TO WK-SALARIO-EDIT.
           MOVE DB2-IDADEFUN         TO WK-IDADE-EDIT.
      *
           PERFORM 205-CONTA-NOMEFUN.
           PERFORM 206-CONTA-EMAILFUN.
      *
           IF WK-NOMEFUN-ACCEPT NOT = SPACES
               PERFORM 210-ALTERA-NOME
           END-IF.
      *
           IF WK-SALARIOFUN-ACCEPT IS NUMERIC
               PERFORM 211-ALTERA-SALARIO
           END-IF.
      *
           IF WK-DEPTOFUN-ACCEPT NOT = SPACES
               PERFORM 212-ALTERA-DEPARTAMENTO
           END-IF.
      *
           IF WK-ADMISSFUN-ACCEPT NOT = SPACES
               PERFORM 213-ALTERA-ADMISSAO
           END-IF.
      *
           IF WK-IDADEFUN-ACCEPT IS NUMERIC
               PERFORM 214-ALTERA-IDADE
           END-IF.
      *
           IF WK-EMAILFUN-ACCEPT NOT = SPACES
               PERFORM 215-ALTERA-EMAIL
           END-IF.
      *
       205-CONTA-NOMEFUN.
           MOVE 30 TO DB2-NOMEFUN-LEN.
      *
           PERFORM VARYING WK-POSICAO FROM 30 BY -1
                   UNTIL DB2-NOMEFUN-TEXT(WK-POSICAO:1) NOT = SPACES
               SUBTRACT 1 FROM DB2-NOMEFUN-LEN
           END-PERFORM.
      *
       206-CONTA-EMAILFUN.
           MOVE 30 TO DB2-EMAILFUN-LEN.
      *
           PERFORM VARYING WK-POSICAO FROM 30 BY -1
                   UNTIL DB2-EMAILFUN-TEXT(WK-POSICAO:1) NOT = SPACES
               SUBTRACT 1 FROM DB2-EMAILFUN-LEN
           END-PERFORM.
      *
       210-ALTERA-NOME.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET NOMEFUN = :DB2-NOMEFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'NOME DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADO PARA ' DB2-NOMEFUN-TEXT
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DO NOME DO FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       211-ALTERA-SALARIO.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET SALARIOFUN = :DB2-SALARIOFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'SALARIO DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADO PARA ' WK-SALARIO-EDIT
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DO SALARIO DO FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       212-ALTERA-DEPARTAMENTO.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET DEPTOFUN = :DB2-DEPTOFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE

               WHEN 0
                   DISPLAY 'DEPARTAMENTO DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADO PARA ' DB2-DEPTOFUN
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN -530
                   DISPLAY 'O DEPARTAMENTO ' DB2-DEPTOFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DO DEPARTAMENTO DO'
                           ' FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       213-ALTERA-ADMISSAO.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET ADMISSFUN = :DB2-ADMISSFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'ADMISSAO DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADA PARA ' DB2-ADMISSFUN
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DA ADMISSAO DO'
                           ' FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       214-ALTERA-IDADE.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET IDADEFUN = :DB2-IDADEFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'IDADE DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADA PARA ' WK-IDADE-EDIT
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DA IDADE DO'
                           ' FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
       215-ALTERA-EMAIL.
           EXEC SQL
               UPDATE EAD703.FUNCIONARIOS
                   SET EMAILFUN = :DB2-EMAILFUN
                   WHERE   CODFUN = :DB2-CODFUN
           END-EXEC.
      *
           MOVE SQLCODE TO WK-SQLCODE-EDIT.
      *
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'EMAIL DO FUNCIONARIO ' DB2-CODFUN
                           ' FOI ALTERADA PARA ' DB2-EMAILFUN-TEXT
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                           ' NAO EXISTE'
               WHEN OTHER
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                           ' NA ATUALIZACAO DO EMAIL DO'
                           ' FUNCIONARIO'
                   MOVE 12 TO RETURN-CODE
                   GOBACK
           END-EVALUATE.
      *
      ******************************************************************
       300-LER-FUNCIONARIOS SECTION.
       301-LER-FUNCIONARIOS.
           EXIT.
      ******************************************************************
       900-FINALIZAR SECTION.
       901-FINALIZAR.
           EXIT.
      ******************************************************************
       END PROGRAM COBFUN04.