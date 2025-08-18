CREATE TRIGGER Actualizar_saldo_cuenta
ON Operaciones
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    -- Actualiza el saldo de la cuenta según la operación insertada
    UPDATE c
    SET c.saldo = c.saldo - i.monto
    FROM Cuentas c
    INNER JOIN INSERTED i ON c.id_cuenta = i.id_cuenta;


    -- Verifica que ninguna cuenta quede con saldo negativo
    IF EXISTS (
        SELECT 1 
        FROM Cuentas 
        WHERE saldo < 0
    )
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50000, 'El saldo no puede ser menor a cero', 1;
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION;
    END
END;

