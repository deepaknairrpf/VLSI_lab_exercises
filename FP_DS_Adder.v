//header guards
`ifndef _FP_DS_Adder_vh_
`define _FP_DS_Adder_vh_

`include "prefixAdder.v"
`include "D-FlipFlop.v"
`include "MUX2.v"
`include "priorityEncoder.v"
`include "barrelShifter.v"
`include "prefixAdder8.v"

//adds FP number of different signs - cannot handle 0 result inputs

//20 clock cycles - input : clk 0 ; output : clk 20
module FF_DS_Adder
	(
		SIGN_A,MANTISSA_A,SIGN_B,MANTISSA_B,EXPONENT, 	//inputs
		SUM,	//outputs
		clk
	);

	input SIGN_A,SIGN_B,clk;
	input[23:0] MANTISSA_A,MANTISSA_B;
	input[7:0] EXPONENT;

	output[31:0] SUM;

	/*compares the MANTISSAS, places larger: A, smaller: B -- start */
	wire[31:0] PA_IN_MANTISSA, PA_IN_MANTISSB;
	assign PA_IN_MANTISSA[23:0] = MANTISSA_A;
	assign PA_IN_MANTISSA[31:24]= 8'd0;
	assign PA_IN_MANTISSB[23:0] = MANTISSA_B;
	assign PA_IN_MANTISSB[31:24]= 8'd0;

	wire AgB_cout;
	wire[31:0] MANTISSA_DIFF;
	//subtracts to find larger MANTISSA
	prefixAdder PA_MANTISSA_COMP(PA_IN_MANTISSA,~PA_IN_MANTISSB,1,AgB_cout,MANTISSA_DIFF,clk);
	
	//5th clock cycle - capture AgB;
	wire AgB_cout_FFOUT;
	DFlipFlop AgB_FF(AgB_cout,clk,AgB_cout_FFOUT);
	/*compares the MANTISSAS, places larger: A, smaller: B -- end */


	/*DELAY MANTISSA,SIGN A,B ; EXPONENT by 5 clk cycles -- start */
	
	//1st clock cycle
	wire[23:0] level1_MANTISSA,level1_MANTISSB;
	wire level1_SIGNA,level1_SIGNB;
	wire[7:0] level1_EXPONENT;
	DFlipFlop24 level1_MANTISSA_FF(MANTISSA_A,clk,level1_MANTISSA);
	DFlipFlop24 level1_MANTISSB_FF(MANTISSA_B,clk,level1_MANTISSB);
	DFlipFlop2IN level1_SIGN_FF(SIGN_A,SIGN_B,clk,level1_SIGNA,level1_SIGNB);
	DFlipFlop8 level1_EXPONENT_FF(EXPONENT,clk,level1_EXPONENT);

	//2th clock cycle
	wire[23:0] level2_MANTISSA,level2_MANTISSB;
	wire level2_SIGNA,level2_SIGNB;
	wire[7:0] level2_EXPONENT;

	DFlipFlop24 level2_MANTISSA_FF(level1_MANTISSA,clk,level2_MANTISSA);
	DFlipFlop24 level2_MANTISSB_FF(level1_MANTISSB,clk,level2_MANTISSB);
	DFlipFlop2IN level2_SIGN_FF(level1_SIGNA,level1_SIGNB,clk,level2_SIGNA,level2_SIGNB);
	DFlipFlop8 level2_EXPONENT_FF(level1_EXPONENT,clk,level2_EXPONENT);

	//3th clock cycle
	wire[23:0] level3_MANTISSA,level3_MANTISSB;
	wire level3_SIGNA,level3_SIGNB;
	wire[7:0] level3_EXPONENT;

	DFlipFlop24 level3_MANTISSA_FF(level2_MANTISSA,clk,level3_MANTISSA);
	DFlipFlop24 level3_MANTISSB_FF(level2_MANTISSB,clk,level3_MANTISSB);
	DFlipFlop2IN level3_SIGN_FF(level2_SIGNA,level2_SIGNB,clk,level3_SIGNA,level3_SIGNB);
	DFlipFlop8 level3_EXPONENT_FF(level2_EXPONENT,clk,level3_EXPONENT);

	//4th clock cycle
	wire[23:0] level4_MANTISSA,level4_MANTISSB;
	wire level4_SIGNA,level4_SIGNB;
	wire[7:0] level4_EXPONENT;

	DFlipFlop24 level4_MANTISSA_FF(level3_MANTISSA,clk,level4_MANTISSA);
	DFlipFlop24 level4_MANTISSB_FF(level3_MANTISSB,clk,level4_MANTISSB);
	DFlipFlop2IN level4_SIGN_FF(level3_SIGNA,level3_SIGNB,clk,level4_SIGNA,level4_SIGNB);
	DFlipFlop8 level4_EXPONENT_FF(level3_EXPONENT,clk,level4_EXPONENT);

	//5th clock cycle
	wire[23:0] level5_MANTISSA,level5_MANTISSB;
	wire level5_SIGNA,level5_SIGNB;
	wire[7:0] level5_EXPONENT;

	DFlipFlop24 level5_MANTISSA_FF(level4_MANTISSA,clk,level5_MANTISSA);
	DFlipFlop24 level5_MANTISSB_FF(level4_MANTISSB,clk,level5_MANTISSB);
	DFlipFlop2IN level5_SIGN_FF(level4_SIGNA,level4_SIGNB,clk,level5_SIGNA,level5_SIGNB);
	DFlipFlop8 level5_EXPONENT_FF(level4_EXPONENT,clk,level5_EXPONENT);
	/*DELAY MANTISSA,SIGN A,B ; EXPONENT by 5 clk cycles -- end */ 

	/*PUT LARGER MANTISSA FP IN A ; SMALLER MANTISSA FP IN B --start */
	wire SWAP_SIGN;
	MUX2x1 MUX_SIGN(level5_SIGNB,level5_SIGNA,AgB_cout_FFOUT,SWAP_SIGN);

	//6th clock cycle : Ignore sign of smaller
	wire SIGN_FFOUT;
	DFlipFlop SIGN_FF(SWAP_SIGN,clk,SIGN_FFOUT);

	wire[23:0] SWAP_MANTISSA, SWAP_MANTISSB;
	MUX24bit_2x1 MUX_MANTISSA(level5_MANTISSB,level5_MANTISSA,AgB_cout_FFOUT,SWAP_MANTISSA);
	MUX24bit_2x1 MUX_MANTISSB(level5_MANTISSA,level5_MANTISSB,AgB_cout_FFOUT,SWAP_MANTISSB);

	//6th clock cycle
	wire[23:0] MANTISSA_FFOUT, MANTISSB_FFOUT;
	DFlipFlop24 SWAP_MANTISSA_FF(SWAP_MANTISSA,clk,MANTISSA_FFOUT);
	DFlipFlop24 SWAP_MANTISSB_FF(SWAP_MANTISSB,clk,MANTISSB_FFOUT);

	//6th clock cycle
	wire[7:0] level6_EXPONENT;
	DFlipFlop8 SWAP_EXPONENT_FF(level5_EXPONENT,clk,level6_EXPONENT);
	/*PUT LARGER MANTISSA FP IN A ; SMALLER MANTISSA FP IN B --end */
	

	/*Subtract larger MANTISSA from SMALLER  --start  */
	wire[31:0] PA1_MANTISSA_IN, PA1_MANTISSB_IN, PA1_MANTISSA_DIFF;
	assign PA1_MANTISSA_IN[7:0] = 8'd0;
	assign PA1_MANTISSA_IN[31:8]  = MANTISSA_FFOUT;
	assign PA1_MANTISSB_IN[7:0] = 8'd0;
	assign PA1_MANTISSB_IN[31:8]  = MANTISSB_FFOUT;

	//subtract the mantissas
	wire AgB_cout_PA1;
	prefixAdder PA_MANTISSA_DIFF(PA1_MANTISSA_IN,~PA1_MANTISSB_IN,1,AgB_cout_PA1,PA1_MANTISSA_DIFF,clk);

	//11th clock cycle
	wire[31:0] MANTISSA_DIFF_FFOUT;
	DFlipFlop32 MANTISSA_DIFF_FF(PA1_MANTISSA_DIFF,clk,MANTISSA_DIFF_FFOUT);

	//Propogate MANTISSA_DIFF_FFOUT till 13th clock cycle
	//12th clock cycle
	wire[31:0] level12_MANTISSA_DIFF;
	DFlipFlop32 level12_MANTISSA_FF(MANTISSA_DIFF_FFOUT,clk,level12_MANTISSA_DIFF);

	//13th clock cycle
	wire[31:0] level13_MANTISSA_DIFF;
	DFlipFlop32 level13_MANTISSA_FF(level12_MANTISSA_DIFF,clk,level13_MANTISSA_DIFF);

	//Priority Encoding the MANTISSA DIFFERENCE
	wire[31:0] MANTISSA_PE_IN;
	//reverse bits of MANTISSA_DIFF_FFOUT into MANTISSA_PE_IN
	assign MANTISSA_PE_IN[0]=MANTISSA_DIFF_FFOUT[31];
	assign MANTISSA_PE_IN[1]=MANTISSA_DIFF_FFOUT[30];
	assign MANTISSA_PE_IN[2]=MANTISSA_DIFF_FFOUT[29];
	assign MANTISSA_PE_IN[3]=MANTISSA_DIFF_FFOUT[28];
	assign MANTISSA_PE_IN[4]=MANTISSA_DIFF_FFOUT[27];
	assign MANTISSA_PE_IN[5]=MANTISSA_DIFF_FFOUT[26];
	assign MANTISSA_PE_IN[6]=MANTISSA_DIFF_FFOUT[25];
	assign MANTISSA_PE_IN[7]=MANTISSA_DIFF_FFOUT[24];
	assign MANTISSA_PE_IN[8]=MANTISSA_DIFF_FFOUT[23];
	assign MANTISSA_PE_IN[9]=MANTISSA_DIFF_FFOUT[22];
	assign MANTISSA_PE_IN[10]=MANTISSA_DIFF_FFOUT[21];
	assign MANTISSA_PE_IN[11]=MANTISSA_DIFF_FFOUT[20];
	assign MANTISSA_PE_IN[12]=MANTISSA_DIFF_FFOUT[19];
	assign MANTISSA_PE_IN[13]=MANTISSA_DIFF_FFOUT[18];
	assign MANTISSA_PE_IN[14]=MANTISSA_DIFF_FFOUT[17];
	assign MANTISSA_PE_IN[15]=MANTISSA_DIFF_FFOUT[16];
	assign MANTISSA_PE_IN[16]=MANTISSA_DIFF_FFOUT[15];
	assign MANTISSA_PE_IN[17]=MANTISSA_DIFF_FFOUT[14];
	assign MANTISSA_PE_IN[18]=MANTISSA_DIFF_FFOUT[13];
	assign MANTISSA_PE_IN[19]=MANTISSA_DIFF_FFOUT[12];
	assign MANTISSA_PE_IN[20]=MANTISSA_DIFF_FFOUT[11];
	assign MANTISSA_PE_IN[21]=MANTISSA_DIFF_FFOUT[10];
	assign MANTISSA_PE_IN[22]=MANTISSA_DIFF_FFOUT[9];
	assign MANTISSA_PE_IN[23]=MANTISSA_DIFF_FFOUT[8];
	assign MANTISSA_PE_IN[24]=MANTISSA_DIFF_FFOUT[7];
	assign MANTISSA_PE_IN[25]=MANTISSA_DIFF_FFOUT[6];
	assign MANTISSA_PE_IN[26]=MANTISSA_DIFF_FFOUT[5];
	assign MANTISSA_PE_IN[27]=MANTISSA_DIFF_FFOUT[4];
	assign MANTISSA_PE_IN[28]=MANTISSA_DIFF_FFOUT[3];
	assign MANTISSA_PE_IN[29]=MANTISSA_DIFF_FFOUT[2];
	assign MANTISSA_PE_IN[30]=MANTISSA_DIFF_FFOUT[1];
	assign MANTISSA_PE_IN[31]=MANTISSA_DIFF_FFOUT[0];

	wire[4:0] MANTISSA_NORMALISER;
	wire PEinput_valid;
	priorityEncoder32x5 PE_MANTISSA_DIFF(MANTISSA_PE_IN,MANTISSA_NORMALISER,PEinput_valid,clk);

	//13th clock cycle
	wire[4:0] MANTISSA_NORM_FFOUT;
	DFlipFlop5 MANTISSA_NORM_FF(MANTISSA_NORMALISER,clk,MANTISSA_NORM_FFOUT);

	/*Subtract larger MANTISSA from SMALLER  --end  */


	/*Delay Sign, Exponent - 6th  to  13th clock  cycle -- start*/

	//7th clock cycle
	wire level7_SIGN;
	wire[7:0] level7_EXPONENT;
	DFlipFlop level7_SIGN_FF(SIGN_FFOUT,clk,level7_SIGN);
	DFlipFlop8 level7_EXPONENT_FF(level6_EXPONENT,clk,level7_EXPONENT);

	//8th clock cycle
	wire level8_SIGN;
	wire[7:0] level8_EXPONENT;
	DFlipFlop level8_SIGN_FF(level7_SIGN,clk,level8_SIGN);
	DFlipFlop8 level8_EXPONENT_FF(level7_EXPONENT,clk,level8_EXPONENT);

	//9th clock cycle
	wire level9_SIGN;
	wire[7:0] level9_EXPONENT;
	DFlipFlop level9_SIGN_FF(level8_SIGN,clk,level9_SIGN);
	DFlipFlop8 level9_EXPONENT_FF(level8_EXPONENT,clk,level9_EXPONENT);

	//10th clock cycle
	wire level10_SIGN;
	wire[7:0] level10_EXPONENT;
	DFlipFlop level10_SIGN_FF(level9_SIGN,clk,level10_SIGN);
	DFlipFlop8 level10_EXPONENT_FF(level9_EXPONENT,clk,level10_EXPONENT);

	//11th clock cycle
	wire level11_SIGN;
	wire[7:0] level11_EXPONENT;
	DFlipFlop level11_SIGN_FF(level10_SIGN,clk,level11_SIGN);
	DFlipFlop8 level11_EXPONENT_FF(level10_EXPONENT,clk,level11_EXPONENT);

	//12th clock cycle
	wire level12_SIGN;
	wire[7:0] level12_EXPONENT;
	DFlipFlop level12_SIGN_FF(level11_SIGN,clk,level12_SIGN);
	DFlipFlop8 level12_EXPONENT_FF(level11_EXPONENT,clk,level12_EXPONENT);

	//13th clock cycle
	wire level13_SIGN;
	wire[7:0] level13_EXPONENT;
	DFlipFlop level13_SIGN_FF(level12_SIGN,clk,level13_SIGN);
	DFlipFlop8 level13_EXPONENT_FF(level12_EXPONENT,clk,level13_EXPONENT);

	//14th clock cycle
	wire level14_SIGN;
	DFlipFlop level14_SIGN_FF(level13_SIGN,clk,level14_SIGN);

	//15th clock cycle
	wire level15_SIGN;
	DFlipFlop level15_SIGN_FF(level14_SIGN,clk,level15_SIGN);

	//16th clock cycle
	wire level16_SIGN;
	DFlipFlop level16_SIGN_FF(level15_SIGN,clk,level16_SIGN);

	//17th clock cycle
	wire level17_SIGN;
	DFlipFlop level17_SIGN_FF(level16_SIGN,clk,level17_SIGN);

	//18th clock cycle
	wire level18_SIGN;
	DFlipFlop level18_SIGN_FF(level17_SIGN,clk,level18_SIGN);

	//19th clock cycle
	wire level19_SIGN;
	DFlipFlop level19_SIGN_FF(level18_SIGN,clk,level19_SIGN);

	/*Delay sign till 20th clock cycle*/


	/*Delay Sign, Exponent - 6th  to  13th clock  cycle -- end*/
	
	/*Normalise MANTISSA and EXPONENT -- start */
	
	//Left shift the mantissa
	wire[31:0] SHIFTED_MANTISSA, SHIFT_MANTISSA_FFOUT;
	//output - 20th clock cycle
	barrelShifterRotator BS_MANTISSA_SHIFT(level13_MANTISSA_DIFF,MANTISSA_NORM_FFOUT,1,0,0,clk,SHIFTED_MANTISSA);

	//subtract normaliser from exponent
	wire[7:0] MANTISSA_NORM;
	assign MANTISSA_NORM[4:0]=MANTISSA_NORM_FFOUT;
	assign MANTISSA_NORM[7:5]=3'd0;

	wire[7:0] NORMALISED_EXPONENT;
	wire exponent_norm_cout;
	//output - 15 th clock cycle
	prefixAdder8bit PA_EXP_NORM(level13_EXPONENT,~MANTISSA_NORM,1,exponent_norm_cout,NORMALISED_EXPONENT,clk);

	//16th clock cycle
	wire[7:0] level16_exponent;
	DFlipFlop8 level16_exponentFF(NORMALISED_EXPONENT,clk,level16_exponent);

	//17th clock cycle
	wire[7:0] level17_exponent;
	DFlipFlop8 level17_exponentFF(level16_exponent,clk,level17_exponent);

	//18th clock cycle
	wire[7:0] level18_exponent;
	DFlipFlop8 level18_exponentFF(level17_exponent,clk,level18_exponent);

	//19th clock cycle
	wire[7:0] level19_exponent;
	DFlipFlop8 level19_exponentFF(level18_exponent,clk,level19_exponent);
	/*Normalise MANTISSA and EXPONENT -- end */

	//generating output
	assign SUM[31]=level19_SIGN;
	assign SUM[30:23]=level19_exponent;
	assign SUM[22:0]=SHIFTED_MANTISSA[30:8];

endmodule // FF_DS_Adder

`endif
