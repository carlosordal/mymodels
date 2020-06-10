# Read SW PN, Serial number of IPC and EFP on Ford fusion 2017 HS2 using Peak CAN tool.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

# Next steps:
# include not response for a module that is not on the network
# read and decode DIDs from yaml file
# convert it to app simulation and Peak CAN.
# Print DTC description from a different file List.
# Select network for report. if HS1 print out VIN#
# Create a file with Report. txt
# 

# result on fusion DTCs induced. 
#  ----------------- Section: IPC - Instrument Panel Cluster -------------------
# IPC DTC 1 U0212-00
#  ----------------- Section: EFP - Electronic Front Panel (CC) -------------------
# EFP 0xf188 HS7T-14G121-DB
# EFP DTC 1 B1A61-15
# EFP DTC 2 B1A69-15
#  ----------------- Section: SCCM - Steering Column Control Module -------------------
# SCCM 0xf188 G3GT-14C579-AB
# SCCM 0xde00 0x200600
# no SCCM dtcs
# ********************************************************* completed  ********************************************

import   diagnostic_lib
import   isotp
import   can
import   udsoncan
import   udsoncan.configs
from     udsoncan.connections import PythonIsoTpConnection
from     udsoncan.client      import Client
import   struct
import   yaml  
import   pdb


#udsoncan.setup_logging()


dtc_status_mask = 0x0D         #0x2F
bus = diagnostic_lib.canToolDefinition('PeakCan')

with open('modulesIdsFusion.yaml') as file:
   documents = yaml.full_load(file)
   for module, moduleContent in documents.items():
      moduleName = module
      moduleDescription = moduleContent.get('description')
      requestedData = moduleContent.get('requestedData')
      txId = moduleContent.get('request')
      rxId = moduleContent.get('response')
      print (' ----------------- Section:', moduleName, '-', moduleDescription, '-------------------')
      conn = diagnostic_lib.ecuConnection(txId, rxId, bus)

      with Client(conn, request_timeout=10) as client:                                     # Application layer (UDS protocol)
            for dataTypes, dataTypeContent in requestedData.items():
               if dataTypes == 'DTCs':
                  diagnostic_lib.getDTCs(client, dtc_status_mask, moduleName)
               elif dataTypes == 'DIDs':
                  for didNumber, didNumberContent in dataTypeContent.items():
                     diagnostic_lib.getDID(client, conn, moduleName, didNumber, didNumberContent)

print("********************************************************* completed  ********************************************")




