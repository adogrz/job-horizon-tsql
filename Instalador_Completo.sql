-- ==============================================================================
-- INSTALADOR COMPLETO DE BASE DE DATOS - JOBHORIZON
-- Microsoft SQL Server (T-SQL)
-- ==============================================================================
-- Este script realiza la creación limpia de la base de datos,
-- todas las tablas (ordenadas jerárquicamente), índices, funciones,
-- procedimientos almacenados, triggers, semillas y datos masivos de prueba.
-- ==============================================================================

-- ==============================================================================
-- SECCION 0: CREACION DE LA BASE DE DATOS
-- ==============================================================================
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'JobHorizonDB')
BEGIN
    ALTER DATABASE JobHorizonDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE JobHorizonDB;
END
GO

CREATE DATABASE JobHorizonDB;
GO

USE JobHorizonDB;
GO

-- ==============================================================================
-- SECCION 1: TABLAS DE CATALOGOS
-- ==============================================================================

CREATE TABLE Departamento
(
    IdDepartamento INT          NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(100) NOT NULL,
    Activo         BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Departamento PRIMARY KEY (IdDepartamento),
    CONSTRAINT UQ_Departamento_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE Distrito
(
    IdDistrito     INT          NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(150) NOT NULL,
    IdDepartamento INT          NOT NULL,
    Activo         BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Distrito PRIMARY KEY (IdDistrito),
    CONSTRAINT FK_Distrito_Departamento
        FOREIGN KEY (IdDepartamento) REFERENCES Departamento (IdDepartamento)
);
GO

CREATE TABLE EstadoUsuario
(
    IdEstadoUsuario INT         NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(30) NOT NULL,
    Activo          BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoUsuario PRIMARY KEY (IdEstadoUsuario),
    CONSTRAINT UQ_EstadoUsuario_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE EstadoOferta
(
    IdEstadoOferta INT         NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(30) NOT NULL,
    Activo         BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoOferta PRIMARY KEY (IdEstadoOferta),
    CONSTRAINT UQ_EstadoOferta_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE EstadoAplicacion
(
    IdEstadoAplicacion INT         NOT NULL IDENTITY (1,1),
    Nombre             VARCHAR(30) NOT NULL,
    Activo             BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_EstadoAplicacion PRIMARY KEY (IdEstadoAplicacion),
    CONSTRAINT UQ_EstadoAplicacion_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE Genero
(
    IdGenero INT         NOT NULL IDENTITY (1,1),
    Nombre   VARCHAR(30) NOT NULL,
    Activo   BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_Genero PRIMARY KEY (IdGenero),
    CONSTRAINT UQ_Genero_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE TipoDocumento
(
    IdTipoDocumento INT          NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(50)  NOT NULL,
    Descripcion     VARCHAR(200) NULL,
    Activo          BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoDocumento PRIMARY KEY (IdTipoDocumento),
    CONSTRAINT UQ_TipoDocumento_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE TipoContrato
(
    IdTipoContrato INT         NOT NULL IDENTITY (1,1),
    Nombre         VARCHAR(80) NOT NULL,
    Activo         BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoContrato PRIMARY KEY (IdTipoContrato),
    CONSTRAINT UQ_TipoContrato_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE NivelEducativo
(
    IdNivelEducativo INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(80) NOT NULL,
    OrdenComparacion TINYINT     NOT NULL,
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelEducativo PRIMARY KEY (IdNivelEducativo),
    CONSTRAINT UQ_NivelEducativo_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelEducativo_Orden UNIQUE (OrdenComparacion)
);
GO

CREATE TABLE Modalidad
(
    IdModalidad INT         NOT NULL IDENTITY (1,1),
    Nombre      VARCHAR(30) NOT NULL,
    Activo      BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_Modalidad PRIMARY KEY (IdModalidad),
    CONSTRAINT UQ_Modalidad_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE CategoriaHabilidad
(
    IdCategoriaHabilidad INT          NOT NULL IDENTITY (1,1),
    Nombre               VARCHAR(100) NOT NULL,
    Descripcion          VARCHAR(300) NULL,
    Activo               BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_CategoriaHabilidad PRIMARY KEY (IdCategoriaHabilidad),
    CONSTRAINT UQ_CategoriaHabilidad_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE Habilidad
(
    IdHabilidad          INT          NOT NULL IDENTITY (1,1),
    Nombre               VARCHAR(100) NOT NULL,
    Descripcion          VARCHAR(300) NULL,
    IdCategoriaHabilidad INT          NOT NULL,
    Activo               BIT          NOT NULL DEFAULT 1,
    CONSTRAINT PK_Habilidad PRIMARY KEY (IdHabilidad),
    CONSTRAINT FK_Habilidad_Categoria
        FOREIGN KEY (IdCategoriaHabilidad) REFERENCES CategoriaHabilidad (IdCategoriaHabilidad)
);
GO

CREATE TABLE Idioma
(
    IdIdioma INT         NOT NULL IDENTITY (1,1),
    Nombre   VARCHAR(80) NOT NULL,
    Activo   BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_Idioma PRIMARY KEY (IdIdioma),
    CONSTRAINT UQ_Idioma_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE NivelIdioma
(
    IdNivelIdioma    INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(20) NOT NULL,
    OrdenComparacion TINYINT     NOT NULL,
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelIdioma PRIMARY KEY (IdNivelIdioma),
    CONSTRAINT UQ_NivelIdioma_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelIdioma_Orden UNIQUE (OrdenComparacion)
);
GO

CREATE TABLE NivelHabilidad
(
    IdNivelHabilidad INT         NOT NULL IDENTITY (1,1),
    Nombre           VARCHAR(20) NOT NULL,
    OrdenComparacion TINYINT     NOT NULL,
    Activo           BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_NivelHabilidad PRIMARY KEY (IdNivelHabilidad),
    CONSTRAINT UQ_NivelHabilidad_Nombre UNIQUE (Nombre),
    CONSTRAINT UQ_NivelHabilidad_Orden UNIQUE (OrdenComparacion)
);
GO

CREATE TABLE TipoCertificacion
(
    IdTipoCertificacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(80) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoCertificacion PRIMARY KEY (IdTipoCertificacion),
    CONSTRAINT UQ_TipoCertificacion_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE TipoRecomendacion
(
    IdTipoRecomendacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(30) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoRecomendacion PRIMARY KEY (IdTipoRecomendacion)
);
GO

CREATE TABLE Pais
(
    IdPais INT IDENTITY (1,1) NOT NULL,
    Nombre VARCHAR(100)       NOT NULL,
    Activo BIT                NOT NULL DEFAULT 1,
    CONSTRAINT PK_Pais PRIMARY KEY (IdPais),
    CONSTRAINT UQ_Pais_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE TipoParticipacion
(
    IdTipoParticipacion INT         NOT NULL IDENTITY (1,1),
    Nombre              VARCHAR(30) NOT NULL,
    Activo              BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoParticipacion PRIMARY KEY (IdTipoParticipacion)
);
GO

CREATE TABLE TipoRedSocial
(
    IdTipoRedSocial INT         NOT NULL IDENTITY (1,1),
    Nombre          VARCHAR(50) NOT NULL,
    Activo          BIT         NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoRedSocial PRIMARY KEY (IdTipoRedSocial),
    CONSTRAINT UQ_TipoRedSocial_Nombre UNIQUE (Nombre)
);
GO

-- ==============================================================================
-- SECCION 2: TABLAS DE SEGURIDAD
-- ==============================================================================

CREATE TABLE Usuario
(
    IdUsuario        INT          NOT NULL IDENTITY (1,1),
    Correo           VARCHAR(150) NOT NULL,
    PasswordHash     VARCHAR(255) NOT NULL,
    IntentosFallidos TINYINT      NOT NULL DEFAULT 0,
    FechaRegistro    DATETIME2    NOT NULL DEFAULT GETDATE(),
    TokenDesbloqueo  VARCHAR(100) NULL,
    FechaTokenExp    DATETIME2    NULL,
    IdEstadoUsuario  INT          NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (IdUsuario),
    CONSTRAINT UQ_Usuario_Correo UNIQUE (Correo),
    CONSTRAINT FK_Usuario_Estado
        FOREIGN KEY (IdEstadoUsuario) REFERENCES EstadoUsuario (IdEstadoUsuario),
    CONSTRAINT CK_Usuario_Intentos CHECK (IntentosFallidos >= 0 AND IntentosFallidos <= 10)
);
GO

CREATE TABLE TokenVerificacion
(
    IdTokenVerificacion INT          NOT NULL IDENTITY(1,1),
    Token               VARCHAR(100) NOT NULL,
    FechaExpiracion     DATETIME2    NOT NULL,
    IdUsuario           INT          NOT NULL,
    CONSTRAINT PK_TokenVerificacion PRIMARY KEY (IdTokenVerificacion),
    CONSTRAINT UQ_TokenVerificacion_Token UNIQUE (Token),
    CONSTRAINT FK_TokenVerificacion_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE
);
GO

CREATE TABLE Administrador
(
    IdUsuario INT NOT NULL,
    CONSTRAINT PK_Administrador PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Administrador_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE
);
GO

CREATE TABLE Rol
(
    IdRol       INT          NOT NULL IDENTITY (1,1),
    Nombre      VARCHAR(80)  NOT NULL,
    Descripcion VARCHAR(300) NULL,
    CONSTRAINT PK_Rol PRIMARY KEY (IdRol),
    CONSTRAINT UQ_Rol_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE Privilegio
(
    IdPrivilegio INT          NOT NULL IDENTITY (1,1),
    Nombre       VARCHAR(80)  NOT NULL,
    NombreMenu   VARCHAR(100) NOT NULL,
    Ruta         VARCHAR(200) NULL,
    CONSTRAINT PK_Privilegio PRIMARY KEY (IdPrivilegio),
    CONSTRAINT UQ_Privilegio_Nombre UNIQUE (Nombre)
);
GO

CREATE TABLE UsuarioRol
(
    IdUsuario INT NOT NULL,
    IdRol     INT NOT NULL,
    CONSTRAINT PK_UsuarioRol PRIMARY KEY (IdUsuario, IdRol),
    CONSTRAINT FK_UsuarioRol_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_UsuarioRol_Rol
        FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
);
GO

CREATE TABLE RolPrivilegio
(
    IdRol        INT NOT NULL,
    IdPrivilegio INT NOT NULL,
    CONSTRAINT PK_RolPrivilegio PRIMARY KEY (IdRol, IdPrivilegio),
    CONSTRAINT FK_RolPrivilegio_Rol
        FOREIGN KEY (IdRol) REFERENCES Rol (IdRol)
            ON DELETE CASCADE,
    CONSTRAINT FK_RolPrivilegio_Privilegio
        FOREIGN KEY (IdPrivilegio) REFERENCES Privilegio (IdPrivilegio)
);
GO

-- ==============================================================================
-- SECCION 3: TABLAS PRINCIPALES
-- ==============================================================================

CREATE TABLE Postulante
(
    IdUsuario       INT          NOT NULL,
    Nombres         VARCHAR(100) NOT NULL,
    Apellidos       VARCHAR(100) NOT NULL,
    FechaNacimiento DATE         NOT NULL,
    NumDocumento    VARCHAR(20)  NOT NULL,
    Nup             VARCHAR(20)  NULL,
    Nit             VARCHAR(20)  NULL,
    Direccion       VARCHAR(300) NOT NULL,
    FotoUrl         VARCHAR(500) NULL,
    CvUrl           VARCHAR(500) NULL,
    IdGenero        INT          NOT NULL,
    IdTipoDocumento INT          NOT NULL,
    IdDistrito      INT          NOT NULL,
    CONSTRAINT PK_Postulante PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Postulante_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Postulante_Genero
        FOREIGN KEY (IdGenero) REFERENCES Genero (IdGenero),
    CONSTRAINT FK_Postulante_TipoDocumento
        FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento (IdTipoDocumento),
    CONSTRAINT FK_Postulante_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT CK_Postulante_NumDocumento
        CHECK (
            (IdTipoDocumento = 1 AND NumDocumento LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')
                OR (IdTipoDocumento <> 1 AND LEN(NumDocumento) > 0)
            ),
    CONSTRAINT CK_Postulante_Nup
        CHECK (Nup IS NULL OR (LEN(Nup) = 9 AND Nup NOT LIKE '%[^0-9]%')),
    CONSTRAINT CK_Postulante_Nit
        CHECK (Nit IS NULL OR (
            Nit LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]'
                OR Nit LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'
            ))
);
GO

CREATE TABLE PostulanteTelefono
(
    IdUsuario INT         NOT NULL,
    Telefono  VARCHAR(15) NOT NULL,
    CONSTRAINT PK_PostulanteTelefono PRIMARY KEY (IdUsuario, Telefono),
    CONSTRAINT FK_PostulanteTelefono_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_PostulanteTelefono_Formato
        CHECK (Telefono LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE PostulanteRedSocial
(
    IdUsuario       INT          NOT NULL,
    IdTipoRedSocial INT          NOT NULL,
    Url             VARCHAR(500) NOT NULL,
    CONSTRAINT PK_PostulanteRedSocial PRIMARY KEY (IdUsuario, IdTipoRedSocial),
    CONSTRAINT FK_PostulanteRedSocial_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteRedSocial_Tipo
        FOREIGN KEY (IdTipoRedSocial) REFERENCES TipoRedSocial (IdTipoRedSocial)
);
GO

CREATE TABLE ExperienciaLaboral
(
    NumExp           INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    NombreEmpresa    VARCHAR(150) NOT NULL,
    Puesto           VARCHAR(120) NOT NULL,
    FechaInicio      DATE         NOT NULL,
    FechaFin         DATE         NULL,
    TrabajoActual    BIT          NOT NULL DEFAULT 0,
    Funciones        VARCHAR(MAX) NOT NULL,
    TelefonoContacto VARCHAR(15)  NULL,
    CorreoContacto   VARCHAR(150) NULL,
    CONSTRAINT PK_ExperienciaLaboral PRIMARY KEY (NumExp, IdUsuario),
    CONSTRAINT FK_ExperienciaLaboral_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_ExperienciaLaboral_Fechas
        CHECK (FechaFin IS NULL OR FechaFin >= FechaInicio),
    CONSTRAINT CK_ExperienciaLaboral_Actual
        CHECK (TrabajoActual = 0 OR (TrabajoActual = 1 AND FechaFin IS NULL)),
    CONSTRAINT CK_ExperienciaLaboral_Telefono
        CHECK (TelefonoContacto IS NULL
            OR TelefonoContacto LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR TelefonoContacto LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR TelefonoContacto LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    CONSTRAINT CK_ExperienciaLaboral_Correo
        CHECK (CorreoContacto IS NULL
            OR (CorreoContacto LIKE '%@%.%'
                AND LEN(CorreoContacto) >= 6))
);
GO

CREATE TABLE FormacionAcademica
(
    NumFormacion     INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    Institucion      VARCHAR(200) NOT NULL,
    Titulo           VARCHAR(200) NOT NULL,
    IdNivelEducativo INT          NOT NULL,
    FechaInicio      DATE         NOT NULL,
    FechaFin         DATE         NULL,
    EnCurso          BIT          NOT NULL DEFAULT 0,
    CONSTRAINT PK_FormacionAcademica PRIMARY KEY (NumFormacion, IdUsuario),
    CONSTRAINT FK_FormacionAcademica_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_FormacionAcademica_NivelEducativo
        FOREIGN KEY (IdNivelEducativo) REFERENCES NivelEducativo (IdNivelEducativo),
    CONSTRAINT CK_FormacionAcademica_Fechas
        CHECK (FechaFin IS NULL OR FechaFin >= FechaInicio),
    CONSTRAINT CK_FormacionAcademica_EnCurso
        CHECK (EnCurso = 0 OR (EnCurso = 1 AND FechaFin IS NULL))
);
GO

CREATE TABLE Certificacion
(
    CodCert             INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    CodigoCertificacion VARCHAR(100) NULL,
    Nombre              VARCHAR(200) NOT NULL,
    IdTipoCertificacion INT          NOT NULL,
    Institucion         VARCHAR(200) NOT NULL,
    FechaObtencion      DATE         NOT NULL,
    ArchivoUrl          VARCHAR(500) NULL,
    CONSTRAINT PK_Certificacion PRIMARY KEY (CodCert, IdUsuario),
    CONSTRAINT FK_Certificacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Certificacion_Tipo
        FOREIGN KEY (IdTipoCertificacion) REFERENCES TipoCertificacion (IdTipoCertificacion)
);
GO

CREATE TABLE Logro
(
    NumLogro    INT          NOT NULL,
    IdUsuario   INT          NOT NULL,
    Descripcion VARCHAR(MAX) NOT NULL,
    Fecha       DATE         NOT NULL,
    CONSTRAINT PK_Logro PRIMARY KEY (NumLogro, IdUsuario),
    CONSTRAINT FK_Logro_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO

CREATE TABLE Recomendacion
(
    NumRecomendacion    INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    NombreContacto      VARCHAR(150) NOT NULL,
    TelefonoContacto    VARCHAR(15)  NOT NULL,
    IdTipoRecomendacion INT          NOT NULL,
    CONSTRAINT PK_Recomendacion PRIMARY KEY (NumRecomendacion, IdUsuario),
    CONSTRAINT FK_Recomendacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Recomendacion_Tipo
        FOREIGN KEY (IdTipoRecomendacion) REFERENCES TipoRecomendacion (IdTipoRecomendacion)
);
GO

CREATE TABLE Evento
(
    NumEvento           INT          NOT NULL,
    IdUsuario           INT          NOT NULL,
    NombreEvento        VARCHAR(200) NOT NULL,
    Lugar               VARCHAR(200) NOT NULL,
    Anfitrion           VARCHAR(200) NOT NULL,
    Fecha               DATE         NOT NULL,
    IdTipoParticipacion INT          NOT NULL,
    IdPais              INT          NOT NULL,
    CONSTRAINT PK_Evento PRIMARY KEY (NumEvento, IdUsuario),
    CONSTRAINT FK_Evento_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Evento_TipoParticipacion
        FOREIGN KEY (IdTipoParticipacion) REFERENCES TipoParticipacion (IdTipoParticipacion),
    CONSTRAINT FK_Evento_Pais
        FOREIGN KEY (IdPais) REFERENCES Pais (IdPais)
);
GO

CREATE TABLE Publicacion
(
    NumPublicacion   INT          NOT NULL,
    IdUsuario        INT          NOT NULL,
    Titulo           VARCHAR(300) NOT NULL,
    LugarPublicacion VARCHAR(200) NOT NULL,
    Fecha            DATE         NOT NULL,
    Isbn             VARCHAR(20)  NULL,
    Edicion          VARCHAR(100) NULL,
    CONSTRAINT PK_Publicacion PRIMARY KEY (NumPublicacion, IdUsuario),
    CONSTRAINT FK_Publicacion_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO

CREATE TABLE Examen
(
    NumExamen  INT          NOT NULL,
    IdUsuario  INT          NOT NULL,
    Tipo       VARCHAR(100) NOT NULL,
    Resultado  VARCHAR(100) NOT NULL,
    Fecha      DATE         NOT NULL,
    ArchivoUrl VARCHAR(500) NULL,
    CONSTRAINT PK_Examen PRIMARY KEY (NumExamen, IdUsuario),
    CONSTRAINT FK_Examen_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE
);
GO

CREATE TABLE PostulanteHabilidad
(
    IdUsuario        INT NOT NULL,
    IdHabilidad      INT NOT NULL,
    IdNivelHabilidad INT NOT NULL,
    CONSTRAINT PK_PostulanteHabilidad PRIMARY KEY (IdUsuario, IdHabilidad),
    CONSTRAINT FK_PostulanteHabilidad_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteHabilidad_Habilidad
        FOREIGN KEY (IdHabilidad) REFERENCES Habilidad (IdHabilidad),
    CONSTRAINT FK_PostulanteHabilidad_Nivel
        FOREIGN KEY (IdNivelHabilidad) REFERENCES NivelHabilidad (IdNivelHabilidad)
);
GO

CREATE TABLE PostulanteIdioma
(
    IdUsuario           INT NOT NULL,
    IdIdioma            INT NOT NULL,
    IdNivelLectura      INT NOT NULL,
    IdNivelEscritura    INT NOT NULL,
    IdNivelConversacion INT NOT NULL,
    IdNivelEscucha      INT NOT NULL,
    CONSTRAINT PK_PostulanteIdioma PRIMARY KEY (IdUsuario, IdIdioma),
    CONSTRAINT FK_PostulanteIdioma_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_PostulanteIdioma_Idioma
        FOREIGN KEY (IdIdioma) REFERENCES Idioma (IdIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelLectura
        FOREIGN KEY (IdNivelLectura) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelEscritura
        FOREIGN KEY (IdNivelEscritura) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelConversacion
        FOREIGN KEY (IdNivelConversacion) REFERENCES NivelIdioma (IdNivelIdioma),
    CONSTRAINT FK_PostulanteIdioma_NivelEscucha
        FOREIGN KEY (IdNivelEscucha) REFERENCES NivelIdioma (IdNivelIdioma)
);
GO

CREATE TABLE Empresa
(
    IdUsuario       INT          NOT NULL,
    NombreComercial VARCHAR(150) NOT NULL,
    RazonSocial     VARCHAR(200) NOT NULL,
    Nit             VARCHAR(17)  NOT NULL,
    SitioWeb        VARCHAR(300) NULL,
    Descripcion     VARCHAR(MAX) NULL,
    LogoUrl         VARCHAR(500) NULL,
    IdDistrito      INT          NOT NULL,
    CONSTRAINT PK_Empresa PRIMARY KEY (IdUsuario),
    CONSTRAINT FK_Empresa_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES Usuario (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_Empresa_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT UQ_Empresa_Nit UNIQUE (Nit),
    CONSTRAINT CK_Empresa_Nit
        CHECK (Nit LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9]')
);
GO

CREATE TABLE EmpresaTelefono
(
    IdUsuario INT         NOT NULL,
    Telefono  VARCHAR(15) NOT NULL,
    CONSTRAINT PK_EmpresaTelefono PRIMARY KEY (IdUsuario, Telefono),
    CONSTRAINT FK_EmpresaTelefono_Empresa
        FOREIGN KEY (IdUsuario) REFERENCES Empresa (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT CK_EmpresaTelefono_Formato
        CHECK (Telefono LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
            OR Telefono LIKE '+[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);
GO

CREATE TABLE OfertaTrabajo
(
    IdOferta               INT            NOT NULL IDENTITY (1,1),
    Titulo                 VARCHAR(200)   NOT NULL,
    Descripcion            VARCHAR(MAX)   NOT NULL,
    SalarioMin             DECIMAL(10, 2) NULL,
    SalarioMax             DECIMAL(10, 2) NULL,
    NumVacantes            SMALLINT       NOT NULL DEFAULT 1,
    AniosExperienciaMinima SMALLINT       NOT NULL DEFAULT 0,
    FechaPublicacion       DATETIME2      NOT NULL DEFAULT GETDATE(),
    FechaVencimiento       DATE           NOT NULL,
    IdEmpresa              INT            NOT NULL,
    IdTipoContrato         INT            NOT NULL,
    IdNivelEducativo       INT            NOT NULL,
    IdModalidad            INT            NOT NULL,
    IdEstadoOferta         INT            NOT NULL,
    IdDistrito             INT            NOT NULL,
    PesoHabilidades        DECIMAL(5, 2)  NOT NULL DEFAULT 0.35,
    PesoAcademico          DECIMAL(5, 2)  NOT NULL DEFAULT 0.25,
    PesoExperiencia        DECIMAL(5, 2)  NOT NULL DEFAULT 0.20,
    PesoIdiomas            DECIMAL(5, 2)  NOT NULL DEFAULT 0.20,
    CONSTRAINT PK_OfertaTrabajo PRIMARY KEY (IdOferta),
    CONSTRAINT FK_OfertaTrabajo_Empresa
        FOREIGN KEY (IdEmpresa) REFERENCES Empresa (IdUsuario)
            ON DELETE CASCADE,
    CONSTRAINT FK_OfertaTrabajo_TipoContrato
        FOREIGN KEY (IdTipoContrato) REFERENCES TipoContrato (IdTipoContrato),
    CONSTRAINT FK_OfertaTrabajo_NivelEducativo
        FOREIGN KEY (IdNivelEducativo) REFERENCES NivelEducativo (IdNivelEducativo),
    CONSTRAINT FK_OfertaTrabajo_Modalidad
        FOREIGN KEY (IdModalidad) REFERENCES Modalidad (IdModalidad),
    CONSTRAINT FK_OfertaTrabajo_EstadoOferta
        FOREIGN KEY (IdEstadoOferta) REFERENCES EstadoOferta (IdEstadoOferta),
    CONSTRAINT FK_OfertaTrabajo_Distrito
        FOREIGN KEY (IdDistrito) REFERENCES Distrito (IdDistrito),
    CONSTRAINT CK_OfertaTrabajo_Salario
        CHECK (SalarioMin IS NULL OR SalarioMax IS NULL OR SalarioMax >= SalarioMin),
    CONSTRAINT CK_OfertaTrabajo_Vacantes
        CHECK (NumVacantes >= 1),
    CONSTRAINT CK_OfertaTrabajo_Experiencia
        CHECK (AniosExperienciaMinima >= 0),
    CONSTRAINT CK_OfertaTrabajo_FechaVencimiento
        CHECK (FechaVencimiento > CAST(FechaPublicacion AS DATE))
);
GO

CREATE TABLE OfertaHabilidad
(
    IdOferta         INT NOT NULL,
    IdHabilidad      INT NOT NULL,
    IdNivelHabilidad INT NOT NULL,
    CONSTRAINT PK_OfertaHabilidad PRIMARY KEY (IdOferta, IdHabilidad),
    CONSTRAINT FK_OfertaHabilidad_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo (IdOferta)
            ON DELETE CASCADE,
    CONSTRAINT FK_OfertaHabilidad_Habilidad
        FOREIGN KEY (IdHabilidad) REFERENCES Habilidad (IdHabilidad),
    CONSTRAINT FK_OfertaHabilidad_Nivel
        FOREIGN KEY (IdNivelHabilidad) REFERENCES NivelHabilidad (IdNivelHabilidad)
);
GO

CREATE TABLE OfertaIdioma
(
    IdOferta      INT NOT NULL,
    IdIdioma      INT NOT NULL,
    IdNivelIdioma INT NOT NULL,
    CONSTRAINT PK_OfertaIdioma PRIMARY KEY (IdOferta, IdIdioma),
    CONSTRAINT FK_OfertaIdioma_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo (IdOferta)
            ON DELETE CASCADE,
    CONSTRAINT FK_OfertaIdioma_Idioma
        FOREIGN KEY (IdIdioma) REFERENCES Idioma (IdIdioma),
    CONSTRAINT FK_OfertaIdioma_Nivel
        FOREIGN KEY (IdNivelIdioma) REFERENCES NivelIdioma (IdNivelIdioma)
);
GO

CREATE TABLE PostulanteOferta
(
    IdUsuario          INT       NOT NULL,
    IdOferta           INT       NOT NULL,
    FechaAplicacion    DATETIME2 NOT NULL DEFAULT GETDATE(),
    IdEstadoAplicacion INT       NOT NULL,
    CONSTRAINT PK_PostulanteOferta PRIMARY KEY (IdUsuario, IdOferta),
    CONSTRAINT FK_PostulanteOferta_Postulante
        FOREIGN KEY (IdUsuario) REFERENCES Postulante(IdUsuario)
            ON DELETE NO ACTION,
    CONSTRAINT FK_PostulanteOferta_Oferta
        FOREIGN KEY (IdOferta) REFERENCES OfertaTrabajo(IdOferta)
            ON DELETE NO ACTION,
    CONSTRAINT FK_PostulanteOferta_Estado
        FOREIGN KEY (IdEstadoAplicacion) REFERENCES EstadoAplicacion (IdEstadoAplicacion)
);
GO

CREATE TABLE ConfiguracionSistema
(
    Clave       VARCHAR(100) NOT NULL,
    Valor       VARCHAR(500) NOT NULL,
    Descripcion VARCHAR(300) NULL,
    CONSTRAINT PK_ConfiguracionSistema PRIMARY KEY (Clave)
);
GO

CREATE TABLE AuditoriaUsuario
(
    IdAuditoria     INT          NOT NULL IDENTITY (1,1),
    IdUsuario       INT          NOT NULL,
    Accion          VARCHAR(10)  NOT NULL,
    CampoModificado VARCHAR(60)  NULL,
    ValorAnterior   VARCHAR(255) NULL,
    ValorNuevo      VARCHAR(255) NULL,
    FechaAccion     DATETIME2    NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AuditoriaUsuario PRIMARY KEY (IdAuditoria),
    CONSTRAINT CK_AuditoriaUsuario_Accion
        CHECK (Accion IN ('INSERT', 'UPDATE', 'DELETE'))
);
GO

CREATE TABLE AuditoriaRol
(
    IdAuditoria INT         NOT NULL IDENTITY (1,1),
    IdUsuario   INT         NOT NULL,
    IdRol       INT         NOT NULL,
    Accion      VARCHAR(10) NOT NULL,
    FechaAccion DATETIME2   NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AuditoriaRol PRIMARY KEY (IdAuditoria),
    CONSTRAINT CK_AuditoriaRol_Accion CHECK (Accion IN ('ASSIGN', 'REVOKE'))
);
GO

-- ==============================================================================
-- SECCION 4: CREACION DE INDICES
-- ==============================================================================

-- Usuarios
CREATE INDEX IX_Usuario_EstadoUsuario     ON Usuario(IdEstadoUsuario);

-- Postulante
CREATE INDEX IX_Postulante_Distrito       ON Postulante(IdDistrito);
CREATE INDEX IX_Postulante_NombreCompleto ON Postulante(Apellidos, Nombres);

-- Empresa
CREATE INDEX IX_Empresa_Distrito          ON Empresa(IdDistrito);
CREATE INDEX IX_Empresa_NombreComercial   ON Empresa(NombreComercial);

-- OfertaTrabajo
CREATE INDEX IX_OfertaTrabajo_Empresa     ON OfertaTrabajo(IdEmpresa);
CREATE INDEX IX_OfertaTrabajo_Experiencia ON OfertaTrabajo(AniosExperienciaMinima);

CREATE INDEX IX_OfertaTrabajo_FiltrosDinamicos
    ON OfertaTrabajo(IdEstadoOferta, IdDistrito, IdModalidad, IdTipoContrato, IdNivelEducativo);

CREATE INDEX IX_OfertaTrabajo_Vencimiento
    ON OfertaTrabajo(FechaVencimiento)
    INCLUDE (Titulo, IdEmpresa);

-- PostulanteOferta
CREATE INDEX IX_PostulanteOferta_Oferta   ON PostulanteOferta(IdOferta);
CREATE INDEX IX_PostulanteOferta_Estado   ON PostulanteOferta(IdEstadoAplicacion);

-- Matching
CREATE INDEX IX_PostulanteHabilidad_Habilidad ON PostulanteHabilidad(IdHabilidad);
CREATE INDEX IX_PostulanteIdioma_Idioma        ON PostulanteIdioma(IdIdioma);

-- Distrito
CREATE INDEX IX_Distrito_Departamento     ON Distrito(IdDepartamento);
GO

-- ==============================================================================
-- SECCION 5: CREACION DE FUNCIONES
-- ==============================================================================

CREATE OR ALTER FUNCTION fn_CalcularEdad(
    @FechaNacimiento DATE
)
    RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @FechaNacimiento, GETDATE())
        - IIF(MONTH(@FechaNacimiento) > MONTH(GETDATE())
                  OR (MONTH(@FechaNacimiento) = MONTH(GETDATE())
                AND DAY(@FechaNacimiento) > DAY(GETDATE())), 1, 0);
END;
GO

CREATE OR ALTER FUNCTION fn_PorcentajeCompletitudPerfil(
    @IdUsuario INT
)
    RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Puntaje INT = 0;
    DECLARE @Total INT = 4;

    IF EXISTS (SELECT 1 FROM Postulante WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    IF EXISTS (SELECT 1 FROM ExperienciaLaboral WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    IF EXISTS (SELECT 1 FROM FormacionAcademica WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    IF EXISTS (SELECT 1 FROM PostulanteHabilidad WHERE IdUsuario = @IdUsuario)
        SET @Puntaje = @Puntaje + 1;

    RETURN CAST(@Puntaje AS DECIMAL(5, 2)) / @Total * 100;
END;
GO

CREATE OR ALTER FUNCTION fn_PuntajeMatching(
    @IdUsuario INT,
    @IdOferta INT
)
    RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @Alpha DECIMAL(5, 2); 
    DECLARE @Beta DECIMAL(5, 2); 
    DECLARE @Gamma DECIMAL(5, 2); 
    DECLARE @Delta DECIMAL(5, 2); 

    SELECT @Alpha = PesoHabilidades,
           @Beta = PesoAcademico,
           @Gamma = PesoExperiencia,
           @Delta = PesoIdiomas
    FROM OfertaTrabajo
    WHERE IdOferta = @IdOferta;

    IF @Alpha IS NULL OR @Beta IS NULL OR @Gamma IS NULL OR @Delta IS NULL
    BEGIN
        SELECT @Alpha = CAST(Valor AS DECIMAL(5, 2))
        FROM ConfiguracionSistema
        WHERE Clave = 'COEFICIENTE_HABILIDADES';
        SELECT @Beta = CAST(Valor AS DECIMAL(5, 2))
        FROM ConfiguracionSistema
        WHERE Clave = 'COEFICIENTE_ACADEMICO';
        SELECT @Gamma = CAST(Valor AS DECIMAL(5, 2))
        FROM ConfiguracionSistema
        WHERE Clave = 'COEFICIENTE_EXPERIENCIA';
        SELECT @Delta = CAST(Valor AS DECIMAL(5, 2))
        FROM ConfiguracionSistema
        WHERE Clave = 'COEFICIENTE_IDIOMAS';

        IF @Alpha IS NULL SET @Alpha = 0.35;
        IF @Beta IS NULL SET @Beta = 0.25;
        IF @Gamma IS NULL SET @Gamma = 0.20;
        IF @Delta IS NULL SET @Delta = 0.20;
    END

    DECLARE @HabilidadesReq INT;
    DECLARE @HabilidadesOk INT;

    SELECT @HabilidadesReq = COUNT(*)
    FROM OfertaHabilidad
    WHERE IdOferta = @IdOferta;

    SELECT @HabilidadesOk = COUNT(*)
    FROM PostulanteHabilidad ph
             JOIN OfertaHabilidad oh ON ph.IdHabilidad = oh.IdHabilidad
        AND oh.IdOferta = @IdOferta
             JOIN NivelHabilidad nph ON ph.IdNivelHabilidad = nph.IdNivelHabilidad
             JOIN NivelHabilidad noh ON oh.IdNivelHabilidad = noh.IdNivelHabilidad
    WHERE ph.IdUsuario = @IdUsuario
      AND nph.OrdenComparacion >= noh.OrdenComparacion;

    DECLARE @H DECIMAL(5, 2) =
        CASE
            WHEN @HabilidadesReq = 0 THEN 1.00
            ELSE CAST(@HabilidadesOk AS DECIMAL(5, 2)) / CAST(@HabilidadesReq AS DECIMAL(5, 2))
            END;

    DECLARE @NivelReqOferta INT;
    SELECT @NivelReqOferta = IdNivelEducativo
    FROM OfertaTrabajo
    WHERE IdOferta = @IdOferta;

    DECLARE @OrdReq INT = 0;
    SELECT @OrdReq = ne.OrdenComparacion
    FROM NivelEducativo ne
    WHERE ne.IdNivelEducativo = @NivelReqOferta;

    DECLARE @OrdMax INT = 0;
    SELECT @OrdMax = ISNULL(MAX(ne2.OrdenComparacion), 0)
    FROM FormacionAcademica fa
             JOIN NivelEducativo ne2 ON fa.IdNivelEducativo = ne2.IdNivelEducativo
    WHERE fa.IdUsuario = @IdUsuario;

    DECLARE @A DECIMAL(5, 2) =
        CASE WHEN @OrdMax >= @OrdReq THEN 1.00 ELSE 0.00 END;

    DECLARE @AniosReq DECIMAL(5, 2) = 0;
    SELECT @AniosReq = ISNULL(AniosExperienciaMinima, 0)
    FROM OfertaTrabajo
    WHERE IdOferta = @IdOferta;

    DECLARE @AniosPostulante DECIMAL(5, 2) = 0;
    SELECT @AniosPostulante = ISNULL(
            SUM(DATEDIFF(MONTH, FechaInicio, ISNULL(FechaFin, GETDATE())) / 12.0),
            0)
    FROM ExperienciaLaboral
    WHERE IdUsuario = @IdUsuario;

    DECLARE @E DECIMAL(5, 2) =
        CASE
            WHEN @AniosReq = 0 THEN 1.00
            WHEN @AniosPostulante >= @AniosReq THEN 1.00
            ELSE @AniosPostulante / @AniosReq
            END;
    IF @E > 1.00 SET @E = 1.00;

    DECLARE @IdiomasReq INT;
    DECLARE @IdiomasOk INT;

    SELECT @IdiomasReq = COUNT(*)
    FROM OfertaIdioma
    WHERE IdOferta = @IdOferta;

    SELECT @IdiomasOk = COUNT(*)
    FROM PostulanteIdioma pi2
             JOIN OfertaIdioma oi ON pi2.IdIdioma = oi.IdIdioma
        AND oi.IdOferta = @IdOferta
             JOIN NivelIdioma nr ON oi.IdNivelIdioma = nr.IdNivelIdioma
             JOIN NivelIdioma nLec ON pi2.IdNivelLectura = nLec.IdNivelIdioma
             JOIN NivelIdioma nEsc ON pi2.IdNivelEscritura = nEsc.IdNivelIdioma
             JOIN NivelIdioma nCon ON pi2.IdNivelConversacion = nCon.IdNivelIdioma
             JOIN NivelIdioma nLis ON pi2.IdNivelEscucha = nLis.IdNivelIdioma
    WHERE pi2.IdUsuario = @IdUsuario
      AND (SELECT MIN(v)
           FROM (VALUES (nLec.OrdenComparacion),
                        (nEsc.OrdenComparacion),
                        (nCon.OrdenComparacion),
                        (nLis.OrdenComparacion)) AS T(v)) >= nr.OrdenComparacion;

    DECLARE @I DECIMAL(5, 2) =
        CASE
            WHEN @IdiomasReq = 0 THEN 1.00
            ELSE CAST(@IdiomasOk AS DECIMAL(5, 2)) / CAST(@IdiomasReq AS DECIMAL(5, 2))
            END;

    RETURN CAST((@Alpha * @H + @Beta * @A + @Gamma * @E + @Delta * @I) * 100 AS DECIMAL(5, 2));
END;
GO

-- ==============================================================================
-- SECCION 6: PROCEDIMIENTOS ALMACENADOS
-- ==============================================================================

CREATE OR ALTER PROCEDURE sp_RegistrarIntentoFallido @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @Intentos INT;
        DECLARE @IdBloqueado INT;
        DECLARE @MaxIntentos INT;

        SELECT @MaxIntentos = CAST(Valor AS INT)
        FROM ConfiguracionSistema
        WHERE Clave = 'MAX_INTENTOS_FALLIDOS';

        IF @MaxIntentos IS NULL SET @MaxIntentos = 3;

        SELECT @Intentos = IntentosFallidos
        FROM Usuario
        WHERE IdUsuario = @IdUsuario;

        IF @Intentos IS NULL
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        SET @Intentos = @Intentos + 1;

        SELECT @IdBloqueado = IdEstadoUsuario
        FROM EstadoUsuario
        WHERE Nombre = 'BLOQUEADO';

        IF @Intentos >= @MaxIntentos
            BEGIN
                UPDATE Usuario
                SET IntentosFallidos = @Intentos,
                    IdEstadoUsuario  = @IdBloqueado
                WHERE IdUsuario = @IdUsuario;
            END
        ELSE
            BEGIN
                UPDATE Usuario
                SET IntentosFallidos = @Intentos
                WHERE IdUsuario = @IdUsuario;
            END

        SELECT IntentosFallidos, IdEstadoUsuario
        FROM Usuario
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_ResetearIntentosFallidos @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        UPDATE Usuario
        SET IntentosFallidos = 0
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_GenerarTokenDesbloqueo @IdUsuario INT,
                                                    @Token VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @HorasExp INT;

        SELECT @HorasExp = CAST(Valor AS INT)
        FROM ConfiguracionSistema
        WHERE Clave = 'TOKEN_EXPIRACION_HORAS';

        IF @HorasExp IS NULL SET @HorasExp = 24;

        IF NOT EXISTS (SELECT 1 FROM Usuario WHERE IdUsuario = @IdUsuario)
            BEGIN
                RAISERROR ('Usuario con IdUsuario %d no encontrado.', 16, 1, @IdUsuario);
                RETURN;
            END

        UPDATE Usuario
        SET TokenDesbloqueo = @Token,
            FechaTokenExp   = DATEADD(HOUR, @HorasExp, GETDATE())
        WHERE IdUsuario = @IdUsuario;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_DesbloquearUsuario @Token VARCHAR(100),
                                                @Resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @IdUsuario INT;
        DECLARE @FechaExp DATETIME2;
        DECLARE @IdActivo INT;

        SELECT @IdUsuario = IdUsuario,
               @FechaExp = FechaTokenExp
        FROM Usuario
        WHERE TokenDesbloqueo = @Token;

        IF @IdUsuario IS NULL
            BEGIN
                SET @Resultado = 1;
                RETURN;
            END

        IF GETDATE() > @FechaExp
            BEGIN
                SET @Resultado = 2;
                RETURN;
            END

        SELECT @IdActivo = IdEstadoUsuario
        FROM EstadoUsuario
        WHERE Nombre = 'ACTIVO';

        UPDATE Usuario
        SET IdEstadoUsuario  = @IdActivo,
            IntentosFallidos = 0,
            TokenDesbloqueo  = NULL,
            FechaTokenExp    = NULL
        WHERE IdUsuario = @IdUsuario;

        SET @Resultado = 0;
    END TRY
    BEGIN CATCH
        SET @Resultado = -1;
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_ObtenerPrivilegiosUsuario @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT DISTINCT p.IdPrivilegio,
                        p.Nombre,
                        p.NombreMenu,
                        p.Ruta
        FROM UsuarioRol ur
                 JOIN RolPrivilegio rp ON ur.IdRol = rp.IdRol
                 JOIN Privilegio p ON rp.IdPrivilegio = p.IdPrivilegio
        WHERE ur.IdUsuario = @IdUsuario
        ORDER BY p.Nombre;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE sp_ObtenerAspirantes @IdOferta INT,
                                               @IdDepartamento INT = NULL,
                                               @SoloDisponibles BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DECLARE @HabilidadesRequeridas INT;
        SELECT @HabilidadesRequeridas = COUNT(*)
        FROM OfertaHabilidad
        WHERE IdOferta = @IdOferta;

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

               dbo.fn_PuntajeMatching(p.IdUsuario, @IdOferta)                                 AS PuntajeMatching

        FROM Postulante p
                 JOIN Usuario u ON p.IdUsuario = u.IdUsuario
                 JOIN Distrito dis ON p.IdDistrito = dis.IdDistrito
                 JOIN Departamento dep ON dis.IdDepartamento = dep.IdDepartamento
                 JOIN EstadoUsuario eu ON u.IdEstadoUsuario = eu.IdEstadoUsuario

        WHERE eu.Nombre = 'ACTIVO'
          AND (@IdDepartamento IS NULL OR dep.IdDepartamento = @IdDepartamento)
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

CREATE OR ALTER PROCEDURE sp_AplicarOferta @IdUsuario INT,
                                           @IdOferta INT,
                                           @Resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1
                       FROM OfertaTrabajo o
                                JOIN EstadoOferta eo ON o.IdEstadoOferta = eo.IdEstadoOferta
                       WHERE o.IdOferta = @IdOferta
                         AND eo.Nombre = 'ACTIVA')
            BEGIN
                SET @Resultado = 2;
                RETURN;
            END

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

-- ==============================================================================
-- SECCION 7: TRIGGERS
-- ==============================================================================

CREATE OR ALTER TRIGGER trg_AuditarCambiosUsuario
    ON Usuario
    AFTER INSERT, UPDATE, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
        BEGIN
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario, 'INSERT', 'Correo', NULL, i.Correo
            FROM inserted i;
        END

    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT d.IdUsuario, 'DELETE', 'Correo', d.Correo, NULL
            FROM deleted d;
        END

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        BEGIN
            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario,
                   'UPDATE',
                   'IdEstadoUsuario',
                   CAST(d.IdEstadoUsuario AS VARCHAR(10)),
                   CAST(i.IdEstadoUsuario AS VARCHAR(10))
            FROM inserted i
                     JOIN deleted d ON i.IdUsuario = d.IdUsuario
            WHERE i.IdEstadoUsuario <> d.IdEstadoUsuario;

            INSERT INTO AuditoriaUsuario (IdUsuario, Accion, CampoModificado, ValorAnterior, ValorNuevo)
            SELECT i.IdUsuario,
                   'UPDATE',
                   'IntentosFallidos',
                   CAST(d.IntentosFallidos AS VARCHAR(5)),
                   CAST(i.IntentosFallidos AS VARCHAR(5))
            FROM inserted i
                     JOIN deleted d ON i.IdUsuario = d.IdUsuario
            WHERE i.IntentosFallidos <> d.IntentosFallidos;
        END
END;
GO

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

CREATE OR ALTER TRIGGER trg_AutonumerarExperiencia
    ON ExperienciaLaboral
    INSTEAD OF INSERT
    AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO ExperienciaLaboral
    (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
    SELECT
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

CREATE OR ALTER TRIGGER trg_ValidarRolMinimo
    ON UsuarioRol
    AFTER DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT d.IdUsuario
               FROM deleted d
               WHERE NOT EXISTS (SELECT 1
                                 FROM UsuarioRol ur
                                 WHERE ur.IdUsuario = d.IdUsuario))
        BEGIN
            RAISERROR (
                'No se puede revocar todos los roles. El usuario debe tener al menos un rol asignado.',
                16, 1
                );
            ROLLBACK TRANSACTION;
            RETURN;
        END
END;
GO

CREATE OR ALTER TRIGGER trg_AuditarCambiosRol
    ON UsuarioRol
    AFTER INSERT, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
        BEGIN
            INSERT INTO AuditoriaRol (IdUsuario, IdRol, Accion)
            SELECT i.IdUsuario, i.IdRol, 'ASSIGN'
            FROM inserted i;
        END

    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            INSERT INTO AuditoriaRol (IdUsuario, IdRol, Accion)
            SELECT d.IdUsuario, d.IdRol, 'REVOKE'
            FROM deleted d;
        END
END;
GO

-- ==============================================================================
-- SECCION 8: SEMILLAS DE CONFIGURACION Y CATALOGOS (DatosPrueba/01)
-- ==============================================================================

INSERT INTO ConfiguracionSistema (Clave, Valor, Descripcion)
VALUES ('MAX_INTENTOS_FALLIDOS', '3', N'Máximo de intentos fallidos antes de bloqueo de cuenta'),
       ('TOKEN_EXPIRACION_HORAS', '24', N'Horas de validez del token de desbloqueo de cuenta'),
       ('COEFICIENTE_HABILIDADES', '0.35', N'Peso (alfa) de habilidades técnicas en el algoritmo de matching'),
       ('COEFICIENTE_ACADEMICO', '0.25', N'Peso (beta) de nivel académico en el algoritmo de matching'),
       ('COEFICIENTE_EXPERIENCIA', '0.20', N'Peso (gamma) de experiencia laboral en el algoritmo de matching'),
       ('COEFICIENTE_IDIOMAS', '0.20', N'Peso (delta) de idiomas en el algoritmo de matching');

INSERT INTO EstadoUsuario (Nombre)
VALUES ('ACTIVO'), ('INACTIVO'), ('BLOQUEADO'), ('PENDIENTE_VERIFICACION');

INSERT INTO EstadoOferta (Nombre)
VALUES ('ACTIVA'), ('VENCIDA'), ('CERRADA'), ('PAUSADA');

INSERT INTO EstadoAplicacion (Nombre)
VALUES ('PENDIENTE'), ('REVISADA'), ('CONTACTADO'), ('RECHAZADO');

INSERT INTO Genero (Nombre)
VALUES ('MASCULINO'), ('FEMENINO'), ('OTRO'), ('PREFIERO_NO_DECIR');

INSERT INTO TipoDocumento (Nombre, Descripcion)
VALUES ('DUI', N'Documento Único de Identidad'),
       ('PASAPORTE', 'Pasaporte vigente'),
       ('CARNET_RESIDENTE', 'Carnet de residente extranjero');

INSERT INTO TipoContrato (Nombre)
VALUES ('TIEMPO_COMPLETO'), ('MEDIO_TIEMPO'), ('TEMPORAL'), ('FREELANCE');

INSERT INTO NivelEducativo (Nombre, OrdenComparacion)
VALUES ('BACHILLERATO', 1), ('TECNICO', 2), ('INGENIERIA', 3), ('LICENCIATURA', 4), ('MAESTRIA', 5), ('DOCTORADO', 6);

INSERT INTO Modalidad (Nombre)
VALUES ('PRESENCIAL'), ('REMOTO'), ('HIBRIDO');

INSERT INTO NivelHabilidad (Nombre, OrdenComparacion)
VALUES ('BASICO', 1), ('INTERMEDIO', 2), ('AVANZADO', 3), ('EXPERTO', 4);

INSERT INTO NivelIdioma (Nombre, OrdenComparacion)
VALUES ('A1', 1), ('A2', 2), ('B1', 3), ('B2', 4), ('C1', 5), ('C2', 6), ('NATIVO', 7);

INSERT INTO TipoCertificacion (Nombre)
VALUES ('TECNOLOGIA'), ('IDIOMA'), ('GESTION_PROYECTOS'), ('SEGURIDAD'), ('OTRO');

INSERT INTO TipoRecomendacion (Nombre)
VALUES ('PROFESIONAL'), ('PERSONAL'), ('ACADEMICA');

INSERT INTO Pais (Nombre)
VALUES ('El Salvador'), ('Guatemala'), ('Honduras'), ('Nicaragua'), ('Costa Rica'), (N'Panamá'), (N'México'), ('Estados Unidos');

INSERT INTO TipoParticipacion (Nombre)
VALUES ('PONENTE'), ('ASISTENTE'), ('ORGANIZADOR'), ('PATROCINADOR');

INSERT INTO TipoRedSocial (Nombre)
VALUES ('LINKEDIN'), ('GITHUB'), ('TWITTER'), ('FACEBOOK'), ('OTRO');

INSERT INTO Departamento (Nombre)
VALUES (N'Ahuachapán'), (N'Santa Ana'), (N'Sonsonate'), (N'Chalatenango'), (N'La Libertad'), (N'San Salvador'), (N'Cuscatlán'),
       (N'La Paz'), (N'Cabañas'), (N'San Vicente'), (N'Usulután'), (N'San Miguel'), (N'Morazán'), (N'La Unión');

-- 262 Distritos de El Salvador
INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Atiquizaya', 1), (N'El Refugio', 1), (N'San Lorenzo', 1), (N'Turín', 1), (N'Ahuachapán', 1),
       (N'Apaneca', 1), (N'Concepción de Ataco', 1), (N'Tacuba', 1), (N'Guaymango', 1), (N'Jujutla', 1),
       (N'San Francisco Menéndez', 1), (N'San Pedro Puxtla', 1);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Masahuat', 2), (N'Metapán', 2), (N'Santa Rosa Guachipilín', 2), (N'Texistepeque', 2), (N'Santa Ana', 2),
       (N'Coatepeque', 2), (N'El Congo', 2), (N'Candelaria de la Frontera', 2), (N'Chalchuapa', 2), (N'El Porvenir', 2),
       (N'San Antonio Pajonal', 2), (N'San Sebastián Salitrillo', 2), (N'Santiago de la Frontera', 2);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Juayúa', 3), (N'Nahuizalco', 3), (N'Salcoatitán', 3), (N'Santa Catarina Masahuat', 3), (N'Sonsonate', 3),
       (N'Sonzacate', 3), (N'Nahulingo', 3), (N'San Antonio del Monte', 3), (N'Santo Domingo de Guzmán', 3), (N'Izalco', 3),
       (N'Armenia', 3), (N'Caluco', 3), (N'San Julián', 3), (N'Cuisnahuat', 3), (N'Santa Isabel Ishuatán', 3), (N'Acajutla', 3);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'La Palma', 4), (N'Citalá', 4), (N'San Ignacio', 4), (N'Nueva Concepción', 4), (N'Tejutla', 4),
       (N'La Reina', 4), (N'Agua Caliente', 4), (N'Dulce Nombre de María', 4), (N'El Paraíso', 4), (N'San Fernando', 4),
       (N'San Francisco Morazán', 4), (N'San Rafael', 4), (N'Santa Rita', 4), (N'Chalatenango', 4), (N'Arcatao', 4),
       (N'Azacualpa', 4), (N'Comalapa', 4), (N'Concepción Quezaltepeque', 4), (N'El Carrizal', 4), (N'La Laguna', 4),
       (N'Las Vueltas', 4), (N'Nombre de Jesús', 4), (N'Nueva Trinidad', 4), (N'Ojos de Agua', 4), (N'Potonico', 4),
       (N'San Antonio de la Cruz', 4), (N'San Antonio Los Ranchos', 4), (N'San Francisco Lempa', 4), (N'San Isidro Labrador', 4),
       (N'San José Cancasque', 4), (N'San José Las Flores', 4), (N'San Luis del Carmen', 4), (N'San Miguel de Mercedes', 4);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Quezaltepeque', 5), (N'San Matías', 5), (N'San Pablo Tacachico', 5), (N'San Juan Opico', 5), (N'Ciudad Arce', 5),
       (N'Colón', 5), (N'Jayaque', 5), (N'Sacacoyo', 5), (N'Tepecoyo', 5), (N'Talnique', 5),
       (N'Antiguo Cuscatlán', 5), (N'Huizúcar', 5), (N'Nuevo Cuscatlán', 5), (N'San José Villanueva', 5), (N'Zaragoza', 5),
       (N'Chiltiupán', 5), (N'Jicalapa', 5), (N'La Libertad', 5), (N'Tamanique', 5), (N'Teotepeque', 5),
       (N'Comasagua', 5), (N'Santa Tecla', 5);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Aguilares', 6), (N'El Paisnal', 6), (N'Guazapa', 6), (N'Apopa', 6), (N'Nejapa', 6),
       (N'Ilopango', 6), (N'San Martín', 6), (N'Soyapango', 6), (N'Tonacatepeque', 6), (N'Ayutuxtepeque', 6),
       (N'Mejicanos', 6), (N'San Salvador', 6), (N'Cuscatancingo', 6), (N'Ciudad Delgado', 6), (N'Panchimalco', 6),
       (N'Rosario de Mora', 6), (N'San Marcos', 6), (N'Santo Tomás', 6), (N'Santiago Texacuangos', 6);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Suchitoto', 7), (N'San José Guayabal', 7), (N'Oratorio de Concepción', 7), (N'San Bartolomé Perulapía', 7), (N'San Pedro Perulapán', 7),
       (N'Cojutepeque', 7), (N'San Rafael Cedros', 7), (N'Candelaria', 7), (N'Monte San Juan', 7), (N'El Carmen', 7),
       (N'San Cristóbal', 7), (N'Santa Cruz Michapa', 7), (N'San Ramón', 7), (N'El Rosario', 7), (N'Santa Cruz Analquito', 7),
       (N'Tenancingo', 7);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Cuyultitán', 8), (N'Olocuilta', 8), (N'San Juan Talpa', 8), (N'San Luis Talpa', 8), (N'San Pedro Masahuat', 8),
       (N'Tapalhuaca', 8), (N'San Francisco Chinameca', 8), (N'El Rosario', 8), (N'Jerusalén', 8), (N'Mercedes La Ceiba', 8),
       (N'Paraíso de Osorio', 8), (N'San Antonio Masahuat', 8), (N'San Emigdio', 8), (N'San Juan Tepezontes', 8), (N'San Luis La Herradura', 8),
       (N'San Miguel Tepezontes', 8), (N'San Pedro Nonualco', 8), (N'Santa María Ostuma', 8), (N'Santiago Nonualco', 8), (N'San Juan Nonualco', 8),
       (N'San Rafael Obrajuelo', 8), (N'Zacatecoluca', 8);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Sensuntepeque', 9), (N'Victoria', 9), (N'Dolores', 9), (N'Guacotecti', 9), (N'San Isidro', 9),
       (N'Ilobasco', 9), (N'Tejutepeque', 9), (N'Jutiapa', 9), (N'Cinquera', 9);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Apastepeque', 10), (N'Santa Clara', 10), (N'San Ildefonso', 10), (N'San Esteban Catarina', 10), (N'San Sebastián', 10),
       (N'San Lorenzo', 10), (N'Santo Domingo', 10), (N'San Vicente', 10), (N'Guadalupe', 10), (N'Verapaz', 10),
       (N'Tepetitán', 10), (N'Tecoluca', 10), (N'San Cayetano Istepeque', 10);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Santiago de María', 11), (N'Alegría', 11), (N'Berlín', 11), (N'Mercedes Umaña', 11), (N'Jucuapa', 11),
       (N'El Triunfo', 11), (N'Estanzuelas', 11), (N'San Buenaventura', 11), (N'Nueva Granada', 11), (N'Usulután', 11),
       (N'Jucuarán', 11), (N'San Dionisio', 11), (N'Concepción Batres', 11), (N'Santa María', 11), (N'Ozatlán', 11),
       (N'Tecapán', 11), (N'Santa Elena', 11), (N'California', 11), (N'Ereguayquín', 11), (N'Jiquilisco', 11),
       (N'Puerto El Triunfo', 11), (N'San Agustín', 11), (N'San Francisco Javier', 11);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Ciudad Barrios', 12), (N'Sesori', 12), (N'Nuevo Edén de San Juan', 12), (N'San Gerardo', 12), (N'San Luis de la Reina', 12),
       (N'Carolina', 12), (N'San Antonio del Mosco', 12), (N'Chapeltique', 12), (N'San Miguel', 12), (N'Comacarán', 12),
       (N'Uluazapa', 12), (N'Moncagua', 12), (N'Quelepa', 12), (N'Chirilagua', 12), (N'Chinameca', 12),
       (N'Nueva Guadalupe', 12), (N'Lolotique', 12), (N'San Jorge', 12), (N'San Rafael Oriente', 12), (N'El Tránsito', 12);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Arambala', 13), (N'Cacaopera', 13), (N'Corinto', 13), (N'El Rosario', 13), (N'Joateca', 13),
       (N'Jocoaitique', 13), (N'Meanguera', 13), (N'Perquín', 13), (N'San Fernando', 13), (N'San Isidro', 13),
       (N'Torola', 13), (N'Chilanga', 13), (N'Delicias de Concepción', 13), (N'El Divisadero', 13), (N'Gualococti', 13),
       (N'Guatajiagua', 13), (N'Jocoro', 13), (N'Lolotiquillo', 13), (N'Osicala', 13), (N'San Carlos', 13),
       (N'San Francisco Gotera', 13), (N'San Simón', 13), (N'Sensembra', 13), (N'Sociedad', 13), (N'Yamabal', 13),
       (N'Yoloaiquín', 13);

INSERT INTO Distrito (Nombre, IdDepartamento)
VALUES (N'Anamorós', 14), (N'Bolívar', 14), (N'Concepción de Oriente', 14), (N'El Sauce', 14), (N'Lislique', 14),
       (N'Nueva Esparta', 14), (N'Pasaquina', 14), (N'Polorós', 14), (N'San José La Fuente', 14), (N'Santa Rosa de Lima', 14),
       (N'Conchagua', 14), (N'El Carmen', 14), (N'Intipucá', 14), (N'La Unión', 14), (N'Meanguera del Golfo', 14),
       (N'San Alejo', 14), (N'Yayantique', 14), (N'Yucuaiquín', 14);

INSERT INTO CategoriaHabilidad (Nombre, Descripcion)
VALUES (N'Programación', N'Lenguajes y paradigmas de programación'),
       ('Base de Datos', 'Gestores y modelado de datos'),
       ('Frameworks Backend', 'Frameworks del lado del servidor'),
       ('Frameworks Frontend', 'Frameworks del lado del cliente'),
       ('Herramientas DevOps', 'CI/CD, contenedores, nube'),
       ('Habilidades Blandas', N'Comunicación, trabajo en equipo, liderazgo');

INSERT INTO Habilidad (Nombre, Descripcion, IdCategoriaHabilidad)
VALUES ('Java', 'Lenguaje Java SE/EE', 1), ('Python', 'Lenguaje Python', 1), ('JavaScript', 'JavaScript ES6+', 1), ('TypeScript', 'TypeScript', 1),
       ('SQL', 'Lenguaje de consulta SQL', 2), ('SQL Server', 'Microsoft SQL Server', 2), ('MySQL', 'MySQL / MariaDB', 2),
       ('Spring Boot', 'Framework Spring Boot', 3),
       ('Angular', 'Angular 17+', 4), ('React', 'React 18+', 4),
       ('Docker', 'Contenedores con Docker', 5), ('Git', 'Control de versiones Git', 5),
       ('Trabajo en equipo', N'Colaboración efectiva', 6), (N'Comunicación', N'Comunicación oral y escrita', 6);

INSERT INTO Idioma (Nombre)
VALUES (N'Español'), (N'Inglés'), (N'Francés'), (N'Portugués');

INSERT INTO Rol (Nombre, Descripcion)
VALUES ('ADMIN', N'Administrador del sistema con acceso total'),
       ('POSTULANTE', N'Usuario que busca empleo y aplica a ofertas de trabajo'),
       ('EMPRESA', N'Empresa que publica y gestiona ofertas de trabajo');

INSERT INTO Privilegio (Nombre, NombreMenu, Ruta)
VALUES ('GESTIONAR_USUARIOS',  N'Gestión de Usuarios',  '/admin/usuarios'),
       ('GESTIONAR_ROLES',     N'Gestión de Roles',     '/admin/roles'),
       ('GESTIONAR_CATALOGOS', N'Gestión de Catálogos', '/admin/catalogos'),
       ('VER_REPORTES',        N'Reportes',             '/admin/reportes'),
       ('GESTIONAR_OFERTAS',   N'Mis Ofertas',          '/ofertas/gestionar'),
       ('VER_OFERTAS',         N'Ofertas de Trabajo',   '/ofertas'),
       ('APLICAR_OFERTA',      N'Aplicar a Oferta',     NULL),
       ('VER_ASPIRANTES',      N'Aspirantes',           '/ofertas/aspirantes'),
       ('GESTIONAR_PERFIL',    N'Mi Perfil',            '/perfil');

INSERT INTO RolPrivilegio (IdRol, IdPrivilegio)
SELECT r.IdRol, p.IdPrivilegio FROM Rol r CROSS JOIN Privilegio p WHERE r.Nombre = 'ADMIN';

INSERT INTO RolPrivilegio (IdRol, IdPrivilegio)
SELECT r.IdRol, p.IdPrivilegio FROM Rol r JOIN Privilegio p ON p.Nombre IN ('VER_OFERTAS', 'APLICAR_OFERTA', 'GESTIONAR_PERFIL') WHERE r.Nombre = 'POSTULANTE';

INSERT INTO RolPrivilegio (IdRol, IdPrivilegio)
SELECT r.IdRol, p.IdPrivilegio FROM Rol r JOIN Privilegio p ON p.Nombre IN ('VER_OFERTAS', 'GESTIONAR_OFERTAS', 'VER_ASPIRANTES', 'GESTIONAR_PERFIL') WHERE r.Nombre = 'EMPRESA';
GO

-- ==============================================================================
-- SECCION 9: CARGA DE USUARIOS (DatosPrueba/02)
-- ==============================================================================

DECLARE @IdActivo INT;
SELECT @IdActivo = IdEstadoUsuario FROM EstadoUsuario WHERE Nombre = 'ACTIVO';

DECLARE @IdAdminRol INT, @IdPostulanteRol INT, @IdEmpresaRol INT;
SELECT @IdAdminRol = IdRol FROM Rol WHERE Nombre = 'ADMIN';
SELECT @IdPostulanteRol = IdRol FROM Rol WHERE Nombre = 'POSTULANTE';
SELECT @IdEmpresaRol = IdRol FROM Rol WHERE Nombre = 'EMPRESA';

-- Administrador
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('admin@jobhorizon.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdAdminUsuario INT = SCOPE_IDENTITY();

INSERT INTO Administrador (IdUsuario) VALUES (@IdAdminUsuario);
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdAdminUsuario, @IdAdminRol);

-- Empresas
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('rrhh@techsolutions.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdEmpresa1 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdEmpresa1, @IdEmpresaRol);

INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('empleos@salvadev.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdEmpresa2 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdEmpresa2, @IdEmpresaRol);

-- Postulantes
INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('juan.perez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante1 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdPostulante1, @IdPostulanteRol);

INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('maria.gomez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante2 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdPostulante2, @IdPostulanteRol);

INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('carlos.lopez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante3 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdPostulante3, @IdPostulanteRol);

INSERT INTO Usuario (Correo, PasswordHash, IntentosFallidos, IdEstadoUsuario)
VALUES ('sofia.rodriguez@email.com', '$2a$10$qR2p5n5Qj4Yv1jZt2hFzeuK2yP3oFz1wXG5gq7t1tO9q4K6vE1M2.', 0, @IdActivo);
DECLARE @IdPostulante4 INT = SCOPE_IDENTITY();
INSERT INTO UsuarioRol (IdUsuario, IdRol) VALUES (@IdPostulante4, @IdPostulanteRol);

-- ==============================================================================
-- SECCION 10: CARGA DE PERFILES (DatosPrueba/03)
-- ==============================================================================

DECLARE @IdMasc INT, @IdFem INT;
SELECT @IdMasc = IdGenero FROM Genero WHERE Nombre = 'MASCULINO';
SELECT @IdFem = IdGenero FROM Genero WHERE Nombre = 'FEMENINO';

DECLARE @IdDui INT;
SELECT @IdDui = IdTipoDocumento FROM TipoDocumento WHERE Nombre = 'DUI';

DECLARE @IdDistritoSS INT;
SELECT @IdDistritoSS = IdDistrito FROM Distrito d JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento WHERE d.Nombre = 'San Salvador' AND dep.Nombre = 'San Salvador';

DECLARE @IdDistritoST INT;
SELECT @IdDistritoST = IdDistrito FROM Distrito d JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento WHERE d.Nombre = 'Santa Tecla' AND dep.Nombre = 'La Libertad';

-- Juan Pérez
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdPostulante1, 'Juan Antonio', 'Perez Castillo', '1992-05-15', '04857692-3', '123456789', '0614-150592-101-2', 'Colonia Escalon, Psje. A #4', @IdMasc, @IdDui, @IdDistritoSS);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono) VALUES (@IdPostulante1, '7021-3948'), (@IdPostulante1, '+50322459876');
INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url) VALUES (@IdPostulante1, 1, 'https://linkedin.com/in/juanperezbackend'), (@IdPostulante1, 2, 'https://github.com/juanperezdev');

-- María Gómez
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdPostulante2, 'Maria Elena', 'Gomez Rivas', '1999-09-22', '05948372-1', NULL, '0501-220999-102-1', 'Residencial Santa Teresa, Senda 3 #12', @IdFem, @IdDui, @IdDistritoST);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono) VALUES (@IdPostulante2, '7845-1290');
INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url) VALUES (@IdPostulante2, 1, 'https://linkedin.com/in/mariagomezfrontend'), (@IdPostulante2, 2, 'https://github.com/mariagomezcode');

-- Carlos López
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdPostulante3, 'Carlos Roberto', 'Lopez Alvarado', '1995-11-02', '03847592-5', '987654321', '0614-021195-103-3', 'Urbanizacion Metropoli, Block C-2', @IdMasc, @IdDui, @IdDistritoSS);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono) VALUES (@IdPostulante3, '7190-8833');
INSERT INTO PostulanteRedSocial (IdUsuario, IdTipoRedSocial, Url) VALUES (@IdPostulante3, 1, 'https://linkedin.com/in/carloslopezfullstack');

-- Sofia Rodríguez
INSERT INTO Postulante (IdUsuario, Nombres, Apellidos, FechaNacimiento, NumDocumento, Nup, Nit, Direccion, IdGenero, IdTipoDocumento, IdDistrito)
VALUES (@IdPostulante4, 'Sofia Isabel', 'Rodriguez Menjivar', '2002-02-28', '06012485-9', NULL, NULL, 'Colonia Utila, Final Av. El Boqueron', @IdFem, @IdDui, @IdDistritoST);

INSERT INTO PostulanteTelefono (IdUsuario, Telefono) VALUES (@IdPostulante4, '7550-2918');

-- Formación Académica
DECLARE @IdIng INT, @IdLic INT, @IdTec INT;
SELECT @IdIng = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'INGENIERIA';
SELECT @IdLic = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'LICENCIATURA';
SELECT @IdTec = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'TECNICO';

INSERT INTO FormacionAcademica (NumFormacion, IdUsuario, Institucion, Titulo, IdNivelEducativo, FechaInicio, FechaFin, EnCurso)
VALUES (0, @IdPostulante1, 'Universidad de El Salvador', 'Ingenieria de Sistemas Informaticos', @IdIng, '2010-02-15', '2015-12-15', 0),
       (0, @IdPostulante2, 'ITCA-FEPADE', 'Tecnologo en Desarrollo de Software', @IdTec, '2018-01-15', '2019-12-10', 0),
       (0, @IdPostulante3, 'Universidad Centroamericana Jose Simeon Cañas', 'Licenciatura en Ciencias de la Computacion', @IdLic, '2014-03-01', '2019-11-30', 0),
       (0, @IdPostulante4, 'Universidad de El Salvador', 'Ingenieria de Sistemas Informaticos', @IdIng, '2020-02-10', '2025-05-18', 0);

-- Experiencia Laboral
INSERT INTO ExperienciaLaboral (NumExp, IdUsuario, NombreEmpresa, Puesto, FechaInicio, FechaFin, TrabajoActual, Funciones, TelefonoContacto, CorreoContacto)
VALUES (0, @IdPostulante1, 'Applaudo Studios', 'Senior Java Developer', '2021-06-01', NULL, 1, 'Liderar equipo de desarrollo backend, arquitectura con microservicios en Spring Boot y migraciones de bases de datos.', '2200-1100', 'rrhh@applaudo.com'),
       (0, @IdPostulante1, 'Banco Agricola', 'Backend Developer', '2017-01-15', '2021-05-30', 0, 'Desarrollo de servicios bancarios transaccionales, integracion de APIs y optimizacion de procedimientos en SQL Server.', '2210-2210', 'sistemas@agricola.com'),
       (0, @IdPostulante2, 'Sykes El Salvador', 'Junior Frontend Developer', '2024-05-01', NULL, 1, 'Maquetacion responsiva, integracion de vistas Angular con APIs REST, pruebas unitarias básicas.', '2250-9900', 'hr@sykes.com'),
       (0, @IdPostulante3, 'Telus International', 'Fullstack Software Engineer', '2023-01-10', NULL, 1, 'Desarrollo fullstack utilizando Django, React, y PostgreSQL. Manejo de Pipelines CI/CD.', '2252-0000', 'careers@telus.com');

-- Habilidades
DECLARE @SkillJava INT, @SkillSpring INT, @SkillSql INT, @SkillSqlServer INT, @SkillAngular INT, @SkillReact INT, @SkillGit INT, @SkillPython INT;
SELECT @SkillJava = IdHabilidad FROM Habilidad WHERE Nombre = 'Java';
SELECT @SkillSpring = IdHabilidad FROM Habilidad WHERE Nombre = 'Spring Boot';
SELECT @SkillSql = IdHabilidad FROM Habilidad WHERE Nombre = 'SQL';
SELECT @SkillSqlServer = IdHabilidad FROM Habilidad WHERE Nombre = 'SQL Server';
SELECT @SkillAngular = IdHabilidad FROM Habilidad WHERE Nombre = 'Angular';
SELECT @SkillReact = IdHabilidad FROM Habilidad WHERE Nombre = 'React';
SELECT @SkillGit = IdHabilidad FROM Habilidad WHERE Nombre = 'Git';
SELECT @SkillPython = IdHabilidad FROM Habilidad WHERE Nombre = 'Python';

DECLARE @NivelBas INT, @NivelInt INT, @NivelAva INT, @NivelExp INT;
SELECT @NivelBas = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'BASICO';
SELECT @NivelInt = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'INTERMEDIO';
SELECT @NivelAva = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'AVANZADO';
SELECT @NivelExp = IdNivelHabilidad FROM NivelHabilidad WHERE Nombre = 'EXPERTO';

INSERT INTO PostulanteHabilidad (IdUsuario, IdHabilidad, IdNivelHabilidad)
VALUES (@IdPostulante1, @SkillJava, @NivelExp),
       (@IdPostulante1, @SkillSpring, @NivelExp),
       (@IdPostulante1, @SkillSql, @NivelAva),
       (@IdPostulante1, @SkillSqlServer, @NivelAva),
       (@IdPostulante1, @SkillGit, @NivelAva),
       (@IdPostulante2, @SkillAngular, @NivelAva),
       (@IdPostulante2, @SkillReact, @NivelInt),
       (@IdPostulante2, @SkillGit, @NivelInt),
       (@IdPostulante3, @SkillReact, @NivelAva),
       (@IdPostulante3, @SkillPython, @NivelAva),
       (@IdPostulante3, @SkillSql, @NivelAva),
       (@IdPostulante3, @SkillGit, @NivelAva),
       (@IdPostulante4, @SkillJava, @NivelInt),
       (@IdPostulante4, @SkillAngular, @NivelInt),
       (@IdPostulante4, @SkillGit, @NivelBas);

-- Idiomas
DECLARE @IdiomaEsp INT, @IdiomaIng INT;
SELECT @IdiomaEsp = IdIdioma FROM Idioma WHERE Nombre = 'Español';
SELECT @IdiomaIng = IdIdioma FROM Idioma WHERE Nombre = 'Inglés';

DECLARE @LvlA1 INT, @LvlB1 INT, @LvlB2 INT, @LvlC1 INT, @LvlNat INT;
SELECT @LvlA1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'A1';
SELECT @LvlB1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B1';
SELECT @LvlB2 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B2';
SELECT @LvlC1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'C1';
SELECT @LvlNat = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'NATIVO';

INSERT INTO PostulanteIdioma (IdUsuario, IdIdioma, IdNivelLectura, IdNivelEscritura, IdNivelConversacion, IdNivelEscucha)
VALUES (@IdPostulante1, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       (@IdPostulante1, @IdiomaIng, @LvlB2, @LvlB2, @LvlB2, @LvlB2),
       (@IdPostulante2, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       (@IdPostulante2, @IdiomaIng, @LvlC1, @LvlC1, @LvlC1, @LvlC1),
       (@IdPostulante3, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       (@IdPostulante3, @IdiomaIng, @LvlA1, @LvlA1, @LvlA1, @LvlA1),
       (@IdPostulante4, @IdiomaEsp, @LvlNat, @LvlNat, @LvlNat, @LvlNat),
       (@IdPostulante4, @IdiomaIng, @LvlB1, @LvlB1, @LvlB1, @LvlB1);

-- Certificaciones, Logros, Recomendaciones, Eventos
INSERT INTO Certificacion (CodCert, IdUsuario, CodigoCertificacion, Nombre, IdTipoCertificacion, Institucion, FechaObtencion, ArchivoUrl)
VALUES (1, @IdPostulante1, '1Z0-819', 'Oracle Certified Professional: Java SE 11 Developer', 1, 'Oracle', '2020-08-15', 'http://certificados.org/juan-java11.pdf'),
       (1, @IdPostulante2, 'C1-ADV-1234', 'Cambridge English C1 Advanced', 2, 'Cambridge Assessment English', '2023-11-20', NULL);

INSERT INTO Logro (NumLogro, IdUsuario, Descripcion, Fecha)
VALUES (1, @IdPostulante3, 'Primer lugar en la Hackathon UCA 2021 con un proyecto de automatizacion agraria.', '2021-10-18');

INSERT INTO Recomendacion (NumRecomendacion, IdUsuario, NombreContacto, TelefonoContacto, IdTipoRecomendacion)
VALUES (1, @IdPostulante1, 'Ing. Hugo Gonzalez (CTO en Applaudo)', '7070-5555', 1);

DECLARE @IdPonte INT, @IdPaisSV INT;
SELECT @IdPonte = IdTipoParticipacion FROM TipoParticipacion WHERE Nombre = 'PONENTE';
SELECT @IdPaisSV = IdPais FROM Pais WHERE Nombre = 'El Salvador';

INSERT INTO Evento (NumEvento, IdUsuario, NombreEvento, Lugar, Anfitrion, Fecha, IdTipoParticipacion, IdPais)
VALUES (1, @IdPostulante4, 'Congreso Nacional de Tecnologia bad115', 'San Salvador, UES', 'Escuela de Sistemas ESI', '2024-04-12', @IdPonte, @IdPaisSV);
GO

-- ==============================================================================
-- SECCION 11: CARGA DE EMPRESAS Y OFERTAS DE TRABAJO (DatosPrueba/04)
-- ==============================================================================

DECLARE @IdEmpresaUsuario1 INT, @IdEmpresaUsuario2 INT;
SELECT @IdEmpresaUsuario1 = IdUsuario FROM Usuario WHERE Correo = 'rrhh@techsolutions.com';
SELECT @IdEmpresaUsuario2 = IdUsuario FROM Usuario WHERE Correo = 'empleos@salvadev.com';

DECLARE @IdDistritoSS INT;
SELECT @IdDistritoSS = IdDistrito FROM Distrito d JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento WHERE d.Nombre = 'San Salvador' AND dep.Nombre = 'San Salvador';

DECLARE @IdDistritoST INT;
SELECT @IdDistritoST = IdDistrito FROM Distrito d JOIN Departamento dep ON d.IdDepartamento = dep.IdDepartamento WHERE d.Nombre = 'Santa Tecla' AND dep.Nombre = 'La Libertad';

-- Empresas Perfil
INSERT INTO Empresa (IdUsuario, NombreComercial, RazonSocial, Nit, SitioWeb, Descripcion, LogoUrl, IdDistrito)
VALUES (@IdEmpresaUsuario1, 'Tech Solutions', 'Tech Solutions S.A. de C.V.', '0614-121220-101-9', 'https://techsolutions.com', 'Empresa lider en desarrollo de software para el sector financiero en la region centroamericana.', 'https://images.techsolutions.com/logo.png', @IdDistritoST),
       (@IdEmpresaUsuario2, 'SalvaDev', 'El Salvador Developers S.A. de C.V.', '0614-050518-102-1', 'https://salvadev.com', 'Boutique de desarrollo de software enfocada en soluciones Web y Cloud utilizando tecnologias de vanguardia.', NULL, @IdDistritoSS);

INSERT INTO EmpresaTelefono (IdUsuario, Telefono)
VALUES (@IdEmpresaUsuario1, '2288-4433'), (@IdEmpresaUsuario1, '7766-5544'), (@IdEmpresaUsuario2, '2260-1234');

-- Ofertas
DECLARE @IdContratoTC INT, @IdNivelIng INT, @IdNivelLic INT, @IdNivelTec INT, @IdModHib INT, @IdModRem INT, @IdOfertaActiva INT;
SELECT @IdContratoTC = IdTipoContrato FROM TipoContrato WHERE Nombre = 'TIEMPO_COMPLETO';
SELECT @IdNivelIng = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'INGENIERIA';
SELECT @IdNivelLic = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'LICENCIATURA';
SELECT @IdNivelTec = IdNivelEducativo FROM NivelEducativo WHERE Nombre = 'TECNICO';
SELECT @IdModHib = IdModalidad FROM Modalidad WHERE Nombre = 'HIBRIDO';
SELECT @IdModRem = IdModalidad FROM Modalidad WHERE Nombre = 'REMOTO';
SELECT @IdOfertaActiva = IdEstadoOferta FROM EstadoOferta WHERE Nombre = 'ACTIVA';

-- Oferta 1: Senior Java
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Senior Java Backend Developer (Spring Boot)', 
        'Buscamos un Ingeniero de software Backend Senior experimentado para diseñar, implementar y escalar servicios basados en microservicios e integracion de sistemas legacy.', 
        2200.00, 2800.00, 2, 3, GETDATE(), DATEADD(DAY, 30, GETDATE()), 
        @IdEmpresaUsuario1, @IdContratoTC, @IdNivelIng, @IdModHib, @IdOfertaActiva, @IdDistritoST,
        0.40, 0.20, 0.20, 0.20);
DECLARE @IdOferta1 INT = SCOPE_IDENTITY();

-- Oferta 2: Junior Angular
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Junior Angular Frontend Developer', 
        'Buscamos graduado de carrera tecnica o ingenieria para incorporarse a celula de desarrollo frontend. Enfoque en Angular, TypeScript y maquetacion premium.', 
        800.00, 1100.00, 1, 1, GETDATE(), DATEADD(DAY, 15, GETDATE()), 
        @IdEmpresaUsuario2, @IdContratoTC, @IdNivelTec, @IdModRem, @IdOfertaActiva, @IdDistritoSS,
        0.50, 0.10, 0.20, 0.20);
DECLARE @IdOferta2 INT = SCOPE_IDENTITY();

-- Oferta 3: Fullstack Python/React
INSERT INTO OfertaTrabajo (Titulo, Descripcion, SalarioMin, SalarioMax, NumVacantes, AniosExperienciaMinima, FechaPublicacion, FechaVencimiento, IdEmpresa, IdTipoContrato, IdNivelEducativo, IdModalidad, IdEstadoOferta, IdDistrito, PesoHabilidades, PesoAcademico, PesoExperiencia, PesoIdiomas)
VALUES ('Software Engineer Fullstack (Python / React)', 
        'Desarrollo e integracion de APIs utilizando Python/Django y componentes visuales reactivos en React. Se requiere habilidades solidas en bases de datos relacionales.', 
        1400.00, 1800.00, 1, 2, GETDATE(), DATEADD(DAY, 20, GETDATE()), 
        @IdEmpresaUsuario1, @IdContratoTC, @IdNivelLic, @IdModHib, @IdOfertaActiva, @IdDistritoST,
        0.40, 0.20, 0.20, 0.20);
DECLARE @IdOferta3 INT = SCOPE_IDENTITY();

-- Ofertas Habilidades
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

INSERT INTO OfertaHabilidad (IdOferta, IdHabilidad, IdNivelHabilidad)
VALUES (@IdOferta1, @SkillJava, @NivelAva), (@IdOferta1, @SkillSpring, @NivelAva), (@IdOferta1, @SkillSql, @NivelInt),
       (@IdOferta2, @SkillAngular, @NivelInt), (@IdOferta2, @SkillGit, @NivelInt),
       (@IdOferta3, @SkillReact, @NivelInt), (@IdOferta3, @SkillPython, @NivelInt), (@IdOferta3, @SkillSql, @NivelInt);

-- Ofertas Idiomas
DECLARE @IdiomaIng INT;
SELECT @IdiomaIng = IdIdioma FROM Idioma WHERE Nombre = 'Inglés';

DECLARE @LvlB1 INT, @LvlB2 INT;
SELECT @LvlB1 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B1';
SELECT @LvlB2 = IdNivelIdioma FROM NivelIdioma WHERE Nombre = 'B2';

INSERT INTO OfertaIdioma (IdOferta, IdIdioma, IdNivelIdioma)
VALUES (@IdOferta1, @IdiomaIng, @LvlB2), (@IdOferta2, @IdiomaIng, @LvlB1), (@IdOferta3, @IdiomaIng, @LvlB1);
GO
