create procedure insertAdministrador
@id_usuario int

as
begin
	begin try
		insert into administradores(id_usuario)
		values (@id_usuario)
		print 'Datos de administrador agregado correctamente'
	end try
	begin catch
		print 'Error al ingresar médico'
		print ERROR_MESSAGE();
	end catch

END