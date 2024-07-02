      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGQ0006.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUDENT-VSAM-FILE ASSIGN TO '../STUDENT.VSAM'
            FILE STATUS IS FILE-CHECK-KEY
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS STUDENT-VSAM-ID
               ALTERNATE KEY IS STUDENT-VSAM-NAME
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



       01  ID-QUERY-HEADER.
           05 FILLER      PIC X VALUE '+'.
           05 FILLER      PIC X VALUE '-'
               OCCURS 46 TIMES.
           05 FILLER      PIC X VALUE '+'.

       01  ID-QUERY-HEADER2.
           05 FILLER      PIC X VALUE '|'.
           05 FILLER      PIC X(4) VALUE SPACES.
           05 TITRE11      PIC X(24) VALUE ' Q U E R Y  S T U D E N '.
           05 TITRE12      PIC X(14) VALUE 'T S  B Y  I D '.
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

           OPEN I-O STUDENT-VSAM-FILE.

           PERFORM 1100-DISPLAY-HEADER.



           PERFORM 1200-INVITE.




           READ STUDENT-VSAM-FILE
                KEY IS STUDENT-VSAM-ID
                INVALID KEY DISPLAY "STUDENT NOT FOUND"
                PERFORM 1400-STOP-PROGRAM

           END-READ.



           PERFORM 1300-DISPLAY-RECORD.



           PERFORM 1400-STOP-PROGRAM.







       0000-END.

       1100-DISPLAY-HEADER.

           DISPLAY ID-QUERY-HEADER.
           DISPLAY OUTPUTLINE.
           DISPLAY ID-QUERY-HEADER2.
           DISPLAY OUTPUTLINE.
           DISPLAY ID-QUERY-HEADER.

       1100-END.


       1200-INVITE.



           DISPLAY "ENTER STUDENT ID (MAX 4 DIGITS) >>".

           ACCEPT STUDENT-VSAM-ID.



       1200-END.


       1300-DISPLAY-RECORD.



       DISPLAY '------------------------------------------------------'
               '-------------------------------------'
       DISPLAY 'ID   | STUDENT NAME                |'
                   ' BIRTHDAY | COURSE          |'
               ' INSERT DATE | UPDATE DATE '
       DISPLAY '------------------------------------------------------'
               '-------------------------------------'.

       MOVE STUDENT-VSAM-RECORD TO WS-STUDENT-VSAM-RECORD.

       DISPLAY WS-STUDENT-VSAM-ID
           " | "WS-STUDENT-VSAM-NAME
           " | "WS-STUDENT-VSAM-DOB
           " | "WS-STUDENT-VSAM-COURSE
           " | "WS-VSAM-INSERTDATE
           "    | "WS-VSAM-UPDATEDATE.
       DISPLAY '-------------------------------------------------'
               '------------------------------------------'.



       1300-END.


       1400-STOP-PROGRAM.

           CLOSE STUDENT-VSAM-FILE.
           STOP RUN.

       END PROGRAM PRGQ0006.
