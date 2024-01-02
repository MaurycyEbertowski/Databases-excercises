CREATE TEMP TABLE TempEmployeeInfo(
	firstname VARCHAR,
	lastname VARCHAR,
	businessentityid INT,
	maxrate MONEY
);

WITH MaxSalary AS (
    SELECT 
        humanresources.employeepayhistory.businessentityid,
        person.person.firstname,
        person.person.lastname,
        MAX(humanresources.employeepayhistory.rate) AS maxrate
    FROM 
        humanresources.employeepayhistory
    JOIN 
        person.person ON humanresources.employeepayhistory.businessentityid = person.person.businessentityid
    GROUP BY 
        humanresources.employeepayhistory.businessentityid, person.person.firstname, person.person.lastname
)

INSERT INTO TempEmployeeInfo (businessentityid, firstname, lastname, maxrate)
SELECT 
    businessentityid,
    firstname,
    lastname,
    maxrate
FROM 
    MaxSalary;

SELECT * FROM TempEmployeeInfo

--2

WITH SalesData AS (
	SELECT
		sales.customer.customerid AS customerid,
		sales.customer.territoryid AS territoryid,
		sales.salesperson.businessentityid,
		person.person.firstname AS salesman_firstname,
		person.person.lastname AS salesman_lastname
	FROM
		sales.salesperson
	JOIN sales.customer ON sales.salesperson.territoryid = sales.customer.territoryid
	JOIN person.person ON sales.salesperson.businessentityid = person.person.businessentityid
)
SELECT
	SalesData.customerid,
	SalesData.territoryid,
	SalesData.salesman_firstname,
	SalesData.salesman_lastname
FROM
	SalesData;