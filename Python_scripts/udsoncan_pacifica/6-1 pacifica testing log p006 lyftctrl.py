Python 3.7.4 (tags/v3.7.4:e09359112e, Jul  8 2019, 20:34:20) [MSC v.1916 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
 RESTART: C:\Users\cordunoalbarran\Repo\mymodels\Python_scripts\udsoncan_pacifica\udsoncan_pacifica_ccan.py 
[<DTC ID=0xa18311, Status=0x28, Severity=0x00 at 0x26fd5b83ec8>, <DTC ID=0xa19916, Status=0x28, Severity=0x00 at 0x26fd5b83fc8>]
CBC DTC 1 : A18311
CBC DTC 2 : A19916
CBC PN (0xF132): 68360199AC
CBC SW PN (0xF122): 68360200AC
[<DTC ID=0x056200, Status=0x4c, Severity=0x00 at 0x26fd5b707c8>]
EBCM DTC 1 : 056200
EBCM PN (0xF132): 68240033AJ
EBCM SW PN (0xF18C): 68240033AJ
[<DTC ID=0x455b00, Status=0x4c, Severity=0x00 at 0x26fd5b5b508>, <DTC ID=0x620000, Status=0x4c, Severity=0x00 at 0x26fd5b59648>, <DTC ID=0x402100, Status=0x0c, Severity=0x00 at 0x26fd5b90688>]
ESC/BSMO DTC 1 : 455B00
ESC/BSMO DTC 2 : 620000
ESC/BSMO DTC 3 : 402100
ESC/BSMO PN (0xF132): 68352786AA
ESC/BSMO SW PN (0xF122): 68352786AA
[<DTC ID=0x612916, Status=0xac, Severity=0x00 at 0x26fd5b701c8>, <DTC ID=0x612a84, Status=0x2c, Severity=0x00 at 0x26fd5b90508>]
EPS_A DTC 1 : 612916
EPS_A DTC 2 : 612A84
EPS_A PN (0xF132): 68288309AD
>>> with logging
SyntaxError: invalid syntax
>>> 
 RESTART: C:\Users\cordunoalbarran\Repo\mymodels\Python_scripts\udsoncan_pacifica\udsoncan_pacifica_ccan.py 
2020-06-01 14:54:50 [INFO] Connection: Connection opened
2020-06-01 14:54:50 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:54:50 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:54:51 [DEBUG] Connection: Received 11 bytes : [b'5902fba1831128a1991628']
2020-06-01 14:54:51 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0xa18311, Status=0x28, Severity=0x00 at 0x157ea09d948>, <DTC ID=0xa19916, Status=0x28, Severity=0x00 at 0x157ea09da88>]
CBC DTC 1 : A18311
CBC DTC 2 : A19916
2020-06-01 14:54:51 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:51 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:54:51 [DEBUG] Connection: Received 13 bytes : [b'62f13236383336303139394143']
2020-06-01 14:54:51 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
CBC PN (0xF132): 68360199AC
2020-06-01 14:54:51 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:51 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 14:54:51 [DEBUG] Connection: Received 13 bytes : [b'62f12236383336303230304143']
2020-06-01 14:54:51 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
CBC SW PN (0xF122): 68360200AC
2020-06-01 14:54:51 [INFO] Connection: Connection closed
2020-06-01 14:54:51 [INFO] Connection: Connection opened
2020-06-01 14:54:51 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:54:51 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:54:51 [DEBUG] Connection: Received 3 bytes : [b'7f1978']
2020-06-01 14:54:51 [DEBUG] Connection: Received 7 bytes : [b'5902cf0562004c']
2020-06-01 14:54:51 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0x056200, Status=0x4c, Severity=0x00 at 0x157ea081c48>]
EBCM DTC 1 : 056200
2020-06-01 14:54:51 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:51 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:54:52 [DEBUG] Connection: Received 13 bytes : [b'62f1323638323430303333414a']
2020-06-01 14:54:52 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
EBCM PN (0xF132): 68240033AJ
2020-06-01 14:54:52 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:52 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 14:54:52 [DEBUG] Connection: Received 13 bytes : [b'62f1223638323430303333414a']
2020-06-01 14:54:52 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
EBCM SW PN (0xF18C): 68240033AJ
2020-06-01 14:54:52 [INFO] Connection: Connection closed
2020-06-01 14:54:52 [INFO] Connection: Connection opened
2020-06-01 14:54:52 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:54:52 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:54:52 [DEBUG] Connection: Received 3 bytes : [b'7f1978']
2020-06-01 14:54:52 [DEBUG] Connection: Received 15 bytes : [b'5902cf455b004c6200004c4021000c']
2020-06-01 14:54:52 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0x455b00, Status=0x4c, Severity=0x00 at 0x157ea09da88>, <DTC ID=0x620000, Status=0x4c, Severity=0x00 at 0x157ea0a3208>, <DTC ID=0x402100, Status=0x0c, Severity=0x00 at 0x157ea0a3248>]
ESC/BSMO DTC 1 : 455B00
ESC/BSMO DTC 2 : 620000
ESC/BSMO DTC 3 : 402100
2020-06-01 14:54:52 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:52 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:54:52 [DEBUG] Connection: Received 13 bytes : [b'62f13236383335323738364141']
2020-06-01 14:54:52 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
ESC/BSMO PN (0xF132): 68352786AA
2020-06-01 14:54:52 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:52 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 14:54:53 [DEBUG] Connection: Received 13 bytes : [b'62f12236383335323738364141']
2020-06-01 14:54:53 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
ESC/BSMO SW PN (0xF122): 68352786AA
2020-06-01 14:54:53 [INFO] Connection: Connection closed
2020-06-01 14:54:53 [INFO] Connection: Connection opened
2020-06-01 14:54:53 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 14:54:53 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 14:54:53 [DEBUG] Connection: Received 11 bytes : [b'5902ff612916ac612a842c']
2020-06-01 14:54:53 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[<DTC ID=0x612916, Status=0xac, Severity=0x00 at 0x157ea0a3608>, <DTC ID=0x612a84, Status=0x2c, Severity=0x00 at 0x157ea0a3e08>]
EPS_A DTC 1 : 612916
EPS_A DTC 2 : 612A84
2020-06-01 14:54:53 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf132 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 14:54:53 [DEBUG] Connection: Sending 3 bytes : [b'22f132']
2020-06-01 14:54:53 [DEBUG] Connection: Received 13 bytes : [b'62f13236383238383330394144']
2020-06-01 14:54:53 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
EPS_A PN (0xF132): 68288309AD
2020-06-01 14:54:53 [INFO] Connection: Connection closed
>>> 
