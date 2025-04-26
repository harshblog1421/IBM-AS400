-- *------------------------------------------------------------------*
-- *   THIS MATERIAL IS LICENSED VCCI                                 *
-- *------------------------------------------------------------------*
-- *  DESIGNED BY: Hiram Hubbard                                      *
-- *                                                                  *
-- *        Table: OMV094M1.SQL                                       *
-- *                                                                  *
-- *      Purpose: This SQL View contains the Detail data for the     *
-- *               Picking Rate Fulfilment Detail KPI Inquiry.        *
-- *   Training Only                                                  *
-- ********************************************************************
-- *                      Mod ID                                      *
-- *    Date    Initials  Number      Description                     *
-- *  --------  --------  --------    ------------------------------- *
-- * 04/01/22   HLH                   Initial Write                   *
-- ********************************************************************

  CREATE OR REPLACE VIEW OMS_PICK_RATE_DETVIEW_OMV094M1
   for SYSTEM NAME OMV094M1 AS

     SELECT OMWHSCD AS WAREHOUSE_CODE,

       OMCSTCD AS CUSTOMER_CODE,
       OMORDER AS SALES_ORDER,
       OMPONUM AS PO_NUMBER,
       OMUSRID AS USER_ID,
       OMPRDCD AS PRODUCT_CODE,
       OMDATE  AS PICKED_DATE,
       OMPIKQY AS PICKED_QUANTITY,
       OMPIKCT AS PICKED_COUNT,
       OMSTRTS AS START_TIMESTAMP,
       OMFINTS AS FINISH_TIMESTAMP

     FROM OMS094T;
                