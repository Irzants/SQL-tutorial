/*Source code UDEMY SQL courses*/

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
	WHERE first_name = "Kellie" AND gender = 'F';