CREATE PROCEDURE insertRol
AS
BEGIN
    BEGIN TRY
        INSERT INTO Roles (rol)
        VALUES ('Contador'), ('Administrador'), ('Usuario corriente');

        PRINT 'Roles creados correctamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al agregar roles:';
        PRINT ERROR_MESSAGE(); -- Error correcto sin variable
    END CATCH
END
