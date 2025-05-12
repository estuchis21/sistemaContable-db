DELIMITER //

CREATE PROCEDURE selectUserByIdRol(IN id_rol INT)
BEGIN
    SELECT * FROM usuarios WHERE id_rol = id_rol;
END //

DELIMITER ;
