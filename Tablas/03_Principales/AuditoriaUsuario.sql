CREATE TABLE AuditoriaUsuario
(
    IdAuditoria     INT          NOT NULL IDENTITY (1,1),
    IdUsuario       INT          NOT NULL,
    Accion          VARCHAR(10)  NOT NULL, -- INSERT | UPDATE | DELETE
    CampoModificado VARCHAR(60)  NULL,
    ValorAnterior   VARCHAR(255) NULL,
    ValorNuevo      VARCHAR(255) NULL,
    FechaAccion     DATETIME2    NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AuditoriaUsuario PRIMARY KEY (IdAuditoria),
    CONSTRAINT CK_AuditoriaUsuario_Accion
        CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE'))
);
GO
