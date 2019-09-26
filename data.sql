DROP TABLE employees;

CREATE TABLE employees (
    emp_no INT NOT NULL,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(255) NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(255) NOT NULL,    
    hire_date   DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

SELECT * FROM employees

DROP TABLE departments;

CREATE TABLE departments (
    dept_no     CHAR(4) NOT NULL,
    dept_name   VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no)
    
);

SELECT * FROM departments;

DROP TABLE dept_manager;

CREATE TABLE dept_manager (
   dept_no CHAR(4) NOT NULL,
   emp_no INT NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
); 

select * from dept_manager

DROP TABLE dept_emp

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no) ,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
);

SELECT * FROM dept_emp;

DROP TABLE titles;

CREATE TABLE titles (
    emp_no      INT NOT NULL,
    title       VARCHAR(50) NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
); 

SELECT * FROM titles;

DROP TABLE salaries;

CREATE TABLE salaries (
    emp_no      INT  NOT NULL,
    salary      INT  NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
) ;


select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select* from titles;


-- List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT 
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

-- List employees who were hired in 1986. 

SELECT
hire_date
FROM employees
WHERE extract(year from hire_date) = '1986'; 


-- List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT
m.dept_no,
dept_name,
m.emp_no,
first_name,
last_name,
m.from_date,
m.to_date
FROM dept_manager m
LEFT JOIN departments on m.dept_no = departments.dept_no
LEFT JOIN employees on m.emp_no = employees.emp_no;


-- List the department of each employee with the following information: employee number, last name, first name, and department name

SELECT
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select* from titles;

-- List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE(first_name LIKE 'Hercules' AND last_name LIKE '%B%');

-- List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

Select
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no 
WHERE departments.dept_name lIKE 'Sales';



-- List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.


Select
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no 
WHERE departments.dept_name lIKE 'Sales'
OR departments.dept_name LIKE  'Development';



--In descending order, list the frequency count of employee last names, i.e.,
--how many employees share each last name.

SELECT
last_name,
COUNT(last_name) AS "name_count"
from employees
GROUP BY
last_name
ORDER BY name_count DESC;
