-- Query to use Two CTE to get data 

WITH Data1_CTE
AS
(
    select LIBRARY, OBJECT, OBJECTTYPE, OBJECTATTR,
 	   DESCRIPTION, LASTUSEDDATE, NBRDAYSUSED 
from itvobjd        
	where library = 'LIBARAY1'  
	and lastuseddate >= current date - 60 days), 
    
 Data_CTE AS (
 select LIBRARY, OBJECT, OBJECTTYPE, OBJECTATTR,
 	   LASTUSEDDATE, NBRDAYSUSED 
 FROM itvobjd 
 where library = 'LIBRARY2'  
 ) 
 
select a.*, b.*
from DATA1_CTE a
left outer join DAta_cte b

on 
   a. object = b.object  and 
   a. objecttype = b.objecttype
   
   order by a.objecttype, a.object;
STOP;    