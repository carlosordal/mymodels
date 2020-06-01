# Note that, in order to run this code, both ``python-can`` and ``can-isotp`` must be installed.
# repo: https://github.com/pylessard/python-udsoncan/blob/master/README.rst
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 5/29/2020


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



#from test.ClientServerTest import ClientServerTest
import struct



udsoncan.setup_logging()

status_mask = 0x0D         #0x2F

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




with Client(conn, request_timeout=10) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(status_mask)
    print(response.service_data.dtcs)        # Will print an array of object
    for dtc in response.service_data.dtcs:
        print("DTC : %06X" % dtc.id )         # Print the DTC number
