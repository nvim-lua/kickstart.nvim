local helpers = require('personal.luasnip-helper-funcs')
local get_visual = helpers.get_visual
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return
  {
    -- SELECT
    s({trig = ";s", wordTrig=false, snippetType="autosnippet"},
      {t("SELECT ")}
    ),
    -- FROM
    s({trig = ";f", wordTrig=false, snippetType="autosnippet"},
      {t("FROM ")}
    ),
    -- DISTINCT
    s({trig = ";di", wordTrig=false, snippetType="autosnippet"},
      {t("DISTINCT ")}
    ),
    -- DROP
    s({trig = ";dr", wordTrig=false, snippetType="autosnippet"},
      {t("DROP ")}
    ),
    -- WITH DELIMITER
    s({trig = ";wd", wordTrig=false, snippetType="autosnippet"},
      {t("WITH DELIMITER ")}
    ),
    -- HEADER CSV
    s({trig = ";hc", wordTrig=false, snippetType="autosnippet"},
      {t("HEADER CSV ")}
    ),
    -- CREATE TABLE
    s({trig = ";ct", wordTrig=false, snippetType="autosnippet"},
      {t("CREATE TABLE ")}
    ),
    -- CREATE TEMPORARY TABLE
    s({trig = ";cp", wordTrig=false, snippetType="autosnippet"},
      {t("CREATE TEMPORARY TABLE ")}
    ),
    -- UPDATE
    s({trig = ";u", wordTrig=false, snippetType="autosnippet"},
      {t("UPDATE ")}
    ),
    -- NULL
    s({trig = ";nl", wordTrig=false, snippetType="autosnippet"},
      {t("NULL ")}
    ),
    -- NOT NULL
    s({trig = ";nn", wordTrig=false, snippetType="autosnippet"},
      {t("NOT NULL ")}
    ),
  }

-- ADD 	Adds a column in an existing table
-- ADD CONSTRAINT 	Adds a constraint after a table is already created
-- ALL 	Returns true if all of the subquery values meet the condition
-- ALTER 	Adds, deletes, or modifies columns in a table, or changes the data type of a column in a table
-- ALTER COLUMN 	Changes the data type of a column in a table
-- ALTER TABLE 	Adds, deletes, or modifies columns in a table
-- AND 	Only includes rows where both conditions is true
-- ANY 	Returns true if any of the subquery values meet the condition
-- AS 	Renames a column or table with an alias
-- ASC 	Sorts the result set in ascending order
-- BACKUP DATABASE 	Creates a back up of an existing database
-- BETWEEN 	Selects values within a given range
-- CASE 	Creates different outputs based on conditions
-- CHECK 	A constraint that limits the value that can be placed in a column
-- COLUMN 	Changes the data type of a column or deletes a column in a table
-- CONSTRAINT 	Adds or deletes a constraint
-- CREATE 	Creates a database, index, view, table, or procedure
-- CREATE DATABASE 	Creates a new SQL database
-- CREATE INDEX 	Creates an index on a table (allows duplicate values)
-- CREATE OR REPLACE VIEW 	Updates a view
-- CREATE TABLE 	Creates a new table in the database
-- CREATE PROCEDURE 	Creates a stored procedure
-- CREATE UNIQUE INDEX 	Creates a unique index on a table (no duplicate values)
-- CREATE VIEW 	Creates a view based on the result set of a SELECT statement
-- DATABASE 	Creates or deletes an SQL database
-- DEFAULT 	A constraint that provides a default value for a column
-- DELETE 	Deletes rows from a table
-- DESC 	Sorts the result set in descending order
-- DISTINCT 	Selects only distinct (different) values
-- DROP 	Deletes a column, constraint, database, index, table, or view
-- DROP COLUMN 	Deletes a column in a table
-- DROP CONSTRAINT 	Deletes a UNIQUE, PRIMARY KEY, FOREIGN KEY, or CHECK constraint
-- DROP DATABASE 	Deletes an existing SQL database
-- DROP DEFAULT 	Deletes a DEFAULT constraint
-- DROP INDEX 	Deletes an index in a table
-- DROP TABLE 	Deletes an existing table in the database
-- DROP VIEW 	Deletes a view
-- EXEC 	Executes a stored procedure
-- EXISTS 	Tests for the existence of any record in a subquery
-- FOREIGN KEY 	A constraint that is a key used to link two tables together
-- FROM 	Specifies which table to select or delete data from
-- FULL OUTER JOIN 	Returns all rows when there is a match in either left table or right table
-- GROUP BY 	Groups the result set (used with aggregate functions: COUNT, MAX, MIN, SUM, AVG)
-- HAVING 	Used instead of WHERE with aggregate functions
-- IN 	Allows you to specify multiple values in a WHERE clause
-- INDEX 	Creates or deletes an index in a table
-- INNER JOIN 	Returns rows that have matching values in both tables
-- INSERT INTO 	Inserts new rows in a table
-- INSERT INTO SELECT 	Copies data from one table into another table
-- IS NULL 	Tests for empty values
-- IS NOT NULL 	Tests for non-empty values
-- JOIN 	Joins tables
-- LEFT JOIN 	Returns all rows from the left table, and the matching rows from the right table
-- LIKE 	Searches for a specified pattern in a column
-- LIMIT 	Specifies the number of records to return in the result set
-- NOT 	Only includes rows where a condition is not true
-- NOT NULL 	A constraint that enforces a column to not accept NULL values
-- OR 	Includes rows where either condition is true
-- ORDER BY 	Sorts the result set in ascending or descending order
-- OUTER JOIN 	Returns all rows when there is a match in either left table or right table
-- PRIMARY KEY 	A constraint that uniquely identifies each record in a database table
-- PROCEDURE 	A stored procedure
-- RIGHT JOIN 	Returns all rows from the right table, and the matching rows from the left table
-- ROWNUM 	Specifies the number of records to return in the result set
-- SELECT 	Selects data from a database
-- SELECT DISTINCT 	Selects only distinct (different) values
-- SELECT INTO 	Copies data from one table into a new table
-- SELECT TOP 	Specifies the number of records to return in the result set
-- SET 	Specifies which columns and values that should be updated in a table
-- TABLE 	Creates a table, or adds, deletes, or modifies columns in a table, or deletes a table or data inside a table
-- TOP 	Specifies the number of records to return in the result set
-- TRUNCATE TABLE 	Deletes the data inside a table, but not the table itself
-- UNION 	Combines the result set of two or more SELECT statements (only distinct values)
-- UNION ALL 	Combines the result set of two or more SELECT statements (allows duplicate values)
-- UNIQUE 	A constraint that ensures that all values in a column are unique
-- UPDATE 	Updates existing rows in a table
-- VALUES 	Specifies the values of an INSERT INTO statement
-- VIEW 	Creates, updates, or deletes a view
-- WHERE 	Filters a result set to include only records that fulfill a specified condition
