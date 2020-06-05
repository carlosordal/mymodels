# Script to read specific DIDs.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

# SCCM DE001 Read results:
# SCCM 0xde00 0x200600
# SCCM 0xde01 0xca207889
# done

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
class CodecFourBytes(udsoncan.DidCodec):
   def encode(self, val):
      pdb.set_trace()   
      val = val & 0xFFFFFFFF # Do some stuff
      return struct.pack('>L', val) # Little endian, 32 bit value

   def decode(self, payload):
      val = struct.unpack('>L', payload)[0]  # decode the 32 bits value
      return val                        # Do some stuff (reversed)

   def __len__(self):
      return 4    # encoded paylaod is 4 byte long.


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
didList = {0xDE00 : CodecFourBytes,
            0xDE01 : CodecFourBytes}
# 0xDE00 : udsoncan.DidCodec('<B') = error 0x2006 
# 0xDE00 : udsoncan.DidCodec('<H') = error 0x0600
# 0xDE00 : udsoncan.DidCodec('<I') = SCCM 0xde00 (401408,)
# 0xDE00 : udsoncan.DidCodec('<L') = SCCM 0xde00 (2098688,)
# 0xDE00 : udsoncan.AsciiCodec(4) # this one converted the DID data into ascii data
#           0xF190 : udsoncan.AsciiCodec(17),
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

