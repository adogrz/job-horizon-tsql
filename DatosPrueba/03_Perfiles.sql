-- ============================================================
-- 03_Perfiles.sql
-- Carga de perfiles detallados para los postulantes de prueba
-- ============================================================

-- ------------------------------------------------------------
-- Variables Auxiliares
-- ------------------------------------------------------------
DECLARE @IdUser1 INT, @IdUser2 INT, @IdUser3 INT, @IdUser4 INT;
SELECT @IdUser1 = IdUsuario FROM Usuario WHERE Correo = 'juan.perez@email.com';
SELECT @IdUser2 = IdUsuario FROM Usuario WHERE Correo = 'maria.gomez@email.com';
SELECT @IdUser3 = IdUsuario FROM Usuario WHERE Correo = 'carlos.lopez@email.com';
SELECT @IdUser4 = IdUsuario FROM Usuario WHERE Correo = 'sofia.rodriguez@email.com';

DECLARE @IdMasc INT, @IdFem INT;
SELECT @IdMasc = IdGenero FROM Genero WHERE Nombre = 'MASCULINO';
SELECT @IdFem = IdGenero FROM Genero WHERE Nombre = 'FEMENINO';

DECLARE @IdDui INT;
SELECT @IdDui = IdTipoDocumento FROM TipoDocumento WHERE Nombre = 'DUI';

DECLARE @IdDistritoSS INT;
SELECT @IdDistritoSS = IdDistrito FROM Distrito d 
JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento
WHERE d.Nombre = 'San Salvador' AND dep.Nombre = 'San Salvador';

DECLARE @IdDistritoST INT;
SELECT @IdDistritoST = IdDistrito FROM Distrito d 
JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento
WHERE d.Nombre = 'Santa Tecla' AND dep.Nombre = 'La Libertad';

-- ------------------------------------------------------------
-- 1. DATOS PERSONALES (Postulante, Teléfono, Redes)
-- ------------------------------------------------------------
-- Postulante 1: Juan Pérez (San Salvador, DUI, Masculino)
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdUser1, 'Juan Antonio', 'Perez Castillo', '1992-05-15', '04857692-3', '123456789', '0614-150592-101-2', 'Colonia Escalon, Psje. A #4', @IdMasc, @IdDui, @IdDistritoSS);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono)
VALUES (@IdUser1, '7021-3948'), (@IdUser1, '+50322459876');

INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url)
VALUES (@IdUser1, 1, 'https://linkedin.com/in/juanperezbackend'),
       (@IdUser1, 2, 'https://github.com/juanperezdev');

-- Postulante 2: María Gómez (Santa Tecla, DUI, Femenino)
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdUser2, 'Maria Elena', 'Gomez Rivas', '1999-09-22', '05948372-1', NULL, '0501-220999-102-1', 'Residencial Santa Teresa, Senda 3 #12', @IdFem, @IdDui, @IdDistritoST);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono)
VALUES (@IdUser2, '7845-1290');

INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url)
VALUES (@IdUser2, 1, 'https://linkedin.com/in/mariagomezfrontend'),
       (@IdUser2, 2, 'https://github.com/mariagomezcode');

-- Postulante 3: Carlos López (San Salvador, DUI, Masculino)
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdUser3, 'Carlos Roberto', 'Lopez Alvarado', '1995-11-02', '03847592-5', '987654321', '0614-021195-103-3', 'Urbanizacion Metropoli, Block C-2', @IdMasc, @IdDui, @IdDistritoSS);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono)
VALUES (@IdUser3, '7190-8833');

INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url)
VALUES (@IdUser3, 1, 'https://linkedin.com/in/carloslopezfullstack');

-- Postulante 4: Sofia Rodríguez (Santa Tecla, DUI, Femenino)
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdUser4, 'Sofia Isabel', 'Rodriguez Menjivar', '2002-02-28', '06012485-9', NULL, NULL, 'Colonia Utila, Final Av. El Boqueron', @IdFem, @IdDui, @IdDistritoST);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono)
VALUES (@IdUser4, '7550-2918');

-- ------------------------------------------------------------
-- 2. FORMACION ACADEMICA (Autonumerada por Trigger)
-- ------------------------------------------------------------
DECLARE @IdIng INT, @IdLic INT, @IdTec INT;
SELECT @IdIng = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'INGENIERIA';
SELECT @IdLic = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'LICENCIATURA';
SELECT @IdTec = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'TECNICO';

-- Juan: Ingeniero
INSERT INTO FormacionAcademica (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
VALUES (0, @IdUser1, 'Universidad de El Salvador', 'Ingenieria de Sistemas Informaticos', @IdIng, '2010-02-15', '2015-12-15', 0);

-- María: Técnico
INSERT INTO FormacionAcademica (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
VALUES (0, @IdUser2, 'ITCA-FEPADE', 'Tecnologo en Desarrollo de Software', @IdTec, '2018-01-15', '2019-12-10', 0);

-- Carlos: Licenciado
INSERT INTO FormacionAcademica (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
VALUES (0, @IdUser3, 'Universidad Centroamericana Jose Simeon Cañas', 'Licenciatura en Ciencias de la Computacion', @IdLic, '2014-03-01', '2019-11-30', 0);

-- Sofia: Recién graduada de Ingeniería
INSERT INTO FormacionAcademica (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
VALUES (0, @IdUser4, 'Universidad de El Salvador', 'Ingenieria de Sistemas Informaticos', @IdIng, '2020-02-10', '2025-05-18', 0);

-- ------------------------------------------------------------
-- 3. EXPERIENCIA LABORAL (Autonumerada por Trigger)
-- ------------------------------------------------------------
-- Juan Perez (Senior Backend - 5+ años)
INSERT INTO ExperienciaLaboral (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
VALUES (0, @IdUser1, 'Applaudo Studios', 'Senior Java Developer', '2021-06-01', NULL, 1, 'Liderar equipo de desarrollo backend, arquitectura con microservicios en Spring Boot y migraciones de bases de datos.', '2200-1100', 'rrhh@applaudo.com');

INSERT INTO ExperienciaLaboral (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
VALUES (0, @IdUser1, 'Banco Agricola', 'Backend Developer', '2017-01-15', '2021-05-30', 0, 'Desarrollo de servicios bancarios transaccionales, integracion de APIs y optimizacion de procedimientos en SQL Server.', '2210-2210', 'sistemas@agricola.com');

-- Maria Gomez (Junior Frontend - 1 año)
INSERT INTO ExperienciaLaboral (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
VALUES (0, @IdUser2, 'Sykes El Salvador', 'Junior Frontend Developer', '2024-05-01', NULL, 1, 'Maquetacion responsiva, integracion de vistas Angular con APIs REST, pruebas unitarias básicas.', '2250-9900', 'hr@sykes.com');

-- Carlos Lopez (Fullstack - 3 años)
INSERT INTO ExperienciaLaboral (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
VALUES (0, @IdUser3, 'Telus International', 'Fullstack Software Engineer', '2023-01-10', NULL, 1, 'Desarrollo fullstack utilizando Django, React, y PostgreSQL. Manejo de Pipelines CI/CD.', '2252-0000', 'careers@telus.com');

-- Sofia Rodriguez (Recién graduada - Sin experiencia laboral)
-- No se inserta experiencia laboral para simular postulantes recién graduados.

-- ------------------------------------------------------------
-- 4. HABILIDADES TECNICAS (PostulanteHabilidad)
-- ------------------------------------------------------------
DECLARE @SkillJava INT, @SkillSpring INT, @SkillSql INT, @SkillSqlServer INT, @SkillAngular INT, @SkillReact INT, @SkillGit INT;
SELECT @SkillJava = IdHabilidad FROM Habilidad WHERE Nombre = 'Java';
SELECT @SkillSpring = IdHabilidad FROM Habilidad WHERE Nombre = 'Spring Boot';
SELECT @SkillSql = IdHabilidad FROM Habilidad WHERE Nombre = 'SQL';
SELECT @SkillSqlServer = IdHabilidad FROM Habilidad WHERE Nombre = 'SQL Server';
SELECT @SkillAngular = IdHabilidad FROM Habilidad WHERE Nombre = 'Angular';
SELECT @SkillReact = IdHabilidad FROM Habilidad WHERE Nombre = 'React';
SELECT @SkillGit = IdHabilidad FROM Habilidad WHERE Nombre = 'Git';

DECLARE @NivelBas INT, @NivelInt INT, @NivelAva INT, @NivelExp INT;
SELECT @NivelBas = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'BASICO';
SELECT @NivelInt = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'INTERMEDIO';
SELECT @NivelAva = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'AVANZADO';
SELECT @NivelExp = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'EXPERTO';

-- Juan: Java Experto, Spring Boot Experto, SQL Avanzado, SQL Server Avanzado, Git Avanzado
INSERT INTO PostulanteHabilidad (IdUsuario, IdHabilidad, IdNivelHabilidad)
VALUES (@IdUser1, @SkillJava, @NivelExp),
       (@IdUser1, @SkillSpring, @NivelExp),
       (@IdUser1, @SkillSql, @NivelAva),
       (@IdUser1, @SkillSqlServer, @NivelAva),
       (@IdUser1, @SkillGit, @NivelAva);

-- Maria: Angular Avanzado, React Intermedio, Git Intermedio
INSERT INTO PostulanteHabilidad (IdUsuario, IdHabilidad, IdNivelHabilidad)
VALUES (@IdUser2, @SkillAngular, @NivelAva),
       (@IdUser2, @SkillReact, @NivelInt),
       (@IdUser2, @SkillGit, @NivelInt);

-- Carlos: React Avanzado, Python = React (wait, Python skill is not loaded in variables, let's select it), SQL Avanzado, Git Avanzado
DECLARE @SkillPython INT;
SELECT @SkillPython = IdHabilidad FROM Habilidad WHERE Nombre = 'Python';

INSERT INTO PostulanteHabilidad (IdUsuario, IdHabilidad, IdNivelHabilidad)
VALUES (@IdUser3, @SkillReact, @NivelAva),
       (@IdUser3, @SkillPython, @NivelAva),
       (@IdUser3, @SkillSql, @NivelAva),
       (@IdUser3, @SkillGit, @NivelAva);

-- Sofia: Java Intermedio, Angular Intermedio, Git Basico
INSERT INTO PostulanteHabilidad (IdUsuario, IdHabilidad, IdNivelHabilidad)
VALUES (@IdUser4, @SkillJava, @NivelInt),
       (@IdUser4, @SkillAngular, @NivelInt),
       (@IdUser4, @SkillGit, @NivelBas);

-- ------------------------------------------------------------
-- 5. IDIOMAS (PostulanteIdioma)
-- ------------------------------------------------------------
DECLARE @IdiomaEsp INT, @IdiomaIng INT;
SELECT @IdiomaEsp = IdIdioma FROM Idioma WHERE Nombre = 'Español';
SELECT @IdiomaIng = IdIdioma FROM Idioma WHERE Nombre = 'Inglés';

DECLARE @LvlA1 INT, @LvlB1 INT, @LvlB2 INT, @LvlC1 INT, @LvlNat INT;
SELECT @LvlA1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'A1';
SELECT @LvlB1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B1';
SELECT @LvlB2 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B2';
SELECT @LvlC1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'C1';
SELECT @LvlNat = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'NATIVO';

-- Juan: Español Nativo, Inglés B2
INSERT INTO PostulanteIdioma (IdUsuario, IdIdioma, IdNivelLectura, IdNivelEscritura, IdNivelConversacion, IdNivelEscucha)
VALUES (@IdUser1, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       ( @IdUser1, @IdiomaIng, @LvlB2, @LvlB2, @LvlB2, @LvlB2);

-- Maria: Español Nativo, Inglés C1
INSERT INTO PostulanteIdioma (IdUsuario, IdIdioma, IdNivelLectura, IdNivelEscritura, IdNivelConversacion, IdNivelEscucha)
VALUES (@IdUser2, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       ( @IdUser2, @IdiomaIng, @LvlC1, @LvlC1, @LvlC1, @LvlC1);

-- Carlos: Español Nativo, Inglés A1
INSERT INTO PostulanteIdioma (IdUsuario, IdIdioma, IdNivelLectura, IdNivelEscritura, IdNivelConversacion, IdNivelEscucha)
VALUES (@IdUser3, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       ( @IdUser3, @IdiomaIng, @LvlA1, @LvlA1, @LvlA1, @LvlA1);

-- Sofia: Español Nativo, Inglés B1
INSERT INTO PostulanteIdioma (IdUsuario, IdIdioma, IdNivelLectura, IdNivelEscritura, IdNivelConversacion, IdNivelEscucha)
VALUES (@IdUser4, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       ( @IdUser4, @IdiomaIng, @LvlB1, @LvlB1, @LvlB1, @LvlB1);

-- ------------------------------------------------------------
-- 6. CERTIFICACIONES Y OTROS DATOS EXTRA
-- ------------------------------------------------------------
-- Certificaciones de Juan
INSERT INTO Certificacion (CodCert, IdUsuario, CodigoCertificacion, Nombre, IdTipoCertificacion, Institucion, FechaObtencion, ArchivoUrl)
VALUES (1, @IdUser1, '1Z0-819', 'Oracle Certified Professional: Java SE 11 Developer', 1, 'Oracle', '2020-08-15', 'http://certificados.org/juan-java11.pdf');

-- Certificación de Idioma de Maria
INSERT INTO Certificacion (CodCert, IdUsuario, CodigoCertificacion, Nombre, IdTipoCertificacion, Institucion, FechaObtencion, ArchivoUrl)
VALUES (1, @IdUser2, 'C1-ADV-1234', 'Cambridge English C1 Advanced', 2, 'Cambridge Assessment English', '2023-11-20', NULL);

-- Logro de Carlos
INSERT INTO Logro (NumLogro, IdUsuario, Descripcion, Fecha)
VALUES (1, @IdUser3, 'Primer lugar en la Hackathon UCA 2021 con un proyecto de automatizacion agraria.', '2021-10-18');

-- Recomendación para Juan
INSERT INTO Recomendacion (NumRecomendacion, IdUsuario, NombreContacto, TelefonoContacto, IdTipoRecomendacion)
VALUES (1, @IdUser1, 'Ing. Hugo Gonzalez (CTO en Applaudo)', '7070-5555', 1);

-- Participación en Evento de Sofia
DECLARE @IdPonte INT, @IdPaisSV INT;
SELECT @IdPonte = IdTipoParticipacion FROM TipoParticipacion WHERE Nombre = 'PONENTE';
SELECT @IdPaisSV = IdPais FROM Pais WHERE Nombre = 'El Salvador';

INSERT INTO Evento (NumEvento, IdUsuario, NombreEvento, Lugar, Anfitrion, Fecha, IdTipoParticipacion, IdPais)
VALUES (1, @IdUser4, 'Congreso Nacional de Tecnologia bad115', 'San Salvador, UES', 'Escuela de Sistemas ESI', '2024-04-12', @IdPonte, @IdPaisSV);
GO
