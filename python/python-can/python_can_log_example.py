# send a message
# Fusion 2017, FCIM ecu reset on HS2.
# import the library
import can


# create a bus instance
# many other interfaces are supported as well (see below)
bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.PASSIVE,
                bitrate = 500000)

# send a message
# Fusion 2017, FCIM ecu reset on HS2.
message = can.Message(arbitration_id=0x7A7, is_extended_id=False, is_fd_=False,
                      data=[0x02,0x11, 0x01, 0x0, 0x0, 0x0, 0x0, 0x0])
bus.send(message)

# iterate over received messages
for msg in bus:
    print("{:X}: {}".format(msg.arbitration_id, msg.data))

# or use an asynchronous notifier
notifier = can.Notifier(bus, [can.Logger("recorded.log"), can.Printer()])
