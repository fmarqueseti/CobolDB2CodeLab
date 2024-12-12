      ******************************************************************
      * DCLGEN TABLE(EAD703.DEPARTAMENTOS)                             *
      *        LIBRARY(GR.EAD703.BOOKLIB(BOOKDEPT))                    *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(DB2-)                                             *
      *        STRUCTURE(REG-DEPARTAMENTOS)                            *
      *        QUOTE                                                   *
      *        DBCSDELIM(NO)                                           *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE EAD703.DEPARTAMENTOS TABLE
           ( CODDEPTO                       CHAR(3) NOT NULL,
             NOMEDEPTO                      VARCHAR(30) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE EAD703.DEPARTAMENTOS               *
      ******************************************************************
       01  REG-DEPARTAMENTOS.
      *                       CODDEPTO
           10 DB2-CODDEPTO         PIC X(3).
           10 DB2-NOMEDEPTO.
      *                       NOMEDEPTO LENGTH
              49 DB2-NOMEDEPTO-LEN
                 PIC S9(4) USAGE COMP.
      *                       NOMEDEPTO
              49 DB2-NOMEDEPTO-TEXT
                 PIC X(30).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
