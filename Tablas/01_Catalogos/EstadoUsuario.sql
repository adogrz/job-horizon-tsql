CREATE TABLE EstadoUsuario
(
    IdEstadoUsuario INT         NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(30) NOT NULL, -- ej. ACTIVO | INACTIVO | BLOQUEADO (parametrizable)
    Activo          BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoUsuario PRIMARY KEY (IdEstadoUsuario),
    CONSTRAINT UQ_EstadoUsuario_Nombre UNIQUE (Nombre)
);
GO
