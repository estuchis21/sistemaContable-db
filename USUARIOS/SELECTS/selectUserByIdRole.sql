CREATE PROCEDURE selectUserByIdRol
    @id_rol INT
    AS
    BEGIN
        SELECT * FROM usuarios WHERE id_rol = @id_rol;
    END 

