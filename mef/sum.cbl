IDENTIFICATION DIVISION.
PROGRAM-ID. sum_mef.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
  SELECT mef ASSIGN TO './data/mef.txt'
    ORGANIZATION IS LINE SEQUENTIAL.
  SELECT work-mef ASSIGN TO './mef-sorted.tmp'.

DATA DIVISION.
FILE SECTION.
FD mef.
01 f-mer.
  02 f-mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 f-mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 f-mer-amnt PIC 9(12).99.

SD work-mef.
01 w-mer.
  02 w-mer-ssn PIC 9(9).
  02 filler PIC X VALUE " ".
  02 w-mer-year PIC 9(4).
  02 filler PIC X VALUE " ".
  02 w-mer-amnt PIC 9(12).99.

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
01 b-eof PIC A VALUE 'F'.

PROCEDURE DIVISION.

SORT work-mef ON ASCENDING KEY f-mer-ssn
USING mef OUTPUT PROCEDURE REDUCE.

REDUCE.
PERFORM UNTIL b-eof = 'T'
  RETURN work-mef INTO mer
    AT END MOVE 'T' TO b-eof
    NOT AT END
      MOVE mer-amnt TO mer-amnt-dec

      IF is-first='T' THEN
        MOVE mer-ssn TO last-ssn
        MOVE 'F' TO is-first
      END-IF

      IF mer-ssn=last-ssn THEN
        ADD mer-amnt-dec TO total-income
      ELSE
        DISPLAY 'ssn: ' last-ssn ' $' total-income
        MOVE mer-ssn TO last-ssn
        MOVE mer-amnt-dec TO total-income
      END-IF
  END-RETURN
END-PERFORM.

DISPLAY 'ssn: ' last-ssn ' $' total-income

STOP RUN.
