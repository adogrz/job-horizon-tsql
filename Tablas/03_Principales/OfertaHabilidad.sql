CREATE TABLE OfertaHabilidad
(
    IdOferta         INT NOT NULL,
    IdHabilidad      INT NOT NULL,
    IdNivelHabilidad INT NOT NULL,
    CONSTRAINT PK_OfertaHabilidad PRIMARY KEY (IdOferta, IdHabilidad),
    CONSTRAINT FK_OfertaHabilidad_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo (IdOferta)
            ON DELETE CASCADE,
    CONSTRAINT FK_OfertaHabilidad_Habilidad
        FOREIGN KEY (IdHabilidad) REFERENCES Habilidad (IdHabilidad),
    CONSTRAINT FK_OfertaHabilidad_Nivel
        FOREIGN KEY (IdNivelHabilidad) REFERENCES NivelHabilidad (IdNivelHabilidad)
);
GO
