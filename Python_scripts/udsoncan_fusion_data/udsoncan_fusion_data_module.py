# Read SW PN, Serial number of IPC and EFP on Ford fusion 2017 HS2 using Peak CAN tool.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

# Next steps:
# convert it to app simulation and Peak CAN.
# Decode DTC
# Print DTC description from a different file List.
# Select network for report. if HS1 print out VIN#
# Create a file with Report. txt
# 

# result on fusion DTCs induced. 
#  ----------------- IPC section -------------------
# IPC DTC 1 U0212-00
# IPC 0xf188 HS7T-14C026-HF
#  ----------------- EFP section -------------------
# EFP DTC 1 B1A61-15
# EFP DTC 2 B1A69-15
# EFP 0xf188 HS7T-14G121-DB
#  ----------------- SCCM section -------------------
# no SCCM dtcs
# SCCM 0xf188 G3GT-14C579-AB
# SCCM 0xde00 0x6
# ********************************************************* completed  ********************************************

import   diagnostic_lib
import   isotp
import   can
import   udsoncan
import   udsoncan.configs
from     udsoncan.connections import PythonIsoTpConnection
from     udsoncan.client      import Client
import   struct
import   pdb


#udsoncan.setup_logging()

modules_ids = [   ['IPC', 0x720, 0x728],
                  ['EFP', 0x7A7, 0x7AF],
                  ['SCCM', 0x724, 0x72C]
               ]

class CodecEightBytes(udsoncan.DidCodec):
   def encode(self, val):
      val = val & 0xFFFFFFFF # Do some stuff
      return struct.pack('>Q', val) # Little endian, 32 bit value

   def decode(self, payload):
      val = struct.unpack('>Q', payload)[0]  # decode the 32 bits value
      return val                        # Do some stuff (reversed)

   def __len__(self):
      return 8    # encoded paylaod is 4 byte long.

config = dict(udsoncan.configs.default_client_config)
didList = {0xF188 : udsoncan.AsciiCodec(15)
            }

#            0xF18C : udsoncan.AsciiCodec(15) removeed since SCCM respond with different format.
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

print("********************************************************* completed  ********************************************")




