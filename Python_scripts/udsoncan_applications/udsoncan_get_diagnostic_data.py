# Read information requested on yaml file, depending on vehicle and DID decoder.
# HW Connection: Tested with Peak CAN tool. 1 CAN channel.
# - An special OBD cable is needed with DB9 connections, for CCAN and IHS connections.
#
# Inputs:   1) module_list - yaml File that contains ECUs Request and Response Ids, data requested, DID decode data. 
#           2) dtc_list    - csv File that contains the dtc list and subtype description. (empty rows are not allowed)
#           3) can_network - Select CAN bus - 'ccan' or 'ihs'
# Outpus:   1) DTC, DID, report
# 
# Next steps:
# fix EPS_A B redundant rack response.
# is DTC active or stored?
# stop program if inputs are not known
# convert this code into a function
# improve the way longer DID responses are decoded/processed, each diff size requires to modify the code. like 6
# change logic for EPS_B SW part number read. for DID#
# create a function to get DTC description, and subtype description to call it twice


# avoid repeating SW PN DID definition 0xF132 or 0xF188 or 0xF190
# convert it to app simulation and Peak CAN.

# Create a file with Report. txt
# error handler for no tool connected.
# error handler for bus speed not correct.

# create a list of requirements. udsoncan, yaml
# remove imports on main file if those are not needed.

# README:
# 1. you gotta use python 3.6 and up
# 2. you gotta pip install -r requirements.txt
# 3. usage is python dbcParser <Name Of DBC> = 'file.dbc'

# Requirements:
# cantools==32.20.0
# pyyaml==5.1.1


import   diagnostic_lib
import   udsoncan
from     udsoncan.client      import Client
import   yaml  
import   sys
import   pdb

# arguments example on Escape: 'modulesIdsMSEscape.yaml' 'pacifica_dtc_list.csv' 'ihs'
# 'modulesIdsPacificaObd2CcanEpt.yaml'
# 'modulesIdsPacificaCcan.yaml'
# 'modulesIdsPacificaLyftCtrl.yaml'
# 'modulesIdsPacificaIHS.ymal'
# 'modulesIdsFusion.yaml'
# 'modulesIdsMSEscape.yaml'

udsoncan.setup_logging()
#with arguments
# moduleList = sys.argv[1]
# dtcsFile = sys.argv[2]
# canNetwork = sys.argv[3]

# without argument VS Code
moduleList = 'modulesIdsPacificaLyftCtrl.yaml'
dtcsFile = 'pacifica_dtc_list.csv'
canNetwork = 'lyftctrl'

# open_file = open(dtcsFile)
# csv_file = csv.reader(open_file)

#assign baudrate
if canNetwork == 'ccan':
   baudrate = 500000
elif canNetwork == 'lyftctrl':
   baudrate = 500000
elif canNetwork == 'ept':
   baudrate = 500000
elif canNetwork == 'ihs':
   baudrate = 125000
else:
   print('Application stopped. Unknown network. Options are ccan, ihs, ept')
   sys.exit()


dtc_status_mask = 0x0D         #0x2F
#pdb.set_trace()
bus = diagnostic_lib.canToolDefinition('PeakCan',baudrate)    #'neovi' 'PeakCan' 'Virtual'

print('**************Report created with, Modules File: ', moduleList, 'DTCs file: ', dtcsFile, 'network:', canNetwork)
with open(moduleList) as file:
   documents = yaml.full_load(file)
   for module, moduleContent in documents.items():
      moduleName = module
      moduleDescription = moduleContent.get('description')
      requestedData = moduleContent.get('requestedData')
      txId = moduleContent.get('request')
      rxId = moduleContent.get('response')
      network = moduleContent.get('network')

      print(' ----------------- Section:', moduleName, '-', moduleDescription, 'on', network, 'network -------------------')
      conn = diagnostic_lib.ecuConnection(txId, rxId, bus)

      with Client(conn, request_timeout=10) as client:                                     # Application layer (UDS protocol)
            for dataTypes, dataTypeContent in requestedData.items():
               if dataTypes == 'DTCs':
                  diagnostic_lib.getDTCs(client, dtc_status_mask, moduleName, dtcsFile)
               elif dataTypes == 'DIDs':
                  for didNumber, didNumberContent in dataTypeContent.items():
                     diagnostic_lib.getDID(client, conn, moduleName, didNumber, didNumberContent)

print("********************************************************* completed  ********************************************")




