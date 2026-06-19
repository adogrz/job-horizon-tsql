CREATE TABLE Distrito
(
    IdDistrito     INT          NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(150) NOT NULL,
    IdDepartamento INT          NOT NULL,
    Activo         BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Distrito PRIMARY KEY (IdDistrito),
    CONSTRAINT FK_Distrito_Departamento
        FOREIGN KEY (IdDepartamento) REFERENCES Departamento (IdDepartamento)
);
GO
