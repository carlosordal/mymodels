
import   diagnostic_lib
import  isotp
import  can
import  ics
import  udsoncan
import  udsoncan.configs
from    udsoncan.connections import PythonIsoTpConnection
from    udsoncan.client import Client
import  pdb
import  struct
import  csv

dtcsFile = 'pacifica_dtc_list.csv'
moduleName = 'ECU'
index = 1
dtcJ2012Code = 'C2227-00'
dtcId = 'C2227'
#get dtc description

#file = open(filename, encoding="utf8")
import csv
with open(dtcsFile, encoding="utf8") as csvfile:
    reader = csv.reader(csvfile)
    for row in reader:
        print(row[0], row[1])


open_file = open(dtcsFile, encoding="utf8")
csv_file = csv.reader(open_file)
dtcDescription = ''
for row in csv_file:
    if row[0] == dtcId:
        dtcDescription = row[1]
        #break

#get subtype description
subtypeDescription =''
subtypeId = dtcJ2012Code[6:8]

open_file = open('pacifica_dtc_list.csv', encoding="utf8")
csv_file = csv.reader(open_file)
for row_type in csv_file:
    if row_type[0] == subtypeId:
        subtypeDescription = row_type[1]
        #break

print('     ', moduleName, "DTC", index, ':', dtcJ2012Code, dtcDescription,'-',subtypeDescription)         # Print the HEX DTC number