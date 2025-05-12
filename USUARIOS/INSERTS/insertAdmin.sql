DELIMITER //
CREATE PROCEDURE insertAdministrador(IN id_usuario INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
        BEGIN
            SELECT 'Error al ingresar administrador' AS mensaje;
        END;

    INSERT INTO administradores(id_usuario)
    VALUES (id_usuario);
    
    SELECT 'Datos de administrador agregado correctamente' AS mensaje;
END;
//
DELIMITER ;
