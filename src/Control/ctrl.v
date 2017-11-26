`include "src/Define/ctrl_encode_def.v"
module ctrl(
  input wire clk,
  input wire reset,
  // Operations here
  input wire[5:0] OP,
  input wire[5:0] funct,
  // ALU Zero output
  input wire Zero,
  // Register file write signal 
  output reg RegWrite,
  // Register file destination 0: 20-16, 1: 15-11
  output reg RegDst,
  // Sign extend signal
  output reg[1:0] EXTOp,
  // Data memory write and read signal
  output reg MemWrite,
  output reg MemRead,
  // ALU data 2 source
  output reg ALUSrc,
  // ALU op
  output reg[1:0] ALUOp,
  // Mem to reg mux signal
  output reg Mem2Reg,
  // Branch
  output reg Branch,
  // Jump
  output reg Jump
);
  
  initial
  begin
    ALUSrc = 0;
    RegWrite = 0;
    RegDst = 0;
    MemWrite = 0;
    MemRead = 0;
    Mem2Reg = 0;
    Branch = 0;
    Jump = 1;
  end
  
  // Reference at doc/commands
  always @(*)
  begin
    case (OP)
      `CTRL_OP_RTYPE:
      begin
        case(funct)
          `CTRL_FUNCT_ADDU: ALUOp = `ALUOP_ADDU;
          `CTRL_FUNCT_SUBU: ALUOp = `ALUOP_SUBU;
          default: ALUOp = `ALUOP_ADDU;
        endcase
        ALUSrc = 0;
        RegWrite = 1;
        RegDst = 1;
        MemWrite = 0;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 0;
        Jump = 1;
      end
      
      `CTRL_OP_ORI: 
      begin
        ALUOp = `ALUOP_ORI;
        ALUSrc = 1;
        RegWrite = 1;
        RegDst = 0;
        MemWrite = 0;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 0;
        Jump = 1;
      end
      
      `CTRL_OP_LW:
      begin
        ALUSrc = 1;
        RegWrite = 1;
        RegDst = 0;
        MemWrite = 0;
        MemRead = 1;
        Mem2Reg = 1;
        Branch = 0;
        Jump = 1;
      end
      
      `CTRL_OP_SW:
      begin
        ALUSrc = 1;
        RegWrite = 0;
        RegDst = 0;
        MemWrite = 1;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 0;
        Jump = 1;
      end
      
      `CTRL_OP_BEQ: 
      begin
        ALUSrc = 0;
        RegWrite = 0;
        RegDst = 0;
        MemWrite = 0;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 1;
        Jump   = 1;
      end
      `CTRL_OP_JAL:
      begin
        ALUSrc = 0;
        RegWrite = 1;
        RegDst = 0;
        MemWrite = 0;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 0;
        Jump = 0;
        $display("Jump!---------------");
      end
      
      default:
      begin
        ALUSrc = 0;
        RegWrite = 0;
        RegDst = 0;
        MemWrite = 0;
        MemRead = 0;
        Mem2Reg = 0;
        Branch = 0;
        Jump = 1;
      end
    endcase
  end
endmodule

