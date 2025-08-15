CREATE PROCEDURE libroMayor
    @id_cuenta INT
AS
BEGIN
    SELECT 
        a.id_asiento,
        a.fecha_asiento,
        a.descripcion,
        op.id_tipo_movimiento,
        ts.tipo_saldo,
        SUM(
            CASE 
                -- Cuentas de ACTIVO: DEBE aumenta, HABER disminuye
                WHEN ts.tipo_saldo = 'ACTIVO' AND op.id_tipo_movimiento = 1 THEN op.monto
                WHEN ts.tipo_saldo = 'ACTIVO' AND op.id_tipo_movimiento = 2 THEN -op.monto
                -- Cuentas de PASIVO/PATRIMONIO: HABER aumenta, DEBE disminuye
                WHEN ts.tipo_saldo IN ('PASIVO','PATRIMONIO') AND op.id_tipo_movimiento = 2 THEN op.monto
                WHEN ts.tipo_saldo IN ('PASIVO','PATRIMONIO') AND op.id_tipo_movimiento = 1 THEN -op.monto
                ELSE 0
            END
        ) OVER (ORDER BY a.fecha_asiento, a.id_asiento ROWS UNBOUNDED PRECEDING) AS saldo_acumulado
    FROM Cuentas c, TipoMovimiento tm, Asientos a, Operaciones op, Tipos_Saldos ts
    WHERE c.id_cuenta = op.id_cuenta
      AND tm.id_tipo_movimiento = op.id_tipo_movimiento
      AND op.id_asiento = a.id_asiento
      AND ts.id_tipo_saldo = c.id_tipo_saldo
      AND op.id_cuenta = 22
    ORDER BY a.fecha_asiento, a.id_asiento;
END;
GO
