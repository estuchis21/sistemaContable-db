DELIMITER $$

CREATE PROCEDURE insertarTipoSaldo(
    IN tipo_saldo VARCHAR(100)
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            -- En caso de error
            SELECT 'Error al insertar el tipo de saldo.';
        END;

    -- Insertar el tipo de saldo en la tabla tipos_saldo
    INSERT INTO tipos_saldo(tipo_saldo)
    VALUES (tipo_saldo);

    -- Mensaje de éxito
    SELECT 'Tipo de saldo insertado correctamente.';
END $$

DELIMITER ;

