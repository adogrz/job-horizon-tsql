CREATE OR ALTER PROCEDURE sp_RegistrarIntentoFallido @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @Intentos INT;
        DECLARE @IdBloqueado INT;
        DECLARE @MaxIntentos INT;

        -- Límite parametrizable desde ConfiguracionSistema
        SELECT @MaxIntentos = CAST(Valor AS INT)
        FROM ConfiguracionSistema
        WHERE Clave = 'MAX_INTENTOS_FALLIDOS';

        IF @MaxIntentos IS NULL SET @MaxIntentos = 3; -- valor de seguridad por defecto

        SELECT @Intentos = IntentosFallidos
        FROM Usuario
        WHERE IdUsuario = @IdUsuario;

        IF @Intentos IS NULL
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        SET @Intentos = @Intentos + 1;

        -- Obtener el ID del estado BLOQUEADO
        SELECT @IdBloqueado = IdEstadoUsuario
        FROM EstadoUsuario
        WHERE Nombre = 'BLOQUEADO';

        IF @Intentos >= @MaxIntentos
            BEGIN
                UPDATE Usuario
                SET IntentosFallidos = @Intentos,
                    IdEstadoUsuario  = @IdBloqueado
                WHERE IdUsuario = @IdUsuario;
            END
        ELSE
            BEGIN
                UPDATE Usuario
                SET IntentosFallidos = @Intentos
                WHERE IdUsuario = @IdUsuario;
            END

        SELECT IntentosFallidos, IdEstadoUsuario
        FROM Usuario
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
