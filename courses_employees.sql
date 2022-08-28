/*Source code UDEMY SQL courses
database = employees
*/

use employees;

SELECT * FROM employees
	WHERE first_name = "Elvis";
    
/*AND*/
SELECT * FROM employees
	WHERE first_name = "Kellie" AND gender = 'F';
    
/*OR*/
SELECT * FROM employees
	WHERE first_name = "Kellie" OR first_name = "Aruna";

/*operator precedence*/
SELECT * FROM employees
	WHERE gender = 'F' AND (first_name = "Kellie" OR first_name = "Aruna");
    
/*IN  - NOT IN*/
SELECT * FROM employees
	WHERE first_name IN ("Denis", "Elvis");

SELECT * FROM employees
	WHERE first_name NOT IN ("John", "Mark", "Jacob");

/*LIKE  - NOT LIKE*/
SELECT * FROM employees 
WHERE first_name LIKE('Mark%');

SELECT * FROM employees
WHERE hire_date LIKE ('%2000%');

SELECT * FROM employees 
WHERE emp_no LIKE ('1000_');
    
/* WILDCARD CHAR = ('&' '_' '*') */

/* BETWEEN - AND */
SELECT * FROM salaries
where salary BETWEEN '66000' AND '70000';
    
SELECT * FROM salaries
where emp_no Not BETWEEN '10004' AND '10012';    
    
SELECT dept_name FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006'; 
    
/* IS NULL - IS NOT NULL */   
SELECT * FROM departments
WHERE dept_no IS NOT NULL; 


/*other operator*/
/* NOT EQUAL (<> , !=) */
SELECT * FROM employees;

SELECT * FROM employees
WHERE gender = "F" AND hire_date > "2000-01-01"; 

SELECT * FROM salaries
WHERE salary > 150000;

/* SELECT DISTINCT, different data values*/
SELECT DISTINCT hire_date FROM employees;

/*AGGREGATE FUNCTION
SUM() sums all non-null values in a column, 
COUNT() counts number of non-null record in a field, 
MIN(). MAX(), AVG() 
*/

SELECT COUNT(*) FROM salaries
where salary >= 100000;

SELECT COUNT(*) FROM dept_manager;

/*ORDER BY*/ 
SELECT * FROM employees
order by hire_date desc;
 
/*GROUP BY*/ 
SELECT first_name, count(first_name) FROM employees
group by first_name
ORDER BY first_name; 

/*ALIASES (AS)*/ 
SELECT salary, count(emp_no) AS emps_with_same_salary
FROM salaries
where salary > 80000
GROUP BY salary
ORDER BY salary; 

/*HAVING
most common used with GROUP BY and used aggregate function*/ 
SELECT emp_no, AVG(salary)
FROM  salaries 
GROUP BY emp_no 
HAVING AVG(salary) > 120000
ORDER BY emp_no;

 /*having vs where*/ 
SELECT emp_no FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

/*LIMIT*/
select * from salaries
order by salary DESC 
LIMIT 15;
SELECT * FROM dept_emp
LIMIT 100;


/*INSERT INTO*/
SELECT
    *
FROM
    titles
LIMIT 10;

insert into titles
(
	emp_no,
    title,
    from_date
)
values
(
	999903,
    'Senior Engineer',
    '1997-10-01'
);


SELECT
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into employees
values
(
	999903,
    '1973-3-10',
    'Tony',
    'Klarkun',
    'M'
    '2005-01-01'
);

insert into dept_emp
(
	emp_no,
    dept_no,
    from_date,
    to_date
)
values
(
	999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
); 
 

/*CREATE new table and insert*/
CREATE TABLE departments_dup
(
	dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
);
INSERT INTO departments_dup
(
	dept_no,
    dept_name
)
SELECT * FROM departments;

SELECT * FROM departments_dup
ORDER BY dept_no;

INSERT INTO departments
(
	dept_no,
    dept_name
)
VALUES
(
	'd010',
    'Business Analyst'
    
);

/*update
sometimes need ROLLBACK / COMMIT*/
 SELECT * FROM employees
 ORDER BY emp_no DESC;
 
 UPDATE departments
 SET dept_name = 'Data Analysis'
 WHERE dept_no = 'd010';
 
/*DELETE*/
DELETE FROM departments
WHERE dept_no = 'd010';

/*DROP VS. TRUNCATE VS. DELETE 
1. use DROP TABLE only when you are sure you aren’t going to use the table 
in question anymore
2. when truncating, auto-increment values will be reset
3. delete - removes records row by row
*/


/*COUNT*/
SELECT COUNT(DISTINCT emp_no)
FROM dept_emp;

/*SUM*/
SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';
 
 /*MIN AND MAX*/
 SELECT MIN(emp_no)
 FROM employees;
 
SELECT MAX(emp_no)
 FROM employees;
 
 /*AVERAGE*/
SELECT AVG(salary)
FROM  salaries
WHERE from_date > '1997-01-01';
 
/*ROUND*/
SELECT ROUND(AVG(salary),2)
FROM  salaries
WHERE from_date > '1997-01-01';

/*COALESCE and IF NULL
COALESCE(expression_1, expression_2 …, expression_N) - can have one, two, or more arguments
IFNULL(expression_1, expression_2) - works with precisely two arguments
*/
SELECT
	dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;

SELECT
    IFNULL(dept_no, 'N/A') as dept_no,
    IFNULL(
			dept_name,
            'Department name not provided') 
            AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no ASC;
 
/*JOIN*/ 
ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

 ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;
DROP TABLE IF EXISTS dept_manager_dup;
 
CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES
	(999904, '2017-01-01'),
	(999905, '2017-01-01'),
	(999906, '2017-01-01'),
	(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
 
 
/*INNER JOIN
SELECT table_1.column_name(s), table_2.column_name(s)
FROM table_1
JOIN table_2 ON table_1.column_name = table_2.column_name;
*/
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e
JOIN
dept_manager dm ON e.emp_no = dm.emp_no;
 
 /*LEFT JOIN
 SELECT table_1.column_name(s), table_2.column_name(s)
FROM table_1
LEFT JOIN 
table_2 ON table_1.column_name = table_2.column_name;
 */
 SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN
dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, e.emp_no;
 
 /* JOIN VS WHERE
 -output is identical
 -using where is more time-consuming
 -WHERE is old
 -Join syntax allows to modify connection between table easily
*/
 
 /*old syntax*/
 SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e,
    dept_manager dm
WHERE
    e.emp_no = dm.emp_no;
/*New Join Syntax*/
SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no; 
 
 /*JOin and where using together*/
 SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovotch'
ORDER BY e.emp_no;
 
 /*CROSS JOIN
can be more than two table*/
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < '10011'
ORDER BY e.emp_no , d.dept_name; 

 
/* USING JOIN with some aggregate function */
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

/*Join more than two tables*/
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

/*UNION and UNION ALL
SELECT N columns
FROM table_1
UNION ALL SELECT N columns
FROM table2_;
*/
SELECT * FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;

/* IN nested inside WHERE*/
SELECT * FROM
    dept_manager
WHERE
    emp_no IN (
		SELECT emp_no
		FROM employees
        WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
 
 /*EXIST nested insid WHERE*/
SELECT *
FROM employees e
WHERE
    EXISTS( SELECT * 
		FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

/*SQL query SELECT and FROM*/
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

SELECT * FROM emp_manager;

INSERT INTO emp_manager
SELECT u.* FROM
    (SELECT a.* FROM
        (SELECT 
			e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT emp_no FROM dept_manager
                WHERE emp_no = 110022) AS manager_ID
		FROM employees e
		JOIN dept_emp de ON e.emp_no = de.emp_no
		WHERE e.emp_no <= 10020
		GROUP BY e.emp_no
		ORDER BY e.emp_no
        ) AS a UNION SELECT b.* FROM
			(SELECT e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
				(SELECT emp_no FROM dept_manager
				WHERE emp_no = 110039) AS manager_ID
				FROM employees e
				JOIN dept_emp de ON e.emp_no = de.emp_no
				WHERE e.emp_no > 10020
				GROUP BY e.emp_no
				ORDER BY e.emp_no LIMIT 20) AS b UNION SELECT c.*
					FROM
			(SELECT e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
				(SELECT emp_no
                FROM dept_manager
                WHERE emp_no = 110039) AS manager_ID
					FROM employees e
					JOIN dept_emp de ON e.emp_no = de.emp_no
					WHERE e.emp_no = 110022
					GROUP BY e.emp_no) AS c UNION SELECT 
						d.* FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
				FROM
					employees e
				JOIN dept_emp de ON e.emp_no = de.emp_no
				WHERE
					e.emp_no = 110039
				GROUP BY e.emp_no) AS d) as u;
 
 /* SELF JOIN 
 separate one table into two parts */
 
 /*VIEW*/
 CREATE OR REPLACE VIEW v_manager_avg_salary AS
    SELECT 
        ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;
SELECT * FROM v_manager_avg_salary;
 
 
 
 
 
 
 
 
 
 
 
 
 
