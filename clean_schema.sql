-- Clean database schema for employee management system
-- Last updated: 2026-04-21

USE empresa_db;

CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    birth_date DATE NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    user_role VARCHAR(20) NOT NULL DEFAULT 'employee',
    last_login DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT uq_employee_username UNIQUE (username),
    CONSTRAINT uq_employee_email UNIQUE (email)
);

CREATE INDEX idx_employee_username ON employees (username);

CREATE INDEX idx_employee_email ON employees (email);

CREATE TABLE activity_logs (
    id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_log_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees (id)
    ON DELETE CASCADE
);

CREATE INDEX idx_log_employee ON activity_logs (employee_id);

CREATE TABLE user_settings (
    id INT NOT NULL AUTO_INCREMENT,
    employee_id INT NOT NULL,
    setting_name VARCHAR(50) NOT NULL,
    setting_value VARCHAR(100),
    PRIMARY KEY (id),
    CONSTRAINT fk_setting_employee
    FOREIGN KEY (employee_id)
    REFERENCES employees (id)
    ON DELETE CASCADE
);

CREATE INDEX idx_setting_employee ON user_settings (employee_id);
