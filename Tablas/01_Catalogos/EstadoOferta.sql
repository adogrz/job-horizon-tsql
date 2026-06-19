CREATE TABLE EstadoOferta
(
    IdEstadoOferta INT         NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(30) NOT NULL, -- ej. ACTIVA | VENCIDA | CERRADA | PAUSADA (parametrizable)
    Activo         BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoOferta PRIMARY KEY (IdEstadoOferta),
    CONSTRAINT UQ_EstadoOferta_Nombre UNIQUE (Nombre)
);
GO
