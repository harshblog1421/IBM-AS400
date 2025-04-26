-- *------------------------------------------------------------------*
-- *   THIS MATERIAL IS LICENSED VCCI                       *
-- *------------------------------------------------------------------*
-- *  DESIGNED BY: Hiram Hubbard                                      *
-- *                                                                  *
-- *        Table: OMV094M.SQL                                        *
-- *                                                                  *
-- *      Purpose: This SQL View contains the summary data for the    *
-- *               Picking Rate Fulfilment Summary KPI Inquiry.       *
-- *                                                                  *
-- ********************************************************************
-- *                      Mod ID                                      *
-- *    Date    Initials  Number      Description                     *
-- *  --------  --------  --------    ------------------------------- *
-- * 04/01/22   HLH                   Initial Write                   *
-- ********************************************************************

  CREATE OR REPLACE VIEW OMS_PICK_RATE_SUMVIEW_OMV094M
   for SYSTEM NAME OMV094M  AS

     WITH PICK_CTE as (

    SELECT DISTINCT omusrid as USER_ID, OMDATE as PICKED_DATE,
      sum(OMPIKQy) as TOTAL_QTY,
      sum(OMPIKCT) as TOTAL_COUNT
    FROM oms094t

    GROUP BY omusrid, OMDATE
    ORDER BY omusrid, OMDATE)

    SELECT USER_ID, PICKED_DATE, UPText as Name,
     cast(substr(cfrdat,1,5) as dec(5,2))as hours,
     cast(TOTAL_QTY as dec(8,0)) as TOTAL_QTY_PICKED,
     cast(TOTAL_COUNT as dec(5,0)) as TOTAL_PICKED_COUNT

    FROM PICK_CTE
    JOIN CFS150M
    ON USER_ID = cfrkey
    LEFT OUTER JOIN PROFILES
    ON USER_ID = UPUPRF

    WHERE cfrcat = 'PWH' and
    cfrkey <> '99999';
                      