'''
@File: gen_rf_td.py
@Author: Hoshino Touko
@License: (C) Copyright 2014 - 2017, HoshinoTouko
@Contact: i@insky.jp
@Create at: 2017/11/17 13:08
@Desc: RF test bench data generator
'''
import random

def main():
    # Initialize data
    register = []
    for _ in range(32):
        # register.append(random.randint(0, 2147483647))
        register.append(0)

    output_data = []
    for _ in range(1000):
        # Simulate read and write
        RA1 = random.randint(0, 31)
        RA2 = random.randint(0, 31)
        RFWr = random.randint(0, 1)
        WA1 = random.randint(1, 31)
        WD = random.randint(0, 2147483647)
        RD1_output = register[RA1]
        RD2_output = register[RA2]
        if (RFWr):
            register[WA1] = WD
        # Data structure
        # RA1, RA2, RFWr, WA1, WD, RD1_output, RD2_output
        temp_data = map(lambda i: hex(i), [RA1, RA2, RFWr, WA1, WD, RD1_output, RD2_output])
        #print(list(temp_data))
        output_data.append('\t'.join(temp_data))
    with open('./rf_td.txt', 'w+') as file:
        file.write('\n'.join(output_data))

if __name__ == '__main__':
    main()
