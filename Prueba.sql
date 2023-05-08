use bases1_proyecto2

-- ########################### INGRESAR Restaurante ###########################
EXEC AddRestaurant 'R-01', 'Zona 10, Guatemala City','Guatemala',-10,12121212,10,1; -- Zona invalida
EXEC AddRestaurant 'R-01', 'Zona 10, Guatemala City','Guatemala',10,12121212,-10,1; -- personal invalido
EXEC AddRestaurant 'R-03', 'Zona 20, Villa Nueva','Guatemala',10,12121223,10,1; -- ok
EXEC AddRestaurant 'R-02', 'Zona 19, San Miguel Petapa','Guatemala',10,12121213,10,1; -- ok
EXEC AddRestaurant 'R-01', 'Zona 10, Guatemala City','Guatemala',10,12121212,10,1; -- error duplicado



-- ########################### INGRESAR Puesto De Trabajo ###########################
EXEC AddPosition 'Gerente','Monitoreo del restaurante',-5000.00; -- Salario Invalido
EXEC AddPosition 'Gerente','Monitoreo del restaurante',5000.00;  -- ok
EXEC AddPosition 'Gerente','Monitoreo del restaurante',5000.00; -- Error repetido
EXEC AddPosition 'Repartidor','Repartir comida',3500.00; -- ok
EXEC AddPosition 'Conserje','Limpieza de restaurante',3000.00; -- ok


-- ########################### INGRESAR Empleados ###########################
EXEC AddWorker 'Harry','Maguire','1990-01-01','hola.com',12347890,'Zona 15',4567098710234,1,'2022-01-01',"R-01"; -- Correo invalido
EXEC AddWorker 'Harry','Maguire','1990-01-01','hola@gmail.com',12347890,'Zona 15',4567098710234,4,'2022-01-01',"R-01"; -- Error, puesto de trabajo inexistente
EXEC AddWorker 'Harry','Maguire','1990-01-01','hola@gmail.com',12347890,'Zona 15',4567098710234,1,'2022-01-01',"R-02"; -- Error, restaurante inexistente
EXEC AddWorker 'Jennie','Maguire','1990-01-01','hola2@gmail.com',12347890,'Zona 21',3000346440101,7,'2022-01-01',"R-01"; -- Ok
EXEC AddWorker 'James','Hollywood','1990-01-01','aaa@hotmail.es',12347899,'Zona 15',4567098710234,1,'2022-01-01',"R-01"; -- Error, dpi duplicado
EXEC AddWorker 'James','Hollywood','1990-01-01','aaa@hotmail.es',12347899,'Zona 15',4567098710235,3,'2022-01-01',"R-01"; -- Ok

-- ########################### INGRESAR Clientes ###########################
EXEC AddClient 1234678909123,'Alex','Hunter','1990-01-01','bbbbb@',89709867,NULL; -- Correo Invalido
EXEC AddClient 1234678909135,'Alex','Hunter2','1990-01-01','bbbbb@gmail.com',89709867,NULL; -- ok
EXEC AddClient 1234678909123,'Calvin','Murder','1990-01-01','ccccc@gmail.com',89709867,NULL; -- Error, Dpi duplicado
EXEC AddClient 1234678909097,'Calvin','Murder','1990-01-01','ccccc@gmail.com',89709867,89765678; -- ok


-- ########################### INGRESAR Direcciones ###########################

EXEC AddDirection 4444444444444,'Zona 24, Guatemala','Guatemala',10; -- Error, dpi inexistente
EXEC AddDirection 1234678909123,'Zona 24, Guatemala','Guatemala',10; -- ok
EXEC AddDirection 1234678909123,'Zona 6, Mixco','Mixco',-1; -- Error, zona inv�lida
EXEC AddDirection 1234678909097,'Zona 6, Mixco','Mixco',6; -- ok
EXEC AddDirection 1234678909097,'Zona 10, Guatemala','Guatemala',10; -- ok


-- ########################### Crear Ordenes ###########################
EXEC AddOrder 4444444444444,1,'L'; -- Error, dpi inexistente
EXEC AddOrder 1234678909123,2,'L'; -- Error, dpi si existe, pero esa direccion es de otro cliente
EXEC AddOrder 1234678909123,1,'L'; -- ok
EXEC AddOrder 1234678909097,2,'C'; -- Error canal equivocado
EXEC AddOrder 1234678909097,2,'A'; -- Error, no hay restaurante con cobertura
EXEC AddOrder 1234678909097,3,'A'; -- ok


-- ########################### Agregar Items a ordenes ###########################
EXEC AddItem 10,'C',1,10,''; -- Error, orden inexistente
EXEC AddItem 1,'C',1,-10,''; -- Error, cantidad invalida
EXEC AddItem 1,'O',1,10,''; -- Error, tipo de producto invalido
EXEC AddItem 1,'C',10,10,''; -- Error, producto inexistente
EXEC AddItem 6,'C',1,10,''; -- ok
EXEC AddItem 6,'E',1,10,''; -- ok
EXEC AddItem 1,'B',1,10,''; -- ok
EXEC AddItem 1,'P',1,10,''; -- ok
EXEC AddItem 1,'P',19,10,''; -- Error, producto inexistente
EXEC AddItem 2,'P',19,10,''; -- Error, no se pueden agregar items a una orden sin cobertura
EXEC AddItem 2,'C',2,5,''; -- ok
EXEC AddItem 2,'E',2,5,''; -- ok
EXEC AddItem 2,'B',2,5,''; -- ok
EXEC AddItem 2,'P',2,5,''; -- ok


-- ########################### Confirmar ordenes ###########################
EXEC ConfirmOrder 10,'E',3; -- Error,Orden inexistente
EXEC ConfirmOrder 1,'E',13; -- Error, El trabajador no existe
EXEC ConfirmOrder 1,'S',2; -- Error, M�todo de pago invalido
EXEC ConfirmOrder 6,'E',2; -- ok
EXEC ConfirmOrder 1,'E',2;
EXEC ConfirmOrder 3,'T',2; -- ok


-- ########################### Finalizar �rdenes ###########################
EXEC FinishOrder 1; -- OK
EXEC FinishOrder 6; -- Error, orden inexistente
EXEC FinishOrder 2; -- OK


-- ########################### REPORTE # 01 ###########################
EXEC GetRestaurants;

-- ########################### REPORTE # 02 ###########################
EXEC GetEmployee 5; -- Error Empleado inexistente
EXEC GetEmployee 1; -- ok
EXEC GetEmployee 2; -- ok
EXEC GetEmployee 4; -- Error Empleado inexistente

-- ########################### REPORTE # 03 ###########################
EXEC GetItemOfOrder 1; -- ok
EXEC GetItemOfOrder 4; -- Error, esta orden se quedo en estado de "SIN COBERTURA"
EXEC GetItemOfOrder 3; -- ok
EXEC GetItemOfOrder 6; -- Error, esta orden no existe

-- ########################### REPORTE # 04 ###########################
EXEC ConsultarHistorialOrdenes 1234678909123; -- ok
EXEC ConsultarHistorialOrdenes 44444444444444; -- Error, dpi inexistente              ME FALTA
EXEC ConsultarHistorialOrdenes 1234678909097; -- ok

-- ########################### REPORTE # 05 ###########################
EXEC GetAddress 1234678909123; -- ok
EXEC GetAddress 44444444444444; -- Error, dpi inexistente
EXEC GetAddress 1234678909097; -- ok

-- ########################### REPORTE # 06 ###########################
EXEC GetOrdersByState -1; -- Deber�a mostrar una orden sin cobertura
EXEC GetOrdersByState 1; -- No deber�a mostrar nada
EXEC GetOrdersByState 2; -- No deber�a mostrar nada
EXEC GetOrdersByState 3; -- No deber�a mostrar nada
EXEC GetOrdersByState 4; -- Deber�a mostrar 2 �rdenes entregadas.

-- ########################### REPORTE # 07 ###########################
-- Editar las fechas seg�n sea el caso de validaci�n
EXEC ConsultarFacturas 19,04,2023;
EXEC ConsultarFacturas 29,04,2023;

-- ########################### REPORTE # 08 ###########################
-- Editar los minutos de parametro segun sea el caso de validaci�n
EXEC GetTimes 3;
EXEC GetTimes 10;
EXEC GetTimes 1;