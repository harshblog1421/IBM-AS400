

-- Trigger program Example Only 

CREATE OR REPLACE TRIGGER YIMTRG01A
    BEFORE UPDATE OF YISTAT ON YIMAST
    REFERENCING NEW AS N OLD AS O
    FOR EACH ROW
    MODE DB2ROW
    PROGRAM NAME YIMTRG01A

  BEGIN

--  *******************************************************************
--  * Call UDF to get the actual calling program name                 *
--  *******************************************************************
    DECLARE @PROGRAM_NAME CHAR(20);
    SET @PROGRAM_NAME                = UDF_CALL_STACK_ENTRY(2,'Y','Y');

--  *******************************************************************
--  * If calling program is '*UNKNOWN' check if client program        *
--  *******************************************************************
    IF @PROGRAM_NAME                 = '*UNKNOWN' THEN
       SET @PROGRAM_NAME             = CURRENT CLIENT_APPLNAME;
    END IF;

--  *******************************************************************
--  * If calling program is *blank set to Qsystem                     *
--  *******************************************************************
    IF @PROGRAM_NAME                 = '      ' THEN
      SET @PROGRAM_NAME              = 'Q_SYSTEM ';
    END IF;

--  Create an YIMAST Audit Status Change record                   *
       INSERT INTO YIMASTAUD ( ALSTAT,
                               ALFILE,
                               ALPRCD,
                               ALLOC,
                               ALWACD,
                               ALOHCD,
                               ALINCR,
                               CREATEPGMR)

              VALUES         ( O.YISTAT,
                               O.YIFILE,
                               O.YIPRCD,
                               O.YILOC,
                               O.YIWACD,
                               O.YIOHCD,
                               O.YIINCR,
                               @PROGRAM_NAME);

  END ;
  