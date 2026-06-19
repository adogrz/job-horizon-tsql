CREATE OR ALTER TRIGGER trg_ValidarRolMinimo
    ON UsuarioRol
    AFTER DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si algún usuario afectado quedó sin roles
    IF EXISTS (SELECT d.IdUsuario
               FROM deleted d
               WHERE NOT EXISTS (SELECT 1
                                 FROM UsuarioRol ur
                                 WHERE ur.IdUsuario = d.IdUsuario))
        BEGIN
            RAISERROR (
                'No se puede revocar todos los roles. El usuario debe tener al menos un rol asignado.',
                16, 1
                );
            ROLLBACK TRANSACTION;
            RETURN;
        END
END;
GO
