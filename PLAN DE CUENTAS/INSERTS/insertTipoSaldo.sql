CREATE PROCEDURE insertarTipoSaldo
    @tipo_saldo NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        INSERT INTO tipos_saldo(tipo_saldo)
        VALUES (@tipo_saldo);

        PRINT 'Tipo de saldo insertado correctamente.';
    END TRY
    BEGIN CATCH
        PRINT 'Error al insertar el tipo de saldo.';
        PRINT ERROR_MESSAGE();
    END CATCH
END
