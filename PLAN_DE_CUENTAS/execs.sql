EXEC InsertarTipoSaldo @tipo_saldo = 'Activo';
EXEC InsertarTipoSaldo @tipo_saldo = 'Pasivo';
EXEC InsertarTipoSaldo @tipo_saldo = 'Patrimonio Neto';
EXEC InsertarTipoSaldo @tipo_saldo = 'Ingreso';
EXEC InsertarTipoSaldo @tipo_saldo = 'Egreso';
 

 exec insertarCuenta @codigo = '1.01.01', @nombre = 'Caja', @id_tipo_saldo = 1, @saldo = 1000000.10


 exec selectUserById @id_usuario = 1

 exec selectUserByIdRol @id_rol = 1


 exec mostrarCuentaPorId @id_cuenta = 1