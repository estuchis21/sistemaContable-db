-- =========================================
-- SP: Estado de Situación Patrimonial (Balance General) por Rubros
-- =========================================
CREATE or alter PROCEDURE sp_estado_situacion_patrimonial_rubros
    @fecha_cierre DATE
AS
BEGIN
    PRINT '=============================='
    PRINT 'ESTADO DE SITUACION PATRIMONIAL'
    PRINT 'Fecha de cierre: ' + CONVERT(VARCHAR, @fecha_cierre, 103)
    PRINT '=============================='

    SELECT 
        CASE
            WHEN codigo LIKE '10%' THEN 'Caja y Bancos'
            WHEN codigo LIKE '11%' THEN 'Mobiliario'
            WHEN codigo LIKE '12%' THEN 'Equipos de Oficina'
            WHEN codigo LIKE '20%' THEN 'Proveedores'
            WHEN codigo LIKE '21%' THEN 'Acreedores'
            WHEN codigo LIKE '22%' THEN 'Préstamos Bancarios'
            WHEN codigo LIKE '30%' THEN 'Capital Social'
            WHEN codigo LIKE '31%' THEN 'Resultados Acumulados'
            WHEN codigo LIKE '60%' THEN 'Impuestos y IVA'
            ELSE 'Otros'
        END AS Rubro,
        SUM(CASE WHEN id_tipo_saldo = 1 THEN saldo ELSE 0 END) AS Total_Activos,
        SUM(CASE WHEN id_tipo_saldo = 2 THEN saldo ELSE 0 END) AS Total_Pasivos,
        SUM(CASE WHEN id_tipo_saldo = 3 THEN saldo ELSE 0 END) AS Total_Patrimonio
    FROM Cuentas
    GROUP BY CASE
                WHEN codigo LIKE '10%' THEN 'Caja y Bancos'
                WHEN codigo LIKE '11%' THEN 'Mobiliario'
                WHEN codigo LIKE '12%' THEN 'Equipos de Oficina'
                WHEN codigo LIKE '20%' THEN 'Proveedores'
                WHEN codigo LIKE '21%' THEN 'Acreedores'
                WHEN codigo LIKE '22%' THEN 'Préstamos Bancarios'
                WHEN codigo LIKE '30%' THEN 'Capital Social'
                WHEN codigo LIKE '31%' THEN 'Resultados Acumulados'
                WHEN codigo LIKE '60%' THEN 'Impuestos y IVA'
                ELSE 'Otros'
             END
    ORDER BY Rubro;

    -- Calcular Resultado del Ejercicio e incluir en Patrimonio Neto
    DECLARE @resultado DECIMAL(12,2)
    SELECT @resultado = SUM(
                        CASE 
                            WHEN id_tipo_saldo = 4 THEN saldo
                            WHEN id_tipo_saldo = 5 THEN -saldo
                            ELSE 0
                        END)
    FROM Cuentas

    DECLARE @total_patrimonio DECIMAL(12,2)
    SELECT @total_patrimonio = SUM(CASE WHEN id_tipo_saldo = 3 THEN saldo ELSE 0 END) + @resultado
    FROM Cuentas

    PRINT '------------------------------'
    PRINT 'RESULTADO DEL EJERCICIO (Ganancia/Pérdida): ' + CAST(@resultado AS VARCHAR)
    PRINT 'TOTAL PATRIMONIO NETO INCLUYE RESULTADO: ' + CAST(@total_patrimonio AS VARCHAR)
    PRINT '------------------------------'
END
GO