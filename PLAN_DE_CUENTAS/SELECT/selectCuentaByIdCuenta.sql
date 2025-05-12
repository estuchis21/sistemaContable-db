DELIMITER $$

CREATE PROCEDURE MostrarCuentaPorId(
    IN id_cuenta INT
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            -- En caso de error
            SELECT 'Error al obtener la cuenta.';
        END;

    -- Mostrar la cuenta por el ID proporcionado
    SELECT *
    FROM Cuentas
    WHERE id_cuenta = id_cuenta;

END $$

DELIMITER ;
