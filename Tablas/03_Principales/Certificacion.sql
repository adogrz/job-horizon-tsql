CREATE TABLE Certificacion
(
    CodCert             INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    CodigoCertificacion VARCHAR(100) NULL,
    Nombre              VARCHAR(200) NOT NULL,
    IdTipoCertificacion INT          NOT NULL,
    Institucion         VARCHAR(200) NOT NULL,
    FechaObtencion      DATE         NOT NULL,
    ArchivoUrl          VARCHAR(500) NULL,
    CONSTRAINT PK_Certificacion PRIMARY KEY (CodCert, IdUsuario),
    CONSTRAINT FK_Certificacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Certificacion_Tipo
        FOREIGN KEY (IdTipoCertificacion) REFERENCES TipoCertificacion (IdTipoCertificacion)
);
GO
