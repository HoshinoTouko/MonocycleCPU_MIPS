module RF(
  input clk,
  input RegWrite, // Write data signal

	input [4:0]WA1, // Address of 1st. reg to write
  		
	input [4:0]RA1, // Address of 1st. reg to read
	input [4:0]RA2, // Address of 2nd. reg to read
  		
	input [31:0]WD, // Write data
  		
	output [31:0]RD1, // Read data 1
	output [31:0]RD2  // Read data 2
);
	reg[31:0] register[31:0];
	integer i, fd, cycles;
  	 
	initial 
	begin
	  fd = $fopen("RF_Results.txt","w");
	  cycles = 0;
	  for(i = 0; i < 32; i = i + 1)
      register[i] = 0;
  end

  always@(posedge clk)
  begin
    if (WA1 != 0 && RegWrite) 
    begin
      register[WA1] = WD[31:0];
      $display("RF Write: %x to %d", WD[31:0], WA1);
    end
    $display("----------------------------------- RF info -----------------------------------");
    $fwrite(fd, "---------------------------------, Cycle %d ------------------------------\n", cycles); 
    cycles = cycles + 1;
    for(i = 0; i < 32; i = i + 1)
      if (register[i] != 0)
      begin
        $display("RF %d: %x", i, register[i]);
        $fwrite(fd, "RF %d: %x\n", i, register[i]); 
      end
    $display("----------------------------------- RF fin -----------------------------------");
  end

  assign RD1 = register[RA1];
  assign RD2 = register[RA2];
  	 
endmodule
