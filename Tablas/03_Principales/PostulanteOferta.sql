CREATE TABLE PostulanteOferta
(
    IdUsuario          INT       NOT NULL,
    IdOferta           INT       NOT NULL,
    FechaAplicacion    DATETIME2 NOT NULL DEFAULT GETDATE(),
    IdEstadoAplicacion INT       NOT NULL,
    CONSTRAINT PK_PostulanteOferta PRIMARY KEY (IdUsuario, IdOferta),
    CONSTRAINT FK_PostulanteOferta_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante(IdUsuario)
            ON DELETE NO ACTION,
    CONSTRAINT FK_PostulanteOferta_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo(IdOferta)
            ON DELETE NO ACTION,
    CONSTRAINT FK_PostulanteOferta_Estado
        FOREIGN KEY (IdEstadoAplicacion) REFERENCES EstadoAplicacion (IdEstadoAplicacion)
);
GO
