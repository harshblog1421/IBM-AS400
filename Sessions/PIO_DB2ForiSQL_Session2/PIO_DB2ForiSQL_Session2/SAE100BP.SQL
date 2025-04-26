--  ****************************************************************
--  * THIS MATERIAL IS LICENSED BY VISION-C CONSULTING INC (VCCI)  *
--  *--------------------------------------------------------------*
--  *   Specific Name: SAE100BP                                    *
--  *                                                              *
--  *  Procedure Name: USP_SELECT_YTD_SALES_SAE100BP               *
--  *                                                              *
--  *     Designed By: Hiram Hubbard    Date: 10/24/17             *
--  *                  Chief Development Officer                   *
--  *                                                              *
--  * Purpose:  Example Only                                       *
--  *  To Dynamic Select Records base on InPut parms and return    *
--  *              to calling program   (Result set)               *
--  *                                                              *
--  * Licensed Materials - Property of VCCI,  All rights reserved  *
--  ****************************************************************

CREATE OR REPLACE PROCEDURE USP_SELECT_YTD_SALES_SAE100BP

(IN    v_Country_Code             CHAR(3),
 INOUT SQL_STATUS                 DECIMAL(1,0),
 INOUT SQL_MSGID                  DECIMAL(5,0),
 INOUT SQL_MSGTXT                 VARCHAR(70))

DYNAMIC RESULT SET 1
LANGUAGE SQL
SPECIFIC SAE100BP
CALLED ON NULL INPUT
PROGRAM TYPE SUB

--  ******************************************************************
--  * SQL Compile Options                                            *
--  ******************************************************************
SET OPTION
 COMMIT    = *NONE,
 USRPRF    = *OWNER,
 DYNUSRPRF = *OWNER,
 DATFMT    = *ISO,
 DLYPRP    = *YES,
 DBGVIEW   = *SOURCE,
 CLOSQLCSR = *ENDACTGRP,
 SQLPATH   = *LIBL

--  ******************************************************************
--  * Start of the Business Logic                                    *
--  ******************************************************************
BEGIN

 DECLARE DAL_CURSOR scroll cursor for
         SELECT  a.SA_COUNTRY_CODE, c.SA_COUNTRY_NAME, a.SA_SALESMAN_ID,
                 b.SA_SALESMAN_NAME,   a.SA_YTD_SALES_AMOUNT

         FROM SAS100M  a
         JOIN SAS120M  b
         ON   a.SA_SALESMAN_ID = b.SA_SALESMAN_ID

         JOIN SAS130M c
         ON   a.SA_COUNTRY_CODE = c.SA_COUNTRY_CODE

         WHERE a.SA_COUNTRY_CODE = v_Country_Code ;

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
--  * Return Result Set Data to calling Program                      *
--  ******************************************************************
 OPEN DAL_CURSOR ;
 SET RESULT SETS CURSOR DAL_CURSOR;

END        