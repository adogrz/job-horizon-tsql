CREATE TABLE Administrador
(
    IdUsuario INT NOT NULL,
    CONSTRAINT PK_Administrador PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Administrador_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE
);
GO
