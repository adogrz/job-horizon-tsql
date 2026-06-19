CREATE TABLE Examen
(
    NumExamen  INT          NOT NULL,
    IdUsuario  INT          NOT NULL,
    Tipo       VARCHAR(100) NOT NULL,
    Resultado  VARCHAR(100) NOT NULL,
    Fecha      DATE         NOT NULL,
    ArchivoUrl VARCHAR(500) NULL,
    CONSTRAINT PK_Examen PRIMARY KEY (NumExamen, IdUsuario),
    CONSTRAINT FK_Examen_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO
