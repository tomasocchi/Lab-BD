-- PostgreSQL 
CREATE TABLE LOG_planillaControl (
      numero_operacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,          
      operacion  VARCHAR(30) 
);


-- MySQL
CREATE TABLE LOG_planillaControl (
      numero_operacion      INT PRIMARY KEY AUTO_INCREMENT,
      operacion                      VARCHAR(30) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
