-- Create the DEPARTMENT table if it does not exist
CREATE TABLE IF NOT EXISTS DEPARTMENT (
    EMPLOYEE_ID TEXT,
    NAME TEXT,
    DEPARTMENT_ID TEXT,
    MANAGER_ID TEXT,
    SALARY REAL
);

-- Insert sample data into the DEPARTMENT table
INSERT INTO DEPARTMENT (
    EMPLOYEE_ID,
    NAME,
    DEPARTMENT_ID,
    MANAGER_ID,
    SALARY
) VALUES (
    '100',
    'STEVEN KING',
    '90',
    '100',
    24000
),
(
    '101',
    'NEENA KOCCHAR',
    '90',
    '100',
    17000
),
(
    '102',
    'LEX DEHAAN',
    '90',
    '102',
    9000
),
(
    '103',
    'BRUCE LEE',
    '60',
    '103',
    4800
),
(
    '104',
    'DIANA WILLS',
    '60',
    '103',
    25000
),
(
    '105',
    'VALLI PATOR',
    '50',
    '100',
    4200
),
(
    '1973',
    'LUV HAMI',
    '60',
    '102',
    5000
),
(
    '106',
    'DAVID AUSTIN',
    '90',
    '100',
    6000
);

-- Query to count the number of employees in each department
SELECT
    DEPARTMENT_ID AS "Department Code",
    COUNT(*)      AS "No of Employees"
FROM
    DEPARTMENT
GROUP BY
    DEPARTMENT_ID;

-- Query to sum the salary of each department
SELECT
    DEPARTMENT_ID,
    SUM(SALARY)
FROM
    DEPARTMENT
GROUP BY
    DEPARTMENT_ID;

-- Query to count the number of employees and sum the salary in each department
SELECT
    DEPARTMENT_ID AS "Department Code",
    COUNT(*)      AS "No of Employees",
    SUM(SALARY)   AS "Total Salary"
FROM
    DEPARTMENT
GROUP BY
    DEPARTMENT_ID;

-- Query to sum the salary of employees with a specific manager
SELECT
    DEPARTMENT_ID AS "Department Code",
    SUM(SALARY)   AS "Total Salary"
FROM
    DEPARTMENT
WHERE
    MANAGER_ID = '103'
GROUP BY
    DEPARTMENT_ID;

-- Query to find departments with more than 2 employees
SELECT
    DEPARTMENT_ID,
    COUNT(*)      AS "No. of Employees"
FROM
    DEPARTMENT
GROUP BY
    DEPARTMENT_ID
HAVING
    COUNT(*) > 2;