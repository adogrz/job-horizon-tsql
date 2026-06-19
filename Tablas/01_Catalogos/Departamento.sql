CREATE TABLE Departamento
(
    IdDepartamento INT          NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(100) NOT NULL,
    Activo         BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Departamento PRIMARY KEY (IdDepartamento),
    CONSTRAINT UQ_Departamento_Nombre UNIQUE (Nombre)
);
GO
