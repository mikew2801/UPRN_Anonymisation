import pandas as pd
import MySQLdb
import sqlparse

## Establish connection to MySQL server

db = MySQLdb.connect(host = "127.0.0.1", user = "root", passwd = "psswd")

cur = db.cursor()

## Delete the database if it already exists

choice = str(input("Delete WRA_Data database? [Y/N] >>> "))
if choice == "Y":
    cur.execute("DROP DATABASE WRA_Data;")

# Now create a set of tables that we will upload the csv files to
# The tables will be based on the structure of the csv files

with open('Create_tables.sql', 'rb') as f:
    for statement in sqlparse.split(f.read()):
        if not statement:
            continue
        cur.execute(statement)

filename = "LttBuyer.csv"
df = pd.read_csv(filename)

from sqlalchemy import create_engine

import os
engine = create_engine("mysql+mysqldb://root:"+'psswd'+"@localhost/WRA_Data")

files = os.listdir("/home/michael/WRA_Data_Test/To_Upload/Final")

csvs = []
tables = []

for name in files:
    if ".csv" in name:
        csvs.append(name)

# Now open all the csv files as dataframes

list_of_dataframes = []
list_of_names = []

for name in csvs:
    list_of_dataframes.append(pd.read_csv(name))
    filename, extension = os.path.splitext(name)
    list_of_names.append(filename)

for dataframe, filename in zip(list_of_dataframes, list_of_names):
#    choice = input(filename + " loaded. Press any key to continue >>> ")
#    print("Now loading: " + filename)
    dataframe.to_sql(name = filename, con=engine, if_exists='append', index=False)


db.close()
