CREATE TABLE PostulanteTelefono
(
    IdUsuario INT         NOT NULL,
    Telefono  VARCHAR(15) NOT NULL,
    CONSTRAINT PK_PostulanteTelefono PRIMARY KEY (IdUsuario, Telefono),
    CONSTRAINT FK_PostulanteTelefono_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_PostulanteTelefono_Formato
        CHECK (Telefono LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO
