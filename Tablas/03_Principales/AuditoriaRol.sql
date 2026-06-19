CREATE TABLE AuditoriaRol
(
    IdAuditoria INT         NOT NULL IDENTITY (1,1),
    IdUsuario   INT         NOT NULL,
    IdRol       INT         NOT NULL,
    Accion      VARCHAR(10) NOT NULL, -- ASSIGN | REVOKE
    FechaAccion DATETIME2   NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AuditoriaRol PRIMARY KEY (IdAuditoria),
    CONSTRAINT CK_AuditoriaRol_Accion CHECK (Accion IN ('ASSIGN', 'REVOKE'))
);
GO
