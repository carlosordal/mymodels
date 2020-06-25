# Read information requested on yaml file, depending on vehicle and DID decoder.
# documentation: https://udsoncan.readthedocs.io/en/latest/

# python can for hardware connection
# https://python-can.readthedocs.io/en/master/
# https://github.com/hardbyte/python-can/tree/master
# tested on fusion 6/2/2020, functions added to read DTCs and DIDs
# ForScan: https://docs.google.com/spreadsheets/u/1/d/1yax6zfhZYj2joBczEeruqKh9X5Qhee3C0ngilqwTA7E/pubhtml?gid=0&single=true

# Next steps:



import   diagnostic_lib
import   isotp
import   can
import   ics
import   udsoncan
import   udsoncan.configs
from     udsoncan.connections import PythonIsoTpConnection
from     udsoncan.client      import Client
import   struct
import   yaml  
import   pdb


#udsoncan.setup_logging()
# pacifica: when eng on EBCM, ABS, BPCM, HCP negative response.
# Pacifica: In order to clear DTCs, it should be Ign on, eng off.

dtc_status_mask = 0x0D         #0x2F
bus = diagnostic_lib.canToolDefinition('PeakCan',500000)    #'neovi' 'PeakCan' 'Virtual'
# modulesIdsPacificaCcan
# 'modulesIdsPacificaLyftCtrl.yaml'
# 'modulesIdsPacificaIHS.ymal'
# 'modulesIdsFusion.yaml'
with open('modulesIdsPacificaCcan.yaml') as file:
    documents = yaml.full_load(file)
    for module, moduleContent in documents.items():
        moduleName = module
        moduleDescription = moduleContent.get('description')
        requestedData = moduleContent.get('requestedData')
        txId = moduleContent.get('request')
        rxId = moduleContent.get('response')
        print (' ----------------- Section:', moduleName, '-', moduleDescription, '-------------------')
        conn = diagnostic_lib.ecuConnection(txId, rxId, bus)
    
        with Client(conn, request_timeout=10) as client:
            try:    
                response = client.clear_dtc(group=0xFFFFFF)
                print('Clear DTCs response', response.code_name)
            except:
                print(moduleName, 'Not found')    
                #print(response.service_data.dtcs)              # Will print an array of object: [<DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x1d608854388>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x1d6088541c8>]  


print("********************************************************* completed  ********************************************")




