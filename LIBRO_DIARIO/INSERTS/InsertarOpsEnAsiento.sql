CREATE PROCEDURE insertarOpsEnAsientos
(
    @id_asiento INT,
    @id_cuenta INT,
    @id_tipo_cuenta INT,
    @neto_gravado DECIMAL(12,2),
    @tipo_libro VARCHAR(10),
    @calcular_iva_21 BIT = 0,
    @calcular_iva_10_5 BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @iva_21 DECIMAL(12,2) = 0;
        DECLARE @iva_10_5 DECIMAL(12,2) = 0;
        DECLARE @total DECIMAL(12,2);

        IF @calcular_iva_21 = 1
            SET @iva_21 = ROUND(@neto_gravado * 0.21, 2);

        IF @calcular_iva_10_5 = 1
            SET @iva_10_5 = ROUND(@neto_gravado * 0.105, 2);

        SET @total = @neto_gravado + @iva_21 + @iva_10_5;

        -- Insertar operación con monto total
        INSERT INTO Operaciones (id_asiento, id_cuenta, id_tipo_cuenta, monto)
        VALUES (@id_asiento, @id_cuenta, @id_tipo_cuenta, @total);

        DECLARE @id_operacion INT = SCOPE_IDENTITY();

        -- Insertar registro en IVA_Libro
        INSERT INTO IVA_Libro (
            id_operacion, tipo_libro, neto_gravado, iva_21, iva_10_5, total
        )
        -- Para id_comprobante asumimos NULL o que actualices luego
        VALUES (@id_operacion, @tipo_libro, @neto_gravado, @iva_21, @iva_10_5, @total);

        COMMIT TRANSACTION;

        SELECT 'Operación insertada con éxito' AS mensaje, @id_operacion AS id_operacion;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS error;
    END CATCH
END;
