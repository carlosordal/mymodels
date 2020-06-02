# Initial trial for Pacifica vehicle lyftctrl
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master




import udsoncan
import isotp
import can
from can.interfaces.pcan import PcanBus
from udsoncan.connections import PythonIsoTpConnection
from udsoncan.client import Client


from udsoncan.Response import Response
from udsoncan.exceptions import *
from udsoncan.services import *
from udsoncan import Dtc, DidCodec
import udsoncan.configs

import pdb
import struct

modules_ids = [['DASM', 0x753, 0x4D3],
                ['EPS_B', 0x75A, 0x4DA],
                ['HaLF', 0x764, 0x4E4],
                ['PTS', 0x762, 0x4E2]]


udsoncan.setup_logging()
config = dict(udsoncan.configs.default_client_config)
config['data_identifiers'] = {
   0xF122 : udsoncan.AsciiCodec(10),
   0xF132 : udsoncan.AsciiCodec(10),
   0xF151 : udsoncan.AsciiCodec(15),
   0xF155 : udsoncan.AsciiCodec(15)
   }

# CAN connetion Tx and Rx IDs.
# Refer to isotp documentation for full details about parameters
isotp_params = {
    'stmin' : 32,                          # Will request the sender to wait 32ms between consecutive frame. 0-127ms or 100-900ns with values from 0xF1-0xF9
    'blocksize' : 8,                       # Request the sender to send 8 consecutives frames before sending a new flow control message
    'wftmax' : 0,                          # Number of wait frame allowed before triggering an error
    'll_data_length' : 8,                  # Link layer (CAN layer) works with 8 byte payload (CAN 2.0)
    'tx_padding' : 0,                      # Will pad all transmitted CAN messages with byte 0x00. None means no padding
    'rx_flowcontrol_timeout' : 1000,        # Triggers a timeout if a flow control is awaited for more than 1000 milliseconds
    'rx_consecutive_frame_timeout' : 1000, # Triggers a timeout if a consecutive frame is awaited for more than 1000 milliseconds
    'squash_stmin_requirement' : False     # When sending, respect the stmin requirement of the receiver. If set to True, go as fast as possible.
}

bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)

#########################################
################# DASM read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[0][1], modules_ids[0][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer

dtc_status_mask = 0x0D         #0x2F

with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0: 
        print("no", modules_ids[0][0],  "dtcs")
    #pdb.set_trace()
    else: # len(response.service_data.dtcs) == 1:
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[0][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF132)
    print(modules_ids[0][0], "PN (0xF132):", response.service_data.values[0xF132])
##    response = client.read_data_by_identifier(0xF122) # double response
##    print(modules_ids[0][0], "Serial # (0xF122):", response.service_data.values[0xF122])


#########################################
############### EPS_B ID read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[1][1], modules_ids[1][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer


with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0:
        print("no", modules_ids[1][0],  "dtcs")

    else: 
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[1][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF132)
    print(modules_ids[1][0], "PN (0xF132):", response.service_data.values[0xF132])
##    response = client.read_data_by_identifier(0xF122) #not able to manage negative response
##    print(modules_ids[1][0], "Serial # (0xF122):", response.service_data.values[0xF122])


#########################################
############### Half ID read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[2][1], modules_ids[2][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer


with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0:
        print("no", modules_ids[2][0],  "dtcs")

    else: 
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[2][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF132)
    print(modules_ids[2][0], "PN (0xF132):", response.service_data.values[0xF132])
    response = client.read_data_by_identifier(0xF122)
    print(modules_ids[2][0], "SW PN (0xF122):", response.service_data.values[0xF122])


#########################################
############### PTS read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[3][1], modules_ids[3][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer


with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)


    response = client.get_dtc_by_status_mask(dtc_status_mask)
    #pdb.set_trace()
    print(response.service_data.dtcs)        # Will print an array of object
    #pdb.set_trace()
    # if response.serice_data.dtcs is empty print no DTCs
    if len(response.service_data.dtcs) == 0:
        print("no", modules_ids[3][0],  "dtcs")

    else: 
        index = 0
        for dtc in response.service_data.dtcs:
            #pdb.set_trace()
            index = index + 1
            print(modules_ids[3][0], "DTC", index,": %06X" % dtc.id )         # Print the DTC number
    # read DIDs
    response = client.read_data_by_identifier(0xF132)
    print(modules_ids[3][0], "PN (0xF132):", response.service_data.values[0xF132])
    response = client.read_data_by_identifier(0xF122)
    print(modules_ids[3][0], "SW PN (0xF122):", response.service_data.values[0xF122])

