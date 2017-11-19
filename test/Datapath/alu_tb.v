/*
 * Module: Datapath.alu_tb
 * Author: Touko
 * Create at 2017-11-15 09:58
 */
 
module alu_tb();
  `timescale  1ns/1ps
  
  reg clk;
  
  reg [31:0] num_1;
  reg [31:0] num_2;
  reg [1:0] ALUOp;
  reg Zero_output;
  reg[31:0] result_output;
  
  wire Zero;
  wire[31:0] result;
  
  integer fd;
    		
  initial
  begin
    clk = 1;
    
    num_1 = 32'b0;
    num_2 = 32'b0;
    ALUOp = 2'b0;
    Zero_output = 1;
    result_output = 32'b0;
    
    fd=$fopen("test/data/Datapath/alu_td.txt","r");
  end
  
  always
    #1 clk<=~clk;
  
  alu alu0(
    .num_1(num_1),
    .num_2(num_2),
    .ALUOp(ALUOp),
    .Zero(Zero),
    .result(result)
  );
  
  always@(posedge clk)
  
  begin
    if (result != result_output)
      begin
        $display("testcase failed! result: %x, result_data: %x", result, result_output);
        $stop;
      end
    if (Zero != Zero_output)
      begin
        $display("testcase failed! Zero: %x, Zero_output: %x", Zero, Zero_output);
        $stop;
      end
    
    $fscanf(
      fd, "0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t", 
      num_1, num_2, ALUOp, Zero_output, result_output
    );
    
    $display(
      "testcase: 0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t",
      num_1, num_2, ALUOp, Zero, Zero_output, result, result_output
    );
    
    if ($feof(fd))
    begin
      $fclose(fd);
      $display("pass!");
      $stop;
    end
  end
  
endmodule
