CREATE TABLE TipoContrato
(
    IdTipoContrato INT         NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(80) NOT NULL, -- TIEMPO_COMPLETO | MEDIO_TIEMPO | TEMPORAL | FREELANCE
    Activo         BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoContrato PRIMARY KEY (IdTipoContrato),
    CONSTRAINT UQ_TipoContrato_Nombre UNIQUE (Nombre)
);
GO
