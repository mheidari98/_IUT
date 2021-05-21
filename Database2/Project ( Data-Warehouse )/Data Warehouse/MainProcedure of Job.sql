	USE NorthWindDataWarehouse
	GO

		/****** 
		
				Team Members:  SaraBaradaran, MahdiHeidari, AminEmamJomeh
				Script Date: January 1, 2021
		
		******/


	CREATE PROCEDURE Main_Dw_DailyProcedure
	AS
	BEGIN
		EXEC [NorthWindStorageArea].dbo.Main_SAProcedure 			   -- filling SA
		EXEC [NorthWindDataWarehouse].dbo.Main_DimGeneralLoadProcedure -- filling Dims
		EXEC [NorthWindDataWarehouse].dbo.Main_FactProcedure 		   -- filling Facts
	END
	GO
	CREATE PROCEDURE Main_Dw_FirstLoadProcedure
	AS
	BEGIN
		EXEC [NorthWindStorageArea].dbo.Main_SAProcedure 			   -- filling SA
		EXEC [NorthWindDataWarehouse].dbo.Main_DimFirstLoadProcedure   -- filling Dims
		EXEC [NorthWindDataWarehouse].dbo.Main_FactProcedure 		   -- filling Facts
	END
