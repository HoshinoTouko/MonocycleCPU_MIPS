/*
 * Module: Generatic.mux
 * Author: Touko
 * Create at 2017-11-15 09:58
 */

module mux(
  input reg[31:0] d0,
  input reg[31:0] d1,
  input reg[31:0] d2,
  input reg[31:0] d3,
  input reg[3:0] signal,
  output reg[31:0] output_data
);

  always@(*)
  begin
    case(signal)
      2'b00: output_data = d0;
      2'b01: output_data = d1;
      2'b10: output_data = d2;
      2'b11: output_data = d3;
      default: output_data = 32'b0;
    endcase
  end
endmodule