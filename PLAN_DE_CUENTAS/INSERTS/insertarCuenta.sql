CREATE PROCEDURE insertarCuenta
    @codigo VARCHAR(50),
    @cuenta VARCHAR(100),
    @saldo DECIMAL(18,2),
    @id_tipo_saldo INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Cuentas (codigo, cuenta, saldo, id_tipo_saldo)
        VALUES (@codigo, @cuenta, @saldo, @id_tipo_saldo);

        SELECT 'Cuenta insertada correctamente.' AS mensaje;
    END TRY
    BEGIN CATCH
        SELECT 'Error al insertar la cuenta.' AS mensaje;
        -- Para ver más detalles del error (opcional):
        SELECT ERROR_MESSAGE() AS detalle_error;
    END CATCH
END;
