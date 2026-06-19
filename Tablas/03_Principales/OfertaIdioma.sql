CREATE TABLE OfertaIdioma
(
    IdOferta      INT NOT NULL,
    IdIdioma      INT NOT NULL,
    IdNivelIdioma INT NOT NULL, -- nivel mínimo requerido
    CONSTRAINT PK_OfertaIdioma PRIMARY KEY (IdOferta, IdIdioma),
    CONSTRAINT FK_OfertaIdioma_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo (IdOferta)
            ON DELETE CASCADE,
    CONSTRAINT FK_OfertaIdioma_Idioma
        FOREIGN KEY (IdIdioma) REFERENCES Idioma (IdIdioma),
    CONSTRAINT FK_OfertaIdioma_Nivel
        FOREIGN KEY (IdNivelIdioma) REFERENCES NivelIdioma (IdNivelIdioma)
);
GO
