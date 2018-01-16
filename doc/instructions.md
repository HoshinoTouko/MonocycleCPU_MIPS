## MIPS-Lite

Support 7 instr.

- addu
- subu
- ori
- lw
- sw
- beq
- jal

## Instructions

> Reference:
http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html

### OP and funct

|Instr | op        | funct     |
| :--: | :-------: | :--------:|
| addu | 6'b000000 | 6'b100001 |
| subu | 6'b000000 | 6'b100011 |
| ori  | 6'b001101 | Immediate |
| lw   | 6'b100011 | Immediate |
| sw   | 6'b101011 | Immediate |
| beq  | 6'b000100 | Immediate |
| jal  | 6'b000011 | Immediate |

### Signals

- ALU
    - ALUSrc
- Register File
    - RegWrite
    - RegDst
- Data Memory
    - MemWrite
    - MemRead
- Other
    - Mem2Reg
    - Branch
    - Jump

#### R-Type signals

|Instr|ALUOp|ALUSrc|RegWrite|RegDst|MemWrite|MemRead|Mem2Reg|Branch|Jump |
| :-: | :-: | :--: | :----: | :--: | :----: | :---: | :---: | :--: | :-: |
|addu |ADDU | 0    | 1      | 1    | 0      | 0     | 0     | 0    | 1   |
|subu |SUBU | 0    | 1      | 1    | 0      | 0     | 0     | 0    | 1   |

#### I-Type & J-Type signals (without ALUOp)

|Instr|ALUSrc|RegWrite|RegDst|MemWrite|MemRead|Mem2Reg|Branch|Jump |
| :-: | :--: | :----: | :--: | :----: | :---: | :---: | :--: | :-: |
| ori | 1    | 1      | 0    | 0      | 0     | 0     | 0    | 1   |
| lw  | 1    | 1      | 0    | 0      | 1     | 1     | 0    | 1   |
| sw  | 1    | 0      | 0    | 1      | 0     | 0     | 0    | 1   |
| beq | 0    | 0      | 0    | 0      | 0     | 0     | 1    | 1   |
| jal | 0    | 0      | 0    | 0      | 0     | 0     | 0    | 0   |
