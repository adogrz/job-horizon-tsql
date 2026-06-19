CREATE TABLE TokenVerificacion
(
    IdTokenVerificacion INT          NOT NULL IDENTITY(1,1),
    Token               VARCHAR(100) NOT NULL,
    FechaExpiracion     DATETIME2    NOT NULL,
    IdUsuario           INT          NOT NULL,
    CONSTRAINT PK_TokenVerificacion PRIMARY KEY (IdTokenVerificacion),
    CONSTRAINT UQ_TokenVerificacion_Token UNIQUE (Token),
    CONSTRAINT FK_TokenVerificacion_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE
);
GO
