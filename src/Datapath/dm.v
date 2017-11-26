module dm(
  input wire clk,
  input wire[31:0] write_data,
  input wire MemWrite,
  input wire MemRead,
  input wire[6:3] addr,
  
  output wire[31:0] read_data
);
  
  reg[31:0]	memory[31:0];
  reg[31:0] read_data_tmp;
  
  integer i;
  
  initial
  begin
    for (i = 0; i < 31; i = i + 1)
      memory[i] = 0;
  end
  
  always @(posedge clk) 
  begin
    if (MemWrite) 
    begin
      $display("DM Write %x to %d", write_data, addr);
      memory[addr] = write_data;
    end
    /*
    $display("------------------------------- DM info -------------------------------");
    for (i = 0; i < 31; i = i + 1)
    begin
      if(memory[i] != 0)
        $display("DM %d: %x", i, memory[i]);
    end
    $display("------------------------------- DM fin -------------------------------");
    */
  end
	
	assign read_data = memory[addr];
endmodule