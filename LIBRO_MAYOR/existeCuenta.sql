create procedure existeCuenta
@id_cuenta int
as
begin
	select 1 from Operaciones where id_cuenta = @id_cuenta

end 
go