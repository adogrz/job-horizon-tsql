CREATE TABLE Idioma
(
    IdIdioma INT         NOT NULL IDENTITY (1,1),
    Nombre   VARCHAR(80) NOT NULL,
    Activo   BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_Idioma PRIMARY KEY (IdIdioma),
    CONSTRAINT UQ_Idioma_Nombre UNIQUE (Nombre)
);
GO
