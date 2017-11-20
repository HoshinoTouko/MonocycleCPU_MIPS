`include "src/Define/ctrl_encode_def.v"

module mips(
  input wire clk,
  input wire reset
);
 	wire[31:0]	pc_current;
	wire[31:0]	pc_temp;
	wire[31:0]	pc_next;
	wire[31:0]	pc_add4;
	wire[31:0]	pc_branch;
	wire[31:0]	instr;
	
	// RF
	wire[31:0]	rf_read_data1;
	wire[31:0]	rf_read_data2;
	wire[4:0]	write_addr;
	wire[31:0]	ext_output;
	// ALU
	wire[31:0]	alu_num_1;
	wire[31:0]	alu_num_2;
	wire	Zero;
	// Data memory
	wire[31:0]	alu_result;
	wire[31:0]	dm_write_data;
	wire[31:0]	dm_read_data;
	wire[31:0] mem2reg_data;
	
	// Signals
  wire[1:0] ALUOp;
  wire ALUSrc;
  wire RegWrite;
  wire RegDst;
  wire MemWrite;
  wire MemRead;
  wire Mem2Reg;
  wire Branch;
  wire Jump;
  
  // PC addr add4
  assign pc_add4 = pc_current + 4;
  // PC
  pc pc(
    .clk(clk),
    .reset(reset),
    .data(pc_next),
    .dout(pc_current)
  );
  // PC Branch ALU
  alu pc_branch_alu(
    .ALUOp(`ALUOP_ADDU),
    .num_1(pc_add4),
    .num_2({ext_output[29:0], 2'b00}),
    .result(pc_branch)
  );
  // Branch mux
  mux branch_mux(
    .d0(pc_add4),
    .d1(pc_branch),
    .signal(Branch & Zero),
    .output_data(pc_temp)
  );
  // Jump mux
  mux jump_mux(
    .d0({pc_add4[31:28], instr[25:0], 2'b00}),
    .d1(pc_temp),
    .signal(Jump),
    .output_data(pc_next)
  );
  // Sign extend
  EXT ext(
    .Immediate16(instr[15:0]),
    .EXTOp(`EXTOP_ZERO),
    .Immediate32(ext_output)
  );
  // Instruction Memory
  im im(
    .addr(pc_current[11:2]),
    .dout(instr)
  );
  // Control unit
  ctrl ctrl(
    .OP(instr[31:26]),
    .funct(instr[5:0]),
    .ALUOp(ALUOp),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .RegDst(RegDst),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .Mem2Reg(Mem2Reg),
    .Branch(Branch),
    .Jump(Jump)
  );
  // Write addr mux
  mux write_addr_mux(
    // Input
    .d0(instr[20:16]),
    .d1(instr[15:11]),
    // Signal
    .signal(RegDst),
    // Output
    .output_data(write_addr)
  );
  // Register file 
  RF rf(
    // Input
    .clk(clk),
    .RA1(instr[25:21]),
    .RA2(instr[20:16]),
    .WA1(write_addr),
    .WD(mem2reg_data),
    // Output
    .RD1(rf_read_data1),
    .RD2(rf_read_data2),
    // Signal
    .RegWrite(RegWrite)
  );
  // ALUSrc and ALUSrc mux
  assign alu_num_1 = rf_read_data1;
  mux alu_src_mux(
    .d0(rf_read_data2),
    .d1(ext_output),
    .signal(ALUSrc),
    .output_data(alu_num_2)
  );
  // ALU
  alu alu(
    // Input
    .num_1(alu_num_1),
    .num_2(alu_num_2),
    .ALUOp(ALUOp),
    // Output
    .Zero(Zero),
    .result(alu_result)
  );
  // Data memory
  assign dm_write_data = rf_read_data2;
  dm dm(
    .clk(clk),
    .addr(alu_result),
    .write_data(dm_write_data),
    .MemWrite(MemWrite),
    
    // Output
    .read_data(dm_read_data)
  );
  // Memory to register file mux
  mux mem2reg_mux(
    .d0(alu_result),
    .d1(dm_read_data),
    .signal(Mem2Reg),
    .output_data(mem2reg_data)
  );
  
  always @(clk)
  begin
    $display("------------------------ MIPS signals -------------------------------");
    $display("Branch, Jump: %d, %d", Branch, Jump);
    
    $display("--------- PC addrs... ----------");
    $display("current %x, temp %x, next %x, add4 %x, br %x", 
      pc_current, pc_temp, pc_next, pc_add4, pc_branch
    );
  end

endmodule