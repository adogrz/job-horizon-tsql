CREATE OR ALTER TRIGGER trg_AuditarCambiosUsuario
    ON Usuario
    AFTER INSERT, UPDATE, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT: nuevo usuario
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
        BEGIN
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario, 'INSERT', 'Correo', NULL, i.Correo
            FROM inserted i;
        END

    -- DELETE: usuario eliminado
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT d.IdUsuario, 'DELETE', 'Correo', d.Correo, NULL
            FROM deleted d;
        END

    -- UPDATE: auditar cambios de estado e intentos fallidos
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        BEGIN
            -- Cambio de estado
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario,
                   'UPDATE',
                   'IdEstadoUsuario',
                   CAST(d.IdEstadoUsuario AS VARCHAR(10)),
                   CAST(i.IdEstadoUsuario AS VARCHAR(10))
            FROM inserted i
                     JOIN deleted d ON i.IdUsuario = d.IdUsuario
            WHERE i.IdEstadoUsuario <> d.IdEstadoUsuario;

            -- Cambio de intentos fallidos
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario,
                   'UPDATE',
                   'IntentosFallidos',
                   CAST(d.IntentosFallidos AS VARCHAR(5)),
                   CAST(i.IntentosFallidos AS VARCHAR(5))
            FROM inserted i
                     JOIN deleted d ON i.IdUsuario = d.IdUsuario
            WHERE i.IntentosFallidos <> d.IntentosFallidos;
        END
END;
GO
