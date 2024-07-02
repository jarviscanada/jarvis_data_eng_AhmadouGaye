      ******************************************************************
      * Author: Ahmadou El Bachir Gaye
      * Date: 3/28/2024
      * Purpose: To create a menu to display many options
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGMENU.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.


       01 WS-USERINPUT    PIC 9.

       01 MENU-HEADER.
           05 FILLER      PIC X VALUE '+'.
           05 FILLER      PIC X VALUE '-'
               OCCURS 38 TIMES.
           05 FILLER      PIC X VALUE '+'.

       01 MENU-HEADER2.
           05 FILLER      PIC X VALUE '|'.
           05 FILLER      PIC X(11) VALUE SPACES.
           05 TITRE1      PIC X(16) VALUE 'M A I N  M E N U'.
           05 FILLER      PIC X(11) VALUE SPACES.
           05 FILLER      PIC X VALUE '|'.

       01 MENU-HEADER3.
           05 FILLER      PIC X VALUE '|'.
           05 FILLER      PIC X(15) VALUE SPACES.
           05 TITRE2      PIC X(7) VALUE 'OPTIONS'.
           05 FILLER      PIC X(16) VALUE SPACES.
           05 FILLER      PIC X VALUE '|'.


       01 OUTPUTLINE.
           05 BLANK-LINE PIC X.

       01 OPTION1.
           05 GEN      PIC X(39) VALUE '|    1 - GENERATE VSAM FILE'.
           05 FIN      PIC X VALUE '|'.

       01 OPTION2.

           05 INS      PIC X(39) VALUE '|    2 - INSERT STUDENT DATA'.
           05 FIN      PIC X VALUE '|'.

       01 OPTION3.

           05 UPD      PIC X(39) VALUE '|    3 - UPDATE STUDENT DATA'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION4.
           05 DEL      PIC X(39) VALUE '|    4 - DELETE STUDENT DATA'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION5.

           05 CLS      PIC X(39) VALUE
           '|    5 - CLASS QUERY (ALL STUDENTS)'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION6.
           05 QUS      PIC X(39) VALUE '|    6 - QUERY STUDENT BY ID'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION7.
           05 QUS      PIC X(39) VALUE
           '|    7 - QUERY BY DATE OF INCLUSION'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION8.
           05 QUS      PIC X(39) VALUE
           '|    8 - REPORT FILE WITH DATE BREAK'.
           05 FIN      PIC X VALUE '|'.
       01 OPTION9.
           05 EX       PIC X(39) VALUE '|    9 - EXIT'.
           05 FIN      PIC X VALUE '|'.









       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY MENU-HEADER.
            DISPLAY OUTPUTLINE.
            DISPLAY MENU-HEADER2.
            DISPLAY OUTPUTLINE.
            DISPLAY MENU-HEADER.
            DISPLAY OUTPUTLINE.
            DISPLAY MENU-HEADER3.
            DISPLAY OUTPUTLINE.
            DISPLAY MENU-HEADER.
            DISPLAY OPTION1.
            DISPLAY OPTION2.
            DISPLAY OPTION3.
            DISPLAY OPTION4.
            DISPLAY OPTION5.
            DISPLAY OPTION6.
            DISPLAY OPTION7.
            DISPLAY OPTION8.
            DISPLAY OPTION9.
            DISPLAY OUTPUTLINE.
            DISPLAY MENU-HEADER.
            DISPLAY " CHOSE YOUR OPTION (1 TO 9) >>"
            ACCEPT WS-USERINPUT.
            STOP RUN.
       END PROGRAM PRGMENU.
