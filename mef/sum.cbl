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
01 f_mer.
  02 f_mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 f_mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 f_mer-amnt PIC 9(12).99.

FD sorted-mef.
01 sf_mer.
  02 sf_mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 sf_mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 sf_mer-amnt PIC 9(12).99.

SD work-mef.
01 wo_mer.
  02 wo_mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 wo_mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 wo_mer-amnt PIC 9(12).99.

LOCAL-STORAGE SECTION.
01 mer.
  02 mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 mer-amnt PIC 9(12).99.
01 last-ssn PIC 9(9).
01 mer-amnt-dec PIC 9(12)V99.
01 total-income PIC 9(12)V99 VALUE zero.
01 is-first PIC A VALUE 'T'.
01 b_eof PIC A VALUE 'F'.

PROCEDURE DIVISION.

SORT work-mef ON ASCENDING KEY f_mer-ssn
USING mef GIVING sorted-mef.

OPEN INPUT sorted-mef.
PERFORM UNTIL b_eof = 'T'
  READ sorted-mef INTO mer
    AT END MOVE 'T' TO b_eof
    NOT AT END
      MOVE mer-amnt TO mer-amnt-dec

      IF is-first='T' THEN
        MOVE mer-ssn TO last-ssn
        MOVE 'F' TO is-first
      END-IF

      IF mer-ssn=last-ssn THEN
        ADD mer-amnt-dec TO total-income
      ELSE
        DISPLAY last-ssn
        DISPLAY total-income
        MOVE mer-ssn TO last-ssn
        MOVE mer-amnt-dec TO total-income
      END-IF
  END-READ
END-PERFORM.
CLOSE sorted-mef.

DISPLAY last-ssn
DISPLAY total-income

STOP RUN.
