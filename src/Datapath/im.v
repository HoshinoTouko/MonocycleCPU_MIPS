module im(
  input	wire[11:2] addr,
  output	wire[31:0] dout
);
	reg[31:0]	instrMem[1023:0];

	assign dout = instrMem[addr[11:2]][31:0];
endmodule