//for use in FPA
`ifndef _exp_balance_vh_
`define _exp_balance_vh_

`include "prefixAdder8.v"
`include "D-FlipFlop.v"
`include "barrelShifter.v"


//11 clock cycles - input : clk 0; output : clk 11;
//equalises smaller exponent to larger exponent : and shifts mantissas

/*IMPORTANT NOTE : make sure difference in exponents is at most 23 bits -- taken care*/

module exponent_balance(FP_EXPLARGE,FP_EXPSMALL,OUT_A_SIGN,OUT_A_MANTISSA,OUT_B_SIGN,OUT_B_MANTISSA,OUT_EXPONENT,clk);

	input[31:0] FP_EXPLARGE,FP_EXPSMALL;
	input clk;

	output OUT_A_SIGN, OUT_B_SIGN;

	//24 bit mantissa - with explicit hidden bit
	output[23:0] OUT_A_MANTISSA, OUT_B_MANTISSA;
	output[7:0] OUT_EXPONENT;

	wire[7:0] EXPONENT_LARGE, EXPONENT_SMALL;

	assign EXPONENT_LARGE = FP_EXPLARGE[30:23];
	assign EXPONENT_SMALL = FP_EXPSMALL[30:23];

	//take difference of exponents
	wire exp_PA_cout;
	wire[7:0] EXP_PA_DIFF;
	prefixAdder8bit PA_exp_diff(EXPONENT_LARGE,~EXPONENT_SMALL,1,exp_PA_cout,EXP_PA_DIFF,clk);

	//capture difference in a DFlipFlop: 3rd clock cycle
	wire[7:0] EXP_DIFF_FFOUT;
	DFlipFlop8 EXP_DIFF_DFF(EXP_PA_DIFF,clk,EXP_DIFF_FFOUT);


	/*DELAY SIGN AND MANTISSA bits : wait for DIFFERENCE RESULT  -start */

	//1st clock cycle
	wire level1_FPA_sign, level1_FPB_sign;
	wire[22:0] level1_FPA_mantissa,level1_FPB_mantissa;
	wire[7:0] level1_FP_exponent; //propogate larger exponent


	DFlipFlop2IN level1_sign_FF(FP_EXPLARGE[31],FP_EXPSMALL[31],clk,level1_FPA_sign,level1_FPB_sign);
	DFlipFlop23 level1_mantissaA_FF(FP_EXPLARGE[22:0],clk,level1_FPA_mantissa);
	DFlipFlop23 level1_mantissaB_FF(FP_EXPSMALL[22:0],clk,level1_FPB_mantissa);
	DFlipFlop8 level1_exponent_FF(EXPONENT_LARGE,clk,level1_FP_exponent);

	//2nd clock cycle
	wire level2_FPA_sign, level2_FPB_sign;
	wire[22:0] level2_FPA_mantissa,level2_FPB_mantissa;
	wire[7:0] level2_FP_exponent; //propogate larger exponent

	DFlipFlop2IN level2_sign_FF(level1_FPA_sign,level1_FPB_sign,clk,level2_FPA_sign,level2_FPB_sign);
	DFlipFlop23 level2_mantissaA_FF(level1_FPA_mantissa,clk,level2_FPA_mantissa);
	DFlipFlop23 level2_mantissaB_FF(level1_FPB_mantissa,clk,level2_FPB_mantissa);
	DFlipFlop8 level2_exponent_FF(level1_FP_exponent,clk,level2_FP_exponent);

	//3rd clock cycle
	wire level3_FPA_sign, level3_FPB_sign;
	wire[22:0] level3_FPA_mantissa,level3_FPB_mantissa;
	wire[7:0] level3_FP_exponent; //propogate larger exponent

	DFlipFlop2IN level3_sign_FF(level2_FPA_sign,level2_FPB_sign,clk,level3_FPA_sign,level3_FPB_sign);
	DFlipFlop23 level3_mantissaA_FF(level2_FPA_mantissa,clk,level3_FPA_mantissa);
	DFlipFlop23 level3_mantissaB_FF(level2_FPB_mantissa,clk,level3_FPB_mantissa);
	DFlipFlop8 level3_exponent_FF(level2_FP_exponent,clk,level3_FP_exponent);

	/*DELAY SIGN AND MANTISSA bits : wait for DIFFERENCE RESULT  --end */


	/*Use barrel shifter to shift mantissa B --start */

	wire is_greater_31=EXP_DIFF_FFOUT[7]|EXP_DIFF_FFOUT[6]|EXP_DIFF_FFOUT[5];
	
	wire[4:0] shiftAmount;
	assign shiftAmount[0] = EXP_DIFF_FFOUT[0] | is_greater_31;
	assign shiftAmount[1] = EXP_DIFF_FFOUT[1] | is_greater_31;
	assign shiftAmount[2] = EXP_DIFF_FFOUT[2] | is_greater_31;
	assign shiftAmount[3] = EXP_DIFF_FFOUT[3] | is_greater_31;
	assign shiftAmount[4] = EXP_DIFF_FFOUT[4] | is_greater_31;

	wire[31:0] shiftData;
	assign shiftData[31]=1;
	assign shiftData[30:8]=level3_FPB_mantissa;
	assign shiftData[7:0]=8'd0;

	wire[31:0] MANTISSA_SHIFTEDB_FFIN;
	
	//24 bit mantissa
	wire[23:0] MANTISSA_SHIFTEDB_FFOUT;

	//BS : 7 clock cycles - output at 10th clock cycle (3+7)
	barrelShifterRotator BSA(shiftData,shiftAmount,0,0,0,clk,MANTISSA_SHIFTEDB_FFIN);
	DFlipFlop24 shifted_EXP_FF(MANTISSA_SHIFTEDB_FFIN[31:8],clk,MANTISSA_SHIFTEDB_FFOUT);

	/*Use barrel shifter to shift mantissa B --end */

	/*Propogate signs, mantissa of A, common exponent - 10 clock cycle --start */

	//4th clock cycle
	wire level4_FPA_sign, level4_FPB_sign;
	wire[22:0] level4_FPA_mantissa;
	wire[7:0] level4_FP_exponent;

	DFlipFlop2IN level4_sign_FF(level3_FPA_sign,level3_FPB_sign,clk,level4_FPA_sign,level4_FPB_sign);
	DFlipFlop23 level4_mantissaA_FF(level3_FPA_mantissa,clk,level4_FPA_mantissa);
	DFlipFlop8 level4_exponent_FF(level3_FP_exponent,clk,level4_FP_exponent);

	//5th clock cycle
	wire level5_FPA_sign, level5_FPB_sign;
	wire[22:0] level5_FPA_mantissa;
	wire[7:0] level5_FP_exponent;

	DFlipFlop2IN level5_sign_FF(level4_FPA_sign,level4_FPB_sign,clk,level5_FPA_sign,level5_FPB_sign);
	DFlipFlop23 level5_mantissaA_FF(level4_FPA_mantissa,clk,level5_FPA_mantissa);
	DFlipFlop8 level5_exponent_FF(level4_FP_exponent,clk,level5_FP_exponent);

	//6th clock cycle
	wire level6_FPA_sign, level6_FPB_sign;
	wire[22:0] level6_FPA_mantissa;
	wire[7:0] level6_FP_exponent;

	DFlipFlop2IN level6_sign_FF(level5_FPA_sign,level5_FPB_sign,clk,level6_FPA_sign,level6_FPB_sign);
	DFlipFlop23 level6_mantissaA_FF(level5_FPA_mantissa,clk,level6_FPA_mantissa);
	DFlipFlop8 level6_exponent_FF(level5_FP_exponent,clk,level6_FP_exponent);

	//7th clock cycle
	wire level7_FPA_sign, level7_FPB_sign;
	wire[22:0] level7_FPA_mantissa;
	wire[7:0] level7_FP_exponent;

	DFlipFlop2IN level7_sign_FF(level6_FPA_sign,level6_FPB_sign,clk,level7_FPA_sign,level7_FPB_sign);
	DFlipFlop23 level7_mantissaA_FF(level6_FPA_mantissa,clk,level7_FPA_mantissa);
	DFlipFlop8 level7_exponent_FF(level6_FP_exponent,clk,level7_FP_exponent);

	//8th clock cycle
	wire level8_FPA_sign, level8_FPB_sign;
	wire[22:0] level8_FPA_mantissa;
	wire[7:0] level8_FP_exponent;

	DFlipFlop2IN level8_sign_FF(level7_FPA_sign,level7_FPB_sign,clk,level8_FPA_sign,level8_FPB_sign);
	DFlipFlop23 level8_mantissaA_FF(level7_FPA_mantissa,clk,level8_FPA_mantissa);
	DFlipFlop8 level8_exponent_FF(level7_FP_exponent,clk,level8_FP_exponent);

	//9th clock cycle
	wire level9_FPA_sign, level9_FPB_sign;
	wire[22:0] level9_FPA_mantissa;
	wire[7:0] level9_FP_exponent;

	DFlipFlop2IN level9_sign_FF(level8_FPA_sign,level8_FPB_sign,clk,level9_FPA_sign,level9_FPB_sign);
	DFlipFlop23 level9_mantissaA_FF(level8_FPA_mantissa,clk,level9_FPA_mantissa);
	DFlipFlop8 level9_exponent_FF(level8_FP_exponent,clk,level9_FP_exponent);

	//10th clock cycle
	wire level10_FPA_sign, level10_FPB_sign;
	wire[22:0] level10_FPA_mantissa;
	wire[7:0] level10_FP_exponent;

	DFlipFlop2IN level10_sign_FF(level9_FPA_sign,level9_FPB_sign,clk,level10_FPA_sign,level10_FPB_sign);
	DFlipFlop23 level10_mantissaA_FF(level9_FPA_mantissa,clk,level10_FPA_mantissa);
	DFlipFlop8 level10_exponent_FF(level9_FP_exponent,clk,level10_FP_exponent);
	/*Propogate signs, mantissa of A, common exponent - 10 clock cycle --end */

	/*OUTPUT RESULTS --  start */
	
	assign OUT_A_SIGN = level10_FPA_sign;
	assign OUT_B_SIGN = level10_FPB_sign;

	assign OUT_A_MANTISSA[23]=1;
	assign OUT_A_MANTISSA[22:0]=level10_FPA_mantissa;

	assign OUT_B_MANTISSA=MANTISSA_SHIFTEDB_FFOUT;

	assign OUT_EXPONENT=level10_FP_exponent;

	/*OUTPUT RESULTS --  end */

endmodule // exponent_balance

`endif
