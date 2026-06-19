CREATE TABLE OfertaTrabajo
(
    IdOferta               INT            NOT NULL IDENTITY (1,1),
    Titulo                 VARCHAR(200)   NOT NULL,
    Descripcion            VARCHAR(MAX)   NOT NULL,
    SalarioMin             DECIMAL(10, 2) NULL,
    SalarioMax             DECIMAL(10, 2) NULL,
    NumVacantes            SMALLINT       NOT NULL DEFAULT 1,
    AniosExperienciaMinima SMALLINT       NOT NULL DEFAULT 0, -- años mínimos de experiencia
    FechaPublicacion       DATETIME2      NOT NULL DEFAULT GETDATE(),
    FechaVencimiento       DATE           NOT NULL,
    IdEmpresa              INT            NOT NULL,
    IdTipoContrato         INT            NOT NULL,
    IdNivelEducativo       INT            NOT NULL,
    IdModalidad            INT            NOT NULL,
    IdEstadoOferta         INT            NOT NULL,
    IdDistrito             INT            NOT NULL,
    PesoHabilidades        DECIMAL(5, 2)  NOT NULL DEFAULT 0.35,
    PesoAcademico          DECIMAL(5, 2)  NOT NULL DEFAULT 0.25,
    PesoExperiencia        DECIMAL(5, 2)  NOT NULL DEFAULT 0.20,
    PesoIdiomas            DECIMAL(5, 2)  NOT NULL DEFAULT 0.20,
    CONSTRAINT PK_OfertaTrabajo PRIMARY KEY (IdOferta),
    CONSTRAINT FK_OfertaTrabajo_Empresa
        FOREIGN KEY (IdEmpresa) REFERENCES Empresa (IdUsuario)
            ON DELETE CASCADE,                                -- eliminar empresa elimina sus ofertas
    CONSTRAINT FK_OfertaTrabajo_TipoContrato
        FOREIGN KEY (IdTipoContrato) REFERENCES TipoContrato (IdTipoContrato),
    CONSTRAINT FK_OfertaTrabajo_NivelEducativo
        FOREIGN KEY (IdNivelEducativo) REFERENCES NivelEducativo (IdNivelEducativo),
    CONSTRAINT FK_OfertaTrabajo_Modalidad
        FOREIGN KEY (IdModalidad) REFERENCES Modalidad (IdModalidad),
    CONSTRAINT FK_OfertaTrabajo_EstadoOferta
        FOREIGN KEY (IdEstadoOferta) REFERENCES EstadoOferta (IdEstadoOferta),
    CONSTRAINT FK_OfertaTrabajo_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT CK_OfertaTrabajo_Salario
        CHECK (SalarioMin IS NULL OR SalarioMax IS NULL OR SalarioMax >= SalarioMin),
    CONSTRAINT CK_OfertaTrabajo_Vacantes
        CHECK (NumVacantes >= 1),
    CONSTRAINT CK_OfertaTrabajo_Experiencia
        CHECK (AniosExperienciaMinima >= 0),
    CONSTRAINT CK_OfertaTrabajo_FechaVencimiento
        CHECK (FechaVencimiento > CAST(FechaPublicacion AS DATE))
);
GO
