CREATE TABLE UsuarioRol
(
    IdUsuario INT NOT NULL,
    IdRol     INT NOT NULL,
    CONSTRAINT PK_UsuarioRol PRIMARY KEY (IdUsuario, IdRol),
    CONSTRAINT FK_UsuarioRol_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_UsuarioRol_Rol
        FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);
GO
