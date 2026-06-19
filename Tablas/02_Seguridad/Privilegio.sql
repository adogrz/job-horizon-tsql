CREATE TABLE Privilegio
(
    IdPrivilegio INT          NOT NULL IDENTITY (1,1),
    Nombre       VARCHAR(80)  NOT NULL, -- clave usada en @PreAuthorize y JWT
    NombreMenu   VARCHAR(100) NOT NULL, -- texto visible en el menú
    Ruta         VARCHAR(200) NULL,     -- ruta Angular (opcional, para menú dinámico)
    CONSTRAINT PK_Privilegio PRIMARY KEY (IdPrivilegio),
    CONSTRAINT UQ_Privilegio_Nombre UNIQUE (Nombre)
);
GO
