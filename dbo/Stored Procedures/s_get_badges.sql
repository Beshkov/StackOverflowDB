create   procedure dbo.s_get_badges
	@p_UserID int = 0,
	@p_Name varchar(50) = '',
	@p_date datetime = ''
as
begin try
	print 1
	declare @p_dyn_sql varchar(max) = ''

	set @p_dyn_sql = 
	'select U.DisplayName, B.Name as BadgeName, B.Date as BadeDate, U.Reputation
	from dbo.Badges as B
		inner join dbo.Users as U on B.UserId = U.id
	where '

	select	@p_dyn_sql += coalesce(iif(@p_UserID <> 0, 'U.ID =' + cast(@p_UserID as varchar), null), 
									iif(@p_Name <> '', 'B.Name = ' + ''''+ @p_Name + '''', null),
									iif(@p_date <> '', 'B.Date >= '+ ''''+cast(@p_date as varchar)+ '''', null),
									'1=1')

	exec (@p_dyn_sql)
	
end	try
begin catch
	print 'there was and problem with the following query => '  + @p_dyn_sql
	;throw
end catch
