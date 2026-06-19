CREATE TABLE Publicacion
(
    NumPublicacion   INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    Titulo           VARCHAR(300) NOT NULL,
    LugarPublicacion VARCHAR(200) NOT NULL,
    Fecha            DATE         NOT NULL,
    Isbn             VARCHAR(20)  NULL, -- puede ser NULL (artículos sin ISBN)
    Edicion          VARCHAR(100) NULL,
    CONSTRAINT PK_Publicacion PRIMARY KEY (NumPublicacion, IdUsuario),
    CONSTRAINT FK_Publicacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO
