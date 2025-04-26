--    **************************************************************** 
--    *                                                              * 
--    *       Developer: Hiram Hubbard    Date: 12/29/2020           * 
--    *                                                              * 
--    * Purpose: These are my DB2 admin queries                      * 
--    *                                                              * 
--    **************************************************************** 

-- This query will list all the tables that are candidates to reorg.   
With SYSPSTAT_CTE As

(Select  Row_Number() 
           Over(Partition By a.System_Table_Name, a.System_Table_Schema) RowNbr,
           Current Server  Database,
           a.System_Table_Name Table, a.System_Table_Schema Schema,  
           a.Number_Rows "Total Rows", 
           a.Number_Deleted_Rows  "Total Deleted Rows",
           Int(Round((Dec(a.Number_Deleted_Rows,20,5) * Dec(b.Row_Length,20,5)) / 
           Dec(a.Data_Size,20,5) * 100)) Pct,  
           a.Data_Size / 125000 "Total Size in MB", 
           a.Number_Deleted_Rows * b.Row_Length / 125000 "Estimated Deleted Size in MB",
           IfNull(c.ItJType,'') "Reorg Type", 
           Case When d.MbAccP = 'A' Then 'Arrival' 
                  When d.MbAccP = 'K' Then 'Key' Else '' End "Access Path",
           Case When e.PhCstT = 'R' Then 'Y' Else '' End "Constraint Reference"     
                                         
From SYSPSTAT a
        Join SYStables b On a.System_Table_Name = b.System_Table_Name And
                                    a.System_Table_Schema = b.System_Table_Schema 
        Left Outer Join ItsRgzJob c On a.System_Table_Name = c.ItJFile
                      Join ItDspFD d On a.System_Table_Name = d.MbFile And         
                                                a.System_Table_Schema = d.MbLib 
                      Join ItSCst e On a.System_Table_Name = e.CsFile And                          
                                             a.System_Table_Schema = e.CsLib                                               
                                                
Where a.Number_Rows > 0 And a.Number_Deleted_Rows > 1 And 
         a.System_Table_Schema In (Select ItLib From ITSLIBT))          
          
Select *    
From SYSPSTAT_CTE
Where Pct >= 20 And RowNbr = 1
Order By "Total Deleted Rows" Desc
Fetch First 100 rows only;
