-- ########################### REGISTRAR RESTAURANTES ###########################
EXEC AddRestaurant 'R001', '1a EXECe zona 4', 'Guatemala', 4, 1770, 18, 1; -- ok
EXEC AddRestaurant 'R002', '2a av zona 4', 'Mixco', 4, 1730, 10, 0; -- ok
EXEC AddRestaurant 'R003', '3a EXECe zona 10', 'Guatemala', 10, 1744, 6, 1; -- ok
EXEC AddRestaurant 'R004', '4a av zona 11', 'Guatemala', 11, 1280, 5, 0; -- ok
EXEC AddRestaurant 'R005', '5a EXECe zona 7', 'Guatemala', 7, 1429, 9, 1; -- ok
EXEC AddRestaurant 'R006', '5a EXECe zona 14', 'Guatemala', 14, 1790, 1, 0; -- ok solo 1 personal
EXEC AddRestaurant 'R001', '1a EXECe zona 4', 'Guatemala', 4, 1770, 10, 0; -- error duplicado
EXEC AddRestaurant 'R007', 'direccion x', 'Guatemala', -3, 1771, 8, 0; -- error zona inv�lida
EXEC AddRestaurant 'R008', 'direccion x', 'Guatemala', 2, 1772, 5.5, 0; -- error personal inv�lido




-- ########################### REGISTRAR PUESTOS ###########################
EXEC AddPosition 'Mesero', 'Encargado de atender mesas de los clientes', 3750.00 ; -- ok
EXEC AddPosition 'Anfitri�n', 'Encargado de recibir y ubicar a los clientes', 3100.00 ; -- ok
EXEC AddPosition 'Cocinero', 'Encargado de cocinar y preparar las �rdenes', 4975.00 ; -- ok
EXEC AddPosition 'Gerente', 'A cargo del restaurante', 6500.00 ; -- ok
EXEC AddPosition 'Limpieza', 'Realiza las tareas de limpieza dentro del restaurante', 6500.00 ; -- ok
EXEC AddPosition 'Repartidor', 'Motorista que reparte las �rdenes a las direcciones del cliente', 4635.00 ; -- ok
EXEC AddPosition 'Agente de llamadas', 'Miembro del EXEC center para atender pedidos', 3185.00 ; -- ok
EXEC AddPosition 'Mesero', 'Encargado de atender mesas de los clientes', 3750.00 ; -- error duplicado
EXEC AddPosition 'Puesto Error', 'xxxxxx', -3500.00 ; -- error salario inv�lido




-- ########################### CREAR EMPLEADOS ###########################
EXEC AddWorker 'JUAN SEBASTIAN', 'CHOC BOJ', '2001-03-14', 'juan@gmail.com', 42543549, '29 av z1 1-80', 3024021520101, 1, '2022-05-24', 'R001' ; -- ok mesero 00000001
EXEC AddWorker 'CESAR DANIEL', 'POSADAS GUERRA', '2000-02-15', 'cesar@hotmail.com', 64019962, '30 EXECe z8 12-20', 8029021520101, 2, '2020-09-11', 'R001' ; -- ok anfitri�n 00000002
EXEC AddWorker 'KEVIN STEVE', 'MONTENEGRO SANTOS', '2001-02-24', 'kevin@gmail.com', 65473549, '29 av z1 1-80', 3024053620101, 3, '2023-01-12', 'R001' ; -- ok cocinero 00000003
EXEC AddWorker 'BENAVENTI BERNAL', 'L�PEZ HERN�NDEZ', '2002-04-30', 'benav@gmail.com', 82543547, '29 EXECe z2 1-80', 3095621520101, 4, '2020-07-11', 'R001' ; -- ok gerente 00000004
EXEC AddWorker 'EDDY ALEJANDRO', 'FLORES MORENO', '2003-06-12', 'eddy@gmail.com', 12546545, '29 av z3 1-80', 3104021520101, 5, '2022-02-05', 'R001' ; -- ok limpieza 00000005
EXEC AddWorker 'ANDRES EDUARDO', 'CUBUR CHALI', '2004-09-05', 'andres@gmail.com', 44547549, '29 EXECe z4 1-80', 3024021524001, 6, '2021-06-30', 'R001' ; -- ok repartidor 00000006
EXEC AddWorker 'STEVEN SULLIVAN', 'ESQUIVEL D�AZ', '2002-11-06', 'steven@gmail.com', 42543542, '29 av z5 1-80', 9424021120101, 7, '2020-07-29', 'R001' ; -- ok agente 00000007
EXEC AddWorker 'LUIS ERNESTO', 'CRUZ LOPEZ', '2002-04-30', 'abc@yahoo.com', 12345678, 'direccion abc', 9995621529103, 4, '2022-05-24', 'R006' ; -- ok gerente 00000008
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524002, 6, '2021-06-30', 'R001' ; -- ok repartidor 00000009
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524003, 6, '2021-06-30', 'R002' ; -- ok repartidor 00000010
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524004, 6, '2021-06-30', 'R003' ; -- ok repartidor 00000011
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524005, 6, '2021-06-30', 'R004' ; -- ok repartidor 00000012
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524006, 6, '2021-06-30', 'R005' ; -- ok repartidor 00000013
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524007, 6, '2021-06-30', 'R001' ; -- ok repartidor 00000014
EXEC AddWorker 'REPARTIDOR', 'RESTAURANTE ABC', '2004-09-05', 'rr2@gmail.com', 44547549, 'direccion abc', 3024021524008, 6, '2021-06-30', 'R002' ; -- ok repartidor 00000015
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'error@gmail', 12345678, 'direccion abc', 9995621520101, 1, '2022-05-24', 'R001' ; -- error correo invalido
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'correo.error', 12345678, 'direccion abc', 9995621520102, 1, '2022-05-24', 'R001' ; -- error correo invalido
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'abc@yahoo.com', 12345678, 'direccion abc', 9995621520102, 15, '2022-05-24', 'R001' ; -- error puesto no existe
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'abc@yahoo.com', 12345678, 'direccion abc', 9995621520102, -3, '2022-05-24', 'R001' ; -- error puesto negativo / no existe
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'abc@yahoo.com', 12345678, 'direccion abc', 9995621520102, 1, '2022-05-24', 'RXXX' ; -- error restaurante no existe
EXEC AddWorker 'ERROR', 'XXXXX YYYYY', '2002-04-30', 'abc@yahoo.com', 12345678, 'direccion abc', 4995621529103, 4, '2022-05-24', 'R006' ; -- error l�mite personal alcanzado




-- ########################### REGISTRAR CLIENTE ###########################
EXEC AddClient 8612300001101, 'PABLO JOS�', 'QUIXT�N P�REZ', '2003-05-14', 'serg@gmail.com', 42179456, 123909614 ; -- ok
EXEC AddClient 9712400001101, 'ENRIQUE ALEJANDRO', 'VASQUEZ PE�ATE', '1989-07-03', 'serg@gmail.com', 52179457, NULL ; -- ok
EXEC AddClient 1812500001101, 'DEREK', 'ARMAS MONROY', '1957-08-07', 'serg@gmail.com', 62179458, 111909612 ; -- ok
EXEC AddClient 2912600001101, 'JOSEPH JEFERSON', 'MENDOZA AGUILAR', '1999-10-08', 'serg@gmail.com', 72179459, NULL ; -- ok
EXEC AddClient 3112700001101, 'ALEXIS MARCO TULIO', 'OLIVA ESPA�A', '2001-10-09', 'serg@gmail.com', 82179450, NULL ; -- ok
EXEC AddClient 9712400001101, 'ENRIQUE ALEJANDRO', 'VASQUEZ PE�ATE', '1989-07-03', 'serg@gmail.com', 52179457, NULL ; -- error duplicado
EXEC AddClient 3412400001102, 'ERROR', 'ERROR', '1989-07-03', 'error@.com', 52179457, NULL ; -- error correo invalido
EXEC AddClient 3412400001103, 'Lui$', '_Espino', '2000-12-1', 'Luis@gmail.com', 52179458, NULL ; -- error nombre inv�lido




-- ########################### REGISTRAR DIRECCION ###########################
/* direecion id 1 */EXEC AddDirection 8612300001101, '4ta EXECe B 11-20 zona 7', 'Guatemala', 7 ; -- ok
/* direecion id 2 */EXEC AddDirection 8612300001101, '6ta av A 14-90 zona 11', 'Guatemala', 11 ; -- ok
/* direecion id 3 */EXEC AddDirection 9712400001101, '4ta EXECe C 11-58 zona 10', 'Guatemala', 10 ; -- ok
/* direecion id 4 */EXEC AddDirection 1812500001101, '4ta av A 11-40 zona 11', 'Guatemala', 11 ; -- ok
/* direecion id 5 */EXEC AddDirection 2912600001101, '4ta EXECe B 12-10 zona 4', 'Mixco', 4 ; -- ok
/* direecion id 6 */EXEC AddDirection 2912600001101, '1a av 11-21 zona 4', 'Guatemala', 4 ; -- ok
/* direecion id 7 */EXEC AddDirection 8612300001101, '4ta av C 0-83 zona 8', 'Villa Nueva', 8 ; -- ok
EXEC AddDirection 1111111111111, 'direccion abc', 'municipio', 1 ; -- error cliente no existe
EXEC AddDirection 9712400001101, 'direccion abc', 'municipio', -2 ; -- error zona inv�lida
EXEC AddDirection 9712400001101, 'direccion abc', '', 15 ; -- error municipio vac�o




-- ########################### CREAR ORDEN ###########################
/* orden id 1 */EXEC AddOrder 8612300001101, 1, 'L' ; -- ok
/* orden id 2 */EXEC AddOrder 8612300001101, 2, 'L' ; -- ok
/* orden id 3 */EXEC AddOrder 9712400001101, 3, 'A' ; -- ok
/* orden id 4 */EXEC AddOrder 1812500001101, 4, 'L' ; -- ok
/* orden id 5 */EXEC AddOrder 2912600001101, 5, 'L' ; -- ok
/* orden id 6 */EXEC AddOrder 2912600001101, 6, 'L' ; -- ok
/* orden id 7 */EXEC AddOrder 8612300001101, 7, 'L' ; -- no tiene cobertura
EXEC AddOrder 8888888888888, 1, 'L' ; -- error no existe cliente / direcci�n
EXEC AddOrder 8612300001101, 5, 'L' ; -- error no existe direcci�n
EXEC AddOrder 8612300001101, 1, 'X' ; -- error canal inv�lido
EXEC AddOrder 8612300001101, 6, 'A' ; -- error direcci�n no corresponde a cliente


-- REPORTE DE ESTADO
EXEC GetOrdersByState 1 ; -- ok
EXEC GetOrdersByState -1 ; -- ok


-- ########################### AGREGAR ITEMS A LA ORDEN ###########################
EXEC AddItem 1, 'C', 1, 2, 'Sin pepinillos' ; -- ok
EXEC AddItem 1, 'C', 3, 1, 'Extra barbacoa' ; -- ok
EXEC AddItem 1, 'C', 5, 1, 'Sin champi�ones' ; -- ok
EXEC AddItem 1, 'E', 1, 2, '' ; -- ok
EXEC AddItem 1, 'E', 3, 2, '' ; -- ok
EXEC AddItem 2, 'B', 5, 6, 'Cerveza clara' ; -- ok
EXEC AddItem 3, 'E', 1, 4, '' ; -- ok
EXEC AddItem 3, 'B', 4, 4, 'Sin hielo' ; -- ok
EXEC AddItem 4, 'P', 1, 1, '' ; -- ok
EXEC AddItem 4, 'P', 2, 1, '' ; -- ok
EXEC AddItem 4, 'P', 3, 1, '' ; -- ok
EXEC AddItem 4, 'P', 4, 1, '' ; -- ok
EXEC AddItem 5, 'C', 4, 1, '' ; -- ok
EXEC AddItem 5, 'P', 2, 1, '' ; -- ok
EXEC AddItem 6, 'C', 5, 2, '' ; -- ok
EXEC AddItem 6, 'E', 1, 1, '' ; -- ok
EXEC AddItem 6, 'E', 2, 1, '' ; -- ok
EXEC AddItem 6, 'E', 3, 1, '' ; -- ok
EXEC AddItem 6, 'P', 3, 3, 'Con extra topping' ; -- ok
EXEC AddItem 90, 'C', 1, 2, '' ; -- error orden no existe
EXEC AddItem 7, 'C', 1, 2, '' ; -- error orden no tiene cobertura
EXEC AddItem 1, 'X', 1, 2, '' ; -- error tipo producto inv�lido
EXEC AddItem 1, 'C', 10, 1, '' ; -- error combo no existe
EXEC AddItem 1, 'B', -4, 1, '' ; -- error bebida no existe
EXEC AddItem 1, 'B', 2, -5, '' ; -- error cantidad negativa
EXEC AddItem 1, 'B', 2, 2.25, '' ; -- error cantidad inv�lida


-- REPORTE DE ESTADO
EXEC GetOrdersByState 2 ; -- ok




-- ########################### CONFIRMAR ORDEN ###########################
EXEC ConfirmOrder 25, 'T', 00000001 ; -- error orden no existe
EXEC ConfirmOrder 1, 'W', 00000001 ; -- error forma de pago inv�lida
EXEC ConfirmOrder 1, 'T', 00000999 ; -- error repartidor no existe
EXEC ConfirmOrder 1, 'T', 00000009 ; -- ok
EXEC ConfirmOrder 2, 'E', 00000010 ; -- ok
EXEC ConfirmOrder 3, 'T', 00000011 ; -- ok
EXEC ConfirmOrder 4, 'E', 00000012 ; -- ok
EXEC ConfirmOrder 5, 'T', 00000013 ; -- ok
EXEC ConfirmOrder 6, 'E', 00000014 ; -- ok
EXEC ConfirmOrder 1,'T', 00000014 ; -- error orden ya fue confirmada
EXEC AddItem 1, 'C', 1, 1, '' ; -- error orden ya fue confirmada


-- REPORTE DE ESTADO
EXEC GetOrdersByState 3 ; -- ok




-- ########################### FINALIZAR ORDEN ###########################
EXEC FinishOrder 1 ; -- ok
EXEC FinishOrder 2 ; -- ok
EXEC FinishOrder 3 ; -- ok
EXEC FinishOrder 4 ; -- ok
EXEC FinishOrder 5 ; -- ok
EXEC FinishOrder 6 ; -- ok
EXEC FinishOrder 1 ; -- error orden ya finalizada
EXEC AddItem 1, 'C', 1, 1, '' ; -- error orden ya fue finalizada
EXEC ConfirmOrder 1, 'T', 00000006 ; -- error orden ya fue finalizada


-- REPORTE DE ESTADO
EXEC GetOrdersByState 4 ; -- ok




/*************************** REPORTER�A ***************************/
-- RESTAURANTES
EXEC GetRestaurants  ; -- ok


-- EMPLEADO
EXEC GetEmployee 00000015 ; -- ok
EXEC GetEmployee 99999999 ; -- error no existe empleado


-- DETALLE PEDIDO
EXEC GetItemOfOrder 1 ; -- ok
EXEC GetItemOfOrder 2 ; -- ok
EXEC GetItemOfOrder 3 ; -- ok
EXEC GetItemOfOrder 4 ; -- ok
EXEC GetItemOfOrder 5 ; -- ok
EXEC GetItemOfOrder 6 ; -- ok
EXEC GetItemOfOrder 7 ; -- sin cobertura
EXEC GetItemOfOrder 10 ; -- error no existe pedido


-- HISTORIAL �RDENES
EXEC ConsultarHistorialOrdenes 8612300001101 ; -- ok
EXEC ConsultarHistorialOrdenes 9712400001101 ; -- ok
EXEC ConsultarHistorialOrdenes 1812500001101 ; -- ok
EXEC ConsultarHistorialOrdenes 2912600001101 ; -- ok
EXEC ConsultarHistorialOrdenes 1919191919191 ; -- error no existe cliente




-- DIRECCIONES CLIENTE
EXEC GetAddress 8612300001101 ; -- ok
EXEC GetAddress 9712400001101 ; -- ok
EXEC GetAddress 1812500001101 ; -- ok
EXEC GetAddress 2912600001101 ; -- ok
EXEC GetAddress 3112700001101 ; -- ok


-- �RDENES SEG�N ESTADO
EXEC GetOrdersByState 1 ; -- ok
EXEC GetOrdersByState 2 ; -- ok
EXEC GetOrdersByState 3 ; -- ok
EXEC GetOrdersByState 4 ; -- ok
EXEC GetOrdersByState -1 ; -- ok
EXEC GetOrdersByState 21 ; -- error estado no existe


-- ENCABEZADOS FACTURA
EXEC ConsultarFacturas 7, 5, 2023 ; -- ok
EXEC ConsultarFacturas 31, 12, 2022 ; -- vac�o
EXEC ConsultarFacturas 40, 70, 2023 ; -- error fecha inv�lida


-- TIEMPOS DE ESPERA
EXEC GetTimes 1 ; -- ok
EXEC GetTimes 2 ; -- ok
EXEC GetTimes 3 ; -- ok
EXEC GetTimes 30 ; -- vac�o
EXEC GetTimes -25 ; -- error tiempo inv�lido




/* TABLA HISTORIAL */
-- debe tener los tres tipos de trigger para cada evento  insert, update, delete 
SELECT * FROM historial;





