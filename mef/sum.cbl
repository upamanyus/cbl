IDENTIFICATION DIVISION.
PROGRAM-ID. sum_mef.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  SELECT mef ASSIGN TO './data/mef.txt'
    ORGANIZATION IS LINE SEQUENTIAL.
  SELECT sorted-mef ASSIGN TO './sorted-mef.txt'
    ORGANIZATION IS LINE SEQUENTIAL.
  SELECT work-mef ASSIGN TO './mef-sorted.tmp'.

DATA DIVISION.
FILE SECTION.
FD mef.
01 f_mbr.
  02 f_mbr-ssn PIC 999999999.
  02 f_mbr-year-month PIC 9(4)9(2).
  02 f_mbr-amnt PIC z(9)9.99.

FD sorted-mef.
01 f_mer.
  02 f_mer-ssn PIC 999999999.
  02 f_mer-year-month PIC 9(4)9(2).
  02 f_mer-amnt PIC z(9)9.99.

SD work-mef.
01 wo_mer.
  02 wo_mer-ssn PIC 999999999.
  02 wo_mer-year-month PIC 9(4)9(2).
  02 wo_mer-amnt PIC z(9)9.99.

LOCAL-STORAGE SECTION.
01 mer.
  02 mer-ssn PIC 999999999.
  02 mer-year PIC 9999.
  02 mer-amnt PIC z(9)9.99.
01 b_eof PIC A(1) VALUE 'F'.

PROCEDURE DIVISION.

SORT work-mef ON ASCENDING KEY f_mer-ssn
USING mef GIVING sorted-mef.
OPEN INPUT sorted-mef.

PERFORM UNTIL b_eof = 'T'
  READ sorted-mef INTO mer
    AT END MOVE 'T' TO b_eof
    NOT AT END DISPLAY mer
  END-READ
END-PERFORM.

CLOSE sorted-mef.

STOP RUN.
