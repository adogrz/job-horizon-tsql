CREATE TABLE ExperienciaLaboral
(
    NumExp           INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    NombreEmpresa    VARCHAR(150) NOT NULL,
    Puesto           VARCHAR(120) NOT NULL,
    FechaInicio      DATE         NOT NULL,
    FechaFin         DATE         NULL, -- NULL si Trabajo_Actual = 1
    TrabajoActual    BIT          NOT NULL DEFAULT 0,
    Funciones        VARCHAR(MAX) NOT NULL,
    TelefonoContacto VARCHAR(15)  NULL,
    CorreoContacto   VARCHAR(150) NULL,
    CONSTRAINT PK_ExperienciaLaboral PRIMARY KEY (NumExp, IdUsuario),
    CONSTRAINT FK_ExperienciaLaboral_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_ExperienciaLaboral_Fechas
        CHECK (FechaFin IS NULL OR FechaFin >= FechaInicio),
    CONSTRAINT CK_ExperienciaLaboral_Actual
        CHECK (TrabajoActual = 0 OR (TrabajoActual = 1 AND FechaFin IS NULL)),
    CONSTRAINT CK_ExperienciaLaboral_Telefono
        CHECK (TelefonoContacto IS NULL
            OR TelefonoContacto LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR TelefonoContacto LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR TelefonoContacto LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_ExperienciaLaboral_Correo
        CHECK (CorreoContacto IS NULL
            OR (CorreoContacto LIKE '%@%.%'
                AND LEN(CorreoContacto) >= 6))
);
GO
