-- DB2 For i SQL Catalog Training SQL Script 2022

-- SQL Query to get the Procedure information inclinding the Long Name based on Object Name
-- How to find the SQL Inforamtion
SELECT substr(SPECIFIC_SCHEMA,1,10) as LIBRARY,
substr(SPECIFIC_NAME,1,20) as OBJECT_NAME,     
 ROUTINE_NAME as LONG_NAME,               
 IN_PARMS, OUT_PARMS, INOUT_PARMS                                   
FROM qsys2.sysprocs                            
WHERE SPECIFIC_NAME = '?????'; 
             

-- where ????? = the SQL Procedure Object Name    


-- SQL Query to get the SQL Table information inclinding the Long Name based on Object Name
-- How to find the SQL Inforamtion
SELECT SYSTEM_TABLE_SCHEMA, SYSTEM_TABLE_NAME, TABLE_NAME,      
 TABLE_TYPE, COLUMN_COUNT, TABLE_TEXT 
FROM qsys2.systables 
WHERE SYSTEM_TABLE_NAME = '?????'; 

-- where ????? = the SQL Table Object Name                                       


-- SQL Query to get the SQL Function information inclinding the Long Name based on Object Name 
-- How to find the SQL Inforamtion
SELECT substr(SPECIFIC_SCHEMA,1,10) as LIBRARY, 
 substr(SPECIFIC_NAME,1,20) as OBJECT, 
 ROUTINE_NAME as LONG_NAME, SQL_PATH,      
 IN_PARMS, IS_DETERMINISTIC 
FROM qsys2.sysfuncs 
WHERE SPECIFIC_NAME = '?????'  

-- where ????? = the SQL Function Object Name       

-- SQL Query to get SQL View Information
-- How to find the SQL Inforamtion
 SELECT SYSTEM_VIEW_SCHEMA, SYSTEM_VIEW_NAME, TABLE_NAME 
 FROM qsys2.sysviews 
 WHERE SYSTEM_VIEW_NAME = '?????'   


-- where ????? = the SQL View Object Name  

-- SQL Query to get sql external program information 
-- How to find the IBMi Object Infomation
SELECT substr(SPECIFIC_SCHEMA,1,10) as LIBRARY, substr(SPECIFIC_NAME,1,10) as OBJECT,
 ROUTINE_NAME as LONG_NAME, ROUTINE_BODY  as TYPE, 
 EXTERNAL_NAME as IBMi_OBJECT_INFO
FROM qsys2.sysROUTINES 
WHERE SPECIFIC_NAME = '?????'   

-- where ????? = the SQL External Name   