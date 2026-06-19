-- ============================================================
-- 00_CrearBaseDatos.sql
-- Crea la base de datos para el sistema JobHorizon.
-- ============================================================

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'JobHorizonDB')
BEGIN
    ALTER DATABASE JobHorizonDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE JobHorizonDB;
END
GO

CREATE DATABASE JobHorizonDB;
GO

USE JobHorizonDB;
GO
