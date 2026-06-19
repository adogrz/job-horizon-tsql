-- ============================================================
-- 04_Empresas_Ofertas.sql
-- Creación de perfiles de empresa y ofertas de trabajo activas
-- para pruebas del algoritmo de matching.
-- ============================================================

-- ------------------------------------------------------------
-- Variables Auxiliares
-- ------------------------------------------------------------
DECLARE @IdEmpresa1 INT, @IdEmpresa2 INT;
SELECT @IdEmpresa1 = IdUsuario FROM Usuario WHERE Correo = 'rrhh@techsolutions.com';
SELECT @IdEmpresa2 = IdUsuario FROM Usuario WHERE Correo = 'empleos@salvadev.com';

DECLARE @IdDistritoSS INT;
SELECT @IdDistritoSS = IdDistrito FROM Distrito d 
JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento
WHERE d.Nombre = 'San Salvador' AND dep.Nombre = 'San Salvador';

DECLARE @IdDistritoST INT;
SELECT @IdDistritoST = IdDistrito FROM Distrito d 
JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento
WHERE d.Nombre = 'Santa Tecla' AND dep.Nombre = 'La Libertad';

-- ------------------------------------------------------------
-- 1. CREACION DE PERFILES DE EMPRESA
-- ------------------------------------------------------------
-- Empresa 1: Tech Solutions
INSERT INTO Empresa (IdUsuario, NombreComercial, RazonSocial, Nit, SitioWeb, Descripcion, LogoUrl, IdDistrito)
VALUES (@IdEmpresa1, 'Tech Solutions', 'Tech Solutions S.A. de C.V.', '0614-121220-101-9', 'https://techsolutions.com', 'Empresa lider en desarrollo de software para el sector financiero en la region centroamericana.', 'https://images.techsolutions.com/logo.png', @IdDistritoST);

INSERT INTO EmpresaTelefono (IdUsuario, Telefono)
VALUES (@IdEmpresa1, '2288-4433'), (@IdEmpresa1, '7766-5544');

-- Empresa 2: SalvaDev
INSERT INTO Empresa (IdUsuario, NombreComercial, RazonSocial, Nit, SitioWeb, Descripcion, LogoUrl, IdDistrito)
VALUES (@IdEmpresa2, 'SalvaDev', 'El Salvador Developers S.A. de C.V.', '0614-050518-102-1', 'https://salvadev.com', 'Boutique de desarrollo de software enfocada en soluciones Web y Cloud utilizando tecnologias de vanguardia.', NULL, @IdDistritoSS);

INSERT INTO EmpresaTelefono (IdUsuario, Telefono)
VALUES (@IdEmpresa2, '2260-1234');

-- ------------------------------------------------------------
-- 2. OFERTAS DE TRABAJO (OfertaTrabajo)
-- ------------------------------------------------------------
-- Buscar IDs de catálogos necesarios
DECLARE @IdContratoTC INT, @IdContratoRem INT;
SELECT @IdContratoTC = IdTipoContrato FROM TipoContrato WHERE Nombre = 'TIEMPO_COMPLETO';

DECLARE @IdNivelIng INT, @IdNivelLic INT, @IdNivelTec INT;
SELECT @IdNivelIng = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'INGENIERIA';
SELECT @IdNivelLic = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'LICENCIATURA';
SELECT @IdNivelTec = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'TECNICO';

DECLARE @IdModHib INT, @IdModRem INT;
SELECT @IdModHib = IdModalidad FROM Modalidad WHERE Nombre = 'HIBRIDO';
SELECT @IdModRem = IdModalidad FROM Modalidad WHERE Nombre = 'REMOTO';

DECLARE @IdOfertaActiva INT;
SELECT @IdOfertaActiva = IdEstadoOferta FROM EstadoOferta WHERE Nombre = 'ACTIVA';

-- Oferta 1: Senior Java/Spring Developer (Tech Solutions)
-- Vence en 30 días
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Senior Java Backend Developer (Spring Boot)', 
        'Buscamos un Ingeniero de software Backend Senior experimentado para diseñar, implementar y escalar servicios basados en microservicios e integracion de sistemas legacy.', 
        2200.00, 2800.00, 2, 3, GETDATE(), DATEADD(DAY, 30, GETDATE()), 
        @IdEmpresa1, @IdContratoTC, @IdNivelIng, @IdModHib, @IdOfertaActiva, @IdDistritoST,
        0.40, 0.20, 0.20, 0.20);
DECLARE @IdOferta1 INT = SCOPE_IDENTITY();

-- Oferta 2: Junior Frontend Developer (SalvaDev)
-- Vence en 15 días
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Junior Angular Frontend Developer', 
        'Buscamos graduado de carrera tecnica o ingenieria para incorporarse a celula de desarrollo frontend. Enfoque en Angular, TypeScript y maquetacion premium.', 
        800.00, 1100.00, 1, 1, GETDATE(), DATEADD(DAY, 15, GETDATE()), 
        @IdEmpresa2, @IdContratoTC, @IdNivelTec, @IdModRem, @IdOfertaActiva, @IdDistritoSS,
        0.50, 0.10, 0.20, 0.20);
DECLARE @IdOferta2 INT = SCOPE_IDENTITY();

-- Oferta 3: Fullstack Python/React Engineer (Tech Solutions)
-- Vence en 20 días
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Software Engineer Fullstack (Python / React)', 
        'Desarrollo e integracion de APIs utilizando Python/Django y componentes visuales reactivos en React. Se requiere habilidades solidas en bases de datos relacionales.', 
        1400.00, 1800.00, 1, 2, GETDATE(), DATEADD(DAY, 20, GETDATE()), 
        @IdEmpresa1, @IdContratoTC, @IdNivelLic, @IdModHib, @IdOfertaActiva, @IdDistritoST,
        0.40, 0.20, 0.20, 0.20);
DECLARE @IdOferta3 INT = SCOPE_IDENTITY();

-- ------------------------------------------------------------
-- 3. REQUISITOS DE HABILIDADES PARA LAS OFERTAS
-- ------------------------------------------------------------
DECLARE @SkillJava INT, @SkillSpring INT, @SkillSql INT, @SkillAngular INT, @SkillReact INT, @SkillPython INT, @SkillGit INT;
SELECT @SkillJava = IdHabilidad FROM Habilidad WHERE Nombre = 'Java';
SELECT @SkillSpring = IdHabilidad FROM Habilidad WHERE Nombre = 'Spring Boot';
SELECT @SkillSql = IdHabilidad FROM Habilidad WHERE Nombre = 'SQL';
SELECT @SkillAngular = IdHabilidad FROM Habilidad WHERE Nombre = 'Angular';
SELECT @SkillReact = IdHabilidad FROM Habilidad WHERE Nombre = 'React';
SELECT @SkillPython = IdHabilidad FROM Habilidad WHERE Nombre = 'Python';
SELECT @SkillGit = IdHabilidad FROM Habilidad WHERE Nombre = 'Git';

DECLARE @NivelInt INT, @NivelAva INT;
SELECT @NivelInt = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'INTERMEDIO';
SELECT @NivelAva = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'AVANZADO';

-- Oferta 1: Java (AVANZADO), Spring Boot (AVANZADO), SQL (INTERMEDIO)
INSERT INTO OfertaHabilidad (IdOferta, IdHabilidad, IdNivelHabilidad)
VALUES (@IdOferta1, @SkillJava, @NivelAva),
       (@IdOferta1, @SkillSpring, @NivelAva),
       (@IdOferta1, @SkillSql, @NivelInt);

-- Oferta 2: Angular (INTERMEDIO), Git (INTERMEDIO)
INSERT INTO OfertaHabilidad (IdOferta, IdHabilidad, IdNivelHabilidad)
VALUES (@IdOferta2, @SkillAngular, @NivelInt),
       (@IdOferta2, @SkillGit, @NivelInt);

-- Oferta 3: React (INTERMEDIO), Python (INTERMEDIO), SQL (INTERMEDIO)
INSERT INTO OfertaHabilidad (IdOferta, IdHabilidad, IdNivelHabilidad)
VALUES (@IdOferta3, @SkillReact, @NivelInt),
       (@IdOferta3, @SkillPython, @NivelInt),
       (@IdOferta3, @SkillSql, @NivelInt);

-- ------------------------------------------------------------
-- 4. REQUISITOS DE IDIOMAS PARA LAS OFERTAS
-- ------------------------------------------------------------
DECLARE @IdiomaIng INT;
SELECT @IdiomaIng = IdIdioma FROM Idioma WHERE Nombre = 'Inglés';

DECLARE @LvlB1 INT, @LvlB2 INT;
SELECT @LvlB1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B1';
SELECT @LvlB2 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B2';

-- Oferta 1: Inglés B2 Requerido
INSERT INTO OfertaIdioma (IdOferta, IdIdioma, IdNivelIdioma)
VALUES (@IdOferta1, @IdiomaIng, @LvlB2);

-- Oferta 2: Inglés B1 Requerido
INSERT INTO OfertaIdioma (IdOferta, IdIdioma, IdNivelIdioma)
VALUES (@IdOferta2, @IdiomaIng, @LvlB1);

-- Oferta 3: Inglés B1 Requerido
INSERT INTO OfertaIdioma (IdOferta, IdIdioma, IdNivelIdioma)
VALUES (@IdOferta3, @IdiomaIng, @LvlB1);
GO
