CREATE DATABASE bases1_proyecto2

USE bases1_proyecto2

ALTER TABLE Empleado
DROP CONSTRAINT FK_Empleado_Restaurante

ALTER TABLE Empleado
DROP CONSTRAINT FK_Empleado_Puesto

ALTER TABLE Item
DROP CONSTRAINT FK_Item_Orden

DROP TABLE IF EXISTS Restaurante
CREATE TABLE Restaurante (
	ID VARCHAR(200) PRIMARY KEY NOT NULL,
	Direccion VARCHAR(200) NOT NULL,
	Municipio VARCHAR(200) NOT NULL,
	Zona INT NOT NULL,
	Telefono INT NOT NULL,
	Personal INT NOT NULL,
	Parqueo BIT NOT NULL
);
GO

DROP TABLE IF EXISTS Puesto
CREATE TABLE Puesto (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(200) NOT NULL,
	Descripcion VARCHAR(200) NOT NULL,
	Salario INT NOT NULL
);
GO

DROP TABLE IF EXISTS Cliente
CREATE TABLE Cliente (
	DPI BIGINT PRIMARY KEY NOT NULL,
	Nombre VARCHAR(200) NOT NULL,
	Apellido VARCHAR(200) NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Correo VARCHAR(200) NOT NULL,
	Telefono INT NOT NULL,
	NIT INT,
);
GO

DROP TABLE IF EXISTS Empleado
CREATE TABLE Empleado (
	--Este ID debe de ir con 8 dígitos por lo cual necesitamos un trigger que haga eso, es incremental en 1 y empieza directamente en 1
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(200) NOT NULL,
	Apellido VARCHAR(200) NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Correo VARCHAR(200) NOT NULL,
	Telefono INT NOT NULL,
	Direccion VARCHAR(200) NOT NULL,
	DPI BIGINT NOT NULL,
	IDPuesto INT NOT NULL,
	FechaInicio DATE NOT NULL,
	IDRestaurante VARCHAR(200) NOT NULL,
	CONSTRAINT FK_Empleado_Restaurante FOREIGN KEY (IDRestaurante) REFERENCES Restaurante (ID),
	CONSTRAINT FK_Empleado_Puesto FOREIGN KEY (IDPuesto) REFERENCES Puesto (ID)
);
GO

DROP TABLE IF EXISTS Direccion
CREATE TABLE Direccion (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	DPICliente BIGINT,
	Direccion VARCHAR(200) NOT NULL,
	Municipio VARCHAR(200) NOT NULL,
	Zona INT
);
GO

DROP TABLE IF EXISTS Orden
CREATE TABLE Orden (
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IDCliente BIGINT NOT NULL,
	Canal CHAR(1) NOT NULL,
	IdDireccion VARCHAR(200) NOT NULL,
	FechaInicio DATETIME DEFAULT GETDATE() NOT NULL,
	FechaEntrega DATETIME,
	Estado VARCHAR(200) NOT NULL,
	IDRestaurante VARCHAR(200) NOT NULL,
	IDRepartidor BIGINT
);
GO

DROP TABLE IF EXISTS Item
CREATE TABLE Item (
	ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TipoProducto CHAR(1) NOT NULL,
	Producto INT NOT NULL,
	Cantidad INT NOT NULL,
	IDOrden INT NOT NULL,
	Observacion VARCHAR(200) NOT NULL,
	CONSTRAINT FK_Item_Orden FOREIGN KEY (IDOrden) REFERENCES Orden (ID)
);
GO

DROP TABLE IF EXISTS Factura
CREATE TABLE Factura (
	IDFactura INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NumeroSerie VARCHAR(200) NOT NULL,
	MontoTotal DECIMAL(10, 2) NOT NULL,
	Lugar VARCHAR(200) NOT NULL,
	FechaHoraActual DATETIME NOT NULL,
	IdOrden INT NOT NULL,
	NITCliente VARCHAR(25) NOT NULL,
	FormaPago CHAR(1) NOT NULL
);
GO

DROP TABLE IF EXISTS Historial
CREATE TABLE Historial (
	ID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	Fecha DATETIME DEFAULT GETDATE() NOT NULL,
	Tipo VARCHAR(200) NOT NULL
);
GO

DROP TABLE IF EXISTS Menu
CREATE TABLE Menu(
	ID VARCHAR(5) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(200) NOT NULL,
	Precio DECIMAL(8,2) NOT NULL
);
GO

INSERT INTO Menu (ID, Nombre, Precio)
VALUES ('C1', 'Cheeseburger', 41.00),
       ('C2', 'Chicken Sandwich', 32.00),
       ('C3', 'BBQ Ribs', 54.00),
       ('C4', 'Pasta Alfredo', 47.00),
       ('C5', 'Pizza Espinator', 85.00),
       ('C6', 'Buffalo Wings', 36.00),
       ('E1', 'Papas fritas', 15.00),
       ('E2', 'Aros de cebolla', 17.00),
       ('E3', 'Coleslaw', 12.00),
       ('B1', 'Coca-Cola', 12.00),
       ('B2', 'Fanta', 12.00),
       ('B3', 'Sprite', 12.00),
       ('B4', 'Té frío', 12.00),
       ('B5', 'Cerveza de barril', 18.00),
       ('P1', 'Copa de helado', 13.00),
       ('P2', 'Cheesecake', 15.00),
       ('P3', 'Cupcake de chocolate', 8.00),
       ('P4', 'Flan', 10.00);

SELECT 
    f.name AS ForeignKey,
    OBJECT_NAME(f.parent_object_id) AS TableName,
    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName,
    OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName
FROM 
    sys.foreign_keys AS f
INNER JOIN 
    sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id
WHERE 
    OBJECT_NAME(f.parent_object_id) = 'NombreDeLaTabla'