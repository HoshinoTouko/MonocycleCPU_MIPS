/*
 * Module: Generatic.mux_tb
 * Author: Touko
 * Create at 2017-11-15 09:58
 */
 
module mux_tb();
  `timescale  1ns/1ps
  
  reg clk;
  reg[31:0] d0;
  reg[31:0] d1;
  reg[31:0] d2;
  reg[31:0] d3;
  reg[3:0] signal;
  reg[31:0] ans;
  wire[31:0] output_data;
  
  integer fd, line_count;
  
  initial
  begin
    clk = 1;
    d0 = 4'b0;
    d1 = 4'b0;
    d2 = 4'b0;
    d3 = 4'b0;
    signal = 4'b0;
    fd=$fopen("test/data/Generatic/mux_td.txt","r");
    ans = 0;
    line_count = 0;
  end
  
  always
    #1 clk<=~clk;
  
  mux mux0(
    .d0(d0),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .signal(signal),
    .output_data(output_data)
  );
  
  always@(posedge clk)
  
  begin
    
    line_count <= line_count + 1;
    
    if (ans != output_data[31:0])
      begin
        $display("testcase failed! output_data: %x, ans: %x", output_data[31:0], ans);
        $stop;
      end
    
    $fscanf(fd, "0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t", d0, d1, d2, d3, signal, ans);
    $display("testcase: 0x%x\t0x%x\t0x%x\t0x%x\t0x%x\t0x%x", d0, d1, d2, d3, signal, ans);
    
    if ($feof(fd))
    begin
      $fclose(fd);
      $display("pass!");
      $stop;
    end
  end
  
endmodule