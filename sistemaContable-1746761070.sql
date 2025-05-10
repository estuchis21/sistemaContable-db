-- ROLES
CREATE TABLE [roles] (
	[id_rol] int IDENTITY(1,1) NOT NULL,
	[rol] nvarchar(100) NOT NULL,
	PRIMARY KEY ([id_rol])
);

-- USUARIOS
CREATE TABLE [usuarios] (
	[id_usuario] int IDENTITY(1,1) NOT NULL,
	[id_rol] int NOT NULL,
	[username] nvarchar(max) NOT NULL,
	[mail] nvarchar(max) NOT NULL,
	[contrasena] nvarchar(max) NOT NULL,
	[nombres] nvarchar(max) NOT NULL,
	[apellido] nvarchar(max) NOT NULL,
	[DNI] bigint NOT NULL UNIQUE,
	PRIMARY KEY ([id_usuario])
);

-- ADMINISTRADORES
CREATE TABLE [administradores] (
	[id_admin] int IDENTITY(1,1) NOT NULL,
	[id_usuario] int NOT NULL,
	PRIMARY KEY ([id_admin])
);

-- CONTADORES
CREATE TABLE [contadores] (
	[id_contador] int IDENTITY(1,1) NOT NULL,
	[id_usuario] int NOT NULL,
	PRIMARY KEY ([id_contador])
);

-- USUARIO CORRIENTE
CREATE TABLE [usuario_corriente] (
	[id_operador] int IDENTITY(1,1) NOT NULL,
	[id_usuario] int NOT NULL,
	PRIMARY KEY ([id_operador])
);

-- TIPOS DE SALDO
CREATE TABLE [tipos_saldo] (
	[id_tipo_saldo] int IDENTITY(1,1) NOT NULL,
	[tipo_saldo] nvarchar(100) NOT NULL,
	PRIMARY KEY ([id_tipo_saldo])
);

-- CUENTAS
CREATE TABLE [Cuentas] (
	[id_cuenta] int IDENTITY(1,1) NOT NULL,
	[codigo] nvarchar(max) NOT NULL,
	[nombre] nvarchar(max) NOT NULL,
	[id_tipo_saldo] int NOT NULL,
	[saldo] decimal(18,0) NOT NULL,
	PRIMARY KEY ([id_cuenta])
);

-- TRANSACCIONES
CREATE TABLE [Transacciones] (
	[id_transaccion] int IDENTITY(1,1) NOT NULL,
	[id_cuenta] int NOT NULL,
	[debe] decimal(18,0),
	[haber] decimal(18,0),
	[fecha_transaccion] datetime NOT NULL,
	[id_usuario] int NOT NULL,
	PRIMARY KEY ([id_transaccion])
);

-- RELACIONES
ALTER TABLE [usuarios] ADD CONSTRAINT [usuarios_fk1] FOREIGN KEY ([id_rol]) REFERENCES [roles]([id_rol]);
ALTER TABLE [administradores] ADD CONSTRAINT [administradores_fk1] FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario]);
ALTER TABLE [contadores] ADD CONSTRAINT [contadores_fk1] FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario]);
ALTER TABLE [usuario_corriente] ADD CONSTRAINT [usuario_corriente_fk1] FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario]);
ALTER TABLE [Cuentas] ADD CONSTRAINT [cuentas_fk1] FOREIGN KEY ([id_tipo_saldo]) REFERENCES [tipos_saldo]([id_tipo_saldo]);
ALTER TABLE [Transacciones] ADD CONSTRAINT [Transacciones_fk1] FOREIGN KEY ([id_cuenta]) REFERENCES [Cuentas]([id_cuenta]);
ALTER TABLE [Transacciones] ADD CONSTRAINT [Transacciones_fk2] FOREIGN KEY ([id_usuario]) REFERENCES [usuarios]([id_usuario]);
