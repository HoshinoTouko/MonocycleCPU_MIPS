module dm(
  input wire clk,
  input wire[31:0] din,
  input wire MemWrite,
  input wire MemRead,
  input wire[11:2] addr,
  output reg[31:0] dout
);
  
  reg[31:0]	memory[1023:0] ;
  
  always @(posedge clk) 
  begin
    if (MemWrite) memory[addr[11:2]][31:0] <= din[31:0];
  end

  always @(addr or MemRead) 
  begin
    if (MemRead) dout[31:0] <= memory[addr[11:2]][31:0];
	end
endmodule