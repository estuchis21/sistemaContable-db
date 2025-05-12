DELIMITER //

CREATE PROCEDURE selectUserById(IN id_usuario INT)
BEGIN
    SELECT * FROM usuarios WHERE id_usuario = id_usuario;
END //

DELIMITER ;
