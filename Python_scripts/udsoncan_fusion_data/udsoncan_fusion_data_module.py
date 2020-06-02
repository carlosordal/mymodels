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

import udsoncan
import isotp
import can
from can.interfaces.pcan import PcanBus
from udsoncan.connections import PythonIsoTpConnection
from udsoncan.client import Client


from udsoncan.Response import Response
from udsoncan.exceptions import *
from udsoncan.services import *
from udsoncan import Dtc, DidCodec
import udsoncan.configs

import pdb
import struct




def canToolDefinition(canHw):
    if canHw == 'PeakCan':
        bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)
    elif canHw == 'Virtual':
        bus = can.interface.Bus('test', bustype='virtual')
    return bus



def ecuConnection(txId, rxId):  
    # CAN connetion Tx and Rx IDs.
    # Refer to isotp documentation for full details about parameters
    isotp_params = {
        'stmin' : 32,                          # Will request the sender to wait 32ms between consecutive frame. 0-127ms or 100-900ns with values from 0xF1-0xF9
        'blocksize' : 8,                       # Request the sender to send 8 consecutives frames before sending a new flow control message
        'wftmax' : 0,                          # Number of wait frame allowed before triggering an error
        'll_data_length' : 8,                  # Link layer (CAN layer) works with 8 byte payload (CAN 2.0)
        'tx_padding' : 0,                      # Will pad all transmitted CAN messages with byte 0x00. None means no padding
        'rx_flowcontrol_timeout' : 1000,        # Triggers a timeout if a flow control is awaited for more than 1000 milliseconds
        'rx_consecutive_frame_timeout' : 1000, # Triggers a timeout if a consecutive frame is awaited for more than 1000 milliseconds
        'squash_stmin_requirement' : False     # When sending, respect the stmin requirement of the receiver. If set to True, go as fast as possible.
    }
    tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, txId, rxId) # Network layer addressing scheme
    stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
    conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer
    return conn

def getData(conn, moduleName, config):
    with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)
        didList = config['data_identifiers']
        response = client.get_dtc_by_status_mask(dtc_status_mask)
        #print(response.service_data.dtcs)              # Will print an array of object: [<DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x1d608854388>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x1d6088541c8>]  
        if len(response.service_data.dtcs) == 0:        # if response.serice_data.dtcs is empty print no DTCs
            print("no", moduleName,  "dtcs")
        else: 
            index = 0
            for dtc in response.service_data.dtcs:
                index = index + 1
                print(moduleName, "DTC", index,": %06X" % dtc.id )         # Print the DTC number
        # read DIDs list
        for k, v in didList.items():
            #print(hex(k))
            response = client.read_data_by_identifier(k)
            print(moduleName, hex(k), response.service_data.values[k])



#udsoncan.setup_logging()
modules_ids = [['IPC', 0x720, 0x728],
              ['EFP', 0x7A7, 0x7AF]]

config = dict(udsoncan.configs.default_client_config)
didList = {0xF188 : udsoncan.AsciiCodec(15),
           0xF18C : udsoncan.AsciiCodec(15)}

config['data_identifiers'] = didList 

dtc_status_mask = 0x0D         #0x2F
bus = canToolDefinition('PeakCan')

#pdb.set_trace()

for i in range(len(modules_ids)):
    moduleName = modules_ids [i][0]
    txId = modules_ids [i][1]
    rxId = modules_ids [i][2]
    print (' -----------------', moduleName, 'section -------------------')
##    print ('Tx Id:', hex(txId))
##    print ('Rx Id:', hex(rxId))
    conn = ecuConnection(txId, rxId)
    getData(conn, moduleName, config)



