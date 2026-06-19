CREATE TABLE NivelEducativo
(
    IdNivelEducativo INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(80) NOT NULL, -- BACHILLERATO | TECNICO | INGENIERIA | LICENCIATURA | MAESTRIA | DOCTORADO
    OrdenComparacion TINYINT     NOT NULL, -- 1=BACHILLERATO, 2=TECNICO, 3=INGENIERIA, 4=LICENCIATURA, 5=MAESTRIA, 6=DOCTORADO
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelEducativo PRIMARY KEY (IdNivelEducativo),
    CONSTRAINT UQ_NivelEducativo_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelEducativo_Orden UNIQUE (OrdenComparacion)
);
GO
