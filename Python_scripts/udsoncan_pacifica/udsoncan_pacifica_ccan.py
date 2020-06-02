# Initial trial for Pacifica vehicle ccan
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master


##$22	$F112	-	Chrysler Group Hardware Part Number
##$22	$F122	-	Chrysler Group Software Part Number
##$22	$F132	-	ECU Part Number
##$22	$F150	-	Hardware Version Information
##$22	$F151	-	Software Version Information
##$22	$F153	-	Boot Software Version Information
##$22	$F154	-	Hardware Supplier Identification
##$22	$F155	-	Software Supplier Identification
##$22	$F158	-	Vehicle Information
##$2E	$F15A	-	Write Software Fingerprint
##$22	$F15B	-	Read Software Fingerprint(s)
##$22	$F160	-	Software Module Information


# data service 0x0138	ECU Configuration 6 (Steering)




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

modules_ids = [['CBC', 0x620, 0x504],
                ['EBCM', 0x7E3, 0x7EB],
                ['ESC/BSMO', 0x7E4, 0x7EC],
                ['EPS_A', 0x75A, 0x4DA]]

# CBC network configuration:
# Modify vehicle network configuration with DASM = “present” and HaLF = “not present”
# https://docs.google.com/document/d/1tZSCQGaJg_CgytVrzcHAqjo9dL7jedC8bIh6SVK_IFI/edit#
# CBC configuration for redundant rack: ECU Configuration 6 Steering, A and B.
# https://docs.google.com/presentation/d/1xXU_2e0Jb2sIN8fmH5BWRzRI0YC6l_8_6l8TiR2tMFM/edit#slide=id.g5e2e757680_0_20
# EPS read PN: 0xF132 and decode: https://docs.google.com/presentation/d/1xXU_2e0Jb2sIN8fmH5BWRzRI0YC6l_8_6l8TiR2tMFM/edit#slide=id.g5e2e757680_0_39



udsoncan.setup_logging()
config = dict(udsoncan.configs.default_client_config)
config['data_identifiers'] = {
   0xF122 : udsoncan.AsciiCodec(10),
   0xF132 : udsoncan.AsciiCodec(10),
   0xF151 : udsoncan.AsciiCodec(15),
   0xF155 : udsoncan.AsciiCodec(15),
   0xF011 : udsoncan.AsciiCodec(15)
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
    'squash_stmin_requirement' : False # When sending, respect the stmin requirement of the receiver. If set to True, go as fast as possible.
}

bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 500000)

#########################################
################# CBC read and response
tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, modules_ids[0][1], modules_ids[0][2]) # Network layer addressing scheme
stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer

dtc_status_mask = 0x0D         #0x2F

with Client(conn, request_timeout=10, config=config) as client:                                     # Application layer (UDS protocol)

    #pdb.set_trace()
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
    #pdb.set_trace()
    response = client.read_data_by_identifier(0xF132)
    print(modules_ids[0][0], "PN (0xF132):", response.service_data.values[0xF132])
    response = client.read_data_by_identifier(0xF122)
    print(modules_ids[0][0], "SW PN (0xF122):", response.service_data.values[0xF122])
    response = client.read_data_by_identifier(0xF011)
    print(modules_ids[0][0], "SW PN (0xF122):", response.service_data.values[0xF011])
    # Sending 3 bytes : [b'22f011']
    # turned on.
    # 2020-06-01 15:38:13 [DEBUG] Connection: Received 11 bytes : [b'62f01180ce99c054000000']
    # turned off Half
    #[b'22f011']
    #2020-06-01 15:45:06 [DEBUG] Connection: Received 11 bytes : [b'62f01180ce994054000000']


#########################################
############### BSMO ID read and response
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
    response = client.read_data_by_identifier(0xF122)
    print(modules_ids[1][0], "SW PN (0xF18C):", response.service_data.values[0xF122])


#########################################
############### EBCM ID read and response
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
############### EPS_A read and response
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
##    response = client.read_data_by_identifier(0xF122)
##    print(modules_ids[3][0], "SW PN (0xF122):", response.service_data.values[0xF122])


