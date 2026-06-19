CREATE OR ALTER FUNCTION fn_PorcentajeCompletitudPerfil(
    @IdUsuario INT
)
    RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Puntaje INT = 0;
    DECLARE @Total INT = 4;
    -- 4 secciones del perfil

    -- Sección 1: datos personales (ya existe si hay registro en Postulante)
    IF EXISTS (SELECT 1 FROM Postulante WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    -- Sección 2: al menos 1 experiencia laboral
    IF EXISTS (SELECT 1 FROM ExperienciaLaboral WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    -- Sección 3: al menos 1 formación académica
    IF EXISTS (SELECT 1 FROM FormacionAcademica WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    -- Sección 4: al menos 1 habilidad técnica
    IF EXISTS (SELECT 1 FROM PostulanteHabilidad WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    RETURN CAST(@Puntaje AS DECIMAL(5, 2)) / @Total * 100;
END;
GO
