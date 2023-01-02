select * from feriados where year(dFeriado)=2023 and cDescFeriado!='Feriado Dom' order by dFeriado desc

DECLARE @contador int =1
DECLARE @fechaIni DATE='2023-10-29'
DECLARE @fechaFeriado DATE=@fechaIni
while (@contador<218)
begin

	SET @fechaFeriado=DATEADD(DAY,@contador*7,@fechaIni)
	print @fechaFeriado
	INSERT feriados VALUES(@fechaFeriado,1,1,1,'Feriado Dom')
	INSERT feriados VALUES(@fechaFeriado,1,1,2,'Feriado Dom')
	INSERT feriados VALUES(@fechaFeriado,1,1,3,'Feriado Dom')
	set @contador=@contador+1
end

go

--Depende de que días se asigna la semana santa

INSERT feriados VALUES('2023-04-06',1,1,1,'Semana Santa')
INSERT feriados VALUES('2023-04-07',1,1,1,'Semana Santa')

INSERT feriados VALUES('2023-04-06',1,1,2,'Semana Santa')
INSERT feriados VALUES('2023-04-07',1,1,2,'Semana Santa')

INSERT feriados VALUES('2023-04-06',1,1,3,'Semana Santa')
INSERT feriados VALUES('2023-04-07',1,1,3,'Semana Santa')

go


DECLARE @tFeriadoTemp TABLE(feriadoTemp DATE, idTipoFeriado INT, Vigente INT, idAgencia INT , DescFeriado varchar(150))

INSERT @tFeriadoTemp VALUES('2023-05-01',1,1,1,'Día del trabajador')
INSERT @tFeriadoTemp VALUES('2023-06-29',1,1,1,'San Pedro')
INSERT @tFeriadoTemp VALUES('2023-07-28',1,1,1,'Fiestas Patrias')
INSERT @tFeriadoTemp VALUES('2023-07-29',1,1,1,'Fiestas Patrias')
INSERT @tFeriadoTemp VALUES('2023-08-30',1,1,1,'Santa Rosa')
INSERT @tFeriadoTemp VALUES('2023-10-08',1,1,1,'Combate Angamos')
INSERT @tFeriadoTemp VALUES('2023-11-01',1,1,1,'Días de los vivos')
INSERT @tFeriadoTemp VALUES('2023-12-08',1,1,1,'Inmaculada Concepción')
INSERT @tFeriadoTemp VALUES('2023-12-25',1,1,1,'Navidad') 


DECLARE @feriadoTemp DATE, @idTipoFeriado INT, @Vigente INT, @idAgencia INT , @DescFeriado varchar(150)

DECLARE db_cursor CURSOR FOR 
SELECT * FROM @tFeriadoTemp

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @feriadoTemp,@idTipoFeriado,@Vigente,@idAgencia,@DescFeriado 

WHILE @@FETCH_STATUS = 0  
BEGIN  

	IF NOT EXISTS(SELECT * FROM feriados WHERE dFeriado=@feriadoTemp)
	BEGIN
		INSERT feriados VALUES(@feriadoTemp,@idTipoFeriado,@Vigente,1,@DescFeriado )
		INSERT feriados VALUES(@feriadoTemp,@idTipoFeriado,@Vigente,2,@DescFeriado )
		INSERT feriados VALUES(@feriadoTemp,@idTipoFeriado,@Vigente,3,@DescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM feriados WHERE dFeriado=dateadd(year,1,@feriadoTemp))
	BEGIN
		INSERT feriados VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@Vigente,1,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@Vigente,2,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@Vigente,3,@DescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM feriados WHERE dFeriado=dateadd(year,2,@feriadoTemp))
	BEGIN
		INSERT feriados VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@Vigente,1,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@Vigente,2,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@Vigente,3,@DescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM feriados WHERE dFeriado=dateadd(year,3,@feriadoTemp))
	BEGIN
		INSERT feriados VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@Vigente,1,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@Vigente,2,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@Vigente,3,@DescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM feriados WHERE dFeriado=dateadd(year,4,@feriadoTemp))
	BEGIN
		INSERT feriados VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@Vigente,1,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@Vigente,2,@DescFeriado )
		INSERT feriados VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@Vigente,3,@DescFeriado )
	END
	      
	  	   
	FETCH NEXT FROM db_cursor INTO @feriadoTemp,@idTipoFeriado,@Vigente,@idAgencia,@DescFeriado  
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 