/* to find the intersection or same part in the table */
select EMP_ID, F_NAME from Employees
inner join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP

/* to find the union or same part in the table */
select * from Employees
Full outer join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP

/* to find the part in table 1 includes the intersection in the table */
select * from Employees
right outer join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP

/* to find the part in table 2 includes the intersection in the table */
select * from Employees
left outer join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP

select EMP_ID, F_NAME, L_NAME, SALARY from Employees
inner join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP
where DEP_NAME = 'Architect Group'
order by salary desc

select DEP_NAME, AVG(SALARY) from employees 
INNER JOIN [Departments ]
ON Employees.DEP_ID = [Departments ].DEPT_ID_DEP
WHERE DEP_NAME = 'Architect Group'
GROUP BY DEP_NAME

--CASE 
SELECT F_NAME, salary 
,CASE 
 WHEN salary < 65000 THEN 'low income'
 when salary < 95000 then 'middle income'
 else 'high income'
END as Status
from employees

select F_NAME, L_name, DEP_NAME, SALARY,
case
when DEP_NAME = 'Software Group' then salary + (salary * .10)
when DEP_NAME = 'Architect Group' then salary + (salary * .05)
else salary + (salary * .02)
end as New_Salary
from Employees
join [Departments ]
on Employees.DEP_ID = [Departments ].
--multiple joins 
select * from JobsHistory JoH
inner join [Departments ] DEP
on joH.DEPT_ID = DEP.DEPT_ID_DEP
inner join Employees EMP
on JoH.DEPT_ID = EMP.DEP_ID 
--Partition BY 
select F_NAME, L_NAME, SALARY, SEX, 
count(SEX) over (partition by SEX) AS TotalGENDER
from Employees
inner join [Departments ]
on Employees.DEP_ID = [Departments ].DEPT_ID_DEP
where SALARY >= 70000
order by SALARY desc


select * from JobsHistory
select * from Employees
select * from [Departments ]
select F_NAME + ' ' + L_NAME AS Full_name
from Employees 
 
