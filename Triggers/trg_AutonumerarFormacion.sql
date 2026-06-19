CREATE OR ALTER TRIGGER trg_AutonumerarFormacion
    ON FormacionAcademica
    INSTEAD OF INSERT
    AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO FormacionAcademica
    (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
    SELECT ISNULL(
                   (SELECT MAX(f.NumFormacion) FROM FormacionAcademica f WHERE f.IdUsuario = i.IdUsuario),
                   0
           ) + ROW_NUMBER() OVER (PARTITION BY i.IdUsuario ORDER BY (SELECT NULL)),
           i.IdUsuario,
           i.Institucion,
           i.Titulo,
           i.IdNivelEducativo,
           i.FechaInicio,
           i.FechaFin,
           i.EnCurso
    FROM inserted i;
END;
GO
