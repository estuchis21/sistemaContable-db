-- SISTEMA CONTABLE COMPLETO - ESTRUCTURA SQL

-- Limpieza (solo si estás en entorno de pruebas)
DROP TABLE IF EXISTS log_eventos, iva_libro, comprobantes, operaciones, asientos, cuentas,
  tipos_saldos, tipo_cuenta, usuarios, roles;

-- TABLA DE ROLES
CREATE TABLE roles (
  id_rol INT PRIMARY KEY AUTO_INCREMENT,
  rol VARCHAR(100) NOT NULL UNIQUE
);

-- USUARIOS CON CLAVE HASH Y ROL
CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  id_rol INT NOT NULL,
  nombres VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  mail VARCHAR(150) NOT NULL UNIQUE,
  username VARCHAR(100) NOT NULL UNIQUE,
  clave_hash VARCHAR(255) NOT NULL,
  DNI BIGINT NOT NULL UNIQUE,
  FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- PLAN DE CUENTAS (con tipo de saldo)
CREATE TABLE tipos_saldos (
  id_tipo_saldo INT PRIMARY KEY AUTO_INCREMENT,
  tipo_saldo VARCHAR(100) NOT NULL
);

CREATE TABLE cuentas (
  id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
  codigo VARCHAR(100) NOT NULL UNIQUE,
  cuenta VARCHAR(255) NOT NULL,
  saldo DECIMAL(12,2) DEFAULT 0,
  id_tipo_saldo INT NOT NULL,
  FOREIGN KEY (id_tipo_saldo) REFERENCES tipos_saldos(id_tipo_saldo)
);

-- ASIENTOS CONTABLES
CREATE TABLE asientos (
  id_asiento INT PRIMARY KEY AUTO_INCREMENT,
  fecha_asiento DATETIME NOT NULL,
  descripcion TEXT NOT NULL,
  id_comprobante INT DEFAULT NULL
);

-- TIPO DE MOVIMIENTO DE CUENTA (DEBE / HABER)
CREATE TABLE tipo_cuenta (
  id_tipo_cuenta INT PRIMARY KEY AUTO_INCREMENT,
  tipo_cuenta VARCHAR(50) NOT NULL -- DEBE o HABER
);

-- OPERACIONES EN ASIENTOS
CREATE TABLE operaciones (
  id_operacion INT PRIMARY KEY AUTO_INCREMENT,
  id_asiento INT NOT NULL,
  id_cuenta INT NOT NULL,
  id_tipo_cuenta INT NOT NULL,
  monto DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (id_asiento) REFERENCES asientos(id_asiento),
  FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta),
  FOREIGN KEY (id_tipo_cuenta) REFERENCES tipo_cuenta(id_tipo_cuenta)
);

-- COMPROBANTES (Factura, Nota de crédito, etc.)
CREATE TABLE comprobantes (
  id_comprobante INT PRIMARY KEY AUTO_INCREMENT,
  tipo ENUM('FACTURA_A', 'FACTURA_B', 'NC_A', 'NC_B', 'ND_A', 'ND_B') NOT NULL,
  fecha DATE NOT NULL,
  numero VARCHAR(20) NOT NULL,
  cuit_cliente VARCHAR(20),
  razon_social_cliente VARCHAR(100),
  monto_total DECIMAL(12,2) NOT NULL
);

-- LIBRO IVA (COMPRAS Y VENTAS)
CREATE TABLE iva_libro (
  id_iva INT PRIMARY KEY AUTO_INCREMENT,
  id_comprobante INT NOT NULL,
  tipo_libro ENUM('VENTAS', 'COMPRAS') NOT NULL,
  neto_gravado DECIMAL(12,2),
  iva_21 DECIMAL(12,2),
  iva_10_5 DECIMAL(12,2),
  total DECIMAL(12,2),
  FOREIGN KEY (id_comprobante) REFERENCES comprobantes(id_comprobante)
);

-- LOG DE EVENTOS (opcional para auditoría)
CREATE TABLE log_eventos (
  id_log INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  accion VARCHAR(100),
  descripcion TEXT,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- INSERTAR ROLES INICIALES
INSERT INTO roles (rol) VALUES ('ADMINISTRADOR'), ('CONTADOR'), ('USUARIO');

-- INSERTAR TIPOS DE SALDO
INSERT INTO tipos_saldos (tipo_saldo) VALUES ('DEUDOR'), ('ACREEDOR');

-- INSERTAR TIPO DE MOVIMIENTO
INSERT INTO tipo_cuenta (tipo_cuenta) VALUES ('DEBE'), ('HABER');
