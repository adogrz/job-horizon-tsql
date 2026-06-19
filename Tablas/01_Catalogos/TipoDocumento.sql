CREATE TABLE TipoDocumento
(
    IdTipoDocumento INT          NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(50)  NOT NULL, -- DUI | PASAPORTE | CARNET_RESIDENTE
    Descripcion     VARCHAR(200) NULL,
    Activo          BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoDocumento PRIMARY KEY (IdTipoDocumento),
    CONSTRAINT UQ_TipoDocumento_Nombre UNIQUE (Nombre)
);
GO
