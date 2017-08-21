`ifndef _comp_swap_vh_
`define _comp_swap_vh_

`include "prefixAdder8.v"
`include "D-FlipFlop.v"
`include "MUX2.v"

/*for use in FPA*/

//4 clock cycles - input : clk 0 ; output : clk 4

//compares the exponents of 2 FP numbers: and swaps if necessary
module comparator_swap(A,B,OUT_EXPLARGE,OUT_EXPSMALL,clk);

	input[31:0] A,B;
	input clk;

	output[31:0] OUT_EXPLARGE,OUT_EXPSMALL;

	//difference of exponents A-B

	//ignore difference and use cout and a>=b flag
	wire[7:0] EXPONENT_SUB_DIFF;
	wire PA_cout_FFIN;

	//module prefixAdder8bit(X,Y,cin,cout,SUM,clk); //pipelined
	prefixAdder8bit PA_exp_diff(A[30:23],~B[30:23],1,PA_cout_FFIN,EXPONENT_SUB_DIFF,clk);

	//3rd clock cycle
	wire PA_cout_FFOUT;
	DFlipFlop exp_cout_FF(PA_cout_FFIN,clk,PA_cout_FFOUT);

	/*DELAYING A and B until PA produces OUTPUT --start */
	
	//1st clock
	wire[31:0] level1_A_FFOUT,level1_B_FFOUT;
	DFlipFlop32 level1_A_FF(A,clk,level1_A_FFOUT);
	DFlipFlop32 level1_B_FF(B,clk,level1_B_FFOUT);

	//2nd clock cycle
	wire[31:0] level2_A_FFOUT,level2_B_FFOUT;
	DFlipFlop32 level2_A_FF(level1_A_FFOUT,clk,level2_A_FFOUT);
	DFlipFlop32 level2_B_FF(level1_B_FFOUT,clk,level2_B_FFOUT);

	//3rd clock cycle
	wire[31:0] level3_A_FFOUT,level3_B_FFOUT;
	DFlipFlop32 level3_A_FF(level2_A_FFOUT,clk,level3_A_FFOUT);
	DFlipFlop32 level3_B_FF(level2_B_FFOUT,clk,level3_B_FFOUT);

	/*DELAYING A and B until PA produces OUTPUT --end */

	MUX32bit_2x1 MUX_EXPLARGE(level3_A_FFOUT,level3_B_FFOUT,~PA_cout_FFOUT,OUT_EXPLARGE);
	MUX32bit_2x1 MUX_EXPSMALL(level3_A_FFOUT,level3_B_FFOUT,PA_cout_FFOUT,OUT_EXPSMALL);

endmodule // comparator_swap

`endif
