CREATE OR ALTER PROCEDURE sp_AplicarOferta @IdUsuario INT,
                                           @IdOferta INT,
                                           @Resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validar que la oferta exista y esté activa
        IF NOT EXISTS (SELECT 1
                       FROM OfertaTrabajo o
                                JOIN EstadoOferta eo ON o.IdEstadoOferta = eo.IdEstadoOferta
                       WHERE o.IdOferta = @IdOferta
                         AND eo.Nombre = 'ACTIVA')
            BEGIN
                SET @Resultado = 2;
                RETURN;
            END

        -- Validar que no haya aplicado ya
        IF EXISTS (SELECT 1
                   FROM PostulanteOferta
                   WHERE IdUsuario = @IdUsuario
                     AND IdOferta = @IdOferta)
            BEGIN
                SET @Resultado = 1;
                RETURN;
            END

        DECLARE @IdPendiente INT;
        SELECT @IdPendiente = IdEstadoAplicacion
        FROM EstadoAplicacion
        WHERE Nombre = 'PENDIENTE';

        INSERT INTO PostulanteOferta (IdUsuario, IdOferta, IdEstadoAplicacion)
        VALUES (@IdUsuario, @IdOferta, @IdPendiente);

        SET @Resultado = 0;
    END TRY
    BEGIN CATCH
        SET @Resultado = -1;
        THROW;
    END CATCH
END;
GO
