CREATE PROCEDURE selectUserById
@id_usuario int
as
begin
	select * from usuarios where id_usuario = @id_usuario
end
go