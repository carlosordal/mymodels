# Basic transmission with python-can
# https://github.com/pylessard/python-can-isotp/blob/master/doc/source/isotp/examples.rst
# tested on fusion not working yet 5/29

import isotp
import logging
import time
import can

from can.interfaces.pcan import PcanBus

def my_error_handler(error):
   logging.warning('IsoTp error happened : %s - %s' % (error.__class__.__name__, str(error)))

#bus = PcanBus(channel='PCAN_USBBUS1', bitrate=500000)
bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)
addr = isotp.Address(isotp.AddressingMode.Normal_11bits, rxid=0x123, txid=0x456)

stack = isotp.CanStack(bus, address=addr, error_handler=my_error_handler)
stack.send(b'Hello, this is a long payload sent in small chunks')

while stack.transmitting():
   stack.process()
   time.sleep(stack.sleep_time())

print("Payload transmission done.")

bus.shutdown()
