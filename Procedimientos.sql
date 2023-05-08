USE bases1_proyecto2
GO

-- Procedimiento para agregar un Restaurante a la DB
DROP PROCEDURE IF EXISTS AddRestaurante
GO
CREATE PROCEDURE AddRestaurant
    @p_Id VARCHAR(100),
    @Direccion VARCHAR(200),
    @Municipio VARCHAR(200),
    @Zona INT,
    @Telefono BIGINT,
    @Personal INT,
    @Tiene_Parqueo BIT
AS
BEGIN
    -- Primero valido que la zona sea un entero positivo
    IF dbo.ValidarPositivo(@Zona) = 0 
		BEGIN
        SELECT 'ZONA DEBE SER UN NUMERO POSITIVO' AS ERROR;
        RETURN
		END
    -- Validar que el numero de empleados sea un entero positivo 
    IF dbo.ValidarPositivo(@Personal) = 0 
		BEGIN
        SELECT 'NUMERO DE EMPLEADOS DEBE SER UN NUMERO POSITIVO' AS ERROR;
        RETURN;
		END
    -- Valido que el numero en parqueo sea 0 o 1 
    IF dbo.ValidarBooleano(@Tiene_Parqueo) = 0 
		BEGIN
        SELECT 'PARQUEO DEBE SER 0 O 1 UNICAMENTE' AS ERROR
        RETURN
		END

    IF EXISTS(SELECT ID FROM dbo.Restaurante WHERE ID = @p_Id) 
		BEGIN
        SELECT 'RESTAURANTE YA EXISTE' AS ERROR;
        RETURN;
		END;

    INSERT INTO dbo.Restaurante (Id, Direccion, Municipio, Zona, Telefono, Personal, Parqueo) 
    VALUES (@p_Id, @Direccion, @Municipio, @Zona, @Telefono, @Personal, @Tiene_parqueo);
END;
GO

-- Procedimiento para agregar un puesto a la DB
DROP PROCEDURE IF EXISTS AddPosition
GO
CREATE PROCEDURE AddPosition 
  @p_Nombre VARCHAR(200),
  @Descripcion VARCHAR(200),
  @Salario INT
AS
BEGIN
  -- Primero valido que el salario sea un entero positivo
  IF dbo.ValidarPositivo(@Salario) = 0 
  BEGIN
    SELECT 'SALARIO DEBE SER UN NUMERO POSITIVO' AS ERROR;
    RETURN;
  END;
  
  -- Validar que el id del puesto no existe ya
  IF EXISTS(SELECT Nombre FROM dbo.Puesto WHERE Nombre = @p_Nombre)
  BEGIN
    SELECT 'PUESTO YA INGRESADO' AS ERROR;
    RETURN;
  END;
  
  INSERT INTO dbo.Puesto(Nombre, Descripcion, Salario) 
  VALUES (@p_Nombre, @Descripcion, @Salario);
END;
GO

-- Procedimiento para añadir nuevos empleados a la DB
DROP PROCEDURE IF EXISTS AddWorker;
GO
CREATE PROCEDURE AddWorker (
  @Nombres VARCHAR(200),
  @Apellidos VARCHAR(200),
  @FechaNacimiento DATE,
  @Correo VARCHAR(100),
  @Telefono INT ,
  @Direccion VARCHAR(100),
  @p_NumDPI BIGINT,
  @p_IdPuesto INT,
  @FechaInicio DATE,
  @p_IdRestaurante VARCHAR(100)
)
AS
BEGIN
	-- Primero valido que la zona sea un entero positivo
	IF dbo.ValidarCorreo(@Correo) = 0 BEGIN
		SELECT 'EL CORREO NO ES VALIDO' AS ERROR;
		RETURN;
	END
	/* VALIDAR QUE EL ID DEL PUESTO EXISTA  */
	IF (NOT EXISTS(SELECT Nombre FROM dbo.Puesto WHERE Id = @p_IdPuesto)) BEGIN
	SELECT 'EL PUESTO INGRESADO NO EXISTE' AS ERROR;
	RETURN;
	END
	/* VALIDAR QUE EL ID DEL RESTAURANTE EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM dbo.Restaurante WHERE Id = @p_IdRestaurante)) BEGIN
	SELECT 'EL RESTAURANTE INGRESADO NO EXISTE' AS ERROR;
	RETURN;
	END
	/* VALIDAR QUE EL DPI DEL EMPLEADO NO EXISTA YA */
	IF (EXISTS(SELECT Nombre FROM dbo.Empleado WHERE DPI = @p_NumDPI)) BEGIN
	SELECT 'EL EMPLEADO YA ESTA INGRESADO' AS ERROR;
	RETURN;
	END

	INSERT INTO dbo.Empleado(Nombre, Apellido, FechaNacimiento, Correo, Telefono, Direccion, DPI, IDPuesto, FechaInicio, IDRestaurante) 
	VALUES (@Nombres, @Apellidos, @FechaNacimiento, @Correo, @Telefono, @Direccion, @p_NumDPI, @p_IdPuesto, @FechaInicio, @p_IdRestaurante);
END
GO

-- Procedimiento para añadir nuevos clientes a la DB
DROP PROCEDURE IF EXISTS AddClient;
GO
CREATE PROCEDURE AddClient (
  @p_DPI BIGINT,
  @Nombre VARCHAR(255),
  @Apellidos VARCHAR(255),
  @Fecha_de_nacimiento DATE,
  @Correo VARCHAR(255),
  @Telefono INT,
  @NIT INT
)
AS
BEGIN
	-- Validar que el correo sea válido
	IF (CHARINDEX('@', @Correo) = 0 OR CHARINDEX('.', @Correo) = 0) BEGIN
		SELECT 'EL CORREO NO ES VALIDO' AS ERROR;
		RETURN;
	END;

	-- Validar que el DPI del cliente no exista ya
	IF (EXISTS(SELECT Nombre FROM dbo.Cliente WHERE DPI = @p_DPI)) BEGIN
		SELECT 'EL CLIENTE YA EXISTE' AS ERROR;
		RETURN;
	END;

	INSERT INTO dbo.Cliente (DPI, Nombre, Apellido, FechaNacimiento, Correo, Telefono, NIT) 
	VALUES (@p_DPI, @Nombre, @Apellidos, @Fecha_de_nacimiento, @Correo, @Telefono, @NIT);
END;
GO

-- Procedimiento para añadir nuevas direcciones en la DB
DROP PROCEDURE IF EXISTS AddDirection;
GO
CREATE PROCEDURE AddDirection (
  @p_DPI BIGINT,
  @Direccion VARCHAR(255),
  @Municipio VARCHAR(255),
  @Zona INT
)
AS
BEGIN
	-- Primero valido que la zona sea un entero positivo
	IF (@Zona <= 0) BEGIN
		SELECT 'ZONA DEBE SER UN NUMERO POSITIVO' AS ERROR;
		RETURN;
	END;
	
	/* VALIDAR QUE EL DPI DEL CLIENTE NO EXISTA YA */
	IF (NOT EXISTS(SELECT DPI FROM dbo.Cliente WHERE DPI = @p_DPI)) BEGIN
		SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
		RETURN;
	END;

	INSERT INTO dbo.Direccion(DPICliente, Direccion, Municipio, Zona) 
	VALUES (@p_DPI, @Direccion, @Municipio, @Zona);
END;
GO

-- Procedimiento para añadir nuevas ordenes a la DB
DROP PROCEDURE IF EXISTS AddOrder
GO
CREATE PROCEDURE AddOrder (
  @p_Id BIGINT,
  @IdCliente BIGINT,
  @Canal CHAR(1)
)
AS
BEGIN
	/* DECLARO VARIABLES PARA GUARDAR LA INFO  */
    DECLARE @municipioCliente VARCHAR(255);
    DECLARE @zonaCliente INT;
    DECLARE @idRestaurante VARCHAR(100);

    /* GUARDO LA RESPUESTA EN MIS VARIABLES municipioCliente, zonaCliente  */
    SELECT @municipioCliente = Municipio, @zonaCliente = Zona FROM dbo.Direccion WHERE Id = @IdCliente;

    /* GUARDO LA RESPUESTA EN MI VARIABLE idRestaurante  */
    SELECT @idRestaurante = Id FROM dbo.Restaurante WHERE Municipio = @municipioCliente AND Zona = @zonaCliente;

    /* VALIDAR QUE EL DPI DEL CLIENTE EXISTA */
    IF (NOT EXISTS(SELECT Nombre FROM dbo.Cliente WHERE DPI = @p_Id)) 
    BEGIN
        SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
        RETURN;
    END

    /* VALIDAR QUE EL CANAL SEA PERMITIDO */
    IF dbo.ValidarCanal(@Canal) = 0 
    BEGIN
        SELECT 'CANAL NO VALIDO' AS ERROR;
        RETURN;
    END

    IF (NOT EXISTS(SELECT Municipio FROM dbo.Direccion WHERE DPICliente = @p_Id AND Id = @IdCliente)) 
    BEGIN
        SELECT 'LA DIRECCION ES DE OTRO CLIENTE' AS ERROR;
        RETURN;
    END

    IF @idRestaurante IS NULL 
    BEGIN
        INSERT INTO dbo.Orden (IDCliente, Canal, Estado) VALUES (@p_Id, @Canal, 'SIN COBERTURA');
    END
    ELSE
    BEGIN
        INSERT INTO dbo.Orden (IDCliente, IdDireccion, IDRestaurante, Canal, Estado) VALUES (@p_Id, @IdCliente, @idRestaurante, @Canal, 'INICIADA');
    END
END;
GO

-- Procedimiento para agregar los items a la DB
DROP PROCEDURE IF EXISTS AddItem
GO
CREATE PROCEDURE AddItem 
  @idOrden INT,
  @tipo_prod CHAR(1),
  @producto INT,
  @cantidad INT,
  @Observacion VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @estadoOrden VARCHAR(50);

	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM dbo.Orden WHERE Id = @idOrden )) BEGIN
		SELECT 'LA ORDEN NO EXISTE' AS ERROR;
		RETURN
	END

	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM dbo.Orden WHERE Id = @idOrden AND (Estado = 'INICIADA' OR Estado = 'AGREGANDO') )) BEGIN
		SELECT 'EL ESTADO NO PERMITE AGREGAR ITEMS' AS ERROR;
		RETURN
	END

	/* OBTENGO EL ESTADO DE LA ORDEN */
    SELECT @estadoOrden = Estado FROM dbo.Orden WHERE Id = @idOrden;
   
    /* VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO FINALIZADA O EN CAMINO */
    IF @estadoOrden = 'FINALIZADA' OR @estadoOrden = 'EN CAMINO' BEGIN
        SELECT 'NO SE PUEDE AGREGAR PRODUCTO A UNA ORDEN FINALIZADA O EN CAMINO' AS ERROR;
        RETURN
    END
   
    /* ACTUALIZO EL ESTADO DE LA ORDEN A "AGREGANDO" SI SE ENCONTRABA EN "INICIADA" */
    IF @estadoOrden = 'INICIADA' BEGIN
        UPDATE dbo.Orden SET Estado = 'AGREGANDO' WHERE Id = @idOrden;
    END
	
	/* VALIDAR QUE EL TIPO DE PRODUCTO SEA PERMITDIO */
	IF dbo.ValidarTipoProd(@tipo_prod) = 0 BEGIN 
		SELECT 'TIPO DE PRODUCTO NO PERMITIDO' AS ERROR;
		RETURN
	END

	/* VALIDAR QUE CANTIDAD SE ENTERO POSITIVO */
	IF dbo.ValidarPositivo(@cantidad) = 0 BEGIN 
			SELECT 'CANTIDAD DEBE SER UN NUMERO POSITIVO' AS ERROR;
			RETURN
	END

	/* VALIDAR QUE SEA UN PRODUCTO QUE EXISTA */
	IF (NOT EXISTS(SELECT Nombre FROM dbo.Menu WHERE Id = CONCAT(@tipo_prod, @producto))) BEGIN
		SELECT 'EL PRODUCTO NO EXISTE' AS ERROR; 
		RETURN
	END
		
	INSERT INTO dbo.Item (TipoProducto, Producto, Cantidad, IDOrden, Observacion) 
    VALUES (@tipo_prod, @producto, @cantidad, @idOrden, @Observacion);
END;
GO

-- Procedimiento para confirmar ordenes de la DB
DROP PROCEDURE IF EXISTS ConfirmOrder
GO
CREATE PROCEDURE ConfirmOrder (
  @idOrden INT,
  @FormaPago CHAR(1),
  @p_IdRepartidor INT
)
AS
BEGIN
    SET NOCOUNT ON;

	/*DECLARAMOS TODO PARA LA FACTURA*/
	DECLARE @p_total DECIMAL(10,2);
	DECLARE @p_numserie VARCHAR(50);
	DECLARE @p_lugar VARCHAR(200);
	DECLARE @p_fecha_hora DATETIME;
	DECLARE @p_nit INT;
	DECLARE @p_FormaPago CHAR(1);
	DECLARE @p_estado_orden VARCHAR(50);
	
	/* VALIDAR QUE LA ORDEN EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM dbo.Orden WHERE Id = @idOrden )) BEGIN
	    SELECT 'LA ORDEN NO EXISTE' AS ERROR;
	    RETURN;
	END;
	
	/* VALIDAR QUE LA FORMA DE PAGO ES CORRECTA */
	IF dbo.ValidarFormaPago(@FormaPago) = 0 BEGIN 
		SELECT 'FORMA DE PAGO NO ADMITIDO' AS ERROR;
		RETURN;
	END;
	
	/* VALIDAR QUE EL TRABAJADOR EXISTA  */
	IF (NOT EXISTS(SELECT Id FROM dbo.Empleado WHERE Id = @p_IdRepartidor )) BEGIN
	    SELECT 'NO EXISTE EL TRABAJADOR' AS ERROR;
	    RETURN;
	END;
	
	/* OBTENGO EL ESTADO DE LA ORDEN */
    SELECT @p_estado_orden = Estado FROM dbo.Orden WHERE Id = @idOrden;
    
    /* VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO ENTREGADA O EN CAMINO */
    IF (@p_estado_orden != 'AGREGANDO') BEGIN
        SELECT 'NO SE PUEDE CONFIRMAR LA ORDEN AHORA' AS ERROR;
        RETURN;
    END;
    
    UPDATE dbo.Orden SET Estado = 'EN CAMINO', IdRepartidor = @p_IdRepartidor WHERE Id = @idOrden;

	/* OBTENGO LOS DATOS DE LA ORDEN Y DEL CLIENTE */	
 	SET @p_lugar = (SELECT Municipio FROM dbo.Direccion WHERE DPICliente = (SELECT IdCliente FROM dbo.Orden WHERE Id = @idOrden));
 	SET @p_nit = (SELECT NIT FROM dbo.Cliente WHERE DPI = (SELECT IdCliente FROM dbo.Orden WHERE Id = @idOrden));
END;
GO

DROP PROCEDURE IF EXISTS FinishOrder
GO
CREATE PROCEDURE FinishOrder
  @idOrden INT
AS
BEGIN
  DECLARE @p_estado_orden VARCHAR(50);
	
  -- VALIDAR QUE LA ORDEN EXISTA
  IF NOT EXISTS(SELECT ID FROM dbo.Orden WHERE ID = @idOrden) 
  BEGIN
    SELECT 'LA ORDEN NO EXISTE' AS ERROR;
    RETURN;
  END;

  -- OBTENGO EL ESTADO DE LA ORDEN
  SELECT @p_estado_orden = Estado FROM dbo.Orden WHERE Id = @idOrden;
   
  -- VALIDO QUE LA ORDEN NO ESTÉ EN ESTADO ENTREGADA O EN CAMINO
  IF @p_estado_orden <> 'EN CAMINO' 
  BEGIN
    SELECT 'NO SE PUEDE FINALIZAR LA ORDEN PORQUE NO ESTÁ EN CAMINO' AS ERROR;
    RETURN;
  END;

  UPDATE dbo.Orden SET Estado = 'ENTREGADA', FechaEntrega = GETDATE() WHERE Id = @idOrden;
END;
GO

DROP PROCEDURE IF EXISTS GetRestaurants
GO
CREATE PROCEDURE GetRestaurants
AS
BEGIN
    SELECT Id, Direccion, Municipio, Zona, Telefono, Personal,
        CASE Parqueo WHEN 1 THEN 'Sí' ELSE 'No' END AS Tiene_Parqueo
    FROM dbo.Restaurante;
END;
GO

-- Procedimiento para obtener los datos de un empleado
DROP PROCEDURE IF EXISTS GetEmployee
GO
CREATE PROCEDURE GetEmployee
    @idEmpleado INT
AS
BEGIN
    SET NOCOUNT ON;
	
	/* VALIDAR QUE EL EMPLEADO NO EXISTA  */
	IF NOT EXISTS(SELECT Id FROM dbo.Empleado WHERE Id = @idEmpleado )
	BEGIN
	    SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
	    RETURN;
	END;
	
	SELECT e.Id, CONCAT(e.Nombre ,' ', e.Apellido) AS NombreCompleto, e.FechaNacimiento, e.Correo, e.Telefono, e.Direccion, e.DPI, e.FechaInicio, p.Nombre, p.Salario
	FROM dbo.Empleado e
	INNER JOIN dbo.Puesto p ON e.IdPuesto = p.Id
	WHERE e.Id = @idEmpleado;
	
END;
GO

-- Procedimiento para obtener los items de las ordenes
DROP PROCEDURE IF EXISTS GetItemOrder
GO
CREATE PROCEDURE GetItemOfOrder (
    @idOrder INT
)
AS
BEGIN
    SET NOCOUNT ON;

    /* VALIDAR QUE LA ORDEN EXISTA */
    IF NOT EXISTS (SELECT Id FROM dbo.Orden WHERE Id = @idOrder)
    BEGIN
        SELECT 'LA ORDEN NO EXISTE' AS ERROR;
        RETURN;
    END;

    /* VALIDAR QUE LA ORDEN SEA DIFERENTE A SIN COBERTURA */
    IF EXISTS (SELECT Id FROM dbo.Orden WHERE Id = @idOrder AND Estado = 'SIN COBERTURA')
    BEGIN
        SELECT 'ESTA ORDEN NO TIENE COBERTURA' AS ERROR;
        RETURN;
    END;

    /* LE PONGO NOMBRE AL TIPO DE PRODUCTO */
    SELECT p.Nombre AS Producto,
           CASE i.TipoProducto
                WHEN 'C' THEN 'Combo'
                WHEN 'E' THEN 'Extra'
                WHEN 'B' THEN 'Bebida'
                WHEN 'P' THEN 'Postre'
           END AS TipoProducto,
           p.Precio AS Precio,
           i.cantidad AS Cantidad,
           i.observacion AS Observacion
    FROM dbo.Item i
    INNER JOIN dbo.Menu p ON CONCAT(i.TipoProducto, producto) = p.ID
    WHERE i.idOrden = @idOrder;

END;
GO

-- Procedimiento para obtener las direcciones de un cliente almacenado en la DB
DROP PROCEDURE IF EXISTS GetAddress
GO
CREATE PROCEDURE GetAddress
    @dpi_client BIGINT
AS
BEGIN
    -- VALIDAR QUE EL CLIENTE EXISTA
    IF NOT EXISTS (SELECT DPI FROM dbo.Cliente WHERE DPI = @dpi_client)
    BEGIN
        SELECT 'EL CLIENTE NO EXISTE' AS ERROR;
        RETURN;
    END;

    -- OBTENER LOS DATOS DE LA DIRECCIÓN
    SELECT Direccion, Municipio, Zona
    FROM dbo.Direccion
    WHERE DPICliente = @dpi_client;
END;
GO

DROP PROCEDURE IF EXISTS GetOrderByState
GO
CREATE PROCEDURE GetOrdersByState
    @EstadoOrden INT
AS
BEGIN
    SELECT o.Id AS IdOrden, o.Estado, o.FechaInicio AS Fecha, o.IdCliente AS DPICliente, o.IdDireccion,
           CASE o.canal
               WHEN 'L' THEN 'Llamada'
               WHEN 'A' THEN 'Aplicacion'
           END AS Canal, r.Direccion AS Restaurante
    FROM dbo.Orden o 
    LEFT OUTER JOIN dbo.Restaurante r ON r.Id = o.IdDireccion
    WHERE o.Estado = CASE @EstadoOrden
                         WHEN 1 THEN 'INICIADA'
                         WHEN 2 THEN 'AGREGANDO'
                         WHEN 3 THEN 'EN CAMINO'
                         WHEN 4 THEN 'ENTREGADA'
                         WHEN -1 THEN 'SIN COBERTURA'
                     END;
END;
GO

DROP PROCEDURE IF EXISTS GetTimes
GO

CREATE PROCEDURE GetTimes
    @Minutos INT
AS
BEGIN
    SELECT o.Id as IdOrden, o.IdDireccion as DireccionEntrega, o.FechaInicio, DATEDIFF(MINUTE, o.FechaInicio, o.FechaEntrega) AS TiempoEspera, CONCAT(e.Nombre,' ',e.Apellido) AS Repartidor
    FROM dbo.Orden o
    LEFT JOIN dbo.Empleado e ON o.IdRepartidor = e.Id
    WHERE o.Estado = 'ENTREGADA' AND DATEDIFF(MINUTE, o.FechaInicio, o.FechaEntrega) >= @Minutos;
END
GO