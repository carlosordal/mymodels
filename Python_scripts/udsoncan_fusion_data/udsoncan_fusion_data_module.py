# Read SW PN, Serial number of IPC and EFP on Ford fusion 2017 HS2 using Peak CAN tool.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 5/31/2020

# result on fusion SCCM conn removed and cabin temp sensor disconnected
##[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x209e055ba88>]
##IPC DTC 1  : C21200
##IPC  SW PN (0xF188): HS7T-14C026-HF
##IPC  Serial # (0xF18C): 63342001
##[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x209e054e188>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x209e054e148>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x209e0540ec8>]
##EFP DTC 1  : 905A14
##EFP DTC 2  : 9A6115
##EFP DTC 3  : 9A6915
##EFP  SW PN (0xF188): HS7T-14G121-DB
##EFP  Serial # (0xF18C): 0246-3406

##result when there are no DTCs:
##[]
##no IPC dtcs
##IPC SW PN (0xF188): HS7T-14C026-HF 
##IPC Serial # (0xF18C): 63342001       
##[]
##no EFP dtcs
##EFP SW PN (0xF188): HS7T-14G121-DB 
##EFP Serial # (0xF18C): 0246-3406  

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

modules_ids = [['IPC', 0x720, 0x728],
              ['EFP', 0x7A7, 0x7AF]]

#udsoncan.setup_logging()
config = dict(udsoncan.configs.default_client_config)
config['data_identifiers'] = {
   0xF188 : udsoncan.AsciiCodec(15),
   0xF18C : udsoncan.AsciiCodec(15)
   }

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

bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)

# IPC read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[0][1], modules_ids[0][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer

dtc_status_mask = 0x0D         #0x2F

with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0: 
        print("no", modules_ids[0][0],  "dtcs")
    #pdb.set_trace()
    else: # len(response.service_data.dtcs) == 1:
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[0][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF188)
    print(modules_ids[0][0], "SW PN (0xF188):", response.service_data.values[0xF188])
    response = client.read_data_by_identifier(0xF18C)
    print(modules_ids[0][0], "Serial # (0xF18C):", response.service_data.values[0xF18C])



# EFP ID read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[1][1], modules_ids[1][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer


with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0:
        print("no", modules_ids[1][0],  "dtcs")

    else: 
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[1][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF188)
    print(modules_ids[1][0], "SW PN (0xF188):", response.service_data.values[0xF188])
    response = client.read_data_by_identifier(0xF18C)
    print(modules_ids[1][0], "Serial # (0xF18C):", response.service_data.values[0xF18C])




##        (Pdb)  	client.ecu_reset(0x01)
##2020-05-31 15:39:57 [INFO] UdsClient: ECUReset<0x11> - Requesting reset of type 0x01 (hardReset)
##2020-05-31 15:39:57 [DEBUG] Connection: Sending 2 bytes : [b'1101']
##2020-05-31 15:39:57 [DEBUG] Connection: Received 2 bytes : [b'5101']
##2020-05-31 15:39:57 [INFO] UdsClient: Received positive response for service ECUReset (0x11) from server.
##<PositiveResponse: [ECUReset] - 1 data bytes at 0x1d87177ca48>

# disconecting temp sensor and reading dtcs:
##(Pdb) response = client.get_dtc_by_status_mask(status_mask)
##2020-05-31 15:31:34 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
##2020-05-31 15:31:34 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
##2020-05-31 15:31:34 [DEBUG] Connection: Received 11 bytes : [b'5902ca9a61150a9a69150a']
##2020-05-31 15:31:34 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
##
##        (Pdb) client.clear_dtc(0xFFFFFF)
##2020-05-31 15:44:03 [INFO] UdsClient: ClearDiagnosticInformation<0x14> - Clearing all DTCs (group mask : 0xFFFFFF)
##2020-05-31 15:44:03 [DEBUG] Connection: Sending 4 bytes : [b'14ffffff']
##2020-05-31 15:44:04 [DEBUG] Connection: Received 3 bytes : [b'7f1478']
##2020-05-31 15:44:04 [DEBUG] Connection: Received 1 bytes : [b'54']
##2020-05-31 15:44:04 [INFO] UdsClient: Received positive response for service ClearDiagnosticInformation (0x14) from server.
##<PositiveResponse: [ClearDiagnosticInformation] - 0 data bytes at 0x1d87178d288>
##(Pdb)

##(Pdb) response = client.get_dtc_by_status_mask(status_mask)
##2020-05-31 15:44:28 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
##2020-05-31 15:44:28 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
##2020-05-31 15:44:28 [DEBUG] Connection: Received 3 bytes : [b'5902ca']
##2020-05-31 15:44:28 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
##(Pdb)         
