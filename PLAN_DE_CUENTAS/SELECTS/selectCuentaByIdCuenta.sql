CREATE PROCEDURE MostrarCuentaPorId
    @id_cuenta INT
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM Cuentas
        WHERE id_cuenta = @id_cuenta;
    END TRY
    BEGIN CATCH
        PRINT 'Error al obtener la cuenta.';
        PRINT ERROR_MESSAGE();
    END CATCH
END
