CREATE TABLE EstadoAplicacion
(
    IdEstadoAplicacion INT         NOT NULL IDENTITY (1,1),
    Nombre             VARCHAR(30) NOT NULL, -- ej. PENDIENTE | REVISADA | CONTACTADO | RECHAZADO (parametrizable)
    Activo             BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoAplicacion PRIMARY KEY (IdEstadoAplicacion),
    CONSTRAINT UQ_EstadoAplicacion_Nombre UNIQUE (Nombre)
);
GO
