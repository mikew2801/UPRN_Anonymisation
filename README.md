# uprn_anonymisation
Anonymysing a dataset of property reference numbers using SHA-256 algorithm

This is the code for a small "proof of concept" project I made to show how a dataset can be anonymysed for analytical purposes using Python. The scripts create a dummy data-set of property taxation data. The CSV files contain a column of fake UPRN numbers. The script creates a new SQL database and uploads the data to a set of different tables. It then encodes the UPRN columsn in each case.
