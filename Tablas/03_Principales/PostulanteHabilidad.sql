CREATE TABLE PostulanteHabilidad
(
    IdUsuario        INT NOT NULL,
    IdHabilidad      INT NOT NULL,
    IdNivelHabilidad INT NOT NULL,
    CONSTRAINT PK_PostulanteHabilidad PRIMARY KEY (IdUsuario, IdHabilidad),
    CONSTRAINT FK_PostulanteHabilidad_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteHabilidad_Habilidad
        FOREIGN KEY (IdHabilidad) REFERENCES Habilidad (IdHabilidad),
    CONSTRAINT FK_PostulanteHabilidad_Nivel
        FOREIGN KEY (IdNivelHabilidad) REFERENCES NivelHabilidad (IdNivelHabilidad)
);
GO
