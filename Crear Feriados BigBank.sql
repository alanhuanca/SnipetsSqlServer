select * from si_finferiado where year(dFeriado)=2023 and cDescFeriado!='Feriado Dom' order by dFeriado desc

DECLARE @contador int =1
DECLARE @fechaIni DATE='2023-10-29'
DECLARE @fechaFeriado DATE=@fechaIni
while (@contador<218)
begin

	SET @fechaFeriado=DATEADD(DAY,@contador*7,@fechaIni)
	print @fechaFeriado
	INSERT si_finferiado VALUES(@fechaFeriado,1,1,1,'Feriado Dom')
	INSERT si_finferiado VALUES(@fechaFeriado,1,1,2,'Feriado Dom')
	INSERT si_finferiado VALUES(@fechaFeriado,1,1,3,'Feriado Dom')
	set @contador=@contador+1
end

go

--Depende de que días se asigna la semana santa

INSERT si_finferiado VALUES('2023-04-06',1,1,1,'Semana Santa')
INSERT si_finferiado VALUES('2023-04-07',1,1,1,'Semana Santa')

INSERT si_finferiado VALUES('2023-04-06',1,1,2,'Semana Santa')
INSERT si_finferiado VALUES('2023-04-07',1,1,2,'Semana Santa')

INSERT si_finferiado VALUES('2023-04-06',1,1,3,'Semana Santa')
INSERT si_finferiado VALUES('2023-04-07',1,1,3,'Semana Santa')

go


DECLARE @tFeriadoTemp TABLE(feriadoTemp DATE, idTipoFeriado INT, lVigente INT, idAgencia INT , cDescFeriado varchar(150))

INSERT @tFeriadoTemp VALUES('2023-05-01',1,1,1,'Día del trabajador')
INSERT @tFeriadoTemp VALUES('2023-06-29',1,1,1,'San Pedro')
INSERT @tFeriadoTemp VALUES('2023-07-28',1,1,1,'Fiestas Patrias')
INSERT @tFeriadoTemp VALUES('2023-07-29',1,1,1,'Fiestas Patrias')
INSERT @tFeriadoTemp VALUES('2023-08-30',1,1,1,'Santa Rosa')
INSERT @tFeriadoTemp VALUES('2023-10-08',1,1,1,'Combate Angamos')
INSERT @tFeriadoTemp VALUES('2023-11-01',1,1,1,'Días de los vivos')
INSERT @tFeriadoTemp VALUES('2023-12-08',1,1,1,'Inmaculada Concepción')
INSERT @tFeriadoTemp VALUES('2023-12-25',1,1,1,'Navidad') 


DECLARE @feriadoTemp DATE, @idTipoFeriado INT, @lVigente INT, @idAgencia INT , @cDescFeriado varchar(150)

DECLARE db_cursor CURSOR FOR 
SELECT * FROM @tFeriadoTemp

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @feriadoTemp,@idTipoFeriado,@lVigente,@idAgencia,@cDescFeriado 

WHILE @@FETCH_STATUS = 0  
BEGIN  

	IF NOT EXISTS(SELECT * FROM SI_FinFeriado WHERE dFeriado=@feriadoTemp)
	BEGIN
		INSERT si_finferiado VALUES(@feriadoTemp,@idTipoFeriado,@lVigente,1,@cDescFeriado )
		INSERT si_finferiado VALUES(@feriadoTemp,@idTipoFeriado,@lVigente,2,@cDescFeriado )
		INSERT si_finferiado VALUES(@feriadoTemp,@idTipoFeriado,@lVigente,3,@cDescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM SI_FinFeriado WHERE dFeriado=dateadd(year,1,@feriadoTemp))
	BEGIN
		INSERT si_finferiado VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@lVigente,1,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@lVigente,2,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,1,@feriadoTemp),@idTipoFeriado,@lVigente,3,@cDescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM SI_FinFeriado WHERE dFeriado=dateadd(year,2,@feriadoTemp))
	BEGIN
		INSERT si_finferiado VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@lVigente,1,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@lVigente,2,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,2,@feriadoTemp),@idTipoFeriado,@lVigente,3,@cDescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM SI_FinFeriado WHERE dFeriado=dateadd(year,3,@feriadoTemp))
	BEGIN
		INSERT si_finferiado VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@lVigente,1,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@lVigente,2,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,3,@feriadoTemp),@idTipoFeriado,@lVigente,3,@cDescFeriado )
	END

	IF NOT EXISTS(SELECT * FROM SI_FinFeriado WHERE dFeriado=dateadd(year,4,@feriadoTemp))
	BEGIN
		INSERT si_finferiado VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@lVigente,1,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@lVigente,2,@cDescFeriado )
		INSERT si_finferiado VALUES(dateadd(year,4,@feriadoTemp),@idTipoFeriado,@lVigente,3,@cDescFeriado )
	END
	      
	  	   
	FETCH NEXT FROM db_cursor INTO @feriadoTemp,@idTipoFeriado,@lVigente,@idAgencia,@cDescFeriado  
END 

CLOSE db_cursor  
DEALLOCATE db_cursor 