CREATE TABLE TipoParticipacion
(
    IdTipoParticipacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(30) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoParticipacion PRIMARY KEY (IdTipoParticipacion)
);
GO
