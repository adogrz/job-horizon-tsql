CREATE OR ALTER PROCEDURE sp_DesbloquearUsuario @Token VARCHAR(100),
                                                @Resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @IdUsuario INT;
        DECLARE @FechaExp DATETIME2;
        DECLARE @IdActivo INT;

        SELECT @IdUsuario = IdUsuario,
               @FechaExp = FechaTokenExp
        FROM Usuario
        WHERE TokenDesbloqueo = @Token;

        IF @IdUsuario IS NULL
            BEGIN
                SET @Resultado = 1; -- token inválido
                RETURN;
            END

        IF GETDATE() > @FechaExp
            BEGIN
                SET @Resultado = 2; -- token expirado
                RETURN;
            END

        SELECT @IdActivo = IdEstadoUsuario
        FROM EstadoUsuario
        WHERE Nombre = 'ACTIVO';

        UPDATE Usuario
        SET IdEstadoUsuario  = @IdActivo,
            IntentosFallidos = 0,
            TokenDesbloqueo  = NULL,
            FechaTokenExp    = NULL
        WHERE IdUsuario = @IdUsuario;

        SET @Resultado = 0; -- éxito
    END TRY
    BEGIN CATCH
        SET @Resultado = -1;
        THROW;
    END CATCH
END;
GO
