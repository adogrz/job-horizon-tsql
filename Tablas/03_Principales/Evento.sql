CREATE TABLE Evento
(
    NumEvento           INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    NombreEvento        VARCHAR(200) NOT NULL,
    Lugar               VARCHAR(200) NOT NULL,
    Anfitrion           VARCHAR(200) NOT NULL,
    Fecha               DATE         NOT NULL,
    IdTipoParticipacion INT          NOT NULL,
    IdPais              INT          NOT NULL,
    CONSTRAINT PK_Evento PRIMARY KEY (NumEvento, IdUsuario),
    CONSTRAINT FK_Evento_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Evento_TipoParticipacion
        FOREIGN KEY (IdTipoParticipacion) REFERENCES TipoParticipacion (IdTipoParticipacion),
    CONSTRAINT FK_Evento_Pais
        FOREIGN KEY (IdPais) REFERENCES Pais (IdPais)
);
GO
