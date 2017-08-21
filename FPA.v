//header guards
`ifndef _FPA_vh_
`define _FPA_vh_

`include "comp_swap.v"
`include "exp_balance.v"
`include "FP_SS_Adder.v"
`include "FP_DS_Adder.v"
`include "D-FlipFlop.v"
`include "MUX2.v"

//36 clock cycles - input : clk 0; output : clk 36
module FPA(A,B,SUM,clk);

	input[31:0] A,B;
	input clk;

	output[31:0] SUM;

	wire[31:0] OUT_EXPLARGE,OUT_EXPSMALL;
	comparator_swap comp_swap(A,B,OUT_EXPLARGE,OUT_EXPSMALL,clk);

	//4th clock cycle
	wire[31:0] OUT_LARGE_FFOUT, OUT_SMALL_FFOUT;
	DFlipFlop32 OUT_LARGE_FF(OUT_EXPLARGE,clk,OUT_LARGE_FFOUT);
	DFlipFlop32 OUT_SMALL_FF(OUT_EXPSMALL,clk,OUT_SMALL_FFOUT);

	wire OUT_A_SIGN, OUT_B_SIGN;
	wire[23:0] OUT_A_MANTISSA, OUT_B_MANTISSA;
	wire[7:0] OUT_EXPONENT;
	exponent_balance exp_balance(OUT_LARGE_FFOUT,OUT_SMALL_FFOUT,OUT_A_SIGN,OUT_A_MANTISSA,OUT_B_SIGN,OUT_B_MANTISSA,OUT_EXPONENT,clk);

	//15th clock cycle
	wire SIGNA_FFOUT,SIGNB_FFOUT;
	wire[23:0] MANTISSA_FFOUT, MANTISSB_FFOUT;
	wire[7:0] EXPONENT_FFOUT;

	DFlipFlop2IN SIGN_FF(OUT_A_SIGN,OUT_B_SIGN,clk,SIGNA_FFOUT,SIGNB_FFOUT);
	DFlipFlop24 MANTISSA_FF(OUT_A_MANTISSA,clk,MANTISSA_FFOUT);
	DFlipFlop24 MANTISSB_FF(OUT_B_MANTISSA,clk,MANTISSB_FFOUT);
	DFlipFlop8 EXPONENT_FF(OUT_EXPONENT,clk,EXPONENT_FFOUT);


	wire[31:0] SUM_SS;
	FP_SS_Adder FPSSAdder(SIGNA_FFOUT,MANTISSA_FFOUT,SIGNB_FFOUT,MANTISSB_FFOUT,EXPONENT_FFOUT,SUM_SS,clk);

	//21st clock cycle
	wire[31:0] SUM_SS_FFOUT;
	DFlipFlop32 SUM_SS_FF(SUM_SS,clk,SUM_SS_FFOUT);

	wire[31:0] SUM_DS;
	FF_DS_Adder FPDSAdder(SIGNA_FFOUT,MANTISSA_FFOUT,SIGNB_FFOUT,MANTISSB_FFOUT,EXPONENT_FFOUT,SUM_DS,clk);

	//35 clock cycle
	wire[31:0] SUM_DS_FFOUT;
	DFlipFlop32 SUM_DS_FF(SUM_DS,clk,SUM_DS_FFOUT);

	/*PROPOGATE XOR OF SIGNS '16th to 35th' clock cycle -- start */
	wire sign_xor = SIGNA_FFOUT^SIGNB_FFOUT;

	//16th clock cycle
	wire level16_signXOR;
	DFlipFlop level16_signXOR_FF(sign_xor,clk,level16_signXOR);

	//17th clock cycle
	wire level17_signXOR;
	DFlipFlop level17_signXOR_FF(level16_signXOR,clk,level17_signXOR);

	//18th clock cycle
	wire level18_signXOR;
	DFlipFlop level18_signXOR_FF(level17_signXOR,clk,level18_signXOR);

	//19th clock cycle
	wire level19_signXOR;
	DFlipFlop level19_signXOR_FF(level18_signXOR,clk,level19_signXOR);

	//20th clock cycle
	wire level20_signXOR;
	DFlipFlop level20_signXOR_FF(level19_signXOR,clk,level20_signXOR);

	//21th clock cycle
	wire level21_signXOR;
	DFlipFlop level21_signXOR_FF(level20_signXOR,clk,level21_signXOR);

	//22th clock cycle
	wire level22_signXOR;
	DFlipFlop level22_signXOR_FF(level21_signXOR,clk,level22_signXOR);

	//23th clock cycle
	wire level23_signXOR;
	DFlipFlop level23_signXOR_FF(level22_signXOR,clk,level23_signXOR);

	//24th clock cycle
	wire level24_signXOR;
	DFlipFlop level24_signXOR_FF(level23_signXOR,clk,level24_signXOR);

	//25th clock cycle
	wire level25_signXOR;
	DFlipFlop level25_signXOR_FF(level24_signXOR,clk,level25_signXOR);

	//26th clock cycle
	wire level26_signXOR;
	DFlipFlop level26_signXOR_FF(level25_signXOR,clk,level26_signXOR);

	//27th clock cycle
	wire level27_signXOR;
	DFlipFlop level27_signXOR_FF(level26_signXOR,clk,level27_signXOR);

	//28th clock cycle
	wire level28_signXOR;
	DFlipFlop level28_signXOR_FF(level27_signXOR,clk,level28_signXOR);

	//29th clock cycle
	wire level29_signXOR;
	DFlipFlop level29_signXOR_FF(level28_signXOR,clk,level29_signXOR);

	//30th clock cycle
	wire level30_signXOR;
	DFlipFlop level30_signXOR_FF(level29_signXOR,clk,level30_signXOR);

	//31th clock cycle
	wire level31_signXOR;
	DFlipFlop level31_signXOR_FF(level30_signXOR,clk,level31_signXOR);

	//32th clock cycle
	wire level32_signXOR;
	DFlipFlop level32_signXOR_FF(level31_signXOR,clk,level32_signXOR);

	//33th clock cycle
	wire level33_signXOR;
	DFlipFlop level33_signXOR_FF(level32_signXOR,clk,level33_signXOR);

	//34th clock cycle
	wire level34_signXOR;
	DFlipFlop level34_signXOR_FF(level33_signXOR,clk,level34_signXOR);

	//35th clock cycle
	wire level35_signXOR;
	DFlipFlop level35_signXOR_FF(level34_signXOR,clk,level35_signXOR);
	/*PROPOGATE XOR OF SIGNS '16th to 35th' clock cycle -- start */


	/*Propogate SUM_SS_FFOUT '22nd to 35th' clock cycle -- start */
	
	//22nd clock cycle
	wire[31:0] level22_SUM_SS;
	DFlipFlop32 level22_SUMSS_FF(SUM_SS_FFOUT,clk,level22_SUM_SS);

	//23 clock cycle
	wire[31:0] level23_SUM_SS;
	DFlipFlop32 level23_SUMSS_FF(level22_SUM_SS,clk,level23_SUM_SS);

	//24 clock cycle
	wire[31:0] level24_SUM_SS;
	DFlipFlop32 level24_SUMSS_FF(level23_SUM_SS,clk,level24_SUM_SS);

	//25 clock cycle
	wire[31:0] level25_SUM_SS;
	DFlipFlop32 level25_SUMSS_FF(level24_SUM_SS,clk,level25_SUM_SS);

	//26 clock cycle
	wire[31:0] level26_SUM_SS;
	DFlipFlop32 level26_SUMSS_FF(level25_SUM_SS,clk,level26_SUM_SS);

	//27 clock cycle
	wire[31:0] level27_SUM_SS;
	DFlipFlop32 level27_SUMSS_FF(level26_SUM_SS,clk,level27_SUM_SS);

	//28 clock cycle
	wire[31:0] level28_SUM_SS;
	DFlipFlop32 level28_SUMSS_FF(level27_SUM_SS,clk,level28_SUM_SS);

	//29 clock cycle
	wire[31:0] level29_SUM_SS;
	DFlipFlop32 level29_SUMSS_FF(level28_SUM_SS,clk,level29_SUM_SS);

	//30 clock cycle
	wire[31:0] level30_SUM_SS;
	DFlipFlop32 level30_SUMSS_FF(level29_SUM_SS,clk,level30_SUM_SS);

	//31 clock cycle
	wire[31:0] level31_SUM_SS;
	DFlipFlop32 level31_SUMSS_FF(level30_SUM_SS,clk,level31_SUM_SS);

	//32 clock cycle
	wire[31:0] level32_SUM_SS;
	DFlipFlop32 level32_SUMSS_FF(level31_SUM_SS,clk,level32_SUM_SS);

	//33 clock cycle
	wire[31:0] level33_SUM_SS;
	DFlipFlop32 level33_SUMSS_FF(level32_SUM_SS,clk,level33_SUM_SS);

	//34 clock cycle
	wire[31:0] level34_SUM_SS;
	DFlipFlop32 level34_SUMSS_FF(level33_SUM_SS,clk,level34_SUM_SS);

	//35 clock cycle
	wire[31:0] level35_SUM_SS;
	DFlipFlop32 level35_SUMSS_FF(level34_SUM_SS,clk,level35_SUM_SS);

	/*Propogate SUM_SS_FFOUT '22nd to 35th' clock cycle -- end */

	//generating output
	MUX32bit_2x1 MUX_SUM(level35_SUM_SS,SUM_DS_FFOUT,level35_signXOR,SUM);
	
endmodule // FPA

`endif
