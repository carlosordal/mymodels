# Note that, in order to run this code, both ``python-can`` and ``can-isotp`` must be installed.
# repo: https://github.com/pylessard/python-udsoncan/blob/master/README.rst
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 5/31/2020


import udsoncan
import isotp
import can
#from can.interfaces.vector import VectorBus
from can.interfaces.pcan import PcanBus
from udsoncan.connections import PythonIsoTpConnection
from udsoncan.client import Client


from udsoncan.Response import Response
from udsoncan.exceptions import *
from udsoncan.services import *
from udsoncan import Dtc, DidCodec

import pdb


#from test.ClientServerTest import ClientServerTest
import struct



udsoncan.setup_logging()


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

#bus = VectorBus(channel=0, bitrate=500000)                                          # Link Layer (CAN protocol)
bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)


tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, txid=0x7A7, rxid=0x7AF) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer
status_mask = 0x0D         #0x2F



with Client(conn, request_timeout=10) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(status_mask)
    #    def ecu_reset(self, reset_type):
    # def clear_dtc(self, group=0xFFFFFF):
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0:
        print("no dtcs")
    
    for dtc in response.service_data.dtcs:
        #pdb.set_trace()
        print("DTC : %06X" % dtc.id )         # Print the DTC number


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
