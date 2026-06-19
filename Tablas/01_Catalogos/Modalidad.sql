CREATE TABLE Modalidad
(
    IdModalidad INT         NOT NULL IDENTITY (1,1),
    Nombre      VARCHAR(30) NOT NULL, -- ej. PRESENCIAL | REMOTO | HIBRIDO (parametrizable)
    Activo      BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_Modalidad PRIMARY KEY (IdModalidad),
    CONSTRAINT UQ_Modalidad_Nombre UNIQUE (Nombre)
);
GO
