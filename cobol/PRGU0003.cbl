      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGU0003.

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

       01  FILE-STATUS      PIC XX.


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
           05  WS-USERCHOICE    PIC 9(4).


       01  UPDATE-HEADER.
           05 FILLER      PIC X VALUE '+'.
           05 FILLER      PIC X VALUE '-'
               OCCURS 38 TIMES.
           05 FILLER      PIC X VALUE '+'.

       01  UPDATE-HEADER2.
           05 FILLER      PIC X VALUE '|'.
           05 FILLER      PIC X(5) VALUE SPACES.
           05 TITRE11      PIC X(14) VALUE ' U P D A T E  '.
           05 TITRE12      PIC X(14) VALUE 'S T U D E N T '.
           05 FILLER      PIC X(5) VALUE SPACES.
           05 FILLER      PIC X VALUE '|'.

       01 OUTPUTLINE.
           05 BLANK-LINE PIC X.


       01 CURRENT-DATE.
           05 CURRENT-YEAR   PIC 9(4).
           05 CURRENT-MONTH  PIC 9(2).
           05 CURRENT-DAY    PIC 9(2).

       PROCEDURE DIVISION.
       0000-MAIN-PROCEDURE.
           OPEN I-O STUDENT-VSAM-FILE.

           PERFORM 1100-DISPLAY-HEADER.
           DISPLAY " INSERT THE 4 DIGIT STUDENT ID >>"

           ACCEPT STUDENT-VSAM-ID.



           READ STUDENT-VSAM-FILE
                KEY IS STUDENT-VSAM-ID
                INVALID KEY DISPLAY "STUDENT NOT FOUND"
           END-READ






           DISPLAY "<---- STUDENT TO BE UPDATED --->".
           PERFORM 1000-DISPLAY-HEADER.
           PERFORM 1200-DISPLAY-RECORD.
           PERFORM 1300-INVITE-AND-PROCESS.



           PERFORM 1400-STOP-PROGRAM.

       0000-END.

       1000-DISPLAY-HEADER.

       DISPLAY '------------------------------------------------------'
               '-------------------------------------'
       DISPLAY 'ID   | STUDENT NAME                |'
                   ' BIRTHDAY | COURSE          |'
               ' INSERT DATE | UPDATE DATE '
       DISPLAY '------------------------------------------------------'
               '-------------------------------------'.








       1000-END.


       1100-DISPLAY-HEADER.

           DISPLAY UPDATE-HEADER.
           DISPLAY OUTPUTLINE.
           DISPLAY UPDATE-HEADER2.
           DISPLAY OUTPUTLINE.
           DISPLAY UPDATE-HEADER.

       1100-END.


       1200-DISPLAY-RECORD.

           MOVE STUDENT-VSAM-RECORD TO WS-STUDENT-VSAM-RECORD.

           DISPLAY WS-STUDENT-VSAM-ID
           " | "WS-STUDENT-VSAM-NAME
           " | "WS-STUDENT-VSAM-DOB
           " | "WS-STUDENT-VSAM-COURSE
           " | "WS-VSAM-INSERTDATE
           "    | "WS-VSAM-UPDATEDATE.
           DISPLAY '-------------------------------------------------'
               '------------------------------------------'.



       1200-END.



       1300-INVITE-AND-PROCESS.


           ACCEPT CURRENT-DATE FROM DATE YYYYMMDD.

           DISPLAY "ENTER NEW FULL NAME (MAX 25 CHARS)>>".

           ACCEPT WS-INPUT-STUDENT-VSAM-NAME.

           DISPLAY "ENTER NEW BIRTHDAY (YYYYMMDD) >>"
           ACCEPT WS-INPUT-STUDENT-VSAM-DOB.

           DISPLAY "ENTER NEW COURSE (MAX 15 CHARS) >> ".
           ACCEPT WS-INPUT-STUDENT-VSAM-COURSE.

           MOVE CURRENT-DATE TO WS-INPUT-UPDATEDATE.


           MOVE STUDENT-VSAM-INSERTDATE TO WS-INPUT-INSERTDATE.
           MOVE STUDENT-VSAM-ID TO WS-INPUT-STUDENT-VSAM-ID.

           MOVE WS-USERINPUT TO STUDENT-VSAM-RECORD.

           REWRITE STUDENT-VSAM-RECORD
                  INVALID KEY
                  DISPLAY "Error updating record with key "
                  WS-INPUT-STUDENT-VSAM-ID
                  NOT INVALID KEY
                  DISPLAY "Record with key "
                  WS-INPUT-STUDENT-VSAM-ID " updated successfully."
                  END-REWRITE.



       1300-END.

       1400-STOP-PROGRAM.

           CLOSE STUDENT-VSAM-FILE.
           STOP RUN.

       END PROGRAM PRGU0003.
