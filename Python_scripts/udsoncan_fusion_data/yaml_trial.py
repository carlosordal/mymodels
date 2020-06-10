import   yaml  

with open('modulesIdsFusion.yaml') as file:
    documents = yaml.full_load(file)
    for module, moduleContent in documents.items():
        moduleName = module
        moduleDescription = moduleContent.get('description')
        requestedData = moduleContent.get('requestedData')
        txId = moduleContent.get('request')
        rxId = moduleContent.get('response')
        for dataTypes, dataTypeContent in requestedData.items():
            print (' -Section:', moduleName, '-', hex(txId), hex(rxId), dataTypes)
            if dataTypes == 'DTCs':
                print('reading', dataTypes)
            elif dataTypes == 'DIDs':
                for didNumber, didNumberContent in dataTypeContent.items():
                    print('reading', dataTypes, hex(didNumber), didNumberContent.get('description'))

