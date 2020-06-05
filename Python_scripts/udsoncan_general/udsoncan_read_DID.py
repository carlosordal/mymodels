# Script to read specific DIDs on SCCM Fusion.
# DE00 4 byte extract byte [2]  [0 1 2 3]
# DE01 4 byte. extract entire feedback
# documentation: https://udsoncan.readthedocs.io/en/latest/
# tested on vehicle 6/4/2020

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

#  ----------------- SCCM section -------------------
# SCCM 0xde00 0x6
# SCCM 0xde01 0xca207889
# done
# tested on 6/4/2020

import  diagnostic_lib
import  isotp
import  can
import  udsoncan
import  udsoncan.configs
from udsoncan.connections import PythonIsoTpConnection
from udsoncan.client import Client
import pdb
import struct

#from can.interfaces.pcan import PcanBus
#from udsoncan.Response import Response
#from udsoncan.exceptions import *
#from udsoncan.services import *
#from udsoncan import Dtc, DidCodec
class CodecTurnIndFlashCount(udsoncan.DidCodec):
   def encode(self, val):
      pdb.set_trace()   
      val = val # Do some stuff
      return struct.pack('>BBBB', val) # Little endian, 32 bit value

   def decode(self, payload):
      val = struct.unpack('>BBBB', payload)  # decode the 32 bits value
      return val[2]                        # Extract byte [2] Turn indictators count Flash on SCCM Fusion

   def __len__(self):
      return 4    # encoded paylaod is 4 byte long.

class CodecFourBytes(udsoncan.DidCodec):
   def encode(self, val):
      val = val & 0xFFFFFFFF # Do some stuff
      return struct.pack('>L', val) # Little endian, 32 bit value

   def decode(self, payload):
      val = struct.unpack('>L', payload)[0]  # decode the 32 bits value
      return val                        # Do some stuff (reversed)

   def __len__(self):
      return 4    # encoded paylaod is 4 byte long.

# class MyCompositeDidCodec(DidCodec):
#    def encode(self, IAC_pintle, rpm, pedalA, pedalB, EGR_duty):
#       pedal = (pedalA << 4) | pedalB
#       return struct.pack('>BHBB', IAC_pintle, rpm, pedal, EGR_duty)

#    def decode(self, payload):
#       vals = struct.unpack('>BHBB', payload)
#       return {
#          'IAC_pintle': vals[0],
#          'rpm'       : vals[1],
#          'pedalA'    : (vals[2] >> 4) & 0xF,
#          'pedalB'    : vals[2] & 0xF,
#          'EGR_duty'  : vals[3]
#       }

#    def __len__(self):
#       return 5


#udsoncan.setup_logging()
modules_ids = [['SCCM', 0x724, 0x72C]]

#HS2
# ['IPC', 0x720, 0x728],
# ['EFP', 0x7A7, 0x7AF]
# ['SCCM', 0x724, 0x72C]
# HS1
# ['SYNC3', 0x7D0, 0x7D8]
# ['BCM', 0x726, 0x72E]
# ['PCM', 0x7E0, 0x7E8]

config = dict(udsoncan.configs.default_client_config)
didList = { 0xDE00 : CodecTurnIndFlashCount,
            0xDE01 : CodecFourBytes}
# {0xDE00 : CodecFourBytes,
#             0xDE01 : CodecFourBytes}
config['data_identifiers'] = didList 
dtc_status_mask = 0x0D         #0x2F
bus = diagnostic_lib.canToolDefinition('PeakCan')   #'PeakCan'

#pdb.set_trace()

for i in range(len(modules_ids)):
    moduleName = modules_ids [i][0]
    txId = modules_ids [i][1]
    rxId = modules_ids [i][2]
    print (' -----------------', moduleName, 'section -------------------')
    conn = diagnostic_lib.ecuConnection(txId, rxId, bus)
    response = diagnostic_lib.getData(conn, moduleName, config, dtc_status_mask)
    #pdb.set_trace()
print('done')

