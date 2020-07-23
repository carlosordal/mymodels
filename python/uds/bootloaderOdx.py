import uds
from uds import Uds
import pdb

if __name__ == "__main__":

# This creates an Uds object from the Bootloader.odx file
    odxEcu = uds.createUdsConnection("Bootloader.odx", "", inteface="peak")

    # This sends a request for Ecu Serial number and stores the result
##    esn = odxEcu.readDataByIdentifier("ECU Serial Number")
##    pdb.set_trace()
##    # This will be the printed ASCII string
##    print(esn)
##    pdb.set_trace()
    # This creates a Uds object manually
    rawEcu = Uds(reqId=0x7E0, resId=0x7E8, interface="peak")
    pdb.set_trace()
    # This sends the request for Ecu Serial Number
    esnRaw = rawEcu.send([0x22, 0xF1, 0x8C])

    # This prints the raw payload returned from the ECU
    print(esnRaw)
