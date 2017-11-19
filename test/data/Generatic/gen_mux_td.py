'''
@File: gen_mux_td.py
@Author: HoshinoTouko
@License: (C) Copyright 2014 - 2017, HoshinoTouko
@Contact: i@insky.jp
@Create at: 2017/11/15 12:03
@Desc: Mux test bench data generator
'''
import random

def main():
    output_data = []
    # Init 0
    temp_data = []
    for _ in range(6):
        temp_data.append(hex(0))
    output_data.append('\t'.join(temp_data))
    # Generate random data
    for _ in range(1000):
        temp_data = []
        for _ in range(4):
            temp_data.append(hex(random.randint(0, 2147483647)))
        signal = random.randint(0, 3)
        temp_data.append(hex(signal))
        temp_data.append(temp_data[signal])
        output_data.append('\t'.join(temp_data))
    # print(output_data)
    with open('./mux_td.txt', 'w+') as file:
        file.write('\n'.join(output_data))

if __name__ == '__main__':
    main()
