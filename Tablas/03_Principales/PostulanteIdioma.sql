CREATE TABLE PostulanteIdioma
(
    IdUsuario           INT NOT NULL,
    IdIdioma            INT NOT NULL,
    IdNivelLectura      INT NOT NULL,
    IdNivelEscritura    INT NOT NULL,
    IdNivelConversacion INT NOT NULL,
    IdNivelEscucha      INT NOT NULL,
    CONSTRAINT PK_PostulanteIdioma PRIMARY KEY (IdUsuario, IdIdioma),
    CONSTRAINT FK_PostulanteIdioma_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteIdioma_Idioma
        FOREIGN KEY (IdIdioma) REFERENCES Idioma (IdIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelLectura
        FOREIGN KEY (IdNivelLectura) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelEscritura
        FOREIGN KEY (IdNivelEscritura) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelConversacion
        FOREIGN KEY (IdNivelConversacion) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelEscucha
        FOREIGN KEY (IdNivelEscucha) REFERENCES NivelIdioma (IdNivelIdioma)
);
GO
