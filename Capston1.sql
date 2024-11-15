-- Create the Salesman table if it does not exist
CREATE TABLE IF NOT EXISTS SALESMAN (
    SALESMAN_ID TEXT PRIMARY KEY,
    NAME TEXT,
    CITY TEXT,
    COMISSION REAL
);

-- Insert sample data into the Salesman table
INSERT INTO SALESMAN (
    SALESMAN_ID,
    NAME,
    CITY,
    COMISSION
) VALUES (
    '5001',
    'James Hoog',
    'New York',
    0.15
),
(
    '5002',
    'Nail Knite',
    'Paris',
    0.13
),
(
    '5005',
    'Pit Alex',
    'London',
    0.11
),
(
    '5006',
    'Mc Lyon',
    'Paris',
    0.14
),
(
    '5007',
    'Paul Adam',
    'Rome',
    0.13
),
(
    '5003',
    'Lauson Hen',
    'San Jose',
    0.12
);

-- Create the Customer table if it does not exist
CREATE TABLE IF NOT EXISTS CUSTOMER (
    CUSTOMER_ID TEXT,
    CUST_NAME TEXT PRIMARY KEY,
    CITY TEXT,
    GRADE INTEGER,
    SALESMAN_ID TEXT,
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID)
);

-- Insert sample data into the Customer table
INSERT INTO CUSTOMER (
    CUSTOMER_ID,
    CUST_NAME,
    CITY,
    GRADE,
    SALESMAN_ID
) VALUES (
    '3002',
    'nick rimando',
    'new york',
    100,
    '5001'
),
(
    '3007',
    'brad davis',
    'new york',
    200,
    '5001'
),
(
    '3005',
    'graham zusi',
    'california',
    200,
    '5002'
),
(
    '3008',
    'julian green',
    'london',
    300,
    '5002'
),
(
    '3004',
    'fabian johnson',
    'paris',
    300,
    '5006'
),
(
    '3009',
    'geoff cameron',
    'berlin',
    100,
    '5003'
),
(
    '3003',
    'jozy altidor',
    'moscow',
    200,
    '5007'
),
(
    '3001',
    'brad guzan',
    'london',
    NULL,
    '5005'
);

-- Create the Orders table if it does not exist
CREATE TABLE IF NOT EXISTS ORDERS (
    ORD_NO TEXT PRIMARY KEY,
    PURCH_AMT REAL,
    ORD_DATE TEXT,
    CUSTOMER_ID TEXT,
    SALESMAN_ID TEXT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID)
);

-- Insert sample data into the Orders table
INSERT INTO ORDERS (
    ORD_NO,
    PURCH_AMT,
    ORD_DATE,
    CUSTOMER_ID,
    SALESMAN_ID
) VALUES (
    '70001',
    150.5,
    '2012-10-05',
    '3005',
    '5002'
),
(
    '70009',
    270.65,
    '2012-09-10',
    '3001',
    '5001'
),
(
    '70002',
    65.26,
    '2012-10-05',
    '3002',
    '5003'
),
(
    '70004',
    110.5,
    '2012-08-17',
    '3009',
    '5007'
),
(
    '70007',
    948.5,
    '2012-09-10',
    '3005',
    '5005'
),
(
    '70005',
    2400.6,
    '2012-07-27',
    '3007',
    '5006'
);

-- Queries

-- Matching customers and salesmen by city
SELECT
    CUSTOMER.CUST_NAME,
    SALESMAN.NAME,
    SALESMAN.CITY
FROM
    CUSTOMER
    JOIN SALESMAN
    ON CUSTOMER.CITY = SALESMAN.CITY;

-- Linking customers to their salesmen
SELECT
    CUSTOMER.CUST_NAME,
    SALESMAN.NAME
FROM
    CUSTOMER
    JOIN SALESMAN
    ON CUSTOMER.SALESMAN_ID = SALESMAN.SALESMAN_ID;

-- Fetching orders where customer's city does not match salesman's city
SELECT
    ORDERS.ORD_NO,
    CUSTOMER.CUST_NAME,
    ORDERS.CUSTOMER_ID,
    ORDERS.SALESMAN_ID
FROM
    ORDERS
    JOIN CUSTOMER
    ON ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
    JOIN SALESMAN
    ON ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID
WHERE
    CUSTOMER.CITY <> SALESMAN.CITY;

-- Fetching all orders with customer names
SELECT
    ORDERS.ORD_NO,
    CUSTOMER.CUST_NAME
FROM
    ORDERS
    JOIN CUSTOMER
    ON ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID;

-- Customers with grades
SELECT
    CUSTOMER.CUST_NAME AS "Customer",
    CUSTOMER.GRADE     AS "Grade"
FROM
    ORDERS
    JOIN SALESMAN
    ON ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID
    JOIN CUSTOMER
    ON ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
WHERE
    CUSTOMER.GRADE IS NOT NULL;

-- Customers with salesmen where commission is between 0.12 and 0.14
SELECT
    CUSTOMER.CUST_NAME AS "Customer",
    CUSTOMER.CITY      AS "City",
    SALESMAN.NAME      AS "Salesman",
    SALESMAN.COMISSION
FROM
    CUSTOMER
    JOIN SALESMAN
    ON CUSTOMER.SALESMAN_ID = SALESMAN.SALESMAN_ID
WHERE
    SALESMAN.COMISSION BETWEEN 0.12 AND 0.14;

-- Calculating commissions for orders where customer grade is 200 or more
SELECT
    ORDERS.ORD_NO,
    CUSTOMER.CUST_NAME,
    SALESMAN.COMISSION                    AS "Commission%",
    ORDERS.PURCH_AMT * SALESMAN.COMISSION AS "Commission"
FROM
    ORDERS
    JOIN SALESMAN
    ON ORDERS.SALESMAN_ID = SALESMAN.SALESMAN_ID
    JOIN CUSTOMER
    ON ORDERS.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
WHERE
    CUSTOMER.GRADE >= 200;

-- Orders on a specific date
SELECT
    *
FROM
    CUSTOMER
    JOIN ORDERS
    ON CUSTOMER.CUSTOMER_ID = ORDERS.CUSTOMER_ID
WHERE
    ORDERS.ORD_DATE = '2012-10-05';