--    ****************************************************************
--    *                                                              *
--    *   Specific Name: CFE900BP.*SRVPGM                            *
--    *                                                              *
--    *  Procedure Name: UDF_WORKING_DAY_DIFF_CFE900BP               *
--    *                                                              *
--    *       Developer: Hiram Hubbard    Date: 01/18/18             *
--    *                                                              *
--    * Purpose: UDF to get working day different between 2 dates    *
--    *  without saturday and sundays                                *
--    *                                                              *
--    ****************************************************************

CREATE OR REPLACE FUNCTION UDF_WORKING_DAY_DIFF_CFE900BP
(DATE_START DATE, DATE_END DATE)

RETURNS INTEGER
LANGUAGE SQL
DETERMINISTIC
READS SQL DATA
SPECIFIC CFE900BP

--  ******************************************************************
--  * SQL Compile Options                                            *
--  ******************************************************************

SET OPTION
  COMMIT    = *NONE,
  USRPRF    = *OWNER,
  DYNUSRPRF = *OWNER,
  DATFMT    = *ISO,
  DLYPRP    = *YES,
  CLOSQLCSR = *ENDACTGRP

--  ******************************************************************
--  * Start of the Program *Main Routine                             *
--  ******************************************************************

BEGIN

    DECLARE WORKING_DAYS INTEGER DEFAULT 0;
    DECLARE DATE_COUNTER DATE;

--  ******************************************************************
--  * Global Error handling Routine                                  *
--  * Check if any SQL error exist, if so set return  value to -1    *
--  ******************************************************************
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      RETURN -1;

    SET DATE_COUNTER = DATE_START;

--  * Loop thru and get working days only count                      *
    WHILE DAYS(DATE_COUNTER) < DAYS(DATE_END) DO
        SET DATE_COUNTER = DATE(days(DATE_COUNTER)+1);

        CASE WHEN DAYOFWEEK_ISO(DATE_COUNTER) = 6 THEN
            SET WORKING_DAYS = WORKING_DAYS;
        WHEN DAYOFWEEK_ISO(DATE_COUNTER) = 7 THEN
            SET WORKING_DAYS = WORKING_DAYS;
        ELSE
            SET WORKING_DAYS = WORKING_DAYS + 1;
        END CASE;
    END WHILE;

    RETURN WORKING_DAYS;

END
           