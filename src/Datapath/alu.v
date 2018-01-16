`include "src/Define/ctrl_encode_def.v"
module alu(
    input [31:0] num_1,
    input [31:0] num_2,
    input [1:0] ALUOp,
    output reg Zero,
    output reg[31:0] result
);

    initial begin
        Zero = 0;
        result = 32'b0;
    end

    always@(*) begin
        // $display("ALU! 1: %x, 2: %x", num_1, num_2);
        // Calc
        case (ALUOp)
            `ALUOP_ADDU: result = num_1 + num_2;
            `ALUOP_SUBU: result = num_1 - num_2;

            `ALUOP_ORI: begin
                result = num_1 | num_2;
                // $display("OR! 1: %x, 2: %x", num_1, num_2);
            end

            default: result = 0;
        endcase
        // Zero
        if (num_1 == num_2)
            Zero = 1;
        else
            Zero = 0;
    end
  
endmodule
  
