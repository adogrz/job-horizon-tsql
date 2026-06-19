CREATE TABLE Rol
(
    IdRol       INT          NOT NULL IDENTITY (1,1),
    Nombre      VARCHAR(80)  NOT NULL,
    Descripcion VARCHAR(300) NULL,
    CONSTRAINT PK_Rol PRIMARY KEY (IdRol),
    CONSTRAINT UQ_Rol_Nombre UNIQUE (Nombre)
);
GO
