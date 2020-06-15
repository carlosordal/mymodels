# diagnostic_lib


import  isotp
import  can
import  udsoncan
import  udsoncan.configs
from    udsoncan.connections import PythonIsoTpConnection
from    udsoncan.client import Client
import  pdb
import  struct


def canToolDefinition(canHw):
    if canHw == 'PeakCan':
        bus = can.Bus(interface = 'pcan',
                channel = 'PCAN_USBBUS1',
                state = can.bus.BusState.ACTIVE,
                bitrate = 125000)
    elif canHw == 'Virtual':
        bus = can.interface.Bus('test', bustype='virtual')
    return bus



def ecuConnection(txId, rxId, bus):  
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
    tp_addr = isotp.Address(isotp.AddressingMode.Normal_11bits, txId, rxId) # Network layer addressing scheme
    stack = isotp.CanStack(bus=bus, address=tp_addr, params=isotp_params)               # Network/Transport layer (IsoTP protocol)
    conn = PythonIsoTpConnection(stack)                                                 # interface between Application and Transport layer
    return conn

def dtcHexToJ2012Conversion(dtcIdNumber):
    dtcBinary = format(dtcIdNumber, '024b')
    #'1001 1010 0110 0001 0001 0101'
    firstCharacter  = dtcBinary[0:2]
    if firstCharacter == '00':
        char1 = "P"
    elif firstCharacter == '01':    
        char1 = "C"
    elif firstCharacter == '10':
        char1 = "B"
    elif firstCharacter == '11':
        char1 = "U"
    
    secondCharacter = dtcBinary[2:4]
    char2 = str(int(secondCharacter,2))
    
    thirdCharacter  = dtcBinary[4:8]
    char3 = format(int(thirdCharacter,2),'X')
    
    fourthCharacter = dtcBinary[8:12]
    char4 = format(int(fourthCharacter,2),'X')
    
    fifthCharacter  = dtcBinary[12:16]
    char5 = format(int(fifthCharacter,2),'X')
    
    sixthCharacter  = dtcBinary[16:20]
    char6 = format(int(sixthCharacter,2),'X')
    
    seventhCharacter  = dtcBinary[20:24]
    char7 = format(int(seventhCharacter,2),'X')
    
    dtcJ2012Code  = char1 + char2 + char3 + char4 +char5 + "-" + char6 + char7
    return dtcJ2012Code



def getDTCs(client, dtc_status_mask, moduleName):
    try:
        response = client.get_dtc_by_status_mask(dtc_status_mask)
            #print(response.service_data.dtcs)              # Will print an array of object: [<DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x1d608854388>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x1d6088541c8>]  
        if len(response.service_data.dtcs) == 0:        # if response.serice_data.dtcs is empty print no DTCs
            print("no", moduleName,  "dtcs")
        else: 
            index = 0
            for dtc in response.service_data.dtcs:
                index = index + 1
                dtcJ2012Code = dtcHexToJ2012Conversion (dtc.id)
                print(moduleName, "DTC", index, ':', dtcJ2012Code)         # Print the HEX DTC number
    except:
        print(moduleName, 'Not found')
    


def getDID(client, conn, moduleName, didNumber, didNumberContent):
    try:
        class CodecTwoBytes(udsoncan.DidCodec):
            def encode(self, val): 
                val = val # Do some stuff
                return struct.pack('>H', val) # 2 Bytes

            def decode(self, payload):
                val = struct.unpack('H', payload)[0]  # decode the 32 bits value
                return val                        

            def __len__(self):
                return 2    # encoded paylaod is 2 byte long.

        class CodecFourBytes(udsoncan.DidCodec):
            def encode(self, val): 
                val = val # Do some stuff
                return struct.pack('>L', val) # 4 Bytes, 32 bits

            def decode(self, payload):
                val = struct.unpack('>L', payload)[0]  # decode the 32 bits value
                return val                        

            def __len__(self):
                return 4    # encoded paylaod is 4 byte long.
        
        class CodecEightBytes(udsoncan.DidCodec):
            def encode(self, val): 
                val = val # Do some stuff
                return struct.pack('>Q', val) # 4 Bytes, 32 bits

            def decode(self, payload):
                val = struct.unpack('>Q', payload)[0]  # decode the 32 bits value
                return val                        

            def __len__(self):
                return 8    # encoded paylaod is 4 byte long.
            
        class CodecTenBytes(udsoncan.DidCodec):
            def encode(self, val): 
                val = val # Do some stuff
                return struct.pack('>QH', val) # 10 Bytes (8,2)

            def decode(self, payload):
                val = struct.unpack('>QH', payload)[0]  
                return val                        

            def __len__(self):
                return 10    # encoded paylaod is 10 byte long.
        
    
        config = dict(udsoncan.configs.default_client_config)
        size = didNumberContent.get('responseByteSize')
        decodedDataDict = didNumberContent['decodedData']
        
        for decodedItem, decodedItemContent in decodedDataDict.items():
            conversion = decodedItemContent['conversion']
            description = decodedItemContent['description']

            if conversion == 'ASCII':
                didList = {didNumber : udsoncan.AsciiCodec(size)}
                config['data_identifiers'] = didList 

            elif conversion == 'HEX':
                if size == 2:
                    didList = {didNumber : CodecTwoBytes}
                    config['data_identifiers'] = didList
                if size == 4:
                    didList = {didNumber : CodecFourBytes}
                    config['data_identifiers'] = didList
                if size == 8:
                    didList = {didNumber : CodecEightBytes}
                    config['data_identifiers'] = didList
                if size == 10:
                    didList = {didNumber : CodecTenBytes}
                    config['data_identifiers'] = didList

            client.config = config
            didList = config['data_identifiers']

        # read DIDs list
            for didItem, v in didList.items():

                response = client.read_data_by_identifier(didItem)
                if conversion == 'HEX':
                    print(moduleName, hex(didItem), description, ':', hex(response.service_data.values[didItem]))
                if conversion == 'ASCII':
                #else:
                    print(moduleName, hex(didItem), description, ':', response.service_data.values[didItem])
    #     client.ecu_reset(reset_type=1, data=b'\x77\x88\x99')
    #     print('Success!')
    except:
        print(moduleName, 'Not found')





        

