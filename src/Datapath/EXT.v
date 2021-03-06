`include "src/Define/ctrl_encode_def.v"
module EXT(
    input wire[15:0] Immediate16,
    input wire[1:0] EXTOp,
    output reg[31:0] Immediate32
);

    initial begin
        Immediate32 = 32'b00;
    end

    always @(Immediate16) begin
        case(EXTOp)
            `EXTOP_ZERO: Immediate32 <= {{16'b0}, Immediate16[15:0]};
            `EXTOP_SIGNED: Immediate32 <= {{16{Immediate16[15]}}, Immediate16[15:0]};
            `EXTOP_INST: Immediate32 <= 32'b0;
            default: Immediate32 <= {{16'b0}, Immediate16[15:0]};
        endcase
        $display("EXT in: %x, out: %x", Immediate16, Immediate32);
    end
endmodule
