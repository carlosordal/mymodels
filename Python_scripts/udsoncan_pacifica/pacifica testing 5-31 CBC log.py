Python 3.7.4 (tags/v3.7.4:e09359112e, Jul  8 2019, 20:34:20) [MSC v.1916 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x22fe7e9b9c8>]
[ConfigError] : Actual data identifier configuration contains no definition for data identifier 0xf188
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py", line 77, in <module>
    response = client.read_data_by_identifier(0xF188)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 362, in read_data_by_identifier
    req = services.ReadDataByIdentifier.make_request(didlist=didlist, didconfig=self.config['data_identifiers'])
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 53, in make_request
    ServiceHelper.check_did_config(didlist, didconfig)
  File "C:\Python37\lib\site-packages\udsoncan\services\__init__.py", line 128, in check_did_config
    raise ConfigError(did, msg='Actual data identifier configuration contains no definition for data identifier 0x%04x' % did)
udsoncan.exceptions.ConfigError: Actual data identifier configuration contains no definition for data identifier 0xf188
>>> 
 RESTART: C:\Users\cordunoalbarran\Repo\mymodels\Python_scripts\python-udsoncan\python-udsoncan_example_read_did_IPC_fusion.py 
HS7T-14C026-HF 
63342001       
HS7T-14C026-HF 
63342001       
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2abef07aa88>]
[ConfigError] : Actual data identifier configuration contains no definition for data identifier 0xf188
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py", line 78, in <module>
    response = client.read_data_by_identifier(0xF188)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 362, in read_data_by_identifier
    req = services.ReadDataByIdentifier.make_request(didlist=didlist, didconfig=self.config['data_identifiers'])
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 53, in make_request
    ServiceHelper.check_did_config(didlist, didconfig)
  File "C:\Python37\lib\site-packages\udsoncan\services\__init__.py", line 128, in check_did_config
    raise ConfigError(did, msg='Actual data identifier configuration contains no definition for data identifier 0x%04x' % did)
udsoncan.exceptions.ConfigError: Actual data identifier configuration contains no definition for data identifier 0xf188
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x1d24fb1b9c8>]
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[]
no IPC dtcs
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x200b29ebb88>]
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[]
no EFP dtcs
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x16b53ecb908>]
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x16b53ebe048>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x16b53ebe248>]
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2b16de6bac8>]
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2b16de5e3c8>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2b16de5ec88>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2b16de5e108>]
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x22e3b06b908>]
> c:\users\cordunoalbarran\repo\mymodels\python_scripts\udsoncan_fusion_data\udsoncan_fusion_data_module.py(73)<module>()
-> if len(response.service_data.dtcs) == 0:
(Pdb) response.service_data.dtcs
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x22e3b06b908>]
(Pdb) if len(response.service_data.dtcs) == 0:
*** SyntaxError: unexpected EOF while parsing
(Pdb) if len(response.service_data.dtcs) == 0:
*** SyntaxError: unexpected EOF while parsing
(Pdb)   if len(response.service_data.dtcs) == 1:
		for dtc in response.service_data.dtcs:
		    #pdb.set_trace()
		    print(modules_ids[0][0], "DTC : %06X" % dtc.id ) 
*** SyntaxError: unexpected EOF while parsing
(Pdb) *** SyntaxError: unexpected EOF while parsing
(Pdb) *** SyntaxError: unexpected EOF while parsing
(Pdb) *** NameError: name 'dtc' is not defined
(Pdb) print(modules_ids[0][0], "DTC : %06X" % dtc.id )
*** NameError: name 'dtc' is not defined
(Pdb) 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2c5bca1c908>]
> c:\users\cordunoalbarran\repo\mymodels\python_scripts\udsoncan_fusion_data\udsoncan_fusion_data_module.py(73)<module>()
-> if len(response.service_data.dtcs) == 1:
(Pdb) c
IPC DTC : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2c5bca00dc8>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2c5bca00e48>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2c5bca2d108>]
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x122d948b908>]
IPC DTC : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x122d947e108>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x122d947e088>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x122d946fec8>]
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2199b29aa08>]
IPC DTC : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2199b28e348>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2199b28e188>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2199b27fdc8>]
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x260ae8cbb48>]
IPC DTC : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x260ae8be3c8>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x260ae8be408>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x260ae8be048>]
EFP DTC : 905A14
EFP DTC : 9A6115
EFP DTC : 9A6915
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2138bb3ba88>]
IPC DTC : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2138bb2e348>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2138bb2e0c8>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2138bb20f88>]
EFP DTC 1  : 905A14
EFP DTC 2  : 9A6115
EFP DTC 3  : 9A6915
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x1efce4aba88>]
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py", line 74, in <module>
    index = index + 1
NameError: name 'index' is not defined
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x209e055ba88>]
IPC DTC 1  : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x209e054e188>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x209e054e148>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x209e0540ec8>]
EFP DTC 1  : 905A14
EFP DTC 2  : 9A6115
EFP DTC 3  : 9A6915
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2d812c7ba08>]
IPC DTC 1  : C21200
IPC  SW PN (0xF188): HS7T-14C026-HF 
IPC  Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2d812c6e148>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2d812c6e108>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2d812c5ff08>]
EFP DTC 1  : 905A14
EFP DTC 2  : 9A6115
EFP DTC 3  : 9A6915
EFP  SW PN (0xF188): HS7T-14G121-DB 
EFP  Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2805f8cbb08>]
IPC DTC 1  : C21200
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x2805f8be3c8>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x2805f8be0c8>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x2805f8be048>]
EFP DTC 1  : 905A14
EFP DTC 2  : 9A6115
EFP DTC 3  : 9A6915
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x1cfc469b9c8>]
IPC DTC 1 : C21200
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x1cfc468e308>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x1cfc468e088>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x1cfc467fec8>]
EFP DTC 1 : 905A14
EFP DTC 2 : 9A6115
EFP DTC 3 : 9A6915
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x1b5b06fb908>]
no IPC dtcs
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x1b5b06ee288>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x1b5b06ee088>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x1b5b06e1f88>]
EFP DTC 1 : 905A14
EFP DTC 2 : 9A6115
EFP DTC 3 : 9A6915
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x20ea736bb48>]
IPC DTC 1 : C21200
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[<DTC ID=0x905a14, Status=0x0a, Severity=0x00 at 0x20ea735e448>, <DTC ID=0x9a6115, Status=0x0a, Severity=0x00 at 0x20ea735e208>, <DTC ID=0x9a6915, Status=0x0a, Severity=0x00 at 0x20ea735e0c8>]
EFP DTC 1 : 905A14
EFP DTC 2 : 9A6115
EFP DTC 3 : 9A6915
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[<DTC ID=0xc21200, Status=0x0a, Severity=0x00 at 0x2166aecba08>]
IPC DTC 1 : C21200
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[]
no EFP dtcs
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_fusion_data/udsoncan_fusion_data_module.py 
[]
no IPC dtcs
IPC SW PN (0xF188): HS7T-14C026-HF 
IPC Serial # (0xF18C): 63342001       
[]
no EFP dtcs
EFP SW PN (0xF188): HS7T-14G121-DB 
EFP Serial # (0xF18C): 0246-3406      
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
[]
no CBC dtcs
[NegativeResponseException] : ReadDataByIdentifier service execution returned a negative response RequestOutOfRange (0x31)
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 91, in <module>
    response = client.read_data_by_identifier(0xF188)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 372, in read_data_by_identifier
    response = self.send_request(req)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 1666, in send_request
    raise NegativeResponseException(response)
udsoncan.exceptions.NegativeResponseException: ReadDataByIdentifier service execution returned a negative response RequestOutOfRange (0x31)
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:01:03 [INFO] Connection: Connection opened
2020-06-01 11:01:03 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:01:03 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:01:03 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:01:03 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:01:03 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf188 (VehicleManufacturerECUSoftwareNumberDataIdentifier)
2020-06-01 11:01:03 [DEBUG] Connection: Sending 3 bytes : [b'22f188']
2020-06-01 11:01:03 [DEBUG] Connection: Received 3 bytes : [b'7f2231']
2020-06-01 11:01:03 [WARNING] UdsClient: [NegativeResponseException] : ReadDataByIdentifier service execution returned a negative response RequestOutOfRange (0x31)
2020-06-01 11:01:03 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 91, in <module>
    response = client.read_data_by_identifier(0xF188)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 372, in read_data_by_identifier
    response = self.send_request(req)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 1666, in send_request
    raise NegativeResponseException(response)
udsoncan.exceptions.NegativeResponseException: ReadDataByIdentifier service execution returned a negative response RequestOutOfRange (0x31)
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:18:46 [INFO] Connection: Connection opened
2020-06-01 11:18:46 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:18:46 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:18:46 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:18:46 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:18:46 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:18:46 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 11:18:46 [DEBUG] Connection: Received 13 bytes : [b'62f12236383336303230304143']
2020-06-01 11:18:46 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:18:46 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
2020-06-01 11:18:46 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 106, in <module>
    response = client.read_data_by_identifier(0xF122)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:20:00 [INFO] Connection: Connection opened
2020-06-01 11:20:00 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:20:00 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:20:00 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:20:00 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:20:00 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:20:00 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 11:20:00 [DEBUG] Connection: Received 13 bytes : [b'62f12236383336303230304143']
2020-06-01 11:20:00 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:20:00 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
2020-06-01 11:20:00 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 106, in <module>
    response = client.read_data_by_identifier(0xF122)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:20:20 [INFO] Connection: Connection opened
2020-06-01 11:20:20 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:20:20 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:20:20 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:20:20 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:20:20 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:20:20 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 11:20:21 [DEBUG] Connection: Received 13 bytes : [b'62f12236383336303230304143']
2020-06-01 11:20:21 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:20:21 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
2020-06-01 11:20:21 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 106, in <module>
    response = client.read_data_by_identifier(0xF122)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:20:59 [INFO] Connection: Connection opened
2020-06-01 11:20:59 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:20:59 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:20:59 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:20:59 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:20:59 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf151 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:20:59 [DEBUG] Connection: Sending 3 bytes : [b'22f151']
2020-06-01 11:20:59 [DEBUG] Connection: Received 6 bytes : [b'62f151112990']
2020-06-01 11:20:59 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:20:59 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
2020-06-01 11:20:59 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 106, in <module>
    response = client.read_data_by_identifier(0xF151)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:21:22 [INFO] Connection: Connection opened
2020-06-01 11:21:22 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:21:22 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:21:22 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:21:22 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:21:22 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf122 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:21:22 [DEBUG] Connection: Sending 3 bytes : [b'22f122']
2020-06-01 11:21:22 [DEBUG] Connection: Received 13 bytes : [b'62f12236383336303230304143']
2020-06-01 11:21:22 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:21:22 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
2020-06-01 11:21:22 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 106, in <module>
    response = client.read_data_by_identifier(0xF122)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 80, in <module>
    bitrate = 500000)
  File "C:\Python37\lib\site-packages\can\interface.py", line 127, in __new__
    return cls(channel, *args, **kwargs)
  File "C:\Python37\lib\site-packages\can\interfaces\pcan\pcan.py", line 198, in __init__
    raise PcanError(self._get_formatted_error(result))
can.interfaces.pcan.pcan.PcanError: The value of a handle (PCAN-Channel, PCAN-Hardware, PCAN-Net, PCAN-Client) is invalid
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
[]
no CBC dtcs
[InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 108, in <module>
    response = client.read_data_by_identifier(0xF122)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf122 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
[]
no CBC dtcs
[InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 108, in <module>
    response = client.read_data_by_identifier(0xF151)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:33:08 [INFO] Connection: Connection opened
2020-06-01 11:33:08 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:33:08 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:33:08 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:33:08 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:33:08 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf151 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:33:08 [DEBUG] Connection: Sending 3 bytes : [b'22f151']
2020-06-01 11:33:08 [DEBUG] Connection: Received 6 bytes : [b'62f151112990']
2020-06-01 11:33:08 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:33:08 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
2020-06-01 11:33:08 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 108, in <module>
    response = client.read_data_by_identifier(0xF151)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf151 was incomplete according to definition in configuration
>>> 
 RESTART: C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py 
2020-06-01 11:34:30 [INFO] Connection: Connection opened
2020-06-01 11:34:30 [INFO] UdsClient: ReadDTCInformation<0x19> - Sending request with subfunction "reportDTCByStatusMask" (0x02).
2020-06-01 11:34:30 [DEBUG] Connection: Sending 3 bytes : [b'19020d']
2020-06-01 11:34:30 [DEBUG] Connection: Received 3 bytes : [b'5902fb']
2020-06-01 11:34:30 [INFO] UdsClient: Received positive response for service ReadDTCInformation (0x19) from server.
[]
no CBC dtcs
2020-06-01 11:34:30 [INFO] UdsClient: ReadDataByIdentifier<0x22> - Reading data identifier : 0xf155 (IdentificationOptionVehicleManufacturerSpecificDataIdentifier)
2020-06-01 11:34:30 [DEBUG] Connection: Sending 3 bytes : [b'22f155']
2020-06-01 11:34:30 [DEBUG] Connection: Received 5 bytes : [b'62f15500c6']
2020-06-01 11:34:30 [INFO] UdsClient: Received positive response for service ReadDataByIdentifier (0x22) from server.
2020-06-01 11:34:30 [ERROR] UdsClient: [InvalidResponseException] : ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf155 was incomplete according to definition in configuration
2020-06-01 11:34:30 [INFO] Connection: Connection closed
Traceback (most recent call last):
  File "C:/Users/cordunoalbarran/Repo/mymodels/Python_scripts/udsoncan_pacifica/udsoncan_pacifica_ccan.py", line 109, in <module>
    response = client.read_data_by_identifier(0xF155)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 123, in decorated
    return func(self, *args, **kwargs)
  File "C:\Python37\lib\site-packages\udsoncan\client.py", line 383, in read_data_by_identifier
    services.ReadDataByIdentifier.interpret_response(response, **params)
  File "C:\Python37\lib\site-packages\udsoncan\services\ReadDataByIdentifier.py", line 131, in interpret_response
    raise InvalidResponseException(response, "Value for data identifier 0x%04x was incomplete according to definition in configuration" % did)
udsoncan.exceptions.InvalidResponseException: ReadDataByIdentifier service execution returned an invalid response. Value for data identifier 0xf155 was incomplete according to definition in configuration
>>> 
