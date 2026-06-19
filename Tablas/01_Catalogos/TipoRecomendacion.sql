CREATE TABLE TipoRecomendacion
(
    IdTipoRecomendacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(30) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoRecomendacion PRIMARY KEY (IdTipoRecomendacion)
);
GO
