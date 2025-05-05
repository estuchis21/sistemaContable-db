-- Tabla roles
CREATE TABLE [roles] (
	[id_rol] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[rol] nvarchar(50) NOT NULL
);

-- Tabla usuarios
CREATE TABLE [usuarios] (
	[id_usuario] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_rol] int NOT NULL,
	[username] nvarchar(50) NOT NULL UNIQUE,
	[contrasena] nvarchar(100) NOT NULL,
	[nombres] nvarchar(100) NOT NULL,
	[apellido] nvarchar(100) NOT NULL,
	[DNI] bigint NOT NULL UNIQUE,
	CONSTRAINT FK_Usuarios_Roles FOREIGN KEY ([id_rol]) REFERENCES [roles]([id_rol])
);

-- Tabla administradores
CREATE TABLE [administradores] (
	[id_admin] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_usuario] int NOT NULL,
	CONSTRAINT FK_Admin_Usuarios FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario])
);

-- Tabla contadores
CREATE TABLE [contadores] (
	[id_contador] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_usuario] int NOT NULL,
	CONSTRAINT FK_Contadores_Usuarios FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario])
);

-- Tabla usuario_corriente
CREATE TABLE [usuario_corriente] (
	[id_operador] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_usuario] int NOT NULL,
	CONSTRAINT FK_Op_Usuarios FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario])
);

-- Tabla tipos_saldo
CREATE TABLE [tipos_saldo] (
	[id_tipo_saldo] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[tipo_saldo] nvarchar(50) NOT NULL
);

-- Tabla Cuentas
CREATE TABLE [Cuentas] (
	[id_cuenta] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[codigo] nvarchar(20) NOT NULL UNIQUE,
	[nombre] nvarchar(100) NOT NULL,
	[id_tipo_saldo] int NOT NULL,
	[saldo] decimal(18,0) NOT NULL,
	CONSTRAINT FK_Cuentas_TiposSaldo FOREIGN KEY ([id_tipo_saldo]) REFERENCES [tipos_saldo]([id_tipo_saldo])
);

-- Tabla Transacciones
CREATE TABLE [Transacciones] (
	[id_transaccion] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_cuenta] int NOT NULL,
	[debe] decimal(18,2) NULL,
	[haber] decimal(18,2) NULL,
	[fecha_transaccion] datetime NOT NULL,
	CONSTRAINT FK_Transacciones_Cuentas FOREIGN KEY ([id_cuenta]) REFERENCES [Cuentas]([id_cuenta]),
	CONSTRAINT CHK_Debe_Haber CHECK (
		([debe] IS NOT NULL AND [haber] IS NULL) OR
		([debe] IS NULL AND [haber] IS NOT NULL)
	)
);

-- ⚠️ Estas dos claves foráneas NO tienen sentido y generan error circular, por eso se eliminan:
-- ALTER TABLE [tipos_saldo] ADD CONSTRAINT [tipos_saldo_fk0] FOREIGN KEY ([id_tipo_saldo]) REFERENCES [Cuentas]([id_tipo_saldo]);
-- ALTER TABLE [roles] ADD CONSTRAINT [roles_fk0] FOREIGN KEY ([id_rol]) REFERENCES [usuarios]([id_rol]);
