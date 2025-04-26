-- *--------------------------------------------------------------*
-- *   THIS MATERIAL IS LICENSED VISION-C CONSULTING INC. (VCCI)  *
-- *--------------------------------------------------------------*
-- *     DESIGNED BY: Hiram Hubbard                               *
-- *                                                              *
-- *   Specific Name: ITE145UP                                    *
-- *                                                              *
-- *  Procedure Name: USP_UPDATE_ITS145T_ITE145UP                 *
-- *                                                              *
-- * Purpose: USP To log all EXIT Point Connection Information    *
-- * to table ITS145T base on Input Parms pass using Merge Stmt   *
-- *                                                              *
-- ****************************************************************
-- * (C) Copyright VCCI. 2021                                     *
-- * All rights reserved.                                         *
-- *                                                              *
-- * Licensed Materials - Property of VCCI                        *
-- ****************************************************************
-- ****************************************************************
-- *                      Mod ID                                  *
-- *    Date    Initials  Number      Description                 *
-- *  --------  --------  --------    --------------------------- *
--  01/2021     HLH                   Initial Write               *
-- ****************************************************************

CREATE OR REPLACE PROCEDURE  USP_UPDATE_ITS145T_ITE145UP

(IN    i_USERID           CHAR(10),
 IN    i_IP               CHAR(15),
 IN    i_TYPE             CHAR(10),
 INOUT SQL_STATUS         DECIMAL(1,0),
 INOUT SQL_MSGID          DECIMAL(5,0),
 INOUT SQL_MSGTXT         VARCHAR(70))

LANGUAGE SQL
SPECIFIC ITE145UP

CALLED ON NULL INPUT
PROGRAM TYPE SUB

--  ******************************************************************
--  * SQL Compile Options                                            *
--  ******************************************************************
SET OPTION
  COMMIT    = *NONE,
  DYNUSRPRF = *OWNER,
  USRPRF    = *OWNER,
  DATFMT    = *ISO,
  DLYPRP    = *YES,
  CLOSQLCSR = *ENDACTGRP,
  SQLPATH   = *LIBL

--  ******************************************************************
--  * Start of the Program *Main Routine                             *
--  ******************************************************************
BEGIN

--  ******************************************************************
--  * Global Error handling Routine                                  *
--  * Check if any SQL error exist, if so set output parms & return  *
--  ******************************************************************
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
    GET DIAGNOSTICS EXCEPTION 1
         SQL_MSGTXT = MESSAGE_TEXT;
     SET SQL_MSGID  = SQLCODE;
     SET SQL_STATUS = 1;
  END;

--  ******************************************************************
--  * Log All ODBC connection to ITS145T base on input parms         *
--  ******************************************************************

 MERGE INTO ITS145T

    USING TABLE(VALUES(
                       i_USERID,
                       i_IP,
                       CURRENT SERVER,
                       CURRENT_DATE,
                       i_TYPE))

    VIRTUALTABLE(v_UserID,
                 v_IP,
                 v_System,
                 v_Date,
                 v_Type)

      ON (ITEXTUI = v_USERID   AND
          ITEXTIP = v_IP       AND
          ITEXTDB = v_SYSTEM   AND
          ITEXTDT = v_DATE     AND
          ITEXTTY = v_TYPE)

      WHEN MATCHED THEN
        UPDATE SET
          ITEXTCT = ITEXTCT + 1

      WHEN NOT MATCHED THEN

      INSERT(ITEXTUI, ITEXTIP, ITEXTDB,
             ITEXTDT, ITEXTTY, ITEXTCT)

      VALUES(i_UserID, i_IP, CURRENT SERVER, CURRENT_DATE,
             i_TYPE,   1);

END
         