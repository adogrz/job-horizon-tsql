CREATE TABLE PostulanteRedSocial
(
    IdUsuario       INT          NOT NULL,
    IdTipoRedSocial INT          NOT NULL,
    Url             VARCHAR(500) NOT NULL,
    CONSTRAINT PK_PostulanteRedSocial PRIMARY KEY (IdUsuario, IdTipoRedSocial),
    CONSTRAINT FK_PostulanteRedSocial_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteRedSocial_Tipo
        FOREIGN KEY (IdTipoRedSocial) REFERENCES TipoRedSocial (IdTipoRedSocial)
);
GO
