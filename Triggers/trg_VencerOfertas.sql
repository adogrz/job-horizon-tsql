CREATE OR ALTER TRIGGER trg_VencerOfertas
    ON OfertaTrabajo
    AFTER INSERT, UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdVencida INT;
    SELECT @IdVencida = IdEstadoOferta
    FROM EstadoOferta
    WHERE Nombre = 'VENCIDA';

    DECLARE @IdActiva INT;
    SELECT @IdActiva = IdEstadoOferta
    FROM EstadoOferta
    WHERE Nombre = 'ACTIVA';

    UPDATE OfertaTrabajo
    SET IdEstadoOferta = @IdVencida
    WHERE IdOferta IN (SELECT IdOferta FROM inserted)
      AND FechaVencimiento < CAST(GETDATE() AS DATE)
      AND IdEstadoOferta = @IdActiva;
END;
GO
