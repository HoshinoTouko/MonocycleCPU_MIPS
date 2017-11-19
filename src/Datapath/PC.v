module pc(
  input wire clk,
  input	wire reset,
  input	wire[31:0]	data,
  output	reg[31:0]	dout
);

  always @(posedge clk)
	begin
		if(reset)
			dout[31:0] <= {32'h0000_3000};
		else
			dout <= data;
	end
endmodule
