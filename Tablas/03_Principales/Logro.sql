CREATE TABLE Logro
(
    NumLogro    INT          NOT NULL,
    IdUsuario   INT          NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
    Fecha       DATE         NOT NULL,
    CONSTRAINT PK_Logro PRIMARY KEY (NumLogro, IdUsuario),
    CONSTRAINT FK_Logro_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO
