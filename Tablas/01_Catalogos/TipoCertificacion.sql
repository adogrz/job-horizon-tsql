CREATE TABLE TipoCertificacion
(
    IdTipoCertificacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(80) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoCertificacion PRIMARY KEY (IdTipoCertificacion),
    CONSTRAINT UQ_TipoCertificacion_Nombre UNIQUE (Nombre)
);
GO
