#this script reads the serial number and converts it to srting
# import the library
#intermitently work on Ford Fusion 2017
from uds import Uds
import pdb
import time


E400 = Uds(resId=0x7E8, reqId=0x7E0, transportProtocol="CAN", interface="peak", device="PCAN_USBBUS1")
time.sleep(0.5)
serialNumberRequest = [0x22, 0xF1, 0x8C]
try:
    serialNumberArray = E400.send(serialNumberRequest) # gets the entire response from the ECU
    #for i in serialNumberRequest: serialNumberRequest += hex(i)
    print("serial# request cmd: ", hex(serialNumberRequest[0]), hex(serialNumberRequest[1]), hex(serialNumberRequest[2]))  # This should be [0x3E, 0x00]
    print("serial# response: ", serialNumberArray)
    
except:
    print("Send did not complete/Response not received it")
if(serialNumberArray [0] == 0x7F):
    print("Negative response")
else:
    serialNumberArray = serialNumberArray[3:] # cuts the response down to just the serial number
    print("string shortened: ", serialNumberArray)
    serialNumberString = "" # initialises the string
    for i in serialNumberArray: serialNumberString += chr(i) # Iterates over each element and converts the array element into an ASCII string
    print("serial# ascii: ", serialNumberString) # prints the ASCII string
