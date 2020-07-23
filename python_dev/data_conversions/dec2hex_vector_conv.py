
dec_array = [98, 241, 140]
print("dec array", dec_array)

print("manual vector conversion to hex string: ", hex(dec_array[0]), hex(dec_array[1]), hex(dec_array[2]))


#Using a list comprehensions would probably be the easiest way of doing this:

hex_array = [hex(x) for x in dec_array]
print("For vector conversion to hex: ", hex_array)

#convert hex_array str to decimal
dec_array = [int(x,16) for x in hex_array]
print("For Hex with 0x  conversion to dec: ", dec_array)

#And if you want to remove the 0x at the beginning of each element:

hex_array = [hex(x)[2:] for x in dec_array]
print("For without 0x vector conversion to hex: ", hex_array)

#convert hex_array str to decimal
dec_array = [int(x,16) for x in hex_array]
print("For Hex without 0x conversion to dec: ", dec_array)


    

