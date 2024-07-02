      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGI0002.

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

       01  FILE-STATUS   PIC XX.


       01  WS-STUDENT-VSAM-RECORD.
           05 WS-STUDENT-VSAM-ID               PIC 9(4).
           05 WS-SEPARATOR1-VSAM               PIC X.
           05 WS-STUDENT-VSAM-NAME             PIC X(27).
           05 WS-SEPARATOR2-VSAM               PIC X.
           05 WS-STUDENT-VSAM-DOB              PIC 9(8).
           05 WS-SEPARATOR3-VSAM               PIC X.
           05 WS-STUDENT-VSAM-COURSE           PIC X(15).
           05 WS-SEPARATOR4-VSAM               PIC X.
           05 WS-VSAM-INSERTDATE               PIC 9(8).
           05 WS-SEPARATOR5-VSAM               PIC X.
           05 WS-VSAM-UPDATEDATE               PIC 9(8).


       01  WS-USERINPUT.

           05 WS-INPUT-STUDENT-VSAM-ID               PIC 9(4).
           05 WS-SEPARATOR1-VSAM               PIC X VALUE ','.
           05 WS-INPUT-STUDENT-VSAM-NAME             PIC X(27).
           05 WS-SEPARATOR2-VSAM               PIC X VALUE ','.
           05 WS-INPUT-STUDENT-VSAM-DOB              PIC 9(8).
           05 WS-INPUT-SEPARATOR3-VSAM               PIC X VALUE ','.
           05 WS-INPUT-STUDENT-VSAM-COURSE           PIC X(15).
           05 WS-INPUT-SEPARATOR4-VSAM               PIC X VALUE ','.
           05 WS-INPUT-INSERTDATE               PIC 9(8).
           05 WS-INPUT-SEPARATOR5-VSAM               PIC X VALUE ','.
           05 WS-INPUT-UPDATEDATE               PIC 9(8).


       01  WS-WORK-AREAS.
           05  FILE-CHECK-KEY      PIC X(2).
           05  WS-STUDENT-COUNT    PIC 9(4)  VALUE 0.





       01  ADD-HEADER.
           05 FILLER      PIC X VALUE '+'.
           05 FILLER      PIC X VALUE '-'
               OCCURS 38 TIMES.
           05 FILLER      PIC X VALUE '+'.

       01  ADD-HEADER2.
           05 FILLER      PIC X VALUE '|'.
           05 FILLER      PIC X(4) VALUE SPACES.
           05 TITRE11      PIC X(15) VALUE ' A D D  N E W  '.
           05 TITRE12      PIC X(15) VALUE 'S T U D E N T S'.
           05 FILLER      PIC X(4) VALUE SPACES.
           05 FILLER      PIC X VALUE '|'.

       01 OUTPUTLINE.
           05 BLANK-LINE PIC X.


       01 CURRENT-DATE.
           05 CURRENT-YEAR   PIC 9(4).
           05 CURRENT-MONTH  PIC 9(2).
           05 CURRENT-DAY    PIC 9(2).

       PROCEDURE DIVISION.
       0000-MAIN-PROCEDURE.


            PERFORM 1100-DISPLAY-HEADER.


            PERFORM 1200-INVITE.



            OPEN I-O STUDENT-VSAM-FILE.
            READ STUDENT-VSAM-FILE INTO WS-STUDENT-VSAM-RECORD
                AT END SET ENDOFFILE TO TRUE.
            IF FILE-CHECK-KEY="00"
                PERFORM 1300-GET-ID UNTIL ENDOFFILE
                ADD 1 TO WS-STUDENT-COUNT

                PERFORM 1400-INSERTION
            ELSE
                DISPLAY "ERROR WHILE OPENING THE STUDENT.VSAM FILE"

            END-IF.

            PERFORM 1500-STOP-PROGRAM.

       0000-END.




       1100-DISPLAY-HEADER.

           DISPLAY ADD-HEADER.
           DISPLAY OUTPUTLINE.
           DISPLAY ADD-HEADER2.
           DISPLAY OUTPUTLINE.
           DISPLAY ADD-HEADER.

       1100-END.

       1200-INVITE.

           ACCEPT CURRENT-DATE FROM DATE YYYYMMDD.

           DISPLAY "ENTER FULL NAME (MAX 25 CHARS) >>".
           ACCEPT WS-INPUT-STUDENT-VSAM-NAME.

           DISPLAY "ENTER BIRTHDAY (YYYYMMDD) >>"
           ACCEPT WS-INPUT-STUDENT-VSAM-DOB.

           DISPLAY "ENTER COURSE (MAX 15 CHARS) >> ".
           ACCEPT WS-INPUT-STUDENT-VSAM-COURSE.

       1200-END.

       1300-GET-ID.

           ADD 1 TO WS-STUDENT-COUNT



           READ STUDENT-VSAM-FILE INTO WS-STUDENT-VSAM-RECORD
               AT END SET ENDOFFILE TO TRUE.


       1300-END.



       1400-INSERTION.


           MOVE WS-STUDENT-COUNT TO WS-INPUT-STUDENT-VSAM-ID.
           MOVE CURRENT-DATE TO WS-INPUT-INSERTDATE.
           MOVE CURRENT-DATE TO WS-INPUT-UPDATEDATE.


           MOVE WS-INPUT-STUDENT-VSAM-ID TO STUDENT-VSAM-ID.
           MOVE WS-INPUT-STUDENT-VSAM-NAME TO STUDENT-VSAM-NAME.
           MOVE WS-INPUT-STUDENT-VSAM-DOB TO STUDENT-VSAM-DOB.
           MOVE WS-INPUT-STUDENT-VSAM-COURSE TO STUDENT-VSAM-COURSE.
           MOVE WS-INPUT-INSERTDATE TO STUDENT-VSAM-INSERTDATE.
           MOVE WS-INPUT-UPDATEDATE TO STUDENT-VSAM-UPDATEDATE.

           WRITE STUDENT-VSAM-RECORD
               INVALID KEY DISPLAY
                   "VIDEO STATUS = " FILE-CHECK-KEY
           END-WRITE.




       1400-END.


       1500-STOP-PROGRAM.
           CLOSE STUDENT-VSAM-FILE.
           STOP RUN.
       END PROGRAM PRGI0002.
