CREATE TABLE Empresa
(
    IdUsuario       INT          NOT NULL,
    NombreComercial VARCHAR(150) NOT NULL,
    RazonSocial     VARCHAR(200) NOT NULL,
    Nit             VARCHAR(17)  NOT NULL, -- formato: 0000-000000-000-0
    SitioWeb        VARCHAR(300) NULL,
    Descripcion     VARCHAR(MAX) NULL,
    LogoUrl         VARCHAR(500) NULL,
    IdDistrito      INT          NOT NULL,
    CONSTRAINT PK_Empresa PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Empresa_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Empresa_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT UQ_Empresa_Nit UNIQUE (Nit),
    CONSTRAINT CK_Empresa_Nit
        CHECK (Nit LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]')
);
GO
