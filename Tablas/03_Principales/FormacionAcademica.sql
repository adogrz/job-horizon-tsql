CREATE TABLE FormacionAcademica
(
    NumFormacion     INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    Institucion      VARCHAR(200) NOT NULL,
    Titulo           VARCHAR(200) NOT NULL,
    IdNivelEducativo INT          NOT NULL,
    FechaInicio      DATE         NOT NULL,
    FechaFin         DATE         NULL, -- NULL si EnCurso = 1
    EnCurso          BIT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_FormacionAcademica PRIMARY KEY (NumFormacion, IdUsuario),
    CONSTRAINT FK_FormacionAcademica_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_FormacionAcademica_NivelEducativo
        FOREIGN KEY (IdNivelEducativo) REFERENCES NivelEducativo (IdNivelEducativo),
    CONSTRAINT CK_FormacionAcademica_Fechas
        CHECK (FechaFin IS NULL OR FechaFin >= FechaInicio),
    CONSTRAINT CK_FormacionAcademica_EnCurso
        CHECK (EnCurso = 0 OR (EnCurso = 1 AND FechaFin IS NULL))
);
GO
