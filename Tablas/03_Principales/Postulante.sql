CREATE TABLE Postulante
(
    IdUsuario       INT          NOT NULL,
    Nombres         VARCHAR(100) NOT NULL,
    Apellidos       VARCHAR(100) NOT NULL,
    FechaNacimiento DATE         NOT NULL,
    NumDocumento    VARCHAR(20)  NOT NULL,
    Nup             VARCHAR(20)  NULL,
    Nit             VARCHAR(20)  NULL,
    Direccion       VARCHAR(300) NOT NULL,
    FotoUrl         VARCHAR(500) NULL, -- ruta o URL de la foto
    CvUrl           VARCHAR(500) NULL,
    IdGenero        INT          NOT NULL,
    IdTipoDocumento INT          NOT NULL,
    IdDistrito      INT          NOT NULL,
    CONSTRAINT PK_Postulante PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Postulante_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Postulante_Genero
        FOREIGN KEY (IdGenero) REFERENCES Genero (IdGenero),
    CONSTRAINT FK_Postulante_TipoDocumento
        FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento (IdTipoDocumento),
    CONSTRAINT FK_Postulante_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT CK_Postulante_NumDocumento
        CHECK (
            -- Si es DUI (IdTipoDocumento = 1): formato 00000000-0
            (IdTipoDocumento = 1 AND NumDocumento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')
                -- Si es Pasaporte o Carnet Residente: cualquier valor no vacío de hasta 20 chars
                OR (IdTipoDocumento <> 1 AND LEN(NumDocumento) > 0)
            ),
    CONSTRAINT CK_Postulante_Nup
        CHECK (Nup IS NULL OR (LEN(Nup) = 9 AND Nup NOT LIKE '%[^0-9]%')),
    CONSTRAINT CK_Postulante_Nit
        CHECK (Nit IS NULL OR (
            -- Formato tradicional de NIT: 0000-000000-000-0
            Nit LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]'
                -- Formato unificado moderno con DUI: 00000000-0
                OR Nit LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'
            ))
);
GO
