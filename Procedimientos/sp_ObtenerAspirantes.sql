CREATE OR ALTER PROCEDURE sp_ObtenerAspirantes @IdOferta INT,
                                               @IdDepartamento INT = NULL,
                                               @SoloDisponibles BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Habilidades requeridas por la oferta
        DECLARE @HabilidadesRequeridas INT;
        SELECT @HabilidadesRequeridas = COUNT(*)
        FROM OfertaHabilidad
        WHERE IdOferta = @IdOferta;

        -- Idiomas requeridos por la oferta
        DECLARE @IdiomasRequeridos INT;
        SELECT @IdiomasRequeridos = COUNT(*)
        FROM OfertaIdioma
        WHERE IdOferta = @IdOferta;

        SELECT p.IdUsuario,
               p.Nombres,
               p.Apellidos,
               p.Nombres + ' ' + p.Apellidos                                                  AS NombreCompleto,
               u.Correo,
               dep.Nombre                                                                     AS Departamento,
               dis.Nombre                                                                     AS Distrito,

               -- Habilidades que coinciden (nivel mínimo cumplido)
               (SELECT COUNT(*)
                FROM PostulanteHabilidad ph
                         JOIN OfertaHabilidad oh
                              ON ph.IdHabilidad = oh.IdHabilidad
                                  AND oh.IdOferta = @IdOferta
                         JOIN NivelHabilidad nph ON ph.IdNivelHabilidad = nph.IdNivelHabilidad
                         JOIN NivelHabilidad noh ON oh.IdNivelHabilidad = noh.IdNivelHabilidad
                WHERE ph.IdUsuario = p.IdUsuario
                  AND nph.OrdenComparacion >= noh.OrdenComparacion)                           AS HabilidadesCoinciden,

               @HabilidadesRequeridas                                                         AS HabilidadesRequeridas,

               -- Idiomas que coinciden (mínimo en todas las 4 habilidades lingüísticas)
               (SELECT COUNT(*)
                FROM PostulanteIdioma pi2
                         JOIN OfertaIdioma oi
                              ON pi2.IdIdioma = oi.IdIdioma
                                  AND oi.IdOferta = @IdOferta
                         JOIN NivelIdioma nr ON oi.IdNivelIdioma = nr.IdNivelIdioma
                         JOIN NivelIdioma nLec ON pi2.IdNivelLectura = nLec.IdNivelIdioma
                         JOIN NivelIdioma nEsc ON pi2.IdNivelEscritura = nEsc.IdNivelIdioma
                         JOIN NivelIdioma nCon ON pi2.IdNivelConversacion = nCon.IdNivelIdioma
                         JOIN NivelIdioma nLis ON pi2.IdNivelEscucha = nLis.IdNivelIdioma
                WHERE pi2.IdUsuario = p.IdUsuario
                  AND (SELECT MIN(v)
                       FROM (VALUES (nLec.OrdenComparacion),
                                    (nEsc.OrdenComparacion),
                                    (nCon.OrdenComparacion),
                                    (nLis.OrdenComparacion)) AS T(v)) >= nr.OrdenComparacion) AS IdiomasCoinciden,

               @IdiomasRequeridos                                                             AS IdiomasRequeridos,

               -- Puntaje de matching completo (4 variables ponderadas)
               dbo.fn_PuntajeMatching(p.IdUsuario, @IdOferta)                                 AS PuntajeMatching

        FROM Postulante p
                 JOIN Usuario u ON p.IdUsuario = u.IdUsuario
                 JOIN Distrito dis ON p.IdDistrito = dis.IdDistrito
                 JOIN Departamento dep ON dis.IdDepartamento = dep.IdDepartamento
                 JOIN EstadoUsuario eu ON u.IdEstadoUsuario = eu.IdEstadoUsuario

        WHERE eu.Nombre = 'ACTIVO'
          AND (@IdDepartamento IS NULL OR dep.IdDepartamento = @IdDepartamento)
          -- Solo postulantes que no han aplicado ya a esta oferta
          AND NOT EXISTS (SELECT 1
                          FROM PostulanteOferta po
                          WHERE po.IdUsuario = p.IdUsuario
                            AND po.IdOferta = @IdOferta)

        ORDER BY PuntajeMatching DESC;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
