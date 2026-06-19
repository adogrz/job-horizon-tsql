CREATE TABLE CategoriaHabilidad
(
    IdCategoriaHabilidad INT          NOT NULL IDENTITY (1,1),
    Nombre               VARCHAR(100) NOT NULL,
    Descripcion          VARCHAR(300) NULL,
    Activo               BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_CategoriaHabilidad PRIMARY KEY (IdCategoriaHabilidad),
    CONSTRAINT UQ_CategoriaHabilidad_Nombre UNIQUE (Nombre)
);
GO
