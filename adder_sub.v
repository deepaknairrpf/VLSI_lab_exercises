//header guards
`ifndef _add_sub_vh_
`define _add_sub_vh_

`include "prefixAdder.v"

//Adder and Subtractor
/*
	cin=0; neg_b=0	=>	Addition
	cin=1; neg_b=0	=>	Addition with carry
	cin=1; neg_b=1	=>	Subtraction
	cin=0; neg_b=1	=>	Subtraction with borrow
*/

//5 clock cycles - input : clk 0; output : clk 5
module Adder_Subtractor(A,B,cin,neg_b,cout,SUM,clk);
	
	input[31:0] A,B;
	input cin,neg_b,clk;

	output cout;
	output[31:0] SUM;

	wire[31:0] PA_B_IN;
	assign PA_B_IN[0] = B[0] ^ neg_b;
	assign PA_B_IN[1] = B[1] ^ neg_b;
	assign PA_B_IN[2] = B[2] ^ neg_b;
	assign PA_B_IN[3] = B[3] ^ neg_b;
	assign PA_B_IN[4] = B[4] ^ neg_b;
	assign PA_B_IN[5] = B[5] ^ neg_b;
	assign PA_B_IN[6] = B[6] ^ neg_b;
	assign PA_B_IN[7] = B[7] ^ neg_b;
	assign PA_B_IN[8] = B[8] ^ neg_b;
	assign PA_B_IN[9] = B[9] ^ neg_b;
	assign PA_B_IN[10] = B[10] ^ neg_b;
	assign PA_B_IN[11] = B[11] ^ neg_b;
	assign PA_B_IN[12] = B[12] ^ neg_b;
	assign PA_B_IN[13] = B[13] ^ neg_b;
	assign PA_B_IN[14] = B[14] ^ neg_b;
	assign PA_B_IN[15] = B[15] ^ neg_b;
	assign PA_B_IN[16] = B[16] ^ neg_b;
	assign PA_B_IN[17] = B[17] ^ neg_b;
	assign PA_B_IN[18] = B[18] ^ neg_b;
	assign PA_B_IN[19] = B[19] ^ neg_b;
	assign PA_B_IN[20] = B[20] ^ neg_b;
	assign PA_B_IN[21] = B[21] ^ neg_b;
	assign PA_B_IN[22] = B[22] ^ neg_b;
	assign PA_B_IN[23] = B[23] ^ neg_b;
	assign PA_B_IN[24] = B[24] ^ neg_b;
	assign PA_B_IN[25] = B[25] ^ neg_b;
	assign PA_B_IN[26] = B[26] ^ neg_b;
	assign PA_B_IN[27] = B[27] ^ neg_b;
	assign PA_B_IN[28] = B[28] ^ neg_b;
	assign PA_B_IN[29] = B[29] ^ neg_b;
	assign PA_B_IN[30] = B[30] ^ neg_b;
	assign PA_B_IN[31] = B[31] ^ neg_b;

	prefixAdder adder_sub(A,PA_B_IN,cin,cout,SUM,clk);
	
endmodule // Adder_Subtractor

`endif
