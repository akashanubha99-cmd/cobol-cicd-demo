      *----------------------------------------------------------------
      * EMPREC.CPY
      * Employee input record - 30 bytes, fixed format, no delimiters.
      * Columns:  1-20 name, 21-25 hours (999V99), 26-30 rate (999V99)
      *----------------------------------------------------------------
       01  EMPLOYEE-RECORD.
           05  EMP-NAME              PIC X(20).
           05  EMP-HOURS             PIC 9(3)V99.
           05  EMP-RATE              PIC 9(3)V99.
