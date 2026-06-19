CREATE OR ALTER PROCEDURE sp_ObtenerPrivilegiosUsuario @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT p.IdPrivilegio,
                        p.Nombre,
                        p.NombreMenu,
                        p.Ruta
        FROM UsuarioRol ur
                 JOIN RolPrivilegio rp ON ur.IdRol = rp.IdRol
                 JOIN Privilegio p ON rp.IdPrivilegio = p.IdPrivilegio
        WHERE ur.IdUsuario = @IdUsuario
        ORDER BY p.Nombre;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
