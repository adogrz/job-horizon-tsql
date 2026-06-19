CREATE OR ALTER PROCEDURE sp_CambiarEstadoAplicacion @IdUsuario INT,
                                                     @IdOferta INT,
                                                     @NuevoEstado VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @IdEstado INT;
        SELECT @IdEstado = IdEstadoAplicacion
        FROM EstadoAplicacion
        WHERE Nombre = @NuevoEstado;

        IF @IdEstado IS NULL
            BEGIN
                RAISERROR (N'Estado de aplicación "%s" no existe en el catálogo.', 16, 1, @NuevoEstado);
                RETURN;
            END

        UPDATE PostulanteOferta
        SET IdEstadoAplicacion = @IdEstado
        WHERE IdUsuario = @IdUsuario
          AND IdOferta = @IdOferta;

        IF @@ROWCOUNT = 0
            RAISERROR (N'Aplicación no encontrada para IdUsuario=%d, IdOferta=%d.', 16, 1, @IdUsuario, @IdOferta);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
