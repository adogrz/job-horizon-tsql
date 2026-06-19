CREATE OR ALTER PROCEDURE sp_ResetearIntentosFallidos @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        UPDATE Usuario
        SET IntentosFallidos = 0
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
