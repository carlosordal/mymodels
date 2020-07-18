#new decoder FCA wayt of couting.
# description: Number of Speakers
# extract byte 0 from FCA count
startByte = 1
startBit = 4 

byteSize = 1
bitSize = 0

byteLength = 8
didValue = 37069284                 #0x0235A1E4
binValue = format(didValue,'032b')
hexValue = format(didValue, '08X')
pythonStartPosition  = (startByte * 8) + (7 - startBit)
bitsLength = (byteSize * 8) + bitSize


concatenaded_data = ''
shortenedData = binValue[pythonStartPosition-7:]
for x in range(bitsLength):
    # for y in range(byteSize)
        byte = int(x/8)
        binPos = pythonStartPosition - x
        extractedData = binValue[binPos: binPos +1]
        concatenaded_data = extractedData + concatenaded_data

        print('bit#',x,'bit Value', extractedData, 'full data:', concatenaded_data )
print('                ',hexValue[0:2],'     ',hexValue[2:4],'     ',hexValue[4:6],'     ',hexValue[6:8])
print('binValue     ',binValue[0:8], binValue[8:16], binValue[16:24], binValue[24:32])
print('concatenated ',concatenaded_data[0:8],concatenaded_data[7:16], ' hex value:', hex(int(concatenaded_data, base = 2)),concatenaded_data )
print('shortenedData, from byte:',startByte, 'hex value:', hex(int(shortenedData, base = 2)), shortenedData[0:8],shortenedData[8:16],shortenedData[16:])

print('done')
