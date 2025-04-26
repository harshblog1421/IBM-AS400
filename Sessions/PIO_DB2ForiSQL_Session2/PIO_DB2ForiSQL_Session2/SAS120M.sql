-- *------------------------------------------------------------------*
-- *   THIS MATERIAL IS LICENSED VISION-C CONSULTING INC. (VCCI)      *
-- *------------------------------------------------------------------*
-- *  DESIGNED BY: Hiram Hubbard                                      *
-- *                                                                  *
-- *        Table: SAS120M.SQL                                        *
-- *                                                                  *
-- *      Purpose: SA - Sales Analysis Salesman Master Table          *
-- *               Example Only                                       *
-- *  Licensed Materials - Property of VCCI,  All rights reserved     *
-- ********************************************************************
-- *                      Mod ID                                      *
-- *    Date    Initials  Number      Description                     *
-- *  --------  --------  --------    ------------------------------- *
-- * 01/2017    HLH                   Initial Write                   *
-- ********************************************************************

CREATE TABLE SA_SALESMAN_MASTER_SAS120M

     FOR SYSTEM NAME SAS120M (

  SA_SALESMAN_ID   FOR COLUMN SASALMID DECIMAL(4,0) NOT NULL DEFAULT 0,
  SA_SALESMAN_NAME FOR COLUMN SASALNM  CHAR(30) NOT NULL DEFAULT ' ',

--  *******************************************************************
--  * CREATE CDC COLUMNS FOR CHANGE DATA CAPTURE                      *
--  *******************************************************************
    CREATEUSER VARCHAR(20) ALLOCATE(10) NOT NULL DEFAULT USER,
    CREATETIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHANGEJOB  VARCHAR(28) CCSID 37 GENERATED ALWAYS AS (QSYS2.JOB_NAME),
    CHANGEUSER VARCHAR(18) CCSID 37 GENERATED ALWAYS AS (USER),
    CHANGETIME TIMESTAMP NOT NULL
     GENERATED ALWAYS FOR EACH ROW ON UPDATE AS ROW CHANGE TIMESTAMP,

--  ******************************************************************
--  * PRIMARY KEY                                                    *
--  ******************************************************************
  CONSTRAINT SA_SAS120M_PK PRIMARY KEY
    (SA_SALESMAN_ID))

 RCDFMT SAR120M;

 LABEL ON TABLE SA_SALESMAN_MASTER_SAS120M
   IS 'Sales Analysis Saleman Master Table';

 LABEL ON COLUMN SA_SALESMAN_MASTER_SAS120M
  (SA_SALESMAN_ID    TEXT IS 'Salesman ID',
   SA_SALESMAN_NAME  TEXT IS 'Salesman Name',
   CREATEUSER TEXT IS 'CREATE USER ID',
   CREATETIME TEXT IS 'CREATE TIMESTAMP',
   CHANGEJOB  TEXT IS 'CHANGE JOB',
   CHANGEUSER TEXT IS 'CHANGE USER',
   CHANGETIME TEXT IS 'CHANGE TIMESTAMP');
                                              