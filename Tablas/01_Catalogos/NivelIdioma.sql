CREATE TABLE NivelIdioma
(
    IdNivelIdioma    INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(20) NOT NULL,
    OrdenComparacion TINYINT     NOT NULL, -- 1=A1, 2=A2, 3=B1, 4=B2, 5=C1, 6=C2, 7=NATIVO
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelIdioma PRIMARY KEY (IdNivelIdioma),
    CONSTRAINT UQ_NivelIdioma_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelIdioma_Orden UNIQUE (OrdenComparacion)
);
GO
