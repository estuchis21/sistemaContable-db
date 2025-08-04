CREATE PROCEDURE obtenerUsuarioPorId
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT *
        FROM usuarios
        WHERE id_usuario = @id_usuario;
    END TRY
    BEGIN CATCH
        SELECT 'Error al obtener el usuario.' AS mensaje;
    END CATCH
END;
