`include "program_counter.v"
`include "memory_address.v"
`include "memory_data.v"
`include "instruction_reg.v"
`include "alu_out_reg.v"

`include "registerFile.v"
`include "ALU.v"
`include "DFFwithEnable.v"

module processor
	(
		MEM_ADDRESS,
		MEMDATA_IN, MEMDATA_OUT,
		mem_cs, mem_rd_wr,
		clk
	);

	//22-bit output from Processor
	output[21:0] MEM_ADDRESS;
	
	input[31:0] MEMDATA_IN;
	output[31:0] MEMDATA_OUT;

	output mem_cs, mem_rd_wr;

	input clk;

	//internal buses
	wire[31:0] BUSA, BUSB, BUSC;

	wire pc_in,pc_out,pc_increment;
	program_counter PC(BUSC[21:0],pc_in,pc_out,pc_increment,BUSB,clk);

	wire busb_mar_in,busc_mar_in;
	memory_add_reg MAR(BUSB[21:0],BUSC[21:0],busb_mar_in,busc_mar_in,MEM_ADDRESS,clk);
	
	wire busc_mdr_out,busa_mdr_in,busb_mdr_in,mem_in,mem_out;
	memory_data_reg MDR(BUSC,BUSA,BUSB,busc_mdr_out,busa_mdr_in,busb_mdr_in,MEMDATA_IN,MEMDATA_OUT,mem_in,mem_out,clk);

	wire busc_ir_in,instrn_ir_out;
	wire[31:0] INSTRN_DATA_OUT;
	instruction_reg IR(BUSC,busc_ir_in,instrn_ir_out,INSTRN_DATA_OUT,clk);

	//register File : 32 bit register x 32 numbers
	wire[4:0] RDADDRESS1, RDADDRESS2, WRADDRESS;
	wire read, write;
	registers REGISTER_FILE(RDADDRESS1,RDADDRESS2,WRADDRESS,BUSC,read,write,BUSA,BUSB,clk);

	wire[31:0] ALU_INPUT_A, ALU_INPUT_B;
	wire load_alu_a, load_alu_b;
	DFF32bitEnable ALU_INPUTA_FF(BUSA,clk,ALU_INPUT_A,load_alu_a);
	DFF32bitEnable ALU_INPUTB_FF(BUSB,clk,ALU_INPUT_B,load_alu_b);

	wire[63:0] ALU_OUTPUT;
	wire[3:0] OP_SELECT;
	ALU alu(ALU_INPUT_A,ALU_INPUT_B,OP_SELECT,ALU_OUTPUT,clk);

	wire r_load_in,r_out;
	ALU_OUTPUT_REG alu_out_reg(ALU_OUTPUT[31:0],r_load_in,r_out,BUSC,clk);

endmodule // processor

//Needs to be completed
module control_unit
	(
		BUSC_DATA_OUT, //output to bus
		cu_busc_out, // control lines to CU

		pc_in, pc_out, pc_increment, // control lines for PC
		busb_mar_in,busc_mar_in, // control lines for MAR
		busc_mdr_out,busa_mdr_in,busb_mdr_in,mem_in,mem_out, //control lines for MDR
		busc_ir_in,instrn_ir_out, //control lines for IR
		RDADDRESS1,RDADDRESS2,WRADDRESS, read, write, //control lines to REGISTER FILE
		load_alu_a, load_alu_b, // controls lines to control input to ALU
		r_load_in,r_out, // control lines to output of ALU
		OP_SELECT,
		mem_cs, mem_rd_wr,
		clk
	);

	input clk;

	output pc_in,pc_out,pc_increment;
	output busb_mar_in,busc_mar_in;
	output busc_mdr_out,busa_mdr_in,busb_mdr_in,mem_in,mem_out;
	output busc_ir_in,instrn_ir_out;

	output[4:0] RDADDRESS1,RDADDRESS2,WRADDRESS;
	output read, write;

	output load_alu_a, load_alu_b;
	output[3:0] OP_SELECT;

	output r_load_in,r_out;

	//output to BUS;
	output[31:0] BUSC_DATA_OUT;
	output cu_busc_out;

	output mem_cs, mem_rd_wr;


endmodule // control_unit
