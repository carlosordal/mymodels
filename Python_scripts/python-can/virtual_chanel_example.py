# python-can virtual channel test.
# the comparison was modified from original example. since
# tested on windows.
# msg1 and msg2 have diferentt time stamp and we want to compare only the data.
# msg1 = can.Message(timestamp=0.0,                 arbitration_id=0xabcde, extended_id=True,                   dlc=3, data=[0x1, 0x2, 0x3])
# msg2 = can.Message(timestamp=1590968886.1914701,  arbitration_id=0xabcde, extended_id=True, channel='test',   dlc=3, data=[0x1, 0x2, 0x3])
# https://python-can.readthedocs.io/en/master/interfaces/virtual.html

import can
import pdb

bus1 = can.interface.Bus('test', bustype='virtual')
bus2 = can.interface.Bus('test', bustype='virtual')

msg1 = can.Message(arbitration_id=0xabcde, data=[1,2,3])
bus1.send(msg1)
msg2 = bus2.recv()

message1 = ('msg1, id: ', msg1.arbitration_id, '; data: ', msg1.data)
message2 = ('msg2, id: ', msg2.arbitration_id, '; data: ', msg2.data)
print(message1)
print(message2)
if message1 == message2:
    print('comparison: data received is equal to data sent')

#pdb.set_trace()
assert msg1.data == msg2.data
