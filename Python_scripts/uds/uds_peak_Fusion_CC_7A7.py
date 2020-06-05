#this script can read Climate control module on Ford Fusion 2017. HS2. HS2+
# it requires python-uds
# user can select one of the options
# CC reqId = 0x7A7, resId = 0x7AF

#notes (open items):
# - when clearing DTCs the response recorded only grabs the first answer but sometimes there is a delay on the response,
# ecu DTC clear:  ['0x7f', '0x14', '0x78'], this is telling us the response will be delayed.
# the actual dtc clear confirmation came after that. 01 54 00 00 00 00 00 00 how to capture it?
# how to capture the DTCs?? this is the actual response? what to do when there is 
# -------> Ecu Read DTC Cmd ['0x19', '0x2', '0xd']
#-------> ecuResetResponse:  ['0x59', '0x2', '0xca', '0x90', '0x5a', '0x14', '0xa', '0x9a', '0x61', '0x15', '0xa', '0x9a', '0x69', '0x15', '0xa']

# Next steps:
# convert request services and responses to a more readable code.

# import the library
from uds import Uds
import pdb
import time
# this is the one being used on this example:
# https://python-uds.readthedocs.io/en/latest/interface.html
# https://github.com/richClubb/python-uds/blob/master/docs/interface.rst



#https://github.com/pylessard/python-udsoncan
#https://udsoncan.readthedocs.io/en/latest/


cc = Uds(reqId=0x7A7, resId=0x7AF, transportProtocol="CAN", interface="peak", device="PCAN_USBBUS1")
#time.sleep(0.5)

#pdb.set_trace()
while True:
    userChoice = input("Please select the service: \n\
                        sw = Read SW PN (0xF188) \n\
                        sn = Read Seria number (0xF18C \n\
                        d = DTC read \n\
                        c = DTC clear \n\
                        r = ecu reset\n\
                        x = exit the program \n\
                        your input: ")

    if userChoice == 'sn':
        #pdb.set_trace()
        ######################################################################
        # ecu Serial number
        ecuSerialNumberCmd = [0x22, 0xF1, 0x8C]
        try:
            ecuSerialNumberResponse = cc.send(ecuSerialNumberCmd) # gets the entire response from the ECU
            print("-------> Ecu Serial number Cmd", [hex(x) for x in ecuSerialNumberCmd])
            ecuSerialNumberResponse = ecuSerialNumberResponse[3:] # cuts the response down to just the serial number
            ecuSerialNumberResponseString = "" # initialises the string
            for i in ecuSerialNumberResponse: ecuSerialNumberResponseString += chr(i) # Iterates over each element and converts the array element into an ASCII string
            print("-------> ecu Serial number: ", ecuSerialNumberResponseString)
        except:
            print("-------> ECU serial Number Send did not complete/Response not received it")

    elif userChoice == 'sw':
        #pdb.set_trace()
        ######################################################################
        # ecu SW PN
        ecuSwPnCmd = [0x22, 0xF1, 0x88]
        try:
            ecuSwPnResponse = cc.send(ecuSwPnCmd) # gets the entire response from the ECU
            print("-------> Ecu Sw PN Cmd", [hex(x) for x in ecuSwPnCmd])
            #ecuSwPnResponseHex = [hex(x) for x in ecuSwPnResponse]
            ecuSwPnResponse = ecuSwPnResponse[3:] # cuts the response down to just the serial number
            ecuSwPnResponseString = "" # initialises the string
            for i in ecuSwPnResponse: ecuSwPnResponseString += chr(i) # Iterates over each element and converts the array element into an ASCII string
            print("-------> ecu SW PN: ", ecuSwPnResponseString)
            
        except:
            print("-------> ECU SW PN Send did not complete/Response not received it")

    elif userChoice == 'd':
        #pdb.set_trace()
        ######################################################################
        # ecu DTC Read
        ecuDtcReadCmd = [0x19, 0x02, 0x0D]
        try:
            ecuDtcReadResponse = cc.send(ecuDtcReadCmd) # gets the entire response from the ECU
            print("-------> Ecu Read DTC Cmd", [hex(x) for x in ecuDtcReadCmd])
            ecuDtcReadHex= [hex(x) for x in ecuDtcReadResponse]
            print("-------> ECU DTC read response: ", ecuDtcReadHex)
            
        except:
            print("-------> ECU DTC Read did not complete/Response not received it")

    elif userChoice == 'c':
        #pdb.set_trace()
        ######################################################################
        # ecu DTC Clear
        ecuDtcClearCmd = [0x14, 0xFF, 0xFF, 0xFF]
        try:
            ecuDtcClearResponse = cc.send(ecuDtcClearCmd) # gets the entire response from the ECU
            print("-------> Ecu Read DTC Cmd", [hex(x) for x in ecuDtcClearCmd])
            ecuDtcClearHex = [hex(x) for x in ecuDtcClearResponse]
            print("-------> ECU DTC Clear: ", ecuDtcClearHex)
            
        except:
            print("-------> ECU DTC Clear did not complete/Response not received it")

    elif userChoice == 'r':
        #pdb.set_trace()
        ######################################################################
        ## reset Cmd
        ecuResetCmd = [0x11, 0x01]  #the number of bytes needs to be removed, it is calculated by the lib
        try:
            ecuResetResponse = cc.send(ecuResetCmd) # gets the entire response from the ECU
            print("-------> Ecu Reset Cmd", [hex(x) for x in ecuResetCmd])
            ecuResetResponseHex = [hex(x) for x in ecuResetResponse]
            print("-------> ecu Reset Response: ", ecuResetResponseHex)
        
        except:
            print("-------> ECU reset Send did not complete/Response not received it")


    elif userChoice == 'x':
        print("program terminated by the user", userChoice)
        break

    else:
        print("wrong selection, select a valid quetion or x for exit")

