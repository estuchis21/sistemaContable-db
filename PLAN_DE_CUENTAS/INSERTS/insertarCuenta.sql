DELIMITER $$

CREATE PROCEDURE insertarCuenta(
    IN saldo BIGINT,
    IN id_tipo_saldo INT,
    IN nombre VARCHAR(255),
    IN codigo VARCHAR(255)
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            -- En caso de error
            SELECT 'Error al insertar la cuenta.';
        END;

    -- Insertar la cuenta en la tabla Cuentas
    INSERT INTO Cuentas(saldo, id_tipo_saldo, nombre, codigo)
    VALUES (saldo, id_tipo_saldo, nombre, codigo);

    -- Mensaje de éxito
    SELECT 'Cuenta insertada correctamente.';
END $$

DELIMITER ;
