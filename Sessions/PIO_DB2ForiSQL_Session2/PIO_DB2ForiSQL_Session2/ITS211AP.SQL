--  ******************************************************************
--  *                                                                *
--  *   DDL Script Name: ITS211AP                                    *
--  *                                                                *
--  *   Delevoper: Hiram Hubbard    Date: 07/29/2016                 *
--  *                                                                *
--  * Purpose:                                                       *
--  *                                                                *
--  *  This table is use for IT Security Table                       *
--  *   see IT Production Support                                    *
--  ******************************************************************

CREATE TABLE ITS211AP (

  ITAEMP DECIMAL(10,0) NOT NULL DEFAULT 0,
  ITASSN DECIMAL(9,0) NOT NULL DEFAULT 0,
  ITAENM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',

--  ******************************************************************
--  * Create CDC Columns for change data capture                     *
--  ******************************************************************

 CREATEUSER VARCHAR(20)  ALLOCATE(10) NOT NULL  DEFAULT USER,
 CREATETIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
 CHANGETIME TIMESTAMP NOT NULL
   GENERATED ALWAYS FOR EACH ROW ON UPDATE AS ROW CHANGE TIMESTAMP,

  PRIMARY KEY( ITAEMP ) )

  RCDFMT RIT211AP ;

LABEL ON TABLE ITS211AP
  IS 'IT SUPPORT SECURITY TABLE';

LABEL ON COLUMN ITS211AP
( ITAEMP TEXT IS 'Employee Number',
  ITASSN TEXT IS 'Social Security Number',
  ITAENM TEXT IS 'Employee Name',
  CREATEUSER TEXT IS 'Create User ID',
  CREATETIME TEXT IS 'Create TimeStamp',
  CHANGETIME TEXT IS 'Change TimeStamp');
                                          