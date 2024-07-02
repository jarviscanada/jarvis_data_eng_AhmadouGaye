      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGV0001.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
           SELECT STUDENT-SEQ-FILE ASSIGN TO '../STUDENTSEQUENTIAL.txt'
               ORGANISATION IS LINE SEQUENTIAL.
           SELECT STUDENT-VSAM-FILE ASSIGN TO '../STUDENT.VSAM'
           FILE STATUS IS FILE-CHECK-KEY
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS STUDENT-VSAM-ID
               ALTERNATE KEY IS STUDENT-VSAM-INSERTDATE
               WITH DUPLICATES.
       DATA DIVISION.
       FILE SECTION.

       FD STUDENT-VSAM-FILE.
       01  STUDENT-VSAM-HEADER.
           05 ID-VSAM-HEADER                PIC X(2).
           05 SEPARATOR1-VSAM-HEADER        PIC X.
           05 NAME-VSAM-HEADER              PIC X(4).
           05 SEPARATOR2-VSAM-HEADER        PIC X.
           05 DOB-VSAM-HEADER               PIC X(8).
           05 SEPARATOR3-VSAM-HEADER        PIC X.
           05 COURSE-VSAM-HEADER            PIC X(6).

       01  STUDENT-VSAM-RECORD.
           05 STUDENT-VSAM-ID               PIC 9(4).
           05 SEPARATOR1-VSAM               PIC X.
           05 STUDENT-VSAM-NAME             PIC X(27).
           05 SEPARATOR2-VSAM               PIC X.
           05 STUDENT-VSAM-DOB              PIC 9(8).
           05 SEPARATOR3-VSAM               PIC X.
           05 STUDENT-VSAM-COURSE           PIC X(15).
           05 SEPARATOR4-VSAM               PIC X VALUE ','.
           05 STUDENT-VSAM-INSERTDATE       PIC 9(8).
           05 SEPARATOR5-VSAM               PIC X VALUE ','.
           05 STUDENT-VSAM-UPDATEDATE       PIC 9(8).



       FD STUDENT-SEQ-FILE.
       01  STUDENT-SEQUENTIAL-HEADER.
           05 ID-HEADER                PIC X(2).
           05 SEPARATOR1-HEADER        PIC X.
           05 NAME-HEADER              PIC X(4).
           05 SEPARATOR2-HEADER        PIC X.
           05 DOB-HEADER               PIC X(8).
           05 SEPARATOR3-HEADER        PIC X.
           05 COURSE-HEADER            PIC X(6).

       01  STUDENT-SEQUENTIAL-RECORD.
           88 ENDOFFILE                VALUE HIGH-VALUE.
           05 STUDENT-ID               PIC 9(4).
           05 SEPARATOR1               PIC X.
           05 STUDENT-NAME             PIC X(27).
           05 SEPARATOR2               PIC X.
           05 STUDENT-DOB              PIC 9(8).
           05 SEPARATOR3               PIC X.
           05 STUDENT-COURSE           PIC X(15).



       WORKING-STORAGE SECTION.


       01 CURRENT-DATE.
           05 CURRENT-YEAR   PIC 9(4).
           05 CURRENT-MONTH  PIC 9(2).
           05 CURRENT-DAY    PIC 9(2).

       01  WS-WORKING-STORAGE.
           05 ID1       PIC 9(4).
           05 NAMES     PIC X(27).
           05 DOB       PIC 9(8).
           05 COURSE    PIC X(8).
       01  WS-WORK-AREAS.
           05  FILE-CHECK-KEY      PIC X(2).

       01 WS-EOF PIC X VALUE 'N'.


       PROCEDURE DIVISION.
       0000-MAIN-PROCEDURE.
           OPEN INPUT STUDENT-SEQ-FILE.
           OPEN OUTPUT STUDENT-VSAM-FILE.

           READ STUDENT-SEQ-FILE INTO STUDENT-SEQUENTIAL-HEADER.
               PERFORM 1000-PROCESS-HEADER.

           ACCEPT CURRENT-DATE FROM DATE YYYYMMDD.


           MOVE CURRENT-DATE TO STUDENT-VSAM-INSERTDATE.
           MOVE CURRENT-DATE TO STUDENT-VSAM-UPDATEDATE.

           READ STUDENT-SEQ-FILE INTO STUDENT-SEQUENTIAL-RECORD.
               PERFORM 1200-PROCESS-RECORDS UNTIL ENDOFFILE.

           PERFORM 1400-STOP-PROGRAM.



       1000-PROCESS-HEADER.
           MOVE ID-HEADER TO ID-VSAM-HEADER.
           MOVE SEPARATOR1-HEADER TO SEPARATOR1-VSAM-HEADER.
           MOVE NAME-HEADER TO NAME-VSAM-HEADER.
           MOVE SEPARATOR2-HEADER TO SEPARATOR2-VSAM-HEADER.
           MOVE DOB-HEADER TO DOB-VSAM-HEADER.
           MOVE SEPARATOR3-HEADER TO SEPARATOR3-VSAM-HEADER.
           MOVE COURSE-HEADER TO COURSE-VSAM-HEADER.



      *>      WRITE STUDENT-VSAM-HEADER FROM STUDENT-SEQUENTIAL-HEADER
      *>          INVALID KEY DISPLAY
      *>              "VIDEO STATUS = " FILE-CHECK-KEY
      *>      END-WRITE.

       1000-END.

       1200-PROCESS-RECORDS.

           IF ENDOFFILE
               STOP RUN
           END-IF.


           MOVE STUDENT-ID TO STUDENT-VSAM-ID.
           MOVE STUDENT-ID TO ID1.

           MOVE SEPARATOR1 TO SEPARATOR1-VSAM.

           MOVE STUDENT-NAME TO STUDENT-VSAM-NAME.
           MOVE STUDENT-NAME TO NAMES.

           MOVE SEPARATOR2 TO SEPARATOR2-VSAM.

           MOVE STUDENT-DOB TO DOB.
           MOVE STUDENT-DOB TO STUDENT-VSAM-DOB.

           MOVE SEPARATOR3 TO SEPARATOR3-VSAM.

           MOVE STUDENT-COURSE TO STUDENT-VSAM-COURSE.
           MOVE STUDENT-COURSE TO COURSE.

           MOVE SEPARATOR3 TO SEPARATOR3-VSAM.

           MOVE STUDENT-COURSE TO STUDENT-VSAM-COURSE.
           MOVE STUDENT-COURSE TO COURSE.

           MOVE ',' TO SEPARATOR5-VSAM.

           MOVE STUDENT-COURSE TO STUDENT-VSAM-COURSE.
           MOVE STUDENT-COURSE TO COURSE.

           MOVE CURRENT-DATE TO STUDENT-VSAM-INSERTDATE.
           MOVE CURRENT-DATE TO STUDENT-VSAM-UPDATEDATE.


           DISPLAY "ID: "ID1.
           DISPLAY "doB: "DOB.
           DISPLAY "NAME: "NAMES.
           DISPLAY "COURSE: "COURSE.


           WRITE STUDENT-VSAM-RECORD
               INVALID KEY DISPLAY
                   "VIDEO STATUS = " FILE-CHECK-KEY
           END-WRITE.





           READ STUDENT-SEQ-FILE INTO STUDENT-SEQUENTIAL-RECORD
               AT END SET ENDOFFILE TO TRUE.






       1200-END.



       1400-STOP-PROGRAM.

           CLOSE STUDENT-SEQ-FILE, STUDENT-VSAM-FILE.
       END PROGRAM PRGV0001.
