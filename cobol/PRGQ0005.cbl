       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGQ0005.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUDENT-VSAM-FILE ASSIGN TO '../STUDENT.VSAM'
            FILE STATUS IS FILE-CHECK-KEY
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS STUDENT-VSAM-ID
               ALTERNATE KEY IS STUDENT-VSAM-INSERTDATE
               WITH DUPLICATES.

       DATA DIVISION.
       FILE SECTION.
       FD STUDENT-VSAM-FILE.


       01  STUDENT-VSAM-RECORD.
           88 ENDOFFILE                     VALUE HIGH-VALUE.
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

       WORKING-STORAGE SECTION.



       01  WS-STUDENT-VSAM-RECORD.
           05 WS-STUDENT-VSAM-ID               PIC 9(4).
           05 WS-SEPARATOR1-VSAM               PIC X.
           05 WS-STUDENT-VSAM-NAME             PIC X(27).
           05 WS-SEPARATOR2-VSAM               PIC X.
           05 WS-STUDENT-VSAM-DOB              PIC 9(8).
           05 WS-SEPARATOR3-VSAM               PIC X.
           05 WS-STUDENT-VSAM-COURSE           PIC X(15).
           05 WS-SEPARATOR4-VSAM               PIC X VALUE ','.
           05 WS-VSAM-INSERTDATE               PIC 9(8) VALUE 00000000.
           05 WS-SEPARATOR5-VSAM               PIC X VALUE ','.
           05 WS-VSAM-UPDATEDATE               PIC 9(8) VALUE 00000000.




       01  WS-WORK-AREAS.
           05  FILE-CHECK-KEY      PIC X(2).
           05  WS-STUDENT-COUNT    PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.

       0000-MAIN-PROCEDURE.


           PERFORM 1000-DISPLAY-HEADER.

           OPEN INPUT STUDENT-VSAM-FILE.




           READ STUDENT-VSAM-FILE INTO WS-STUDENT-VSAM-RECORD
               AT END SET ENDOFFILE TO TRUE.

           PERFORM 1100-PROCESS-RECORD UNTIL ENDOFFILE.





           PERFORM 1400-STOP-PROGRAM.

       0000-END.


       1000-DISPLAY-HEADER.
       DISPLAY '------------------------------------------------------'
               '-------------------------------------'
       DISPLAY '                         CLASS REPORT                  '
       DISPLAY '------------------------------------------------------'
               '-------------------------------------'
       DISPLAY 'ID   | STUDENT NAME                |'
                   ' BIRTHDAY | COURSE          |'
               ' INSERT DATE | UPDATE DATE '
       DISPLAY '------------------------------------------------------'
               '-------------------------------------'.

       1000-END.

       1100-PROCESS-RECORD.

           IF ENDOFFILE
               PERFORM 1400-STOP-PROGRAM
           END-IF.







           DISPLAY WS-STUDENT-VSAM-ID
           " | "WS-STUDENT-VSAM-NAME
           " | "WS-STUDENT-VSAM-DOB
           " | "WS-STUDENT-VSAM-COURSE
           " | "WS-VSAM-INSERTDATE
           "    | "WS-VSAM-UPDATEDATE.

           ADD 1 TO WS-STUDENT-COUNT.

           READ STUDENT-VSAM-FILE INTO WS-STUDENT-VSAM-RECORD
               AT END SET ENDOFFILE TO TRUE.






       1100-END.






       1200-DISPLAY-FOOTER.
       DISPLAY '------------------------------------------------------'
               '------------------------------------'
       DISPLAY 'TOTAL STUDENTS : ' WS-STUDENT-COUNT.
       1200-END.

       1400-STOP-PROGRAM.
           PERFORM 1200-DISPLAY-FOOTER.
           CLOSE STUDENT-VSAM-FILE.
           STOP RUN.
       END PROGRAM PRGQ0005.
