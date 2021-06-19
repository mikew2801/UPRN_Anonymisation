import pandas as pd
import MySQLdb
import sqlparse
from sqlalchemy import create_engine
import hashlib as hl

## Establish connection to MySQL server

db = MySQLdb.connect(host = "127.0.0.1", user = "root", passwd = "linkdoom56")
cur = db.cursor()

# Read the existing tables into memory as dataframes, drop all address data, hash the UPRNs and upload the new database to the server
cur.execute("USE WRA_Data")
cur.execute("SHOW TABLES")                        # Show all the tables in the WRA_Data database
tables = cur.fetchall()                           # Return data from last query

list_of_dfs = []
for table_name in tables:
    list_of_dfs.append(pd.read_sql('SELECT * FROM ' + table_name[0], con=db))

no_addresses = []
temp = pd.DataFrame()
# Now drop all address data and use SHA256 to encode the UPRNS
for dataframe in list_of_dfs:
    temp = dataframe
    for column in temp.columns:
        if ("Address" in column) or ("Postcode" in column) or ("Country" in column) or ("TelephoneNumber" in column):
            temp = temp.drop(column, axis = 1)
        elif column == "UPRN":
            # Encode any UPRN columns with the SHA256 algorithm
            new_uprn_list = []
            for uprn in temp[column]:
                new_uprn_list.append(hl.sha256(uprn.encode()).hexdigest())
            temp["UPRN"] = new_uprn_list
    no_addresses.append(temp)

for dataframe in no_addresses:
    dataframe.to_csv("New_Dfs/" + dataframe.columns[0] + ".csv", index = False)



db.close()

