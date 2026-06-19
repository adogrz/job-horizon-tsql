CREATE TABLE ConfiguracionSistema
(
    Clave       VARCHAR(100) NOT NULL,
    Valor       VARCHAR(500) NOT NULL,
    Descripcion VARCHAR(300) NULL,
    CONSTRAINT PK_ConfiguracionSistema PRIMARY KEY (Clave)
);
GO
