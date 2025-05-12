DELIMITER //
CREATE PROCEDURE insertRol()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
        BEGIN
            SELECT 'Error al agregar roles' AS mensaje;
        END;

    INSERT INTO Roles (rol)
    VALUES ('Contador'), ('Administrador'), ('Usuario corriente');

    SELECT 'Roles creados correctamente.' AS mensaje;
END;
//
DELIMITER ;
