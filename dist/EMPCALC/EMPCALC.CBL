      *----------------------------------------------------------------
      * EMPCALC.CBL
      * Reads employee hours/rate records and writes a gross-pay
      * report. Hours over 40 are paid at 1.5x the hourly rate.
      *----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. EMPCALC.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMP-FILE ASSIGN TO "EMPIN"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REPORT-FILE ASSIGN TO "EMPOUT"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  EMP-FILE.
           COPY EMPREC.
       FD  REPORT-FILE.
       01  REPORT-RECORD             PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-EOF-FLAG                PIC X VALUE 'N'.
           88  END-OF-FILE                   VALUE 'Y'.
       01  WS-HOURS-WORKED            PIC 9(3)V99.
       01  WS-HOURLY-RATE             PIC 9(3)V99.
       01  WS-GROSS-PAY               PIC 9(5)V99.
       01  WS-REPORT-LINE.
           05  WS-R-NAME              PIC X(20).
           05  FILLER                 PIC X(2)     VALUE SPACES.
           05  WS-R-GROSS             PIC ZZZZ9.99.

       PROCEDURE DIVISION.
       0000-MAIN-PROCESS.
           OPEN INPUT EMP-FILE
           OPEN OUTPUT REPORT-FILE
           PERFORM UNTIL END-OF-FILE
               READ EMP-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       MOVE EMP-HOURS TO WS-HOURS-WORKED
                       MOVE EMP-RATE  TO WS-HOURLY-RATE
                       PERFORM 1000-CALCULATE-GROSS-PAY
                       PERFORM 2000-WRITE-REPORT-LINE
               END-READ
           END-PERFORM
           CLOSE EMP-FILE
           CLOSE REPORT-FILE
           STOP RUN.

       1000-CALCULATE-GROSS-PAY.
           IF WS-HOURS-WORKED > 40
               COMPUTE WS-GROSS-PAY =
                   (40 * WS-HOURLY-RATE) +
                   ((WS-HOURS-WORKED - 40) * WS-HOURLY-RATE * 1.5)
           ELSE
               COMPUTE WS-GROSS-PAY = WS-HOURS-WORKED * WS-HOURLY-RATE
           END-IF.

       2000-WRITE-REPORT-LINE.
           MOVE EMP-NAME     TO WS-R-NAME
           MOVE WS-GROSS-PAY TO WS-R-GROSS
           MOVE WS-REPORT-LINE TO REPORT-RECORD
           WRITE REPORT-RECORD.
