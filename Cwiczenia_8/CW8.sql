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