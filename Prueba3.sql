use Msoto_SBD


--CREACION DE TABLAS --

CREATE TABLE Usuario (
Nombre_usuario varchar(30) not null PRIMARY KEY,
Contraseña varchar(30) )

CREATE TABLE Dirreción (
id_direccion INT IDENTITY(1,1) not null PRIMARY KEY,
calle varchar(30),
Numero int ,
Comuna VARCHAR(30),
Ciudad VARCHAR(30) )

CREATE TABLE Proveedor (
id_proveedor int not null PRIMARY KEY,
id_proveedor_direccion int ,
Nombre_proveedor varchar(30),
telefono int ,
pagina_web varchar(30),

CONSTRAINT FK_Proveedor_Direccion FOREIGN KEY (id_proveedor_direccion) REFERENCES Dirreción(id_direccion) 
)

CREATE TABLE Clientes (
id_cliente int not null PRIMARY KEY,
id_cliente_direccion int,
Nombre varchar(30),
telefono int,

CONSTRAINT FK_Clientes_Direccion FOREIGN KEY (id_cliente_direccion) REFERENCES Dirreción(id_direccion)
)

CREATE TABLE Categorias(
id_categoria int identity(1,1) not null PRIMARY KEY,
Nombre_categoria varchar(30),
Descripcion varchar(30),
)

CREATE TABLE Productos (
id_producto int not null PRIMARY KEY,
id_producto_proveedor int,
id_producto_categoria int ,
nombre varchar(30),
Precio_actual int,
Stock int ,

CONSTRAINT FK_Productos_Proveedor FOREIGN KEY (id_producto_proveedor) REFERENCES Proveedor(id_proveedor),
CONSTRAINT FK_Prodcutos_Categorias FOREIGN KEY (id_producto_categoria) REFERENCES Categorias(id_categoria)
)

CREATE TABLE Ventas (
id_ventas int not null PRIMARY KEY,
id_ventas_cliente int ,
fecha date,
descuento int,
monto_final int,

CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (id_ventas_cliente) REFERENCES Clientes(id_cliente))



--CREACION DE PROCEDIMIENTOS ALMACENADOS--

--AGREGAR CLIENTE--
ALTER PROCEDURE [dbo].[AgregarCliente]
@Rut int,  
@Nombre varchar(30),
@telefono int
AS
BEGIN
	IF NOT EXISTS (select * from dbo.Clientes  where id_cliente=@Rut)
	BEGIN 
		INSERT INTO dbo.Clientes(id_cliente,Nombre,telefono)
		VALUES (@Rut,@Nombre,@telefono);
		
	END
END

--AGREGAR CATEGORIA--

ALTER PROCEDURE [dbo].[AgregarCategoria] 
@nombre_categoria varchar(30),
@descripcion varchar(30)
AS
BEGIN
INSERT INTO Categorias(Nombre_categoria,Descripcion)
VALUES (@nombre_categoria,@descripcion)
END

--AGREGAR DIRECCIÓN--

ALTER PROCEDURE [dbo].[AgregarDireccion] 
@calle varchar(30),  
@numero int,
@comuna varchar(30),
@ciudad varchar(30)
AS
BEGIN
		INSERT INTO dbo.Dirreción(calle,Numero,Comuna,Ciudad)
		VALUES (@calle,@numero,@comuna,@ciudad);
		

END

--AGREGAR PRODUCTOS--

ALTER PROCEDURE [dbo].[AgregarProducto]
@id_producto int,
@rut_proveedor int,
@nombre varchar (30),
@precio_actual int,
@stock int
AS
BEGIN 
		INSERT INTO Productos(id_producto,id_producto_proveedor,nombre,Precio_actual,Stock)
		VALUES(@id_producto,@rut_proveedor,@nombre,@precio_actual,@stock)
END 

--AGREGAR PROVEEDOR--

ALTER procedure [dbo].[AgregarProveedor]
@rut int,
@nombre varchar(30),
@telefono int,
@pagina_web varchar(30)
AS
BEGIN
IF NOT EXISTS (select * from Proveedor where id_proveedor=@Rut)
	BEGIN 
		INSERT INTO Proveedor(id_proveedor,Nombre_proveedor,telefono,pagina_web)
		VALUES (@Rut,@Nombre,@telefono,@pagina_web);

	END
END

--ELIMINAR CLIENTE--

ALTER procedure [dbo].[EliminarCliente]
@rut int
as 
BEGIN 
	Delete from Clientes where id_cliente=@rut
END
