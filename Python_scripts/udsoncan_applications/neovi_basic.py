#neovi and PeakTool testing.
# neovi wasn't receiving feedback


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
bus = diagnostic_lib.canToolDefinition('neovi')
# modulesIdsPacificaCcan
# 'modulesIdsPacificaLyftCtrl.yaml'
# 'modulesIdsPacificaIHS.ymal'
# 'modulesIdsFusion.yaml'

moduleName = 'CC'
moduleDescription = 'Climate Control'
txId = 0x733
rxId = 0x73B
print (' ----------------- Section:', moduleName, '-', moduleDescription, '-------------------')
conn = diagnostic_lib.ecuConnection(txId, rxId, bus)
didNumber = 0xF188

with Client(conn, request_timeout=10) as client:                                     # Application layer (UDS protocol)
    # for dataTypes, dataTypeContent in requestedData.items():
    #     if dataTypes == 'DTCs':
    diagnostic_lib.getDTCs(client, dtc_status_mask, moduleName)
        # elif dataTypes == 'DIDs':
        #     for didNumber, didNumberContent in dataTypeContent.items():
    #diagnostic_lib.getDID(client, conn, moduleName, didNumber, didNumberContent)
    #response = client.ecu_reset(0x01)

print("********************************************************* completed  ********************************************")




