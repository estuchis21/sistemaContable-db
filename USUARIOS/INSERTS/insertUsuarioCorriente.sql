DELIMITER //
CREATE PROCEDURE insertUsuarioCorriente(IN id_usuario INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
        BEGIN
            SELECT 'Error al ingresar usuario corriente' AS mensaje;
        END;

    INSERT INTO usuario_corriente(id_usuario)
    VALUES (id_usuario);
    
    SELECT 'Datos de operador agregado correctamente' AS mensaje;
END;
//
DELIMITER ;
