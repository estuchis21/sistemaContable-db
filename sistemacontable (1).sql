
-- =====================================
-- TABLAS BASE
-- =====================================
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
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (id_rol) REFERENCES Roles(id_rol)
);

CREATE TABLE Admin (
    id_admin INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT NOT NULL CONSTRAINT FK_Admin_Usuarios FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

CREATE TABLE Contador (
    id_contador INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT NOT NULL CONSTRAINT FK_Contador_Usuarios FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

CREATE TABLE UsuarioCorriente (
    id_usuariocorriente INT PRIMARY KEY IDENTITY(1,1),
    id_usuario INT NOT NULL CONSTRAINT FK_UsuarioCorriente_Usuarios FOREIGN KEY REFERENCES Usuarios(id_usuario)
);

-- =====================================
-- TIPOS DE SALDO
-- =====================================
CREATE TABLE Tipos_Saldos (
    id_tipo_saldo INT PRIMARY KEY IDENTITY(1,1),
    tipo_saldo VARCHAR(100) NOT NULL
);

-- =====================================
-- CUENTAS
-- =====================================
CREATE TABLE Cuentas (
    id_cuenta INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(100) UNIQUE NOT NULL,
    cuenta VARCHAR(255) NOT NULL,
    saldo DECIMAL(12,2) DEFAULT 0.00,
    id_tipo_saldo INT NOT NULL CONSTRAINT FK_Cuentas_Tipos_Saldos FOREIGN KEY REFERENCES Tipos_Saldos(id_tipo_saldo)
);

-- =====================================
-- ASIENTOS
-- =====================================
CREATE TABLE Asientos (
    id_asiento INT PRIMARY KEY IDENTITY(1,1),
    fecha_asiento DATETIME NOT NULL,
    descripcion TEXT NOT NULL
);

-- =====================================
-- COMPROBANTES (FK directo a Asientos)
-- =====================================
CREATE TABLE Comprobantes (
    id_comprobante INT PRIMARY KEY IDENTITY(1,1),
    id_asiento INT NOT NULL CONSTRAINT FK_Comprobantes_Asiento FOREIGN KEY REFERENCES Asientos(id_asiento),
    codigo_tipo VARCHAR(20) NOT NULL CHECK (codigo_tipo IN (
        'FACTURA_A','FACTURA_B','FACTURA_C','FACTURA_M',
        'NC_A','NC_B','NC_C','NC_M',
        'ND_A','ND_B','ND_C','ND_M',
        'REMITO','RECIBO','PRESUPUESTO','ORDEN_COMPRA','ORDEN_PAGO'
    )),
    descripcion_completa VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    numero VARCHAR(20) NOT NULL,
    cuit_cliente VARCHAR(20),
    razon_social_cliente VARCHAR(100),
    monto_total DECIMAL(12,2) NOT NULL
);

-- =====================================
-- TIPO MOVIMIENTO
-- =====================================
CREATE TABLE TipoMovimiento (
    id_tipo_movimiento INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(10) NOT NULL CHECK (nombre IN ('DEBE', 'HABER'))
);

INSERT INTO TipoMovimiento (nombre) VALUES ('DEBE'), ('HABER');

-- =====================================
-- OPERACIONES
-- =====================================
CREATE TABLE Operaciones (
    id_operacion INT PRIMARY KEY IDENTITY(1,1),
    id_asiento INT NOT NULL CONSTRAINT FK_Operaciones_Asiento FOREIGN KEY REFERENCES Asientos(id_asiento),
    id_cuenta INT NOT NULL CONSTRAINT FK_Operaciones_Cuenta FOREIGN KEY REFERENCES Cuentas(id_cuenta),
    id_tipo_movimiento INT NOT NULL CONSTRAINT FK_Operaciones_TipoMovimiento FOREIGN KEY REFERENCES TipoMovimiento(id_tipo_movimiento),
    monto DECIMAL(12,2) NOT NULL
);

-- =====================================
-- IVA_LIBRO
-- =====================================
CREATE TABLE IVA_Libro (
    id_iva INT PRIMARY KEY IDENTITY(1,1),
    id_operacion INT NOT NULL CONSTRAINT FK_IVA_Operaciones FOREIGN KEY REFERENCES Operaciones(id_operacion),
    tipo_libro VARCHAR(10) NOT NULL CHECK (tipo_libro IN ('VENTAS', 'COMPRAS')),
    neto_gravado DECIMAL(12,2) NOT NULL,
    iva_21 DECIMAL(12,2) NULL,
    iva_10_5 DECIMAL(12,2) NULL,
    total DECIMAL(12,2) NOT NULL,
    CONSTRAINT CHK_IVA_Libro CHECK (
        (iva_21 IS NOT NULL OR iva_10_5 IS NOT NULL) OR
        (iva_21 IS NULL AND iva_10_5 IS NULL)
    )
);
