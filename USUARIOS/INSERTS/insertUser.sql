DELIMITER //
CREATE PROCEDURE insertarUsuario(
    IN DNI INT,
    IN nombres VARCHAR(100),
    IN apellido VARCHAR(100),
    IN mail VARCHAR(100),
    IN username VARCHAR(50),
    IN contrasena VARCHAR(100),
    IN id_rol INT
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
        BEGIN
            SELECT 'Error al insertar el usuario.' AS mensaje;
        END;

    INSERT INTO Usuarios (DNI, nombres, apellido, mail, username, contrasena, id_rol)
    VALUES (DNI, nombres, apellido, mail, username, contrasena, id_rol);

    SELECT 'Usuario insertado correctamente.' AS mensaje;
END;
//
DELIMITER ;
