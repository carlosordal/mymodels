# Read information requested on yaml file, depending on vehicle and DID decoder.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

# Next steps:
# dtc description for non existing DTCs B1A7D-01 BATTERY VOLTAGE
# # it needs to include Module Network on DTC report.
# avoid repeating SW PN DID definition
# convert it to app simulation and Peak CAN.
# Print DTC description from a different file List.
# Select network for report. if HS1 print out VIN#
# Create a file with Report. txt
# error handler for no tool connected.
# error handler for bus speed not correct.


import   diagnostic_lib
import   isotp
import   can
import ics
import   udsoncan
import   udsoncan.configs
from     udsoncan.connections import PythonIsoTpConnection
from     udsoncan.client      import Client
import   struct
import   yaml  
import   pdb


#udsoncan.setup_logging()


dtc_status_mask = 0x0D         #0x2F
bus = diagnostic_lib.canToolDefinition('PeakCan',500000)    #'neovi' 'PeakCan' 'Virtual'
# modulesIdsPacificaCcan
# 'modulesIdsPacificaLyftCtrl.yaml'
# 'modulesIdsPacificaIHS.ymal'
# 'modulesIdsFusion.yaml'
with open('modulesIdsPacificaCcan.yaml') as file:
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




