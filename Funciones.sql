USE bases1_proyecto2
GO

-- Funci�n para validar que el n�mero entero sea positivo
DROP FUNCTION IF EXISTS ValidarPositivo
GO
CREATE FUNCTION ValidarPositivo(@num INT)
RETURNS BIT
AS
BEGIN
	DECLARE @result BIT
	SET @result = 0
	IF @num >= 0
		BEGIN
			SET @result = 1
		END
	ELSE
		BEGIN
			SET @result = 0
		END
	RETURN @result
END
GO

-- Funci�n para validar que las entradas booleanas/bit sean 0 o 1
DROP FUNCTION IF EXISTS ValidarBooleano
GO
CREATE FUNCTION ValidarBooleano (@num int)
RETURNS bit
AS 
BEGIN
	DECLARE @result bit
	IF @num = 0 OR @num = 1 
		BEGIN
			SET @result = 1
		END
	ELSE
		BEGIN
			SET @result = 0
		END
	RETURN @result
END
GO

-- Funci�n para validar que el correo electr�nico tenga la sintaxis correcta
DROP FUNCTION IF EXISTS ValidarCorreo
GO
CREATE FUNCTION ValidarCorreo(@email VARCHAR(255))
RETURNS BIT
AS
BEGIN
	DECLARE @es_valido BIT;
    IF @email LIKE '%_@__%.__%'
        AND @email NOT LIKE '%[^a-zA-Z0-9.@_-]%[0-9a-zA-Z.@_-]%[^a-zA-Z0-9.@_-]%'
		BEGIN
			SET @es_valido = 1;
		END
    ELSE
		BEGIN
			SET @es_valido = 0;
		END
    RETURN @es_valido;
END
GO

-- Funci�n para validar que el canal solo sea L o A
DROP FUNCTION IF EXISTS ValidarCanal
GO
CREATE FUNCTION ValidarCanal(@canal char(1))
RETURNS BIT 
AS
BEGIN
	DECLARE @es_valido BIT;
	IF @canal = 'L' OR @canal = 'A' 
		BEGIN
			SET @es_valido = 1;
		END
	ELSE
		BEGIN
			SET @es_valido = 0;
		END
	RETURN @es_valido;
END
GO

-- Funci�n para delimitar que el tipo del producto �nicamente sea "C", "E", "B", "P"
DROP FUNCTION IF EXISTS ValidarTipoProd
GO
CREATE FUNCTION ValidarTipoProd (@producto CHAR(1))
RETURNS BIT
AS 
BEGIN
	DECLARE @es_valido BIT;
	
	IF @producto = 'C' OR @producto = 'E' OR @producto = 'B' OR @producto = 'P' 
		BEGIN
			SET @es_valido = 1;
		END
	ELSE
		BEGIN
			SET @es_valido = 0;
		END
	
	RETURN @es_valido;
END
GO

-- Funci�n para validar que la forma de pago sea �nicamente "E" y "T"
DROP FUNCTION IF EXISTS ValidarFormaPago
GO
CREATE FUNCTION ValidarFormaPago(@pago CHAR(1))
RETURNS BIT
AS
BEGIN
	DECLARE @es_valido BIT;
    IF @pago = 'T' OR @pago = 'E'
		BEGIN
			SET @es_valido = 1;
		END
	ELSE
		BEGIN
			SET @es_valido = 0;
		END

	RETURN @es_valido;
END
GO