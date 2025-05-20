/* 
I used the same data loading concept from my previous project and, unsurprisingly, encountered the same error.

This is how I resolved it (valid for PostgreSQL and pgAdmin):
1. Opened pgAdmin
2 .In Object Explorer (left-hand pane), navigated to the database
3 .Right-clicked its name and selected `PSQL Tool which opened a terminal window
4. Got the absolute file path of my CSV file
5. Pasted the following into PSQL Tool:
\copy [file name] FROM '[file path]' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/

-- The final loading step was running this line of code in VS Code:
\copy cl_match_stats FROM 'C:\Users\Jakov\Documents\cl_match_stats.csv' WITH (FORMAT csv, HEADER true,DELIMITER ',', ENCODING 'UTF8');

-- If you are going to use the CSV data, you do not have to use the same loading concept as I did
