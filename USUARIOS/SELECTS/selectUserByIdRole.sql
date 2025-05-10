create procedure selectUserByIdRol
@id_rol int
as 
begin
	select * from usuarios where id_rol = @id_rol
end
go