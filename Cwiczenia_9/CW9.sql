--a

BEGIN;

UPDATE production.product
SET listprice = listprice * 1.1
WHERE productid = 680;

COMMIT;

--b

BEGIN;

UPDATE production.productcosthistory
SET productid = 100
WHERE productid = 707;

DELETE FROM production.product
WHERE productid = 707;

ROLLBACK;
