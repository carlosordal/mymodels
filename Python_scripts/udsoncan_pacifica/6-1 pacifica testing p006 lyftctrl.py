Python 3.7.4 (tags/v3.7.4:e09359112e, Jul  8 2019, 20:34:20) [MSC v.1916 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
 RESTART: C:\Users\cordunoalbarran\Repo\mymodels\Python_scripts\udsoncan_pacifica\udsoncan_pacifica_lyftctrl.py 
[]
no DASM dtcs
DASM PN (0xF132): 04672758AA
[<DTC ID=0x612916, Status=0xaf, Severity=0x00 at 0x22fb48984c8>, <DTC ID=0x612a84, Status=0x2f, Severity=0x00 at 0x22fb4898648>]
EPS_B DTC 1 : 612916
EPS_B DTC 2 : 612A84
EPS_B PN (0xF132): 68288309AD
[<DTC ID=0xa10a00, Status=0x29, Severity=0x00 at 0x22fb487c388>]
HaLF DTC 1 : A10A00
HaLF PN (0xF132): 04672731AB
HaLF SW PN (0xF122): 04672731AB
[<DTC ID=0xa1dd16, Status=0x2f, Severity=0x00 at 0x22fb488cf88>, <DTC ID=0xa10c16, Status=0x2f, Severity=0x00 at 0x22fb48b22c8>]
PTS DTC 1 : A1DD16
PTS DTC 2 : A10C16
PTS PN (0xF132): 68193775AI
PTS SW PN (0xF122): 68193775AI
>>> 
 RESTART: C:\Users\cordunoalbarran\Repo\mymodels\Python_scripts\udsoncan_pacifica\udsoncan_pacifica_lyftctrl.py 
2020-06-01 14:27:20 [INFO] Connection: Connection opened
2020-06-01 14:27:20 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:27:20 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:27:20 [DEBUG] Connection: Received 3 bytes : [b'7f1978']
2020-06-01 14:27:21 [DEBUG] Connection: Received 11 bytes : [b'59020d6227000d6129160d']
2020-06-01 14:27:21 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0x622700, Status=0x0d, Severity=0x00 at 0x13ff490d948>, <DTC ID=0x612916, Status=0x0d, Severity=0x00 at 0x13ff490da08>]
DASM DTC 1 : 622700
DASM DTC 2 : 612916
2020-06-01 14:27:21 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:21 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:27:21 [DEBUG] Connection: Received 13 bytes : [b'62f13230343637323735384141']
2020-06-01 14:27:21 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
DASM PN (0xF132): 04672758AA
2020-06-01 14:27:21 [INFO] Connection: Connection closed
2020-06-01 14:27:21 [INFO] Connection: Connection opened
2020-06-01 14:27:21 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:27:21 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:27:21 [DEBUG] Connection: Received 11 bytes : [b'5902ff612916af612a842f']
2020-06-01 14:27:21 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0x612916, Status=0xaf, Severity=0x00 at 0x13ff48f0bc8>, <DTC ID=0x612a84, Status=0x2f, Severity=0x00 at 0x13ff48f0d08>]
EPS_B DTC 1 : 612916
EPS_B DTC 2 : 612A84
2020-06-01 14:27:21 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:21 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:27:21 [DEBUG] Connection: Received 13 bytes : [b'62f13236383238383330394144']
2020-06-01 14:27:21 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
EPS_B PN (0xF132): 68288309AD
2020-06-01 14:27:21 [INFO] Connection: Connection closed
2020-06-01 14:27:21 [INFO] Connection: Connection opened
2020-06-01 14:27:21 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:27:21 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:27:21 [DEBUG] Connection: Received 7 bytes : [b'590239a10a0029']
2020-06-01 14:27:22 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0xa10a00, Status=0x29, Severity=0x00 at 0x13ff48f0bc8>]
HaLF DTC 1 : A10A00
2020-06-01 14:27:22 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:22 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:27:22 [DEBUG] Connection: Received 13 bytes : [b'62f13230343637323733314142']
2020-06-01 14:27:22 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
HaLF PN (0xF132): 04672731AB
2020-06-01 14:27:22 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:22 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 14:27:22 [DEBUG] Connection: Received 13 bytes : [b'62f12230343637323733314142']
2020-06-01 14:27:22 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
HaLF SW PN (0xF122): 04672731AB
2020-06-01 14:27:22 [INFO] Connection: Connection closed
2020-06-01 14:27:22 [INFO] Connection: Connection opened
2020-06-01 14:27:22 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:27:22 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:27:22 [DEBUG] Connection: Received 3 bytes : [b'7f1978']
2020-06-01 14:27:23 [DEBUG] Connection: Received 11 bytes : [b'59027fa1dd162fa10c162f']
2020-06-01 14:27:23 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0xa1dd16, Status=0x2f, Severity=0x00 at 0x13ff4913588>, <DTC ID=0xa10c16, Status=0x2f, Severity=0x00 at 0x13ff4913f48>]
PTS DTC 1 : A1DD16
PTS DTC 2 : A10C16
2020-06-01 14:27:23 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:23 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:27:23 [DEBUG] Connection: Received 13 bytes : [b'62f13236383139333737354149']
2020-06-01 14:27:23 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
PTS PN (0xF132): 68193775AI
2020-06-01 14:27:23 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:27:23 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 14:27:23 [DEBUG] Connection: Received 13 bytes : [b'62f12236383139333737354149']
2020-06-01 14:27:23 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
PTS SW PN (0xF122): 68193775AI
2020-06-01 14:27:23 [INFO] Connection: Connection closed
>>> 
