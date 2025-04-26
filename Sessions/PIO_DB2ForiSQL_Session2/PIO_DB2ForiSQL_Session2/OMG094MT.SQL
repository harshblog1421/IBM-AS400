-- *--------------------------------------------------------------*
-- *   THIS MATERIAL IS LICENSED VCCI                             *
-- *--------------------------------------------------------------*
-- *     DESIGNED BY: Hiram Hubbard                               *
-- *                                                              *
-- *   Specific Name: OMG094MT.SQL                                *
-- *                                                              *
-- *    Trigger Name: OM_UPDATE_OMS094AT_OMG094MT                 *
-- *                                                              *
-- * Purpose: This SQL Trigger will evoke each time an Insert or  *
-- * a delete on table DSHPF94. This Trigger will populate the    *
-- * OMS Picking Audit Transaction Table OMS094AT                 *
-- *                                                              *
-- ****************************************************************
-- *                      Mod ID                                  *
-- *    Date    Initials  Number      Description                 *
-- *  --------  --------  --------    --------------------------- *
--  03/12/22    HLH                   Initial Write               *
-- ****************************************************************

CREATE OR REPLACE TRIGGER OM_UPDATE_OMS094AT_OMG094MT
    BEFORE INSERT OR DELETE ON DSHPF94
    REFERENCING NEW AS N OLD AS O
    FOR EACH ROW
    MODE DB2ROW
    PROGRAM NAME OMG094MT

--  ***************************************************************
--  * SQL COMPILE OPTIONS                                         *
--  ***************************************************************

  SET OPTION
    COMMIT    = *CHG,
    USRPRF    = *OWNER,
    DYNUSRPRF = *OWNER,
    SQLPATH   = *LIBL

 BEGIN

--  ***************************************************************
--  * Declare Working Storage variables                           *
--  ***************************************************************

    DECLARE v_WACD        CHAR(3);
    DECLARE v_CUCODE      CHAR(6);
    DECLARE v_ORDNUM      DECIMAL(9,0);
    DECLARE v_USERNAME    CHAR(10);
    DECLARE v_PRODCODE    CHAR(25);
    DECLARE v_PICKQTY     DECIMAL(8,0);
    DECLARE v_PICKTS      TIMESTAMP;
    DECLARE v_INCREMENT   DECIMAL(5,0);

    SET v_WACD        =   N.WACD;
    SET v_CUCODE      =   N.CUCODE;
    SET v_ORDNUM      =   N.ORDNUM;
    SET v_USERNAME    =   N.USERNAME;
    SET v_PRODCODE    =   N.PRODCODE;
    SET v_PICKQTY     =   N.PICKQTY;
    SET v_PICKTS      =   N.PICKTS;
    SET v_INCREMENT   =   N.ORDINCR;

    IF Inserting THEN

  SIGNAL SQLSTATE '75002'
             SET MESSAGE_TEXT = 'Insert NOT Allowed from this *PGM';

-- Evoke SQL Stored Procedure to populate table OMS094AT if Update*
       CALL USP_UPDATE_PICK_AUDIT_OME094UP(
            v_WACD,
            v_CUCODE,
            v_ORDNUM,
            v_USERNAME,
            v_PRODCODE,
            v_PICKQTY,
            v_PICKTS,
            'U',
            v_INCREMENT);

    ELSEIF Deleting THEN
-- Evoke SQL Stored Procedure to update table OMS094AT if Resversal *

    SET v_WACD        =   O.WACD;
    SET v_CUCODE      =   O.CUCODE;
    SET v_ORDNUM      =   O.ORDNUM;
    SET v_USERNAME    =   O.USERNAME;
    SET v_PRODCODE    =   O.PRODCODE;
    SET v_PICKQTY     =   O.PICKQTY;
    SET v_PICKTS      =   O.PICKTS;
    SET v_INCREMENT   =   O.ORDINCR;

       CALL USP_UPDATE_PICK_AUDIT_OME094UP(
            v_WACD,
            v_CUCODE,
            v_ORDNUM,
            v_USERNAME,
            v_PRODCODE,
            v_PICKQTY,
            v_PICKTS,
            'R',
            v_INCREMENT);

  END IF;


 END ;
          