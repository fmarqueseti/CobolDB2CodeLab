      ******************************************************************
      * DCLGEN TABLE(EAD703.FUNCIONARIOS)                              *
      *        LIBRARY(GR.EAD703.BOOKLIB(BOOKFUNC))                    *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(DB2-)                                             *
      *        STRUCTURE(REG-FUNCIONARIOS)                             *
      *        QUOTE                                                   *
      *        DBCSDELIM(NO)                                           *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE EAD703.FUNCIONARIOS TABLE
           ( CODFUN                         CHAR(4) NOT NULL,
             NOMEFUN                        VARCHAR(30) NOT NULL,
             SALARIOFUN                     DECIMAL(8, 2) NOT NULL,
             DEPTOFUN                       CHAR(3) NOT NULL,
             ADMISSFUN                      DATE NOT NULL,
             IDADEFUN                       SMALLINT NOT NULL,
             EMAILFUN                       VARCHAR(30)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE EAD703.FUNCIONARIOS                *
      ******************************************************************
       01  REG-FUNCIONARIOS.
      *                       CODFUN
           10 DB2-CODFUN           PIC X(4).
           10 DB2-NOMEFUN.
      *                       NOMEFUN LENGTH
              49 DB2-NOMEFUN-LEN   PIC S9(4) USAGE COMP.
      *                       NOMEFUN
              49 DB2-NOMEFUN-TEXT
                 PIC X(30).
      *                       SALARIOFUN
           10 DB2-SALARIOFUN       PIC S9(6)V9(2) USAGE COMP-3.
      *                       DEPTOFUN
           10 DB2-DEPTOFUN         PIC X(3).
      *                       ADMISSFUN
           10 DB2-ADMISSFUN        PIC X(10).
      *                       IDADEFUN
           10 DB2-IDADEFUN         PIC S9(4) USAGE COMP.
           10 DB2-EMAILFUN.
      *                       EMAILFUN LENGTH
              49 DB2-EMAILFUN-LEN
                 PIC S9(4) USAGE COMP.
      *                       EMAILFUN
              49 DB2-EMAILFUN-TEXT
                 PIC X(30).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 7       *
      ******************************************************************
