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
