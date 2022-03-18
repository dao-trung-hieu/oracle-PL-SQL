---- INDEX -----
/* Exercises 1
Create index for title field of employee TABLE
check it is created or not
*/
DROP INDEX HIEU_INDEX_TITLE;
/

CREATE INDEX HIEU_INDEX_TITLE ON EMPLOYEE(TITLE);
/

-- use plan --
SET AUTOTRACE ON;

-- ccheck of index --
SELECT INDEX_NAME, INDEX_TYPE, TABLESPACE_NAME, STATUS
FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
/

/* Exercises 2
Create index employee TABLE to upseed the performance by name (first_name, last_name)
*/

CREATE INDEX HIEU_INDEX_NAME ON EMPLOYEE(first_name, last_name);
/

-- check of index --
SELECT INDEX_NAME, INDEX_TYPE, TABLESPACE_NAME, STATUS
FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
/

-- use index --
SELECT * FROM EMPLOYEE WHERE first_name = 'Michael' AND last_name = 'Smith';

/* Exercises 3
Create index to upseed the performance by state of customer TABLE
*/

CREATE BITMAP INDEX HIEU_INDEX_STATE ON CUSTOMER(STATE);
/

-------PARTITION --------

/* Exercises 1
Step 1: Create a table according to the following template
CREATE TABLE invoices_not_partition (
invoice_no NUMBER NOT NULL,
invoice_date DATE NOT NULL,
comments VARCHAR2(500)
)
*/
DROP TABLE HIEU_INVOICES_NOT_PARTITION;
/

CREATE TABLE HIEU_INVOICES_NOT_PARTITION (
invoice_no NUMBER NOT NULL,
invoice_date DATE NOT NULL,
comments VARCHAR2(500)
);
/
/*Step 2: Insert mock data */
BEGIN
FOR i IN 1..1010000 LOOP
INSERT INTO HIEU_INVOICES_NOT_PARTITION (invoice_no, invoice_date, comments)
VALUES (
    (SELECT TRUNC(DBMS_RANDOM.VALUE(1,100000)) FROM DUAL), 
    (SELECT TRUNC(SYSDATE - DBMS_RANDOM.VALUE(0,3640)) FROM DUAL),
    (SELECT DBMS_RANDOM.STRING('A',20) FROM DUAL)
    );
    COMMIT;
END LOOP;
END;
/

/*Step 3: Create table hieu_invoices_with_partition */

CREATE TABLE HIEU_INVOICES_WITH_PARTITION
(invoice_no NUMBER NOT NULL,
invoice_date DATE NOT NULL,
comments VARCHAR2(500))
partition by range(invoice_date)(
PARTITION P2010_Q1 VALUES less than(to_date('01-APR-2010', 'DD-MON-YYYY')),
PARTITION P2010_Q2 VALUES less than(to_date('01-JUL-2010', 'DD-MON-YYYY')),
PARTITION P2010_Q3 VALUES less than(to_date('01-OCT-2010', 'DD-MON-YYYY')),
PARTITION P2010_Q4 VALUES less than(to_date('01-JAN-2011', 'DD-MON-YYYY')),
PARTITION P2011_Q1 VALUES less than(to_date('01-APR-2011', 'DD-MON-YYYY')),
PARTITION P2011_Q2 VALUES less than(to_date('01-JUL-2011', 'DD-MON-YYYY')),
PARTITION P2011_Q3 VALUES less than(to_date('01-OCT-2011', 'DD-MON-YYYY')),
PARTITION P2011_Q4 VALUES less than(to_date('01-JAN-2012', 'DD-MON-YYYY')),
PARTITION P2012_Q1 VALUES less than(to_date('01-APR-2012', 'DD-MON-YYYY')),
PARTITION P2012_Q2 VALUES less than(to_date('01-JUL-2012', 'DD-MON-YYYY')),
PARTITION P2012_Q3 VALUES less than(to_date('01-OCT-2012', 'DD-MON-YYYY')),
PARTITION P2012_Q4 VALUES less than(to_date('01-JAN-2013', 'DD-MON-YYYY')),
PARTITION P2013_Q1 VALUES less than(to_date('01-APR-2013', 'DD-MON-YYYY')),
PARTITION P2013_Q2 VALUES less than(to_date('01-JUL-2013', 'DD-MON-YYYY')),
PARTITION P2013_Q3 VALUES less than(to_date('01-OCT-2013', 'DD-MON-YYYY')),
PARTITION P2013_Q4 VALUES less than(to_date('01-JAN-2014', 'DD-MON-YYYY')),
PARTITION P2014_Q1 VALUES less than(to_date('01-APR-2014', 'DD-MON-YYYY')),
PARTITION P2014_Q2 VALUES less than(to_date('01-JUL-2014', 'DD-MON-YYYY')),
PARTITION P2014_Q3 VALUES less than(to_date('01-OCT-2014', 'DD-MON-YYYY')),
PARTITION P2014_Q4 VALUES less than(to_date('01-JAN-2015', 'DD-MON-YYYY')),
PARTITION P2015_Q1 VALUES less than(to_date('01-APR-2015', 'DD-MON-YYYY')),
PARTITION P2015_Q2 VALUES less than(to_date('01-JUL-2015', 'DD-MON-YYYY')),
PARTITION P2015_Q3 VALUES less than(to_date('01-OCT-2015', 'DD-MON-YYYY')),
PARTITION P2015_Q4 VALUES less than(to_date('01-JAN-2016', 'DD-MON-YYYY')),
PARTITION P2016_Q1 VALUES less than(to_date('01-APR-2016', 'DD-MON-YYYY')),
PARTITION P2016_Q2 VALUES less than(to_date('01-JUL-2016', 'DD-MON-YYYY')),
PARTITION P2016_Q3 VALUES less than(to_date('01-OCT-2016', 'DD-MON-YYYY')),
PARTITION P2016_Q4 VALUES less than(to_date('01-JAN-2017', 'DD-MON-YYYY')),
PARTITION P2017_Q1 VALUES less than(to_date('01-APR-2017', 'DD-MON-YYYY')),
PARTITION P2017_Q2 VALUES less than(to_date('01-JUL-2017', 'DD-MON-YYYY')),
PARTITION P2017_Q3 VALUES less than(to_date('01-OCT-2017', 'DD-MON-YYYY')),
PARTITION P2017_Q4 VALUES less than(to_date('01-JAN-2018', 'DD-MON-YYYY')),
PARTITION P2018_Q1 VALUES less than(to_date('01-APR-2018', 'DD-MON-YYYY')),
PARTITION P2018_Q2 VALUES less than(to_date('01-JUL-2018', 'DD-MON-YYYY')),
PARTITION P2018_Q3 VALUES less than(to_date('01-OCT-2018', 'DD-MON-YYYY')),
PARTITION P2018_Q4 VALUES less than(to_date('01-JAN-2019', 'DD-MON-YYYY')),
PARTITION P2019_Q1 VALUES less than(to_date('01-APR-2019', 'DD-MON-YYYY')),
PARTITION P2019_Q2 VALUES less than(to_date('01-JUL-2019', 'DD-MON-YYYY')),
PARTITION P2019_Q3 VALUES less than(to_date('01-OCT-2019', 'DD-MON-YYYY')),
PARTITION P2019_Q4 VALUES less than(to_date('01-JAN-2020', 'DD-MON-YYYY')),
PARTITION P2020_Q1 VALUES less than(to_date('01-APR-2020', 'DD-MON-YYYY')),
PARTITION P2020_Q2 VALUES less than(to_date('01-JUL-2020', 'DD-MON-YYYY')),
PARTITION P2020_Q3 VALUES less than(to_date('01-OCT-2020', 'DD-MON-YYYY')),
PARTITION P2020_Q4 VALUES less than(to_date('01-JAN-2021', 'DD-MON-YYYY')),
PARTITION P2021_Q1 VALUES less than(to_date('01-APR-2021', 'DD-MON-YYYY')),
PARTITION P2021_Q2 VALUES less than(to_date('01-JUL-2021', 'DD-MON-YYYY')),
PARTITION P2021_Q3 VALUES less than(to_date('01-OCT-2021', 'DD-MON-YYYY')),
PARTITION P2021_Q4 VALUES less than(to_date('01-JAN-2022', 'DD-MON-YYYY')),
PARTITION P2022_Q1 VALUES less than(to_date('01-APR-2022', 'DD-MON-YYYY')),
PARTITION P2022_Q2 VALUES less than(to_date('01-JUL-2022', 'DD-MON-YYYY')),
PARTITION P2022_Q3 VALUES less than(to_date('01-OCT-2022', 'DD-MON-YYYY')),
PARTITION P2022_Q4 VALUES less than(to_date('01-JAN-2023', 'DD-MON-YYYY'))
);
/

/*Step 4: insert data into table*/
INSERT INTO HIEU_INVOICES_WITH_PARTITION
SELECT * 
FROM HIEU_INVOICES_NOT_PARTITION;
/

/*Exercise 2:
Use the Range Partition style to perform range partitioning on the TXN_DATE field of the ACC_TRANSACTION table by 5 partitions:
• ACC_TRANSACTION_2001 VALUES LESS CHANNEL (TO_DATE('01-JAN-2001','DD-MON-YYYY')),
• ACC_TRANSACTION_2002 VALUES LESS CHANNEL (TO_DATE('01-JAN-2002','DD-MON-YYYY')),
• ACC_TRANSACTION_2003 VALUES LESS CHANNEL (TO_DATE('01-JAN-2003','DD-MON-YYYY')),
• ACC_TRANSACTION_2004 VALUES LESS CHANNEL (TO_DATE('01-JAN-2004','DD-MON-YYYY')),
• ACC_TRANSACTION_2005 VALUES LESS CHANNEL (TO_DATE('01-JAN-2005','DD-MON-YYYY'))
*/

ALTER TABLE TEST_TRANSACTION MODIFY
PARTITION BY RANGE (TXN_DATE)(
    PARTITION ACC_TRANSACTION_2001 VALUES LESS THAN (to_date('01-JAN-2001','DD-MON-YYYY')),
    PARTITION ACC_TRANSACTION_2002 VALUES LESS THAN (to_date('01-JAN-2002','DD-MON-YYYY')),
    PARTITION ACC_TRANSACTION_2003 VALUES LESS THAN (to_date('01-JAN-2003','DD-MON-YYYY')),
    PARTITION ACC_TRANSACTION_2004 VALUES LESS THAN (to_date('01-JAN-2004','DD-MON-YYYY')),
    PARTITION ACC_TRANSACTION_2005 VALUES LESS THAN (to_date('01-JAN-2005','DD-MON-YYYY'))
);
/

/*Exercise 3:
Use the List Partition style to perform partitioning according to each customer's STATE (Customer table)
*/

ALTER TABLE HIEU_CUSTOMER MODIFY
PARTITION BY LIST (STATE)(
    PARTITION STATE_MA VALUES ('MA'),
    PARTITION STATE_NH VALUES ('NH'),
    PARTITION STATE_ VALUES (DEFAULT)
);
/