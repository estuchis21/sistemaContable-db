CREATE PROCEDURE obtenerCuentaPorId
    @id_cuenta INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT *
        FROM Cuentas
        WHERE id_cuenta = @id_cuenta;
    END TRY
    BEGIN CATCH
        SELECT 'Error al obtener la cuenta.' AS mensaje;
        -- Opcional: más información del error
        SELECT ERROR_MESSAGE() AS detalle_error;
    END CATCH
END;
