# This code Read DTCs, SW PN, Serial number of Climate control on ford fusion 2017
# HW peak CAN USD
# OBDII HS2
# the intention is to use it as a base to read information on pacifica.


import pdb
import udsoncan
from can.interfaces.vector import VectorBus
from udsoncan.client import Client


from udsoncan.Response import Response
from udsoncan.exceptions import *
from udsoncan.services import *
from udsoncan import Dtc, DidCodec




#from test.ClientServerTest import ClientServerTest
import struct

import isotp
import can
from can.interfaces.pcan import PcanBus
#from udsoncan.Connection import IsoTPConnection
from udsoncan.connections import PythonIsoTpConnection
#from udsoncan.connections import IsoTPSocketConnection
from udsoncan.client import Client
import udsoncan.configs

udsoncan.setup_logging()

class MyCustomCodecThatShiftBy4(udsoncan.DidCodec):
   def encode(self, val):
      val = (val << 4) & 0xFFFFFFFF # Do some stuff
      return struct.pack('<L', val) # Little endian, 32 bit value

   def decode(self, payload):
      val = struct.unpack('<L', payload)[0]  # decode the 32 bits value
      return val >> 4                        # Do some stuff (reversed)

   def __len__(self):
      return 4    # encoded paylaod is 4 byte long.


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

#bus = VectorBus(channel=0, bitrate=500000)                                          # Link Layer (CAN protocol)
#bus = can.interface.Bus('test', bustype='virtual')
bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)

tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, txid=0x7A7, rxid=0x7AF) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)

#conn = IsoTPConnection('vcan0', rxid=0x123, txid=0x456)
with Client(conn,  request_timeout=2, config=config) as client:
   response = client.read_data_by_identifier(0xF188)
   print(response.service_data.values[0xF188]) # This is a dict of DID:Value
   #this print ascii: HS7T-14G121-DB
   # raw: Received 27 bytes : [b'62f188485337542d3134473132312d444200000000000000000000']
   #pdb.set_trace()
   response = client.read_data_by_identifier(0xF18C)
   print(response.service_data.values[0xF18C]) # this print ascii 0246-3406
   # raw: [b'62f18c303234362d3334303600000000000000']
   pdb.set_trace()
   # Or, if a single DID is expected, a shortcut to read the value of the first DID

   vin = client.read_data_by_identifier_first(0xF188)
   print(vin)  # 'ABCDE0123456789' (15 chars)
   serial = client.read_data_by_identifier_first(0xF18C)
   print(serial)
