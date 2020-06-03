# Read SW PN, Serial number of IPC and EFP on Ford fusion 2017 HS2 using Peak CAN tool.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs

# result on fusion SCCM conn removed and cabin temp sensor disconnected
## ----------------- IPC section -------------------
##IPC DTC 1 : C21200
##IPC 0xf188 HS7T-14C026-HF
##IPC 0xf18c 63342001
## ----------------- EFP section -------------------
##EFP DTC 1 : 9A6115
##EFP DTC 2 : 9A6915
##EFP 0xf188 HS7T-14G121-DB
##EFP 0xf18c 0246-3406

##result when there are no DTCs:
##no IPC dtcs
##IPC 0xf188 HS7T-14C026-HF
##IPC 0xf18c 63342001
## ----------------- EFP section -------------------
##no EFP dtcs
##EFP 0xf188 HS7T-14G121-DB
##EFP 0xf18c 0246-3406

import  diagnostic_lib
import  isotp
import  can
import  udsoncan
import  udsoncan.configs
from    udsoncan.connections 	import PythonIsoTpConnection
from    udsoncan.client 		import Client
import  pdb


#from can.interfaces.pcan import PcanBus
#from udsoncan.Response import Response
#from udsoncan.exceptions import *
#from udsoncan.services import *
#from udsoncan import Dtc, DidCodec

#udsoncan.setup_logging()
modules_ids = [['IPC', 0x720, 0x728],
              ['EFP', 0x7A7, 0x7AF]]

config = dict(udsoncan.configs.default_client_config)
didList = {0xF188 : udsoncan.AsciiCodec(15),
           0xF18C : udsoncan.AsciiCodec(15)}

config['data_identifiers'] = didList 

dtc_status_mask = 0x0D         #0x2F
bus = diagnostic_lib.canToolDefinition('PeakCan')

#pdb.set_trace()

for i in range(len(modules_ids)):
    moduleName = modules_ids [i][0]
    txId = modules_ids [i][1]
    rxId = modules_ids [i][2]
    print (' -----------------', moduleName, 'section -------------------')
    conn = diagnostic_lib.ecuConnection(txId, rxId, bus)
    diagnostic_lib.getData(conn, moduleName, config, dtc_status_mask)



