CREATE PROCEDURE insertRol
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO Roles (rol)
        VALUES 
            ('Administrador'),
            ('Contador'),
            ('Usuario corriente');

        SELECT 'Roles creados correctamente.' AS mensaje;
    END TRY
    BEGIN CATCH
        SELECT 'Error al agregar roles' AS mensaje;
    END CATCH
END;
