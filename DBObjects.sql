CREATE DATABASE HW10;  
GO  

use HW10;
Go

If Object_ID('Employees') Is Not Null Begin
Drop Table Employees;
end;

CREATE TABLE Employees 
(ID int identity PRIMARY KEY CLUSTERED,
 BadgeNum int not null unique,
 Title varchar(20) null,
 DateHired Datetime2 not null);  
Go



Create Trigger tremployeeTitle 
  on dbo.Employees
	after insert, update
	as
	declare @BadgeNum int;
	select @BadgeNum = BadgeNum
	from inserted


if (@BadgeNum between 0 and 300 ) 
     begin 
	 update dbo.Employees set Title = 'Clerk' where BadgeNum = @BadgeNum
	 end
	  else if (@BadgeNum between 301 and 600)
	  begin
	  update dbo.Employees set Title = 'Office Employee' where BadgeNum = @BadgeNum
	  end
	  else if (@BadgeNum  between 601 and 800)
	  begin
	  update dbo.Employees set Title = 'Manager' where BadgeNum = @BadgeNum
	  end
	  else if (@BadgeNum between 801 and 1000)
	  begin
	  update dbo.Employees set Title = 'Director' where BadgeNum = @BadgeNum
     end  
go

Declare @BadgeNum int;
Declare @counter smallint;
DECLARE @Upper INT;
DECLARE @Lower INT
SET @counter = 1;  
WHILE @counter < 26  
   BEGIN
	SET @Lower = 1 ---- The lowest random number
	SET @Upper = 1000 ---- The highest random number
	set @BadgeNum = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
	SET @counter = @counter + 1
Insert into Employees( BadgeNum, Title, DateHired) 
values (@BadgeNum, Null, getdate())
end 
go

select *  from Employees

Insert into Employees( BadgeNum, Title, DateHired) 
values (900, Null, getdate());
go

--Cursor
--Declare the variables to store the values returned by FETCH.  
DECLARE @BadgeNum int, @Title varchar(20), @DateHired Datetime2(7);  

DECLARE employees_cursor CURSOR FOR  
SELECT ID, BadgeNum, Title, DateHired FROM dbo.employees  
  
ORDER BY ID;  

OPEN employees_cursor;  

-- Perform the first fetch and store the values in variables.  
-- Note: The variables are in the same order as the columns  
-- in the SELECT statement.   

FETCH NEXT FROM employees_cursor  
INTO @BadgeNum, @Title, @DateHired;  

-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
WHILE @@FETCH_STATUS = 0  
BEGIN  

   -- Concatenate and display the current values in the variables.  
   PRINT 'ID: ' + ID +  'Badge Number ' + @BadgeNum + 'Title' + @Title + 'Date Hired' + @DateHired  

   -- This is executed as long as the previous fetch succeeds.  
   FETCH NEXT FROM employees_cursor  
   INTO @BadgeNum, @Title, @DateHired;  
END  

CLOSE contact_cursor;  
DEALLOCATE employees_cursor;  
GO  