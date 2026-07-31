//EMPCOMP  JOB (ACCTNO),'COMPILE EMPCALC',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID,REGION=0M
//*--------------------------------------------------------------
//* Compile and link-edit EMPCALC on Enterprise Server using the
//* region's production Cobol compiler, so the binary that runs
//* in test/prod matches the one built from this exact commit.
//*--------------------------------------------------------------
//COMPLK   EXEC IGYWCL,
//             PARM.COBOL='LIB,APOST,DYNAM'
//COBOL.SYSLIB  DD DSN=APPL.COBOL.COPYLIB,DISP=SHR
//COBOL.SYSIN   DD DSN=APPL.COBOL.SOURCE(EMPCALC),DISP=SHR
//LKED.SYSLMOD  DD DSN=APPL.LOAD.LIBRARY(EMPCALC),DISP=SHR
