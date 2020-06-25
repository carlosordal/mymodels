# send one, mofified for Escape and PCAN and Neo Vi
# PCAN OK.
# NeoVI OK. CH1 125000:     bus = can.interface.Bus(bustype='neovi', channel= 1, bitrate=125000)
# NeoVI OK. CH2 125000:     bus = can.interface.Bus(bustype='neovi', channel= 1, bitrate=125000)
#!/usr/bin/env python
# coding: utf-8
# https://github.com/hardbyte/python-can/blob/8b76232e283c9fab05515d96cb6bc5b32d7d0684/examples/send_one.py

# PCAN configuration and NeoVi Trial on ESCAPE.
# FCIM 0x733 125,000
"""
This example shows how sending a single message works.
"""

from __future__ import print_function

import can

def send_one():

    # this uses the default configuration (for example from the config file)
    # see https://python-can.readthedocs.io/en/stable/configuration.html
    # bus = can.interface.Bus()

    # Using specific buses works similar:
    # bus = can.interface.Bus(bustype='socketcan', channel='vcan0', bitrate=250000)
    #bus = can.interface.Bus(bustype='pcan', channel='PCAN_USBBUS1', bitrate=125000)
    #bus = can.interface.Bus(bustype='neovi', channel= 1, bitrate=125000)
    #bus = can.interface.Bus(bustype='neovi', channel= 2, bitrate=125000)
    bus = can.Bus(interface='neovi', channel= 2, bitrate=125000)
    #    bus = can.interface.Bus(bustype='neovi', channel=2, bitrate=125000)
    # bus = can.interface.Bus(bustype='ixxat', channel=0, bitrate=250000)
    # bus = can.interface.Bus(bustype='vector', app_name='CANalyzer', channel=0, bitrate=250000)
    # ...


    msg = can.Message(arbitration_id=0x733,
                      data=[0x02, 0x11, 0x01, 0x0, 0x0, 0x0, 0x0, 0x0],
                      is_extended_id=False)

    try:
        bus.send(msg)
        print("Message sent on {}".format(bus.channel_info))
    except can.CanError:
        print("Message NOT sent")

if __name__ == '__main__':
    send_one()
