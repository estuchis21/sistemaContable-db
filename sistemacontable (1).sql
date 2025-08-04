CREATE TABLE Roles (
    id_rol INT PRIMARY KEY IDENTITY(1,1),
    rol VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    id_rol INT NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    mail VARCHAR(150) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    clave_hash VARCHAR(255) NOT NULL,
    DNI BIGINT UNIQUE NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

CREATE TABLE Admin (
    id_admin INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Contador (
    id_contador INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

CREATE TABLE UsuarioCorriente (
    id_usuariocorriente INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Tipo_Cuenta (
    id_tipo_cuenta INT PRIMARY KEY IDENTITY(1,1),
    tipo_cuenta VARCHAR(50) NOT NULL
);

CREATE TABLE Tipos_Saldos (
    id_tipo_saldo INT PRIMARY KEY IDENTITY(1,1),
    tipo_saldo VARCHAR(100) NOT NULL
);

CREATE TABLE Cuentas (
    id_cuenta INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(100) UNIQUE NOT NULL,
    cuenta VARCHAR(255) NOT NULL,
    saldo DECIMAL(12,2) DEFAULT 0.00,
    id_tipo_saldo INT NOT NULL,
    FOREIGN KEY (id_tipo_saldo) REFERENCES Tipos_Saldos(id_tipo_saldo)
);

CREATE TABLE Comprobantes (
    id_comprobante INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('FACTURA_A','FACTURA_B','NC_A','NC_B','ND_A','ND_B')),
    fecha DATE NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cuit_cliente VARCHAR(20),
    razon_social_cliente VARCHAR(100),
    monto_total DECIMAL(12,2) NOT NULL
);

CREATE TABLE Asientos (
    id_asiento INT PRIMARY KEY IDENTITY(1,1),
    fecha_asiento DATETIME NOT NULL,
    descripcion TEXT NOT NULL,
    id_comprobante INT FOREIGN KEY REFERENCES Comprobantes(id_comprobante)
);

CREATE TABLE IVA_Libro (
    id_iva INT PRIMARY KEY IDENTITY(1,1),
    id_comprobante INT NOT NULL,
    id_operacion INT, -- Se permite NULL si la operación es opcional
    tipo_libro VARCHAR(10) CHECK (tipo_libro IN ('VENTAS', 'COMPRAS')),
    neto_gravado DECIMAL(12,2),
    iva_21 DECIMAL(12,2),
    iva_10_5 DECIMAL(12,2),
    total DECIMAL(12,2),

    -- Claves foráneas
    CONSTRAINT FK_IVA_Comprobantes FOREIGN KEY (id_comprobante)
        REFERENCES Comprobantes(id_comprobante),

    CONSTRAINT FK_IVA_Operaciones FOREIGN KEY (id_operacion)
        REFERENCES Operaciones(id_operacion)
);


CREATE TABLE Operaciones (
    id_operacion INT PRIMARY KEY IDENTITY(1,1),
    id_asiento INT NOT NULL FOREIGN KEY REFERENCES Asientos(id_asiento),
    id_cuenta INT NOT NULL FOREIGN KEY REFERENCES Cuentas(id_cuenta),
    id_tipo_cuenta INT NOT NULL FOREIGN KEY REFERENCES Tipo_Cuenta(id_tipo_cuenta),
    monto DECIMAL(12,2) NOT NULL
);
