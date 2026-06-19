CREATE TABLE Recomendacion
(
    NumRecomendacion    INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    NombreContacto      VARCHAR(150) NOT NULL,
    TelefonoContacto    VARCHAR(15)  NOT NULL,
    IdTipoRecomendacion INT          NOT NULL,
    CONSTRAINT PK_Recomendacion PRIMARY KEY (NumRecomendacion, IdUsuario),
    CONSTRAINT FK_Recomendacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Recomendacion_Tipo
        FOREIGN KEY (IdTipoRecomendacion) REFERENCES TipoRecomendacion (IdTipoRecomendacion)
);
GO
