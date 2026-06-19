# Proyecto de Base de Datos: JobHorizon - Bolsa de Trabajo en Línea
## Guía de Instalación, Estructura de Scripts y Verificación de Requerimientos (Etapa II)

Este directorio contiene la solución completa de base de datos relacional para el sistema **JobHorizon**, implementada sobre **Microsoft SQL Server (T-SQL)** y estructurada conforme a los lineamientos y rúbricas de la cátedra de Bases de Datos (BAD115).

---

## 📁 Estructura del Proyecto

Toda la lógica de definición de datos (DDL), manipulación de datos (DML) y programación de base de datos se encuentra estructurada y separada por tipo de objeto de la siguiente manera en la raíz de la entrega:

```text
├── Instalador_Completo.sql        <-- [RECOMENDADO] Script maestro de instalación única
├── BaseDeDatos/
│   └── 00_CrearBaseDatos.sql      <-- Definición y creación de la BD "JobHorizonDB"
├── Tablas/
│   ├── 01_Catalogos/              <-- Tablas auxiliares paramétricas con columna 'Activo' (V12)
│   │   ├── Departamento.sql, Distrito.sql, Genero.sql, TipoDocumento.sql, TipoContrato.sql,
│   │   ├── NivelEducativo.sql, Modalidad.sql, CategoriaHabilidad.sql, Habilidad.sql,
│   │   └── Idioma.sql, NivelIdioma.sql, NivelHabilidad.sql, TipoCertificacion.sql, etc.
│   ├── 02_Seguridad/              <-- Tablas de control de accesos, roles y tokens
│   │   └── Usuario.sql, TokenVerificacion.sql, Administrador.sql, Rol.sql, Privilegio.sql, etc.
│   └── 03_Principales/            <-- Tablas del núcleo de negocio y auditorías
│       └── Postulante.sql, Empresa.sql, OfertaTrabajo.sql (con pesos V11), PostulanteOferta.sql, etc.
├── Indices/
│   └── CrearIndices.sql           <-- Índices optimizadores para búsquedas y matching
├── Funciones/
│   ├── fn_CalcularEdad.sql        <-- Función de cálculo dinámico para el campo derivado Edad
│   ├── fn_PorcentajeCompletitudPerfil.sql <-- Indicador de perfil completo en el front
│   └── fn_PuntajeMatching.sql     <-- Algoritmo de matching de 4 variables consolidado (V13)
├── Procedimientos/
│   ├── sp_RegistrarIntentoFallido.sql <-- Seguridad: control de intentos y bloqueo
│   ├── sp_ResetearIntentosFallidos.sql
│   ├── sp_GenerarTokenDesbloqueo.sql
│   ├── sp_DesbloquearUsuario.sql
│   ├── sp_ObtenerPrivilegiosUsuario.sql
│   ├── sp_ObtenerAspirantes.sql   <-- Procedimiento principal del algoritmo de matching
│   ├── sp_AplicarOferta.sql
│   └── sp_CambiarEstadoAplicacion.sql
├── Triggers/
│   ├── trg_AuditarCambiosUsuario.sql <-- Auditoría AFTER INSERT/UPDATE/DELETE (Usuario)
│   ├── trg_AuditarCambiosRol.sql     <-- Auditoría de asignación/revocación de roles (CU-A02)
│   ├── trg_VencerOfertas.sql         <-- Automatización: expiración de ofertas por fecha
│   ├── trg_AutonumerarExperiencia.sql <-- Regla de negocio INSTEAD OF para correlativo
│   ├── trg_AutonumerarFormacion.sql
│   └── trg_ValidarRolMinimo.sql      <-- Restricción: impedir que un usuario quede sin rol
└── DatosPrueba/
    ├── 01_Catalogos.sql           <-- Inserción de configuraciones del sistema, departamentos, distritos y skills
    ├── 02_Usuarios.sql            <-- Semillas de cuentas para Administradores, Postulantes y Empresas
    ├── 03_Perfiles.sql            <-- Datos detallados de candidatos (experiencias, estudios, destrezas)
    └── 04_Empresas_Ofertas.sql    <-- Registro de empresas y ofertas de empleo con requisitos específicos
```

---

## 🚀 Guía de Instalación en Microsoft SQL Server

Para desplegar y verificar el sistema en **SQL Server Management Studio (SSMS)** u otra herramienta compatible (como Azure Data Studio), siga uno de los siguientes dos métodos:

### Método A: Instalación en Un Solo Click (Recomendado para la Defensa)
1. Abra el archivo `Instalador_Completo.sql` ubicado en la raíz del proyecto.
2. Presione la tecla **F5** o haga clic en el botón **Ejecutar** (Execute).
3. El script creará la base de datos `JobHorizonDB`, compilará todos los objetos y cargará el lote completo de datos de prueba automáticamente, respetando estrictamente el orden de dependencias.

### Método B: Ejecución por Bloques Separados
Si desea crear e inspeccionar los objetos individualmente, ejecute los scripts en el siguiente orden:
1. `BaseDeDatos/00_CrearBaseDatos.sql`
2. Todos los archivos bajo `Tablas/01_Catalogos/`
3. Todos los archivos bajo `Tablas/02_Seguridad/`
4. Todos los archivos bajo `Tablas/03_Principales/`
5. `Indices/CrearIndices.sql`
6. Las funciones en `Funciones/`
7. Los procedimientos almacenados en `Procedimientos/`
8. Los triggers en `Triggers/`
9. Los datos de prueba en la carpeta `DatosPrueba/` (`01_Catalogos.sql`, `02_Usuarios.sql`, `03_Perfiles.sql`, y `04_Empresas_Ofertas.sql`).

---

## 🧪 Secuencia de Pasos para Demostración del Funcionamiento (Defensa de Proyecto)

Una vez ejecutada la base de datos, puede validar los principales requerimientos y reglas de negocio del docente ejecutando las siguientes consultas e invocaciones de prueba:

### 1. Gestión de la Seguridad y Bloqueo por Intentos Fallidos
El sistema bloquea una cuenta automáticamente si se superan los intentos parametrizados (3 por defecto).

```sql
USE JobHorizonDB;
GO

-- Consultar estado inicial del usuario "juan.perez@email.com" (Intentos = 0, Estado = ACTIVO)
SELECT Correo, IntentosFallidos, eu.Nombre AS Estado
FROM Usuario u
JOIN EstadoUsuario eu ON u.IdEstadoUsuario = eu.IdEstadoUsuario
WHERE Correo = 'juan.perez@email.com';

-- Simular 3 intentos fallidos consecutivos llamando al procedimiento sp_RegistrarIntentoFallido
DECLARE @IdUser INT;
SELECT @IdUser = IdUsuario FROM Usuario WHERE Correo = 'juan.perez@email.com';

EXEC sp_RegistrarIntentoFallido @IdUsuario = @IdUser;
EXEC sp_RegistrarIntentoFallido @IdUsuario = @IdUser;
EXEC sp_RegistrarIntentoFallido @IdUsuario = @IdUser; -- En este punto se bloquea

-- Verificar que el estado cambió a BLOQUEADO e Intentos = 3
SELECT Correo, IntentosFallidos, eu.Nombre AS Estado
FROM Usuario u
JOIN EstadoUsuario eu ON u.IdEstadoUsuario = eu.IdEstadoUsuario
WHERE Correo = 'juan.perez@email.com';

-- Desbloquear el usuario simulando el proceso de recuperación por correo
-- Generamos el token de desbloqueo
EXEC sp_GenerarTokenDesbloqueo @IdUsuario = @IdUser, @Token = 'TOKEN_DE_PRUEBA_123';

-- Validar que el token y fecha de expiración se guardaron
SELECT Correo, TokenDesbloqueo, FechaTokenExp FROM Usuario WHERE IdUsuario = @IdUser;

-- Ejecutamos la reactivación usando el sp_DesbloquearUsuario
DECLARE @Result INT;
EXEC sp_DesbloquearUsuario @Token = 'TOKEN_DE_PRUEBA_123', @Resultado = @Result OUTPUT;

-- Verificar éxito (@Result = 0) y restauración a ACTIVO con Intentos = 0
SELECT @Result AS ResultadoDesbloqueo;
SELECT Correo, IntentosFallidos, eu.Nombre AS Estado
FROM Usuario u
JOIN EstadoUsuario eu ON u.IdEstadoUsuario = eu.IdEstadoUsuario
WHERE Correo = 'juan.perez@email.com';
```

### 2. Validación de Auditorías Automáticas (Triggers)
Al modificar un usuario o asignar/revocar roles, los triggers de auditoría registran la trazabilidad en sus respectivas tablas.

```sql
-- Consultar el historial de auditoría de usuarios
SELECT * FROM AuditoriaUsuario;

-- Consultar el historial de asignaciones de roles (AuditoriaRol)
SELECT * FROM AuditoriaRol;

-- Validar restricción: Intentar dejar a un usuario sin roles (Debe disparar un error y hacer ROLLBACK)
BEGIN TRY
    DELETE FROM UsuarioRol WHERE IdUsuario = (SELECT IdUsuario FROM Usuario WHERE Correo = 'juan.perez@email.com');
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS MensajeErrorEsperado;
END CATCH;
```

### 3. Demostración del Algoritmo de Matching
El núcleo del proyecto calcula un puntaje del **0% al 100%** basado en las habilidades de los candidatos frente a los requerimientos de la oferta, su nivel académico, años de experiencia y nivel de idiomas.

Ejecute la siguiente consulta para visualizar a los aspirantes recomendados para la vacante de **"Senior Java Backend Developer (Spring Boot)"** (Oferta ID = 1):

```sql
-- Obtener la lista de aspirantes calificados ordenados por el Puntaje de Matching
EXEC sp_ObtenerAspirantes @IdOferta = 1;
```

**Análisis de resultados esperados en base a los datos de prueba insertados:**
* **Juan Pérez (Puntaje ~ 100%)**: Cumple con todos los requisitos. Es Ingeniero (máximo requerido), tiene más de 3 años de experiencia en Java, maneja Java/Spring Boot a nivel Experto e Inglés B2.
* **Sofia Rodríguez (Puntaje ~ 50%)**: Es Ingeniera y conoce Java, pero carece de experiencia laboral previa y su nivel de destreza es Intermedio (la oferta solicita Avanzado), y su nivel de inglés es B1 (se requiere B2).
* **María Gómez (Puntaje ~ 0% / Muy Bajo)**: Tiene perfil puramente frontend (Angular) y no cumple con las tecnologías backend (Java/Spring Boot) requeridas para la oferta.

---

## 🌟 Cumplimiento de Lineamientos del Docente
1. **Esquema T-SQL Limpio**: Sin migraciones fragmentadas, consolidando tablas con sus respectivas modificaciones finales (como el soft delete `Activo` en catálogos y coeficientes ponderados en las ofertas).
2. **Nombres en Español**: Estructura de carpetas y scripts utilizando terminología en español (`Tablas`, `Indices`, `Procedimientos`, etc.).
3. **Restricciones de Integridad**: Tablas definidas con llaves primarias, foráneas con control de borrado `ON DELETE CASCADE` donde aplica, y restricciones de tipo `CHECK` para teléfonos, NIT, DUI y coherencia de fechas.
4. **Objetos de Servidor (Programación en BD)**: Robustez añadida mediante el uso de 3 funciones del sistema, 8 procedimientos almacenados complejos y 6 triggers que encapsulan la lógica de negocio directamente en el motor de datos.
