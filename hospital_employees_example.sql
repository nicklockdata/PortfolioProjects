
  #This project uses two tables I created in excel to showcase functions like MAX, AVG, COUNT, as well as joins

  ------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Using Max, Avg and Count operators to find the Most paid salary, average pay for the hospital and number of employees they have working there
  SELECT MAX(Salary) AS most_paid_job, AVG(Salary) AS average_pay, COUNT(FirstName) AS number_of_employees
  FROM employees.employees_info2

  ------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Using a like operator to find any last name containing the letter "e" in the middle.
  SELECT *
  FROM employees.employees_info2
  WHERE
  FirstName LIKE '%e%'

  ------------------------------------------------------------------------------------------------------------------------------------------------------------
  #Joining the two tables together by their common column EmployeeNumber then ordering YearsAtCompany in descending order
  SELECT
  employees_info1.EmployeeNumber, 
  employees_info1.FirstName,
  employees_info1.LastName,
  employees_info1.JobPosition,
  employees_info1.Age,
  employees_info2.Salary,
  employees_info2.YearsAtCompany,
  FROM employees.employees_info1
  JOIN employees.employees_info2
    ON employees_info1.EmployeeNumber=employees_info2.EmployeeNumber
  ORDER BY
  YearsAtCompany DESC

  ------------------------------------------------------------------------------------------------------------------------------------------------------------
  ##Figuring out bonus that each work area gets
  SELECT
  employees_info1.EmployeeNumber, 
  employees_info1.FirstName,
  employees_info1.LastName,
  employees_info1.JobPosition,
  employees_info1.Age,
  employees_info2.Salary,
  employees_info2.YearsAtCompany,
  CASE
    WHEN JobPosition = 'Lab Tech' THEN (Salary * .15)
    WHEN JobPosition = 'Doctor' THEN (Salary * .20)
    WHEN JobPosition = 'Nurse' THEN (Salary * .10)
    ELSE (Salary * .05)
  END AS Bonus
  FROM employees.employees_info1
  JOIN employees.employees_info2
    ON employees_info1.EmployeeNumber=employees_info2.EmployeeNumber
  ORDER BY
  Bonus DESC