CREATE PROCEDURE sp_insertar_asiento_operacion_iva
    @descripcion TEXT,
    @id_comprobante INT,
    @id_cuenta INT,
    @id_tipo_cuenta INT,
    @monto DECIMAL(12,2),
    @tipo_libro VARCHAR(10),
    @neto_gravado DECIMAL(12,2),
    @calcular_iva_21 BIT = 0,   -- 1 para calcular IVA 21%
    @calcular_iva_10_5 BIT = 0  -- 1 para calcular IVA 10.5%
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar asiento
        INSERT INTO Asientos (fecha_asiento, descripcion, id_comprobante)
        VALUES (GETDATE(), @descripcion, @id_comprobante);

        DECLARE @id_asiento INT = SCOPE_IDENTITY();

        -- Insertar operación
        INSERT INTO Operaciones (id_asiento, id_cuenta, id_tipo_cuenta, monto)
        VALUES (@id_asiento, @id_cuenta, @id_tipo_cuenta, @monto);

        DECLARE @id_operacion INT = SCOPE_IDENTITY();

        -- Calcular IVA según flags
        DECLARE @iva_21 DECIMAL(12,2) = NULL;
        DECLARE @iva_10_5 DECIMAL(12,2) = NULL;

        IF @calcular_iva_21 = 1
            SET @iva_21 = @neto_gravado * 0.21;

        IF @calcular_iva_10_5 = 1
            SET @iva_10_5 = @neto_gravado * 0.105;

        -- Total = neto + suma de los IVAs calculados (considerar NULL como 0)
        DECLARE @total DECIMAL(12,2) = @neto_gravado 
            + ISNULL(@iva_21, 0) + ISNULL(@iva_10_5, 0);

        -- Insertar en IVA_Libro
        INSERT INTO IVA_Libro (
            id_comprobante,
            id_operacion,
            tipo_libro,
            neto_gravado,
            iva_21,
            iva_10_5,
            total
        )
        VALUES (
            @id_comprobante,
            @id_operacion,
            @tipo_libro,
            @neto_gravado,
            @iva_21,
            @iva_10_5,
            @total
        );

        COMMIT TRANSACTION;

        SELECT 'Operación y asiento insertados correctamente.' AS mensaje;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 
            ERROR_MESSAGE() AS error,
            ERROR_LINE() AS linea,
            ERROR_NUMBER() AS codigo;
    END CATCH
END;
