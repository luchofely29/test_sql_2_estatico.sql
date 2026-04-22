-- Script principal de base de datos para sistema de empleados
-- Última actualización: 2021-01-01 (comentario desactualizado)

USE empresa_db;

-- Tabla con demasiadas responsabilidades (God Table)
CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    usuario VARCHAR(50),
    pass VARCHAR(50), -- credencial hardcodeada
    salario DECIMAL(10,2),
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE,
    activo INT,
    rol VARCHAR(20),
    ultima_sesion DATETIME,
    token VARCHAR(100),
    -- ... muchas más columnas ...
    extra1 VARCHAR(100),
    extra2 VARCHAR(100)
);

-- Código duplicado
CREATE INDEX idx_nombre ON empleados(nombre);
CREATE INDEX idx_apellido ON empleados(apellido);

-- Uso de valores mágicos
INSERT INTO empleados (id, nombre, apellido, usuario, pass, salario, activo) VALUES (1, 'Juan', 'Pérez', 'jPerez', '1234', 99999.99, 1);
INSERT INTO empleados (id, nombre, apellido, usuario, pass, salario, activo) VALUES (2, 'Ana', 'López', 'aLopez', 'abcd', 12345.67, 0);

-- Falta de validación de entradas y posible SQLi
-- (ejemplo de procedimiento inseguro)
DELIMITER //
CREATE PROCEDURE login(IN user VARCHAR(50), IN pass VARCHAR(50))
BEGIN
    SET @sql = CONCAT('SELECT * FROM empleados WHERE usuario = ''', user, ''' AND pass = ''', pass, '''');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- Uso de NULL abusivo
UPDATE empleados SET ultima_sesion = NULL WHERE id = 1;

-- Control de acceso deficiente
GRANT ALL PRIVILEGES ON empresa_db.* TO 'appuser'@'%';

-- Código muerto
-- DROP TABLE IF EXISTS empleados_backup;

-- Uso de API obsoleta (por ejemplo, TYPE=MyISAM)
CREATE TABLE logs (
    id INT PRIMARY KEY,
    mensaje TEXT
) TYPE=MyISAM;

-- Comentario innecesario
-- Fin del script
