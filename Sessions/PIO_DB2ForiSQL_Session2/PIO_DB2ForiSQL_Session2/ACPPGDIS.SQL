--    ****************************************************************                              
--    *                                                              *                              
--    *   Specific Name: ACPPGDIS                                  *                                
--    *                                                              *                              
--    *  Procedure Name: USP_ACPPGD_INSERT_ELIGIBILITY               *                              
--    *                                                              *                              
--    *      Programmer: Hiram Hubbard    Date: 05/04/12             *                              
--    *                                                              *                              
--    * Purpose:                                                     *                              
--    *  Insert a new record in table ACPPGD base on InPut parms     *                              
--    *                                                              *                              
--    * Compile:  RUNSQLSTM SRCFILE(*LIBL/RCCLSRC)                   *                              
--    *              SRCMBR(ACPPGDIS)                              *                                
--    *              COMMIT(*NONE)DLYPRP(*YES)                       *                              
--    ****************************************************************                              
                                                                                                    
                                                                                   
CREATE PROCEDURE                                                                                    
                                                                                                    
USP_ACPPGD_INSERT_ELIGIBILITY                                                                       
                                                                                                    
(IN     v_OFFICE                           CHARACTER(3),                                            
IN      v_COUNTRY                          CHARACTER(3),                                            
IN      APPLICATION_NAME                   CHARACTER(30),                                           
IN      v_PAYMENT_PLAN                     INTEGER,                                                 
IN      v_START_DATE                       DATE,                                                    
IN      v_END_DATE                         DATE,                                                    
IN      v_FLAG                             CHARACTER(1),                                            
INOUT   v_PAYMENT_ELIG                     INTEGER,                                                 
INOUT   SQL_STATUS                         DECIMAL(1,0),                                            
INOUT   SQL_MSGID                          DECIMAL(5,0))                                            
                                                                                                    
LANGUAGE SQL                                                                                        
SPECIFIC ACPPGDIS                                                                                   
MODIFIES SQL DATA                                                                                   
                                                                                                    
BEGIN                                                                                               
                                                                                                    
--  ******************************************************************                              
--  * Error handling Routine                                         *                              
--  * Check if any SQL error exist, if so set output parms & return  *                              
--  ******************************************************************                              
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN                                                       
   SET SQL_MSGID  = SQLCODE;                                                                        
   SET SQL_STATUS = 1;                                                                              
  END;                                                                                              
                                                                                                    
--  ******************************************************************                              
--  * Insert a new record If no error exist                          *                              
--  ******************************************************************                              
  INSERT INTO ACPPGD (#RPELI, #ROFCD, #RCYCD, #RPYPI, #RPELS,                                       
                      #RPELE, #RPELF, #RCRDM, #RCRUI, #RCCAI,                                       
                      #RLCDM, #RLCUI, #RLCAI)                                                       
              VALUES (DEFAULT, v_Office, v_Country, v_Payment_Plan,                                 
                      v_Start_Date, v_End_Date, v_Flag, DEFAULT, DEFAULT,                           
                      Application_Name, DEFAULT, DEFAULT, DEFAULT);                                 
                                                                                                    
--  ******************************************************************                              
--  * SQL Function to Retrieve the *Key Identity Column and return it*                              
--  ******************************************************************                              
  VALUES IDENTITY_VAL_LOCAL() INTO v_PAYMENT_ELIG;                                                  
                                                                                                    
--  ******************************************************************                              
--  * Update the last record inserted Last update Columns            *                              
--  ******************************************************************                              
  UPDATE ACPPGD SET  #RLCAI = APPLICATION_NAME                                                      
               WHERE #RPELI = v_PAYMENT_ELIG ;                                                      
                                                                                                    
END;         