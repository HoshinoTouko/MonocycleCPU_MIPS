module pc(
  input wire clk,
  input	wire reset,
  input	wire[31:0]	data,
  output	reg[31:0]	dout
);

  always @(posedge clk)
	begin
		if(reset)
		begin
		  $display("PC receive reset signal.");
			dout <= {32'h00003000};
		end
		else
			dout <= data[31:0];
		//$display("PC data_output: %x", dout);
	end
endmodule
