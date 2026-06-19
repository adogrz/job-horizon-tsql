CREATE OR ALTER TRIGGER trg_AutonumerarExperiencia
    ON ExperienciaLaboral
    INSTEAD OF INSERT
    AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ExperienciaLaboral
    (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
    SELECT
        -- MAX actual por usuario + número de fila dentro del mismo lote por usuario
        ISNULL(
                (SELECT MAX(e.NumExp) FROM ExperienciaLaboral e WHERE e.IdUsuario = i.IdUsuario),
                0
        ) + ROW_NUMBER() OVER (PARTITION BY i.IdUsuario ORDER BY (SELECT NULL)),
        i.IdUsuario,
        i.NombreEmpresa,
        i.Puesto,
        i.FechaInicio,
        i.FechaFin,
        i.TrabajoActual,
        i.Funciones,
        i.TelefonoContacto,
        i.CorreoContacto
    FROM inserted i;
END;
GO
