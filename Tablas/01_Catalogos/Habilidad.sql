CREATE TABLE Habilidad
(
    IdHabilidad          INT          NOT NULL IDENTITY (1,1),
    Nombre               VARCHAR(100) NOT NULL,
    Descripcion          VARCHAR(300) NULL,
    IdCategoriaHabilidad INT          NOT NULL,
    Activo               BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Habilidad PRIMARY KEY (IdHabilidad),
    CONSTRAINT FK_Habilidad_Categoria
        FOREIGN KEY (IdCategoriaHabilidad) REFERENCES CategoriaHabilidad (IdCategoriaHabilidad)
);
GO
