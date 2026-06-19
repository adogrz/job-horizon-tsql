CREATE TABLE NivelHabilidad
(
    IdNivelHabilidad INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(20) NOT NULL,
    OrdenComparacion TINYINT     NOT NULL, -- 1=BASICO, 2=INTERMEDIO, 3=AVANZADO, 4=EXPERTO
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelHabilidad PRIMARY KEY (IdNivelHabilidad),
    CONSTRAINT UQ_NivelHabilidad_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelHabilidad_Orden UNIQUE (OrdenComparacion)
);
GO
