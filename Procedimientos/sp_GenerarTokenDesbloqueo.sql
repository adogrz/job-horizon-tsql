CREATE OR ALTER PROCEDURE sp_GenerarTokenDesbloqueo @IdUsuario INT,
                                                    @Token VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @HorasExp INT;

        SELECT @HorasExp = CAST(Valor AS INT)
        FROM ConfiguracionSistema
        WHERE Clave = 'TOKEN_EXPIRACION_HORAS';

        IF @HorasExp IS NULL SET @HorasExp = 24; -- valor de seguridad por defecto

        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        UPDATE Usuario
        SET TokenDesbloqueo = @Token,
            FechaTokenExp   = DATEADD(HOUR, @HorasExp, GETDATE())
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
