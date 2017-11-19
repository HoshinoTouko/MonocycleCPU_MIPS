'''
@File: gen_alu_td.py
@Author: HoshinoTouko
@License: (C) Copyright 2014 - 2017, HoshinoTouko
@Contact: i@insky.jp
@Create at: 2017/11/18 16:36
@Desc: ALU test bench data generator
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
        temp_data = []
        result = 0
        num_1 = random.randint(0, 2147483647//2)
        # Set a 10% probability for num_2 to equals to num_1
        num_2 = random.randint(0, num_1) if random.randint(0, 9) < 8 else num_1
        alu_op = random.randint(0, 2)
        zero = num_1 == num_2
        if (alu_op == 0):
            result = num_1 + num_2
        elif (alu_op == 1):
            result = num_1 - num_2
        elif (alu_op == 2):
            result = num_1 | num_2
        else:
            result = 0
        # Data structure
        # num_1, num_2, alu_op, zero, result
        temp_data = map(super_hex, [num_1, num_2, alu_op, zero, result])
        output_data.append('\t'.join(list(temp_data)))

    with open('./alu_td.txt', 'w+') as file:
        file.write('\n'.join(output_data))

# transform to 32 bit
def super_hex(number):
    if (number >= 0):
        return hex(number)
    else:
        # result = hex(pow(2, 31) - abs(number))
        result = hex(abs(number))
        print('Transform %s to %s', hex(number), result)
        return result


if __name__ == '__main__':
    main()