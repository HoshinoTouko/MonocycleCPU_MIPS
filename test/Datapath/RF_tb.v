/*
 * Module: Generatic.mux_tb
 * Author: Touko
 * Create at 2017-11-15 09:58
 */
 
module RF_tb();
  `timescale  1ns/1ps
  
  reg clk;
  reg RFWr; // Write data signal

	reg [4:0]WA1; // Address of 1st. reg to write
  		
	reg [4:0]RA1; // Address of 1st. reg to read
	reg [4:0]RA2; // Address of 2nd. reg to read
  		
	reg [31:0]WD; // Write data
  		
	wire [31:0]RD1; // Read data 1
	wire [31:0]RD2;  // Read data 2
	reg [31:0]RD1_tmp;
	reg [31:0]RD2_tmp;
	
	reg [31:0]RD1_output; // Read data 1 output
	reg [31:0]RD2_output;  // Read data 2 output
  
  integer fd, line_count;
  
  initial
  begin
    clk = 1;
    line_count = 0;
    
    RFWr = 4'b0;
    WA1 = 4'b0;
    RA1 = 4'b0;
    RA2 = 4'b0;
    WD = 32'b0;
    RD1_output = 4'b0;
    RD2_output = 4'b0;
    
    fd=$fopen("test/data/Datapath/rf_td.txt","r");
  end
  
  always
    #1 clk<=~clk;
  
  RF RF0(
    .clk(clk),
    .RFWr(RFWr),
    .WA1(WA1),
    .RA1(RA1),
    .RA2(RA2),
    .WD(WD),
    .RD1(RD1),
    .RD2(RD2)
  );
  
  always@(posedge clk)
  
  begin
    line_count <= line_count + 1;
    
    RD1_tmp = RD1[31:0];
    RD2_tmp = RD2[31:0];
    if (RD1_output != RD1_tmp)
      begin
        $display("testcase failed! RD1: %x, RD1_output: %x", RD1_tmp, RD1_output);
        $stop;
      end
    if (RD2_output != RD2_tmp)
      begin
        $display("testcase failed! RD2: %x, RD2_output: %x", RD2_tmp, RD2_output);
        $stop;
      end
    
    $fscanf(fd, "0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t", RA1, RA2, RFWr, WA1, WD, RD1_output, RD2_output);
    $display(
      "testcase: 0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t Getdata: 0x%x\t0x%x",
      RA1, RA2, RFWr, WA1, WD, RD1_output, RD2_output, RD1_tmp, RD2_tmp
    );
    
    if ($feof(fd))
    begin
      $fclose(fd);
      $display("pass!");
      $stop;
    end
  end
  
endmodule