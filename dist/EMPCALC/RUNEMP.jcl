//EMPRUN   JOB (ACCTNO),'RUN EMPCALC',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID,REGION=0M
//*--------------------------------------------------------------
//* Execute the EMPCALC load module against the employee input
//* file and produce the gross-pay report.
//*--------------------------------------------------------------
//STEP1    EXEC PGM=EMPCALC
//STEPLIB  DD DSN=APPL.LOAD.LIBRARY,DISP=SHR
//EMPIN    DD DSN=APPL.EMPLOYEE.INPUT,DISP=SHR
//EMPOUT   DD DSN=APPL.EMPLOYEE.REPORT,
//             DISP=(NEW,CATLG,DELETE),
//             SPACE=(TRK,(5,5)),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=0)
//SYSOUT   DD SYSOUT=*
