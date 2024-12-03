CREATE   FUNCTION dbo.InitialCap ( @String varchar(8000))
RETURNS varchar(8000)
AS
    BEGIN
        DECLARE @Position int;
        
        SELECT @String = STUFF(LOWER(@String), 1, 1, UPPER(LEFT(@String, 1))) COLLATE Latin1_General_BIN,
               @Position = PATINDEX('%[^A-Za-z''][a-z]%', @String COLLATE Latin1_General_BIN);
        
        WHILE @Position > 0
        SELECT @String = STUFF(@String, @Position, 2, UPPER(SUBSTRING(@String, @Position, 2))) COLLATE Latin1_General_BIN,
               @Position = PATINDEX('%[^A-Za-z''][a-z]%', @String COLLATE Latin1_General_BIN);
        
        RETURN @String;
    END;
