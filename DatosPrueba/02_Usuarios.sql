-- ============================================================
-- 02_Usuarios.sql
-- Creación de usuarios de prueba (Admins, Postulantes, Empresas)
-- con hashes de contraseña de tipo BCrypt correspondientes a "Password123!"
-- ============================================================

-- Obtener IDs de estado ACTIVO y roles
DECLARE @IdActivo INT;
SELECT @IdActivo = IdEstadoUsuario FROM EstadoUsuario WHERE Nombre = 'ACTIVO';

DECLARE @IdAdminRol INT, @IdPostulanteRol INT, @IdEmpresaRol INT;
SELECT @IdAdminRol = IdRol FROM Rol WHERE Nombre = 'ADMIN';
SELECT @IdPostulanteRol = IdRol FROM Rol WHERE Nombre = 'POSTULANTE';
SELECT @IdEmpresaRol = IdRol FROM Rol WHERE Nombre = 'EMPRESA';

-- ------------------------------------------------------------
-- 1. ADMINISTRADOR
-- ------------------------------------------------------------
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('admin@jobhorizon.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdAdminUsuario INT = SCOPE_IDENTITY();

INSERT INTO Administrador (IdUsuario)
VALUES (@IdAdminUsuario);

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdAdminUsuario, @IdAdminRol);

-- ------------------------------------------------------------
-- 2. EMPRESAS
-- ------------------------------------------------------------
-- Empresa 1: Tech Solutions
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('rrhh@techsolutions.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdEmpresa1 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdEmpresa1, @IdEmpresaRol);

-- Empresa 2: SalvaDev
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('empleos@salvadev.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdEmpresa2 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdEmpresa2, @IdEmpresaRol);

-- ------------------------------------------------------------
-- 3. POSTULANTES
-- ------------------------------------------------------------
-- Postulante 1: Juan Pérez (Perfil Senior Backend)
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('juan.perez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante1 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdPostulante1, @IdPostulanteRol);

-- Postulante 2: María Gómez (Perfil Frontend Junior)
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('maria.gomez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante2 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdPostulante2, @IdPostulanteRol);

-- Postulante 3: Carlos López (Perfil Fullstack intermedio, sin mucho inglés)
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('carlos.lopez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante3 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdPostulante3, @IdPostulanteRol);

-- Postulante 4: Sofia Rodríguez (Perfil sin experiencia laboral previa, recién graduada)
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('sofia.rodriguez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante4 INT = SCOPE_IDENTITY();

INSERT INTO UsuarioRol (IdUsuario, IdRol)
VALUES (@IdPostulante4, @IdPostulanteRol);

-- Guardar IDs temporales en contexto para fácil verificación/uso
-- Esto lo usaremos en los siguientes scripts mediante consultas de selección.
GO
