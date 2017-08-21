//header guards
`ifndef _FP_SS_Adder_vh_
`define _FP_SS_Adder_vh_

//adds FP numbers of same sign
`include "prefixAdder.v"
`include "D-FlipFlop.v"
`include "prefixAdder8.v"
`include "MUX2.v"
//6 clock cycles - input : clk 0 ; output : clk 6
module FP_SS_Adder
	(
		SIGN_A,MANTISSA_A,SIGN_B,MANTISSA_B,EXPONENT, 	//inputs
		SUM,
		clk //clock		
	);

	input SIGN_A, SIGN_B, clk;
	input[23:0] MANTISSA_A, MANTISSA_B;
	input[7:0] EXPONENT;

	output[31:0] SUM;


	wire[31:0] PA_IN_MANTISSA, PA_IN_MANTISSB;
	assign PA_IN_MANTISSA[23:0] = MANTISSA_A;
	assign PA_IN_MANTISSA[31:24] = 8'd0;
	assign PA_IN_MANTISSB[23:0] = MANTISSA_B;
	assign PA_IN_MANTISSB[31:24] = 8'd0;

//module prefixAdder(X,Y,cin,cout,SUM,clk);
	wire pa_mantissa_cout;
	wire mantissa_cout_ffout;

	wire[31:0] MANTISSA_SUM;
	wire[23:0] MANTISSA_SUM_FFOUT;
	prefixAdder PA_MANTISSA_SUM(PA_IN_MANTISSA,PA_IN_MANTISSB,0,pa_mantissa_cout,MANTISSA_SUM,clk);

	//5th clock cycle
	DFlipFlop MANTISSA_COUT_FF(MANTISSA_SUM[24],clk,mantissa_cout_ffout);
	DFlipFlop24 MANTISSA_SUM_FF(MANTISSA_SUM[23:0],clk,MANTISSA_SUM_FFOUT);


	/*PARALLEL COMPUTING 'EXPONENT+1' : if exponent to be normalised -- start */
	wire[7:0] EXP_PLUS_1;
	wire EXP_PLUS_1_cout;
	prefixAdder8bit EXP_PLUS_1PA(EXPONENT,8'd1,0,EXP_PLUS_1_cout,EXP_PLUS_1,clk);

	//3rd clock cycle
	wire[7:0] level3_EXP_PLUS1;
	DFlipFlop8 level3_EXP_PLUS_1FF(EXP_PLUS_1,clk,level3_EXP_PLUS1);
	
	//4th clock cycle
	wire[7:0] level4_EXP_PLUS1;
	DFlipFlop8 level4_EXP_PLUS_1FF(level3_EXP_PLUS1,clk,level4_EXP_PLUS1);
	
	//5th clock cycle
	wire[7:0] level5_EXP_PLUS1;
	DFlipFlop8 level5_EXP_PLUS_1FF(level4_EXP_PLUS1,clk,level5_EXP_PLUS1);

	/*PARALLEL COMPUTING 'EXPONENT+1' : if exponent to be normalised -- end */

	/*DELAY ORIGINAL EXPONENT 5 clock cycles --start */

	//1st clock cycle
	wire[7:0] level1_EXP;
	wire level1_SIGN;
	DFlipFlop8 level1_EXP_FF(EXPONENT,clk,level1_EXP);
	DFlipFlop level1_SIGN_FF(SIGN_A,clk,level1_SIGN);

	//2nd clock cycle
	wire[7:0] level2_EXP;
	wire level2_SIGN;
	DFlipFlop8 level2_EXP_FF(level1_EXP,clk,level2_EXP);
	DFlipFlop level2_SIGN_FF(level1_SIGN,clk,level2_SIGN);

	//3rd clock cycle
	wire[7:0] level3_EXP;
	wire level3_SIGN;
	DFlipFlop8 level3_EXP_FF(level2_EXP,clk,level3_EXP);
	DFlipFlop level3_SIGN_FF(level2_SIGN,clk,level3_SIGN);

	//4th clock cycle
	wire[7:0] level4_EXP;
	wire level4_SIGN;
	DFlipFlop8 level4_EXP_FF(level3_EXP,clk,level4_EXP);
	DFlipFlop level4_SIGN_FF(level3_SIGN,clk,level4_SIGN);

	//5th clock cycle
	wire[7:0] level5_EXP;
	wire level5_SIGN;
	DFlipFlop8 level5_EXP_FF(level4_EXP,clk,level5_EXP);
	DFlipFlop level5_SIGN_FF(level4_SIGN,clk,level5_SIGN);

	/*DELAY ORIGINAL EXPONENT 5 clock cycles --end */

	//normalised mantissa
	wire[23:0] SHIFTED_MANTISSA;
	MUX_24bitShifter MUX_MANTISSA_NORM(MANTISSA_SUM_FFOUT,mantissa_cout_ffout,SHIFTED_MANTISSA);
	assign SUM[22:0] = SHIFTED_MANTISSA[22:0];
	assign SUM[31] = level5_SIGN;

	MUX8bit_2x1 EXP_MUX(level5_EXP,level5_EXP_PLUS1,mantissa_cout_ffout,SUM[30:23]);

endmodule // FP_SS_Adder

`endif
