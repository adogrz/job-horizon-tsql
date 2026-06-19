CREATE OR ALTER TRIGGER trg_AuditarCambiosRol
    ON UsuarioRol
    AFTER INSERT, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Asignación de roles
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
        BEGIN
            INSERT INTO AuditoriaRol (IdUsuario, IdRol, Accion)
            SELECT i.IdUsuario, i.IdRol, 'ASSIGN'
            FROM inserted i;
        END

    -- Revocación de roles
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            INSERT INTO AuditoriaRol (IdUsuario, IdRol, Accion)
            SELECT d.IdUsuario, d.IdRol, 'REVOKE'
            FROM deleted d;
        END
END;
GO
