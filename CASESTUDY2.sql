USE sqlcasestudy1

CREATE TABLE LOCATIONS (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATIONS (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATIONS(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

Update EMPLOYEE
set HIRE_DATE='20-FEB-85'
where EMPLOYEE_ID=7499

--Simple Queries:
--1. List all the employee details.
SELECT * FROM EMPLOYEE
--2. List all the department details.
SELECT * FROM DEPARTMENT
--3. List all job details.
SELECT * FROM JOB
--4. List all the locations.
SELECT * FROM LOCATIONS
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
SELECT FIRST_NAME, LAST_NAME, SALARY, COMM FROM EMPLOYEE
--6. List out the Employee ID, Last Name, Department ID for all employees and alias

--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id".
SELECT EMPLOYEE_ID AS ID_OF_THE_EMPLOYEE, LAST_NAME AS NAME_OF_THE_EMPLOYEE, DEPARTMENT_ID AS DEPT_ID FROM EMPLOYEE

--7. List out the annual salary of the employees with their names only.
SELECT FIRST_NAME, LAST_NAME, MIDDLE_NAME, SALARY * 12 AS ANNUAL_SALARY FROM EMPLOYEE

--WHERE Condition:
--1. List the details about "Smith".
SELECT * FROM EMPLOYEE WHERE LAST_NAME='SMITH'
--2. List out the employees who are working in department 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID=20

--3. List out the employees who are earning salary between 2000 and 3000.
SELECT * FROM EMPLOYEE WHERE SALARY BETWEEN 2000 AND 3000

--4. List out the employees who are working in department 10 or 20.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID IN (10,20)
--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE NOT  DEPARTMENT_ID IN (10, 30)

--6. List out the employees whose name starts with 'L'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%'
--7. List out the employees whose name starts with 'L' and ends with 'E'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'L%E'

--8. List out the employees whose name length is 4 and start with 'J'.
SELECT * FROM EMPLOYEE WHERE FIRST_NAME LIKE 'J___'

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
SELECT * FROM EMPLOYEE WHERE DEPARTMENT_ID= 30 AND SALARY>2500
--10. List out the employees who are not receiving commission.
SELECT * FROM EMPLOYEE WHERE COMM IS NULL

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
SELECT EMPLOYEE_ID, LAST_NAME FROM EMPLOYEE ORDER BY EMPLOYEE_ID
--2. List out the Employee ID and Name in descending order based on salary.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MIDDLE_NAME FROM EMPLOYEE ORDER BY SALARY DESC

--3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME
--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
SELECT * FROM EMPLOYEE ORDER BY LAST_NAME ASC, DEPARTMENT_ID DESC

--GROUP BY and HAVING Clause:

--1. How many employees are in different departments in the organization?
Select * from EMPLOYEE
select * from DEPARTMENT
SELECT 
    d.Name,
    COUNT(e.employee_id) AS Employee_Count
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
GROUP BY 
    d.Name

--2. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT 
    d.Name,
    Max(SALARY) AS Maximum_salary, Min(salary) as Minimum_salary, AVG(SALARY) AS Average_salary
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
GROUP BY 
    d.Name

--3. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT 
    j.Designation,
    Max(SALARY) AS Maximum_salary, Min(salary) as Minimum_salary, AVG(SALARY) AS Average_salary
FROM 
    employee e
JOIN 
    JOB j ON e.JOB_ID = j.Job_ID
GROUP BY 
    j.Designation

--4. List out the number of employees who joined each month in ascending order.
SELECT 
    DATENAME(month, hire_date) AS Month_Name,
    COUNT(*) AS Employee_Count
FROM 
    employee
GROUP BY 
    DATENAME(month, hire_date), MONTH(hire_date)
ORDER BY 
    MONTH(hire_date)
--5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT 
    YEAR(hire_date) AS Year,
    DATENAME(month, hire_date) AS Month,
    COUNT(*) AS Employee_count
FROM 
    employee
GROUP BY 
    YEAR(hire_date),
    DATENAME(month, hire_date),
    MONTH(hire_date)
ORDER BY 
    YEAR(hire_date),
    MONTH(hire_date)
--6. List out the Department ID having at least four employees.
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS Employee_Count
FROM 
    employee
GROUP BY 
    department_id
HAVING 
    COUNT(*) >= 4

--7. How many employees joined in February month.
SELECT 
    COUNT(*) AS Employee_count
FROM 
    employee
WHERE 
    MONTH(hire_date) = 2;
--8. How many employees joined in May or June month.
SELECT 
    COUNT(*) AS Employee_count
FROM 
    employee
WHERE 
    MONTH(hire_date) = 5 or Month(hire_date) = 6
--9. How many employees joined in 1985?
SELECT 
    COUNT(*) AS Employee_count
FROM 
    employee
WHERE 
    YEAR(hire_date) = 1985
--10. How many employees joined each month in 1985?
SELECT 
    DATENAME(month, hire_date) AS Month_name,
    COUNT(*) AS Employee_count
FROM 
    employee
WHERE 
    YEAR(hire_date) = 1985
GROUP BY 
    DATENAME(month, hire_date),
    MONTH(hire_date)
ORDER BY 
    MONTH(hire_date)

--11. How many employees were joined in April 1985?
SELECT 
    COUNT(*) AS employee_count
FROM 
    employee
WHERE 
    YEAR(hire_date) = 1985
    AND MONTH(hire_date) = 4

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
SELECT 
    department_id,
    COUNT(*) AS employee_count
FROM 
    employee
WHERE 
    YEAR(hire_date) = 1985
    AND MONTH(hire_date) = 4
GROUP BY 
    department_id
HAVING 
    COUNT(*) >= 3

--Joins:
--1. List out employees with their department names. 
SELECT 
    e.FIRST_NAME,e.MIDDLE_NAME,e.LAST_NAME,d.Name,e.EMPLOYEE_ID
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
--2. Display employees with their designations.
SELECT 
   e.EMPLOYEE_ID,e.FIRST_NAME,e.MIDDLE_NAME,e.LAST_NAME,j.Designation
FROM 
    employee e
JOIN 
    JOB j ON e.JOB_ID = j.Job_ID
--3. Display the employees with their department names and regional groups.
SELECT 
    e.FIRST_NAME,e.MIDDLE_NAME,e.LAST_NAME,d.Name,e.EMPLOYEE_ID,l.City
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
Join LOCATIONS l on l.Location_ID=d.Location_Id

--4. How many employees are working in different departments? Display with department names. 
SELECT 
    d.name as Department,
    COUNT(e.employee_id) AS Employee_count
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
GROUP BY 
    d.name
ORDER BY 
    d.name;
--5. How many employees are working in the sales department?
SELECT 
    d.name as Department,
    COUNT(e.employee_id) AS Employee_count
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
where d.Name='sales'
GROUP BY 
    d.name
--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order. 
SELECT 
    d.name,
    COUNT(e.employee_id) AS employee_count
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
GROUP BY 
    d.name
HAVING 
    COUNT(e.employee_id) >= 5
ORDER BY 
    d.name
--7. How many jobs are there in the organization? Display with designations.
SELECT 
    j.Designation,
    COUNT(e.employee_id) AS Employee_count
FROM 
    employee e
JOIN 
    job j ON e.job_id = j.job_id
GROUP BY 
    j.Designation
ORDER BY 
    j.Designation;
--8. How many employees are working in "New York"?
SELECT 
    COUNT(e.employee_id) AS employee_count
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
JOIN 
    locations l ON d.location_id = l.location_id
WHERE 
    l.city = 'New York';
--9. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT 
    employee_id,
    FIRST_NAME,MIDDLE_NAME,LAST_NAME,
    salary,
    CASE
        WHEN salary >= 2500 THEN 'A'
        WHEN salary >= 2000 THEN 'B'
        WHEN salary >= 1500 THEN 'C'
        WHEN salary >= 1000 THEN 'D'
        ELSE 'E'
    END AS grade
FROM 
    employee
ORDER BY 
    grade;
--10. List out the number of employees grade wise. Use conditional statement to create a grade column. 
SELECT 
     COUNT(*) AS Employee_Count,
    CASE
        WHEN salary >= 2500 THEN 'A'
        WHEN salary >= 2000 THEN 'B'
        WHEN salary >= 1500 THEN 'C'
        WHEN salary >= 1000 THEN 'D'
        ELSE 'E'
    END AS Grade
FROM 
    employee
GROUP BY 
    CASE
         WHEN salary >= 2500 THEN 'A'
        WHEN salary >= 2000 THEN 'B'
        WHEN salary >= 1500 THEN 'C'
        WHEN salary >= 1000 THEN 'D'
        ELSE 'E'
    END
ORDER BY 
    grade;
--11.Display the employee salary grades and the number of employees
--between 2000 to 5000 range of salary. 
SELECT 
     COUNT(*) AS Employee_Count,
    CASE
        WHEN salary >= 2500 THEN 'A'
        WHEN salary >= 2000 THEN 'B'
        WHEN salary >= 1500 THEN 'C'
        WHEN salary >= 1000 THEN 'D'
        ELSE 'E'
    END AS Grade
FROM 
    employee
WHERE SALARY between 2000 and 5000
GROUP BY 
    CASE
         WHEN salary >= 2500 THEN 'A'
        WHEN salary >= 2000 THEN 'B'
        WHEN salary >= 1500 THEN 'C'
        WHEN salary >= 1000 THEN 'D'
        ELSE 'E'
    END
ORDER BY 
    grade;
--12. Display all employees in sales or operation departments
SELECT 
    e.employee_id,
    e.FIRST_NAME,e.MIDDLE_NAME,e.LAST_NAME,
    e.salary,
    d.name as Department
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.department_id
WHERE 
    d.name IN ('Sales', 'Operations');

--SET Operators:
--1. List out the distinct jobs in sales and accounting departments. 
SELECT DISTINCT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.Name = 'Sales'
UNION
SELECT DISTINCT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.Name = 'Accounting'

--2. List out all the jobs in sales and accounting departments. 
SELECT DISTINCT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.Name = 'Sales'
UNION ALL
SELECT DISTINCT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.Name = 'Accounting'

--3. List out the common jobs in research and accounting departments in ascending order.
SELECT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.name = 'Research'
INTERSECT
SELECT j.Designation
FROM employee e
JOIN department d ON e.department_id = d.department_id
JOIN job j ON e.job_id = j.job_id
WHERE d.Name = 'Accounting'
ORDER BY j.Designation;

--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT *
FROM 
    employee
WHERE 
    salary = (SELECT MAX(salary) FROM EMPLOYEE);
--2. Display the employees who are working in the sales department. 
SELECT *
FROM 
    employee
WHERE 
    department_id = (SELECT department_id 
                     FROM department 
                     WHERE Name = 'Sales');
--3. Display the employees who are working as 'Clerk'. 
SELECT *
FROM 
    employee
WHERE 
    JOB_ID = (SELECT Job_ID
                     FROM JOB 
                     WHERE Designation = 'Clerk');
--4. Display the list of employees who are living in "New York".
SELECT 
    employee_id,
    FIRST_NAME,MIDDLE_NAME,LAST_NAME,
    salary,
    department_id
FROM 
    employee
WHERE 
    department_id IN (SELECT department_id 
                      FROM department 
                      WHERE location_id = (SELECT location_id 
                                            FROM locations 
                                            WHERE city = 'New York'));
--5. Find out the number of employees working in the sales department. 
SELECT Count(*) as SALES_EMPLOYEE
FROM 
    employee
WHERE 
    department_id = (SELECT department_id 
                     FROM department 
                     WHERE Name = 'Sales');
--6. Update the salaries of employees who are working as clerks on the basis of 10%. 
UPDATE employee
SET salary = salary * 1.10
WHERE job_id = (SELECT job_id 
                FROM job 
                WHERE Designation = 'Clerk');
--7. Delete the employees who are working in the accounting department.
DELETE FROM employee
WHERE department_id = (SELECT department_id 
                       FROM department
                       WHERE Name = 'Accounting');
--8. Display the second highest salary drawing employee details. 
SELECT *
FROM 
    employee
WHERE 
    salary = (SELECT MAX(salary) 
              FROM employee 
              WHERE salary < (SELECT MAX(salary) FROM employee));
--9. Display the nth highest salary drawing employee details.
SELECT 
    employee_id,
    FIRST_NAME,MIDDLE_NAME,LAST_NAME,
    salary,
    department_id
FROM 
    employee
WHERE 
    salary = (
        SELECT DISTINCT salary 
        FROM employee e1
        WHERE (
            SELECT COUNT(DISTINCT salary) 
            FROM employee e2 
            WHERE e2.salary > e1.salary
        ) = 2  
    );
--10. List out the employees who earn more than every employee in department 30.
SELECT 
    employee_id,
    FIRST_NAME,MIDDLE_NAME,LAST_NAME
    salary,
    department_id
FROM 
    employee
WHERE 
    salary > (SELECT MAX(salary) 
              FROM employee
              WHERE department_id = 30);
--11. List out the employees who earn more than the lowest salary in
--department.
SELECT 
   *
FROM 
    employee e
WHERE 
    e.salary > (
        SELECT MIN(salary)
        FROM employee
        WHERE department_id = e.department_id
    )

--12. Find out which department has no employees. 
SELECT 
    d.department_id,
    d.Name
FROM 
    department d
WHERE 
    d.department_id NOT IN (
        SELECT DISTINCT department_id
        FROM employee
    );
--13. Find out the employees who earn greater than the average salary for their department.
SELECT *  
FROM 
    employee e
WHERE 
    e.salary > (
        SELECT AVG(salary)
        FROM employee
        WHERE department_id = e.department_id
    );





