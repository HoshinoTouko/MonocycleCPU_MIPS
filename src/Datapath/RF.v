module RF(
  input clk,
  input reg RFWr, // Write data signal

	input [4:0]WA1, // Address of 1st. reg to write
  		
	input [4:0]RA1, // Address of 1st. reg to read
	input [4:0]RA2, // Address of 2nd. reg to read
  		
	input [31:0]WD, // Write data
  		
	output [31:0]RD1, // Read data 1
	output [31:0]RD2  // Read data 2
);
	reg [31:0] register[31:0];
  	 
	initial 
	begin
    register[0] = 0;
  end

  always@(posedge clk)
  begin
    if (WA1 != 0 && RFWr) begin
      register[WA1] = WD;
    end
  end

  assign RD1 = register[RA1];
  assign RD2 = register[RA2];
  	 
endmodule