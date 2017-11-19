module mips(
  input clk,
  input reset
);
 	reg	[31:0]	pc_current;
	reg	[31:0]	pc_temp;
	reg	[31:0]	pc_next;
	reg	[31:0]	pc_add4;
	reg	[31:0]	pc_branch;
	reg	[31:0]	instr;
	
	reg	[31:0]	read_data1;
	reg	[31:0]	read_data2;
	reg	[31:0]	ext_output;
	// ALUSrc
	reg	[31:0]	num_1;
	reg	[31:0]	num_2;
	reg	Zero;
	reg	[31:0]	alu_result;
	reg	[31:0]	write_data;
	reg	[31:0]	read_data;
	
	// Signals
  reg Instr;
  reg[1:0] ALUOp;
  reg ALUSrc;
  reg RegWrite;
  reg RegDst;
  reg MemWrite;
  reg MemRead;
  reg Mem2Reg;
  reg Branch;
  reg Jump;
  
  
  
endmodule