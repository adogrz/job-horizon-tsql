CREATE TABLE Usuario
(
    IdUsuario        INT          NOT NULL IDENTITY (1,1),
    Correo           VARCHAR(150) NOT NULL,
    PasswordHash     VARCHAR(255) NOT NULL, -- BCrypt (60-72 chars), VARCHAR(255) por seguridad
    IntentosFallidos TINYINT      NOT NULL DEFAULT 0,
    FechaRegistro    DATETIME2    NOT NULL DEFAULT GETDATE(),
    TokenDesbloqueo  VARCHAR(100) NULL,     -- token temporal para correo de desbloqueo
    FechaTokenExp    DATETIME2    NULL,     -- expiración del token
    IdEstadoUsuario  INT          NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (IdUsuario),
    CONSTRAINT UQ_Usuario_Correo UNIQUE (Correo),
    CONSTRAINT FK_Usuario_Estado
        FOREIGN KEY (IdEstadoUsuario) REFERENCES EstadoUsuario (IdEstadoUsuario),
    CONSTRAINT CK_Usuario_Intentos CHECK (IntentosFallidos >= 0 AND IntentosFallidos <= 10)
);
GO
