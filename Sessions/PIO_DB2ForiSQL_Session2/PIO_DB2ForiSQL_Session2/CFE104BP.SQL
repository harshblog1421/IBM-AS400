--    ****************************************************************
--    *                                                              *
--    *   Specific Name: CFE104BP.SQL                                *
--    *                                                              *
--    *       Developer: HIRAM HUBBARD     Date: 01/24/2020          *
--    *                                                              *
--    * Purpose: Command Feature UDF to Verify Host By Name          *
--    *                                                              *
--    * Mod: 9500.3                                                  *
--    ****************************************************************

Create Or Replace Function UDF_CHECK_HOST_BY_NAME_CFE104BP
 (HostName Char(10))

 Returns Char(1)
 Specific CFE104BP
 Deterministic
 Language RPGLE
 External Name CFR100S(cFCheckHostByName)
 Parameter Style General;                      