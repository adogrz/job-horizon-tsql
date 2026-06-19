CREATE TABLE Pais
(
    IdPais INT IDENTITY (1,1) NOT NULL,
    Nombre VARCHAR(100)       NOT NULL,
    Activo BIT                NOT NULL DEFAULT 1,
    CONSTRAINT PK_Pais PRIMARY KEY (IdPais),
    CONSTRAINT UQ_Pais_Nombre UNIQUE (Nombre)
);
GO
