IDENTIFICATION DIVISION.
PROGRAM-ID. print_mbf.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT mbf ASSIGN TO './data/mbf.txt'
ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD mbf.
01 f_mbr.
  02 f_mbr-ssn PIC 999999999.
  02 f_mbr-year-month PIC 9(4)9(2).
  02 f_mbr-amnt PIC z(9)9.99.

LOCAL-STORAGE SECTION.
01 mbr.
  02 mbr-ssn PIC 999999999.
  02 mbr-year PIC 9999.
  02 mbr-amnt PIC z(9)9.99.
01 b_eof PIC A(1) VALUE 'F'.

PROCEDURE DIVISION.

OPEN INPUT mbf.

PERFORM UNTIL b_eof = 'T'
  READ mbf INTO mbr
    AT END MOVE 'T' TO b_eof
    NOT AT END DISPLAY mbr
  END-READ
END-PERFORM.

CLOSE mbf.

STOP RUN.
