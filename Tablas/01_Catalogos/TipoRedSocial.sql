CREATE TABLE TipoRedSocial
(
    IdTipoRedSocial INT         NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(50) NOT NULL, -- LINKEDIN | GITHUB | TWITTER | FACEBOOK | OTRO
    Activo          BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoRedSocial PRIMARY KEY (IdTipoRedSocial),
    CONSTRAINT UQ_TipoRedSocial_Nombre UNIQUE (Nombre)
);
GO
