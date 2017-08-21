//header guards
`ifndef _ALU_vh_
`define _ALU_vh_

`include "adder_sub.v"
`include "D-FlipFlop.v"
`include "wallaceMultiplier.v"
`include "FPA.v"
`include "FPM.v"
`include "MUX2.v"

/*
//All OP_CODES : 0000 to 0011 can be used Addition, Sub OPERATION
Addition 			: OP_SELECT=0000; cin=0; neg_b=0
Addition with carry	: OP_SELECT=0001; cin=1; neg_b=0
Subtraction			: OP_SELECT=0010; cin=1; neg_b=1
Subtraction wborrow : OP_SELECT=0011; cin=0; neg_b=1

Multiplication		: OP_SELECT=0100; cin=X; neg_b=X

//All opcodes : 0101 to 0110 can be used for FP Addition, Sub
FP Addition			: OP_SELECT=0101; cin=X; neg_b=0
FP Subtraction		: OP_SELECT=0110; cin=X; neg_b=1

FP Multiplication	: OP_SELECT=0111; cin=X; neg_b=X

Logical AND 		: OP_SELECT=1000; cin=X; neg_b=X
Logical OR  		: OP_SELECT=1001; cin=X; neg_b=X
Logical XOR 		: OP_SELECT=1010; cin=X; neg_b=X
Logical NAND 		: OP_SELECT=1011; cin=X; neg_b=X
Logical NOR 		: OP_SELECT=1100; cin=X; neg_b=X
Logical XNOR 		: OP_SELECT=1101; cin=X; neg_b=X

//Can use OP_SELECT from 1110 to 1111
Logical NOT 		: OP_SELECT=1110; cin=0; neg_b=X;
2's COMPLEMENT A 	: OP_SELECT=1111; cin=1; neg_b=X;
*/

//38 clock cycles - input : clk 0; output : clk 38
module ALU
	(
		A,B,OP_SELECT,
		OUT,
		clk	
	);

	input[31:0] A,B;
	input clk;

	//4 bit operation select
	input[3:0] OP_SELECT;

	//64 bit output
	output[63:0] OUT;

	assign cin = (~OP_SELECT[1]&OP_SELECT[0]) | (OP_SELECT[2]&OP_SELECT[0]) | (~OP_SELECT[3]&OP_SELECT[1]&~OP_SELECT[0]);
	assign neg_b = OP_SELECT[1];
	
	/*Adder Subtractor  -- start */
	wire[31:0] SUM;
	Adder_Subtractor add_sub(A,B,cin,neg_b,cout,SUM,clk);

	//5th clock cycle
	wire level5_cout;
	wire[31:0] level5_SUM;
	DFlipFlop level5_cout_FF(cout,clk,level5_cout);
	DFlipFlop32 level5_SUM_FF(SUM,clk,level5_SUM);

	//Propogate SUM, cout to 36 clock cycles
	//6th clock cycle
	wire level6_cout;
	wire[31:0] level6_SUM;
	DFlipFlop level6_cout_FF(level5_cout,clk,level6_cout);
	DFlipFlop32 level6_SUM_FF(level5_SUM,clk,level6_SUM);

	//7th clock cycle
	wire level7_cout;
	wire[31:0] level7_SUM;
	DFlipFlop level7_cout_FF(level6_cout,clk,level7_cout);
	DFlipFlop32 level7_SUM_FF(level6_SUM,clk,level7_SUM);

	//8th clock cycle
	wire level8_cout;
	wire[31:0] level8_SUM;
	DFlipFlop level8_cout_FF(level7_cout,clk,level8_cout);
	DFlipFlop32 level8_SUM_FF(level7_SUM,clk,level8_SUM);

	//9th clock cycle
	wire level9_cout;
	wire[31:0] level9_SUM;
	DFlipFlop level9_cout_FF(level8_cout,clk,level9_cout);
	DFlipFlop32 level9_SUM_FF(level8_SUM,clk,level9_SUM);

	//10th clock cycle
	wire level10_cout;
	wire[31:0] level10_SUM;
	DFlipFlop level10_cout_FF(level9_cout,clk,level10_cout);
	DFlipFlop32 level10_SUM_FF(level9_SUM,clk,level10_SUM);

	//11th clock cycle
	wire level11_cout;
	wire[31:0] level11_SUM;
	DFlipFlop level11_cout_FF(level10_cout,clk,level11_cout);
	DFlipFlop32 level11_SUM_FF(level10_SUM,clk,level11_SUM);

	//12th clock cycle
	wire level12_cout;
	wire[31:0] level12_SUM;
	DFlipFlop level12_cout_FF(level11_cout,clk,level12_cout);
	DFlipFlop32 level12_SUM_FF(level11_SUM,clk,level12_SUM);

	//13th clock cycle
	wire level13_cout;
	wire[31:0] level13_SUM;
	DFlipFlop level13_cout_FF(level12_cout,clk,level13_cout);
	DFlipFlop32 level13_SUM_FF(level12_SUM,clk,level13_SUM);

	//14th clock cycle
	wire level14_cout;
	wire[31:0] level14_SUM;
	DFlipFlop level14_cout_FF(level13_cout,clk,level14_cout);
	DFlipFlop32 level14_SUM_FF(level13_SUM,clk,level14_SUM);

	//15th clock cycle
	wire level15_cout;
	wire[31:0] level15_SUM;
	DFlipFlop level15_cout_FF(level14_cout,clk,level15_cout);
	DFlipFlop32 level15_SUM_FF(level14_SUM,clk,level15_SUM);

	//16th clock cycle
	wire level16_cout;
	wire[31:0] level16_SUM;
	DFlipFlop level16_cout_FF(level15_cout,clk,level16_cout);
	DFlipFlop32 level16_SUM_FF(level15_SUM,clk,level16_SUM);

	//17th clock cycle
	wire level17_cout;
	wire[31:0] level17_SUM;
	DFlipFlop level17_cout_FF(level16_cout,clk,level17_cout);
	DFlipFlop32 level17_SUM_FF(level16_SUM,clk,level17_SUM);

	//18th clock cycle
	wire level18_cout;
	wire[31:0] level18_SUM;
	DFlipFlop level18_cout_FF(level17_cout,clk,level18_cout);
	DFlipFlop32 level18_SUM_FF(level17_SUM,clk,level18_SUM);

	//19th clock cycle
	wire level19_cout;
	wire[31:0] level19_SUM;
	DFlipFlop level19_cout_FF(level18_cout,clk,level19_cout);
	DFlipFlop32 level19_SUM_FF(level18_SUM,clk,level19_SUM);

	//20th clock cycle
	wire level20_cout;
	wire[31:0] level20_SUM;
	DFlipFlop level20_cout_FF(level19_cout,clk,level20_cout);
	DFlipFlop32 level20_SUM_FF(level19_SUM,clk,level20_SUM);

	//21th clock cycle
	wire level21_cout;
	wire[31:0] level21_SUM;
	DFlipFlop level21_cout_FF(level20_cout,clk,level21_cout);
	DFlipFlop32 level21_SUM_FF(level20_SUM,clk,level21_SUM);

	//22th clock cycle
	wire level22_cout;
	wire[31:0] level22_SUM;
	DFlipFlop level22_cout_FF(level21_cout,clk,level22_cout);
	DFlipFlop32 level22_SUM_FF(level21_SUM,clk,level22_SUM);

	//23th clock cycle
	wire level23_cout;
	wire[31:0] level23_SUM;
	DFlipFlop level23_cout_FF(level22_cout,clk,level23_cout);
	DFlipFlop32 level23_SUM_FF(level22_SUM,clk,level23_SUM);

	//24th clock cycle
	wire level24_cout;
	wire[31:0] level24_SUM;
	DFlipFlop level24_cout_FF(level23_cout,clk,level24_cout);
	DFlipFlop32 level24_SUM_FF(level23_SUM,clk,level24_SUM);

	//25th clock cycle
	wire level25_cout;
	wire[31:0] level25_SUM;
	DFlipFlop level25_cout_FF(level24_cout,clk,level25_cout);
	DFlipFlop32 level25_SUM_FF(level24_SUM,clk,level25_SUM);

	//26th clock cycle
	wire level26_cout;
	wire[31:0] level26_SUM;
	DFlipFlop level26_cout_FF(level25_cout,clk,level26_cout);
	DFlipFlop32 level26_SUM_FF(level25_SUM,clk,level26_SUM);

	//27th clock cycle
	wire level27_cout;
	wire[31:0] level27_SUM;
	DFlipFlop level27_cout_FF(level26_cout,clk,level27_cout);
	DFlipFlop32 level27_SUM_FF(level26_SUM,clk,level27_SUM);

	//28th clock cycle
	wire level28_cout;
	wire[31:0] level28_SUM;
	DFlipFlop level28_cout_FF(level27_cout,clk,level28_cout);
	DFlipFlop32 level28_SUM_FF(level27_SUM,clk,level28_SUM);

	//29th clock cycle
	wire level29_cout;
	wire[31:0] level29_SUM;
	DFlipFlop level29_cout_FF(level28_cout,clk,level29_cout);
	DFlipFlop32 level29_SUM_FF(level28_SUM,clk,level29_SUM);

	//30th clock cycle
	wire level30_cout;
	wire[31:0] level30_SUM;
	DFlipFlop level30_cout_FF(level29_cout,clk,level30_cout);
	DFlipFlop32 level30_SUM_FF(level29_SUM,clk,level30_SUM);

	//31th clock cycle
	wire level31_cout;
	wire[31:0] level31_SUM;
	DFlipFlop level31_cout_FF(level30_cout,clk,level31_cout);
	DFlipFlop32 level31_SUM_FF(level30_SUM,clk,level31_SUM);

	//32th clock cycle
	wire level32_cout;
	wire[31:0] level32_SUM;
	DFlipFlop level32_cout_FF(level31_cout,clk,level32_cout);
	DFlipFlop32 level32_SUM_FF(level31_SUM,clk,level32_SUM);

	//33th clock cycle
	wire level33_cout;
	wire[31:0] level33_SUM;
	DFlipFlop level33_cout_FF(level32_cout,clk,level33_cout);
	DFlipFlop32 level33_SUM_FF(level32_SUM,clk,level33_SUM);

	//34th clock cycle
	wire level34_cout;
	wire[31:0] level34_SUM;
	DFlipFlop level34_cout_FF(level33_cout,clk,level34_cout);
	DFlipFlop32 level34_SUM_FF(level33_SUM,clk,level34_SUM);

	//35th clock cycle
	wire level35_cout;
	wire[31:0] level35_SUM;
	DFlipFlop level35_cout_FF(level34_cout,clk,level35_cout);
	DFlipFlop32 level35_SUM_FF(level34_SUM,clk,level35_SUM);

	//36th clock cycle
	wire level36_cout;
	wire[31:0] level36_SUM;
	DFlipFlop level36_cout_FF(level35_cout,clk,level36_cout);
	DFlipFlop32 level36_SUM_FF(level35_SUM,clk,level36_SUM);
	/*Adder Subtractor  -- end */


	/*Multiplier -- start */
	wire[63:0] PRODUCT;
	wallaceMultiplier WMultiplier(A,B,PRODUCT,clk);

	//10th clock  cycles
	wire[63:0] level10_PRODUCT;
	DFlipFlop64 level10_PRODUCT_FF(PRODUCT,clk,level10_PRODUCT);

	//11th clock cycle
	wire[63:0] level11_PRODUCT;
	DFlipFlop64 level11_PRODUCT_FF(level10_PRODUCT,clk,level11_PRODUCT);

	//12th clock cycle
	wire[63:0] level12_PRODUCT;
	DFlipFlop64 level12_PRODUCT_FF(level11_PRODUCT,clk,level12_PRODUCT);

	//13th clock cycle
	wire[63:0] level13_PRODUCT;
	DFlipFlop64 level13_PRODUCT_FF(level12_PRODUCT,clk,level13_PRODUCT);

	//14th clock cycle
	wire[63:0] level14_PRODUCT;
	DFlipFlop64 level14_PRODUCT_FF(level13_PRODUCT,clk,level14_PRODUCT);

	//15th clock cycle
	wire[63:0] level15_PRODUCT;
	DFlipFlop64 level15_PRODUCT_FF(level14_PRODUCT,clk,level15_PRODUCT);

	//16th clock cycle
	wire[63:0] level16_PRODUCT;
	DFlipFlop64 level16_PRODUCT_FF(level15_PRODUCT,clk,level16_PRODUCT);

	//17th clock cycle
	wire[63:0] level17_PRODUCT;
	DFlipFlop64 level17_PRODUCT_FF(level16_PRODUCT,clk,level17_PRODUCT);

	//18th clock cycle
	wire[63:0] level18_PRODUCT;
	DFlipFlop64 level18_PRODUCT_FF(level17_PRODUCT,clk,level18_PRODUCT);

	//19th clock cycle
	wire[63:0] level19_PRODUCT;
	DFlipFlop64 level19_PRODUCT_FF(level18_PRODUCT,clk,level19_PRODUCT);

	//20th clock cycle
	wire[63:0] level20_PRODUCT;
	DFlipFlop64 level20_PRODUCT_FF(level19_PRODUCT,clk,level20_PRODUCT);

	//21th clock cycle
	wire[63:0] level21_PRODUCT;
	DFlipFlop64 level21_PRODUCT_FF(level20_PRODUCT,clk,level21_PRODUCT);

	//22th clock cycle
	wire[63:0] level22_PRODUCT;
	DFlipFlop64 level22_PRODUCT_FF(level21_PRODUCT,clk,level22_PRODUCT);

	//23th clock cycle
	wire[63:0] level23_PRODUCT;
	DFlipFlop64 level23_PRODUCT_FF(level22_PRODUCT,clk,level23_PRODUCT);

	//24th clock cycle
	wire[63:0] level24_PRODUCT;
	DFlipFlop64 level24_PRODUCT_FF(level23_PRODUCT,clk,level24_PRODUCT);

	//25th clock cycle
	wire[63:0] level25_PRODUCT;
	DFlipFlop64 level25_PRODUCT_FF(level24_PRODUCT,clk,level25_PRODUCT);

	//26th clock cycle
	wire[63:0] level26_PRODUCT;
	DFlipFlop64 level26_PRODUCT_FF(level25_PRODUCT,clk,level26_PRODUCT);

	//27th clock cycle
	wire[63:0] level27_PRODUCT;
	DFlipFlop64 level27_PRODUCT_FF(level26_PRODUCT,clk,level27_PRODUCT);

	//28th clock cycle
	wire[63:0] level28_PRODUCT;
	DFlipFlop64 level28_PRODUCT_FF(level27_PRODUCT,clk,level28_PRODUCT);

	//29th clock cycle
	wire[63:0] level29_PRODUCT;
	DFlipFlop64 level29_PRODUCT_FF(level28_PRODUCT,clk,level29_PRODUCT);

	//30th clock cycle
	wire[63:0] level30_PRODUCT;
	DFlipFlop64 level30_PRODUCT_FF(level29_PRODUCT,clk,level30_PRODUCT);

	//31th clock cycle
	wire[63:0] level31_PRODUCT;
	DFlipFlop64 level31_PRODUCT_FF(level30_PRODUCT,clk,level31_PRODUCT);

	//32th clock cycle
	wire[63:0] level32_PRODUCT;
	DFlipFlop64 level32_PRODUCT_FF(level31_PRODUCT,clk,level32_PRODUCT);

	//33th clock cycle
	wire[63:0] level33_PRODUCT;
	DFlipFlop64 level33_PRODUCT_FF(level32_PRODUCT,clk,level33_PRODUCT);

	//34th clock cycle
	wire[63:0] level34_PRODUCT;
	DFlipFlop64 level34_PRODUCT_FF(level33_PRODUCT,clk,level34_PRODUCT);

	//35th clock cycle
	wire[63:0] level35_PRODUCT;
	DFlipFlop64 level35_PRODUCT_FF(level34_PRODUCT,clk,level35_PRODUCT);

	//36th clock cycle
	wire[63:0] level36_PRODUCT;
	DFlipFlop64 level36_PRODUCT_FF(level35_PRODUCT,clk,level36_PRODUCT);
	/*Multiplier -- end */


	/*Floating Point Adder-Subtractor  -- start */
	wire[31:0] FPA_B_IN;
	assign FPA_B_IN[31] = B[31] ^ neg_b;
	assign FPA_B_IN[30:0] = B[30:0];

	wire[31:0] FPA_SUM, FPA_SUM_FFOUT;
	FPA fpa(A,FPA_B_IN,FPA_SUM,clk);

	//36th clock cycle
	DFlipFlop32 FPA_SUM_FF(FPA_SUM,clk,FPA_SUM_FFOUT);
	/*Floating Point Adder-Subtractor  -- end */


	/*Floating Point Multiplier  -- start */
	wire[31:0] FPM_PRODUCT;
	FPM fpm(A,B,FPM_PRODUCT,clk);

	//11th clock cycle
	wire[31:0] level11_FPM_PRO;
	DFlipFlop32 level11_FPMPRO_FF(FPM_PRODUCT,clk,level11_FPM_PRO);

	//12th clock cycle
	wire[31:0] level12_FPM_PRO;
	DFlipFlop32 level12_FPMPRO_FF(level11_FPM_PRO,clk,level12_FPM_PRO);

	//13th clock cycle
	wire[31:0] level13_FPM_PRO;
	DFlipFlop32 level13_FPMPRO_FF(level12_FPM_PRO,clk,level13_FPM_PRO);

	//14th clock cycle
	wire[31:0] level14_FPM_PRO;
	DFlipFlop32 level14_FPMPRO_FF(level13_FPM_PRO,clk,level14_FPM_PRO);

	//15th clock cycle
	wire[31:0] level15_FPM_PRO;
	DFlipFlop32 level15_FPMPRO_FF(level14_FPM_PRO,clk,level15_FPM_PRO);

	//16th clock cycle
	wire[31:0] level16_FPM_PRO;
	DFlipFlop32 level16_FPMPRO_FF(level15_FPM_PRO,clk,level16_FPM_PRO);

	//17th clock cycle
	wire[31:0] level17_FPM_PRO;
	DFlipFlop32 level17_FPMPRO_FF(level16_FPM_PRO,clk,level17_FPM_PRO);

	//18th clock cycle
	wire[31:0] level18_FPM_PRO;
	DFlipFlop32 level18_FPMPRO_FF(level17_FPM_PRO,clk,level18_FPM_PRO);

	//19th clock cycle
	wire[31:0] level19_FPM_PRO;
	DFlipFlop32 level19_FPMPRO_FF(level18_FPM_PRO,clk,level19_FPM_PRO);

	//20th clock cycle
	wire[31:0] level20_FPM_PRO;
	DFlipFlop32 level20_FPMPRO_FF(level19_FPM_PRO,clk,level20_FPM_PRO);

	//21th clock cycle
	wire[31:0] level21_FPM_PRO;
	DFlipFlop32 level21_FPMPRO_FF(level20_FPM_PRO,clk,level21_FPM_PRO);

	//22th clock cycle
	wire[31:0] level22_FPM_PRO;
	DFlipFlop32 level22_FPMPRO_FF(level21_FPM_PRO,clk,level22_FPM_PRO);

	//23th clock cycle
	wire[31:0] level23_FPM_PRO;
	DFlipFlop32 level23_FPMPRO_FF(level22_FPM_PRO,clk,level23_FPM_PRO);

	//24th clock cycle
	wire[31:0] level24_FPM_PRO;
	DFlipFlop32 level24_FPMPRO_FF(level23_FPM_PRO,clk,level24_FPM_PRO);

	//25th clock cycle
	wire[31:0] level25_FPM_PRO;
	DFlipFlop32 level25_FPMPRO_FF(level24_FPM_PRO,clk,level25_FPM_PRO);

	//26th clock cycle
	wire[31:0] level26_FPM_PRO;
	DFlipFlop32 level26_FPMPRO_FF(level25_FPM_PRO,clk,level26_FPM_PRO);

	//27th clock cycle
	wire[31:0] level27_FPM_PRO;
	DFlipFlop32 level27_FPMPRO_FF(level26_FPM_PRO,clk,level27_FPM_PRO);

	//28th clock cycle
	wire[31:0] level28_FPM_PRO;
	DFlipFlop32 level28_FPMPRO_FF(level27_FPM_PRO,clk,level28_FPM_PRO);

	//29th clock cycle
	wire[31:0] level29_FPM_PRO;
	DFlipFlop32 level29_FPMPRO_FF(level28_FPM_PRO,clk,level29_FPM_PRO);

	//30th clock cycle
	wire[31:0] level30_FPM_PRO;
	DFlipFlop32 level30_FPMPRO_FF(level29_FPM_PRO,clk,level30_FPM_PRO);

	//31th clock cycle
	wire[31:0] level31_FPM_PRO;
	DFlipFlop32 level31_FPMPRO_FF(level30_FPM_PRO,clk,level31_FPM_PRO);

	//32th clock cycle
	wire[31:0] level32_FPM_PRO;
	DFlipFlop32 level32_FPMPRO_FF(level31_FPM_PRO,clk,level32_FPM_PRO);

	//33th clock cycle
	wire[31:0] level33_FPM_PRO;
	DFlipFlop32 level33_FPMPRO_FF(level32_FPM_PRO,clk,level33_FPM_PRO);

	//34th clock cycle
	wire[31:0] level34_FPM_PRO;
	DFlipFlop32 level34_FPMPRO_FF(level33_FPM_PRO,clk,level34_FPM_PRO);

	//35th clock cycle
	wire[31:0] level35_FPM_PRO;
	DFlipFlop32 level35_FPMPRO_FF(level34_FPM_PRO,clk,level35_FPM_PRO);

	//36th clock cycle
	wire[31:0] level36_FPM_PRO;
	DFlipFlop32 level36_FPMPRO_FF(level35_FPM_PRO,clk,level36_FPM_PRO);
	/*Floating Point Multiplier  -- end */


	/*LOGICAL AND,OR,XOR,NAND,NOR,XNOR -- start */
	wire[31:0] AND, OR, XOR, NAND, NOR, XNOR;
	assign AND  = A &  B;
	assign OR   = A |  B;
	assign XOR  = A ^  B;
	assign NAND = ~(A & B);
	assign NOR  = ~(A | B);
	assign XNOR = A ^~ B;

	//1st clock  cycle
	wire[31:0] level1_AND,level1_OR,level1_XOR,level1_NAND,level1_NOR,level1_XNOR;
	DFlipFlop32 level1_AND_FF(AND,clk,level1_AND);
	DFlipFlop32 level1_OR_FF(OR,clk,level1_OR);
	DFlipFlop32 level1_XOR_FF(XOR,clk,level1_XOR);
	DFlipFlop32 level1_NAND_FF(NAND,clk,level1_NAND);
	DFlipFlop32 level1_NOR_FF(NOR,clk,level1_NOR);
	DFlipFlop32 level1_XNOR_FF(XNOR,clk,level1_XNOR);

	//2th clock cycle
	wire[31:0] level2_AND,level2_OR,level2_XOR,level2_NAND,level2_NOR,level2_XNOR;
	DFlipFlop32 level2_AND_FF(level1_AND,clk,level2_AND);
	DFlipFlop32 level2_OR_FF(level1_OR,clk,level2_OR);
	DFlipFlop32 level2_XOR_FF(level1_XOR,clk,level2_XOR);
	DFlipFlop32 level2_NAND_FF(level1_NAND,clk,level2_NAND);
	DFlipFlop32 level2_NOR_FF(level1_NOR,clk,level2_NOR);
	DFlipFlop32 level2_XNOR_FF(level1_XNOR,clk,level2_XNOR);

	//3th clock cycle
	wire[31:0] level3_AND,level3_OR,level3_XOR,level3_NAND,level3_NOR,level3_XNOR;
	DFlipFlop32 level3_AND_FF(level2_AND,clk,level3_AND);
	DFlipFlop32 level3_OR_FF(level2_OR,clk,level3_OR);
	DFlipFlop32 level3_XOR_FF(level2_XOR,clk,level3_XOR);
	DFlipFlop32 level3_NAND_FF(level2_NAND,clk,level3_NAND);
	DFlipFlop32 level3_NOR_FF(level2_NOR,clk,level3_NOR);
	DFlipFlop32 level3_XNOR_FF(level2_XNOR,clk,level3_XNOR);

	//4th clock cycle
	wire[31:0] level4_AND,level4_OR,level4_XOR,level4_NAND,level4_NOR,level4_XNOR;
	DFlipFlop32 level4_AND_FF(level3_AND,clk,level4_AND);
	DFlipFlop32 level4_OR_FF(level3_OR,clk,level4_OR);
	DFlipFlop32 level4_XOR_FF(level3_XOR,clk,level4_XOR);
	DFlipFlop32 level4_NAND_FF(level3_NAND,clk,level4_NAND);
	DFlipFlop32 level4_NOR_FF(level3_NOR,clk,level4_NOR);
	DFlipFlop32 level4_XNOR_FF(level3_XNOR,clk,level4_XNOR);

	//5th clock cycle
	wire[31:0] level5_AND,level5_OR,level5_XOR,level5_NAND,level5_NOR,level5_XNOR;
	DFlipFlop32 level5_AND_FF(level4_AND,clk,level5_AND);
	DFlipFlop32 level5_OR_FF(level4_OR,clk,level5_OR);
	DFlipFlop32 level5_XOR_FF(level4_XOR,clk,level5_XOR);
	DFlipFlop32 level5_NAND_FF(level4_NAND,clk,level5_NAND);
	DFlipFlop32 level5_NOR_FF(level4_NOR,clk,level5_NOR);
	DFlipFlop32 level5_XNOR_FF(level4_XNOR,clk,level5_XNOR);

	//6th clock cycle
	wire[31:0] level6_AND,level6_OR,level6_XOR,level6_NAND,level6_NOR,level6_XNOR;
	DFlipFlop32 level6_AND_FF(level5_AND,clk,level6_AND);
	DFlipFlop32 level6_OR_FF(level5_OR,clk,level6_OR);
	DFlipFlop32 level6_XOR_FF(level5_XOR,clk,level6_XOR);
	DFlipFlop32 level6_NAND_FF(level5_NAND,clk,level6_NAND);
	DFlipFlop32 level6_NOR_FF(level5_NOR,clk,level6_NOR);
	DFlipFlop32 level6_XNOR_FF(level5_XNOR,clk,level6_XNOR);

	//7th clock cycle
	wire[31:0] level7_AND,level7_OR,level7_XOR,level7_NAND,level7_NOR,level7_XNOR;
	DFlipFlop32 level7_AND_FF(level6_AND,clk,level7_AND);
	DFlipFlop32 level7_OR_FF(level6_OR,clk,level7_OR);
	DFlipFlop32 level7_XOR_FF(level6_XOR,clk,level7_XOR);
	DFlipFlop32 level7_NAND_FF(level6_NAND,clk,level7_NAND);
	DFlipFlop32 level7_NOR_FF(level6_NOR,clk,level7_NOR);
	DFlipFlop32 level7_XNOR_FF(level6_XNOR,clk,level7_XNOR);

	//8th clock cycle
	wire[31:0] level8_AND,level8_OR,level8_XOR,level8_NAND,level8_NOR,level8_XNOR;
	DFlipFlop32 level8_AND_FF(level7_AND,clk,level8_AND);
	DFlipFlop32 level8_OR_FF(level7_OR,clk,level8_OR);
	DFlipFlop32 level8_XOR_FF(level7_XOR,clk,level8_XOR);
	DFlipFlop32 level8_NAND_FF(level7_NAND,clk,level8_NAND);
	DFlipFlop32 level8_NOR_FF(level7_NOR,clk,level8_NOR);
	DFlipFlop32 level8_XNOR_FF(level7_XNOR,clk,level8_XNOR);

	//9th clock cycle
	wire[31:0] level9_AND,level9_OR,level9_XOR,level9_NAND,level9_NOR,level9_XNOR;
	DFlipFlop32 level9_AND_FF(level8_AND,clk,level9_AND);
	DFlipFlop32 level9_OR_FF(level8_OR,clk,level9_OR);
	DFlipFlop32 level9_XOR_FF(level8_XOR,clk,level9_XOR);
	DFlipFlop32 level9_NAND_FF(level8_NAND,clk,level9_NAND);
	DFlipFlop32 level9_NOR_FF(level8_NOR,clk,level9_NOR);
	DFlipFlop32 level9_XNOR_FF(level8_XNOR,clk,level9_XNOR);

	//10th clock cycle
	wire[31:0] level10_AND,level10_OR,level10_XOR,level10_NAND,level10_NOR,level10_XNOR;
	DFlipFlop32 level10_AND_FF(level9_AND,clk,level10_AND);
	DFlipFlop32 level10_OR_FF(level9_OR,clk,level10_OR);
	DFlipFlop32 level10_XOR_FF(level9_XOR,clk,level10_XOR);
	DFlipFlop32 level10_NAND_FF(level9_NAND,clk,level10_NAND);
	DFlipFlop32 level10_NOR_FF(level9_NOR,clk,level10_NOR);
	DFlipFlop32 level10_XNOR_FF(level9_XNOR,clk,level10_XNOR);

	//11th clock cycle
	wire[31:0] level11_AND,level11_OR,level11_XOR,level11_NAND,level11_NOR,level11_XNOR;
	DFlipFlop32 level11_AND_FF(level10_AND,clk,level11_AND);
	DFlipFlop32 level11_OR_FF(level10_OR,clk,level11_OR);
	DFlipFlop32 level11_XOR_FF(level10_XOR,clk,level11_XOR);
	DFlipFlop32 level11_NAND_FF(level10_NAND,clk,level11_NAND);
	DFlipFlop32 level11_NOR_FF(level10_NOR,clk,level11_NOR);
	DFlipFlop32 level11_XNOR_FF(level10_XNOR,clk,level11_XNOR);

	//12th clock cycle
	wire[31:0] level12_AND,level12_OR,level12_XOR,level12_NAND,level12_NOR,level12_XNOR;
	DFlipFlop32 level12_AND_FF(level11_AND,clk,level12_AND);
	DFlipFlop32 level12_OR_FF(level11_OR,clk,level12_OR);
	DFlipFlop32 level12_XOR_FF(level11_XOR,clk,level12_XOR);
	DFlipFlop32 level12_NAND_FF(level11_NAND,clk,level12_NAND);
	DFlipFlop32 level12_NOR_FF(level11_NOR,clk,level12_NOR);
	DFlipFlop32 level12_XNOR_FF(level11_XNOR,clk,level12_XNOR);

	//13th clock cycle
	wire[31:0] level13_AND,level13_OR,level13_XOR,level13_NAND,level13_NOR,level13_XNOR;
	DFlipFlop32 level13_AND_FF(level12_AND,clk,level13_AND);
	DFlipFlop32 level13_OR_FF(level12_OR,clk,level13_OR);
	DFlipFlop32 level13_XOR_FF(level12_XOR,clk,level13_XOR);
	DFlipFlop32 level13_NAND_FF(level12_NAND,clk,level13_NAND);
	DFlipFlop32 level13_NOR_FF(level12_NOR,clk,level13_NOR);
	DFlipFlop32 level13_XNOR_FF(level12_XNOR,clk,level13_XNOR);

	//14th clock cycle
	wire[31:0] level14_AND,level14_OR,level14_XOR,level14_NAND,level14_NOR,level14_XNOR;
	DFlipFlop32 level14_AND_FF(level13_AND,clk,level14_AND);
	DFlipFlop32 level14_OR_FF(level13_OR,clk,level14_OR);
	DFlipFlop32 level14_XOR_FF(level13_XOR,clk,level14_XOR);
	DFlipFlop32 level14_NAND_FF(level13_NAND,clk,level14_NAND);
	DFlipFlop32 level14_NOR_FF(level13_NOR,clk,level14_NOR);
	DFlipFlop32 level14_XNOR_FF(level13_XNOR,clk,level14_XNOR);

	//15th clock cycle
	wire[31:0] level15_AND,level15_OR,level15_XOR,level15_NAND,level15_NOR,level15_XNOR;
	DFlipFlop32 level15_AND_FF(level14_AND,clk,level15_AND);
	DFlipFlop32 level15_OR_FF(level14_OR,clk,level15_OR);
	DFlipFlop32 level15_XOR_FF(level14_XOR,clk,level15_XOR);
	DFlipFlop32 level15_NAND_FF(level14_NAND,clk,level15_NAND);
	DFlipFlop32 level15_NOR_FF(level14_NOR,clk,level15_NOR);
	DFlipFlop32 level15_XNOR_FF(level14_XNOR,clk,level15_XNOR);

	//16th clock cycle
	wire[31:0] level16_AND,level16_OR,level16_XOR,level16_NAND,level16_NOR,level16_XNOR;
	DFlipFlop32 level16_AND_FF(level15_AND,clk,level16_AND);
	DFlipFlop32 level16_OR_FF(level15_OR,clk,level16_OR);
	DFlipFlop32 level16_XOR_FF(level15_XOR,clk,level16_XOR);
	DFlipFlop32 level16_NAND_FF(level15_NAND,clk,level16_NAND);
	DFlipFlop32 level16_NOR_FF(level15_NOR,clk,level16_NOR);
	DFlipFlop32 level16_XNOR_FF(level15_XNOR,clk,level16_XNOR);

	//17th clock cycle
	wire[31:0] level17_AND,level17_OR,level17_XOR,level17_NAND,level17_NOR,level17_XNOR;
	DFlipFlop32 level17_AND_FF(level16_AND,clk,level17_AND);
	DFlipFlop32 level17_OR_FF(level16_OR,clk,level17_OR);
	DFlipFlop32 level17_XOR_FF(level16_XOR,clk,level17_XOR);
	DFlipFlop32 level17_NAND_FF(level16_NAND,clk,level17_NAND);
	DFlipFlop32 level17_NOR_FF(level16_NOR,clk,level17_NOR);
	DFlipFlop32 level17_XNOR_FF(level16_XNOR,clk,level17_XNOR);

	//18th clock cycle
	wire[31:0] level18_AND,level18_OR,level18_XOR,level18_NAND,level18_NOR,level18_XNOR;
	DFlipFlop32 level18_AND_FF(level17_AND,clk,level18_AND);
	DFlipFlop32 level18_OR_FF(level17_OR,clk,level18_OR);
	DFlipFlop32 level18_XOR_FF(level17_XOR,clk,level18_XOR);
	DFlipFlop32 level18_NAND_FF(level17_NAND,clk,level18_NAND);
	DFlipFlop32 level18_NOR_FF(level17_NOR,clk,level18_NOR);
	DFlipFlop32 level18_XNOR_FF(level17_XNOR,clk,level18_XNOR);

	//19th clock cycle
	wire[31:0] level19_AND,level19_OR,level19_XOR,level19_NAND,level19_NOR,level19_XNOR;
	DFlipFlop32 level19_AND_FF(level18_AND,clk,level19_AND);
	DFlipFlop32 level19_OR_FF(level18_OR,clk,level19_OR);
	DFlipFlop32 level19_XOR_FF(level18_XOR,clk,level19_XOR);
	DFlipFlop32 level19_NAND_FF(level18_NAND,clk,level19_NAND);
	DFlipFlop32 level19_NOR_FF(level18_NOR,clk,level19_NOR);
	DFlipFlop32 level19_XNOR_FF(level18_XNOR,clk,level19_XNOR);

	//20th clock cycle
	wire[31:0] level20_AND,level20_OR,level20_XOR,level20_NAND,level20_NOR,level20_XNOR;
	DFlipFlop32 level20_AND_FF(level19_AND,clk,level20_AND);
	DFlipFlop32 level20_OR_FF(level19_OR,clk,level20_OR);
	DFlipFlop32 level20_XOR_FF(level19_XOR,clk,level20_XOR);
	DFlipFlop32 level20_NAND_FF(level19_NAND,clk,level20_NAND);
	DFlipFlop32 level20_NOR_FF(level19_NOR,clk,level20_NOR);
	DFlipFlop32 level20_XNOR_FF(level19_XNOR,clk,level20_XNOR);

	//21th clock cycle
	wire[31:0] level21_AND,level21_OR,level21_XOR,level21_NAND,level21_NOR,level21_XNOR;
	DFlipFlop32 level21_AND_FF(level20_AND,clk,level21_AND);
	DFlipFlop32 level21_OR_FF(level20_OR,clk,level21_OR);
	DFlipFlop32 level21_XOR_FF(level20_XOR,clk,level21_XOR);
	DFlipFlop32 level21_NAND_FF(level20_NAND,clk,level21_NAND);
	DFlipFlop32 level21_NOR_FF(level20_NOR,clk,level21_NOR);
	DFlipFlop32 level21_XNOR_FF(level20_XNOR,clk,level21_XNOR);

	//22th clock cycle
	wire[31:0] level22_AND,level22_OR,level22_XOR,level22_NAND,level22_NOR,level22_XNOR;
	DFlipFlop32 level22_AND_FF(level21_AND,clk,level22_AND);
	DFlipFlop32 level22_OR_FF(level21_OR,clk,level22_OR);
	DFlipFlop32 level22_XOR_FF(level21_XOR,clk,level22_XOR);
	DFlipFlop32 level22_NAND_FF(level21_NAND,clk,level22_NAND);
	DFlipFlop32 level22_NOR_FF(level21_NOR,clk,level22_NOR);
	DFlipFlop32 level22_XNOR_FF(level21_XNOR,clk,level22_XNOR);

	//23th clock cycle
	wire[31:0] level23_AND,level23_OR,level23_XOR,level23_NAND,level23_NOR,level23_XNOR;
	DFlipFlop32 level23_AND_FF(level22_AND,clk,level23_AND);
	DFlipFlop32 level23_OR_FF(level22_OR,clk,level23_OR);
	DFlipFlop32 level23_XOR_FF(level22_XOR,clk,level23_XOR);
	DFlipFlop32 level23_NAND_FF(level22_NAND,clk,level23_NAND);
	DFlipFlop32 level23_NOR_FF(level22_NOR,clk,level23_NOR);
	DFlipFlop32 level23_XNOR_FF(level22_XNOR,clk,level23_XNOR);

	//24th clock cycle
	wire[31:0] level24_AND,level24_OR,level24_XOR,level24_NAND,level24_NOR,level24_XNOR;
	DFlipFlop32 level24_AND_FF(level23_AND,clk,level24_AND);
	DFlipFlop32 level24_OR_FF(level23_OR,clk,level24_OR);
	DFlipFlop32 level24_XOR_FF(level23_XOR,clk,level24_XOR);
	DFlipFlop32 level24_NAND_FF(level23_NAND,clk,level24_NAND);
	DFlipFlop32 level24_NOR_FF(level23_NOR,clk,level24_NOR);
	DFlipFlop32 level24_XNOR_FF(level23_XNOR,clk,level24_XNOR);

	//25th clock cycle
	wire[31:0] level25_AND,level25_OR,level25_XOR,level25_NAND,level25_NOR,level25_XNOR;
	DFlipFlop32 level25_AND_FF(level24_AND,clk,level25_AND);
	DFlipFlop32 level25_OR_FF(level24_OR,clk,level25_OR);
	DFlipFlop32 level25_XOR_FF(level24_XOR,clk,level25_XOR);
	DFlipFlop32 level25_NAND_FF(level24_NAND,clk,level25_NAND);
	DFlipFlop32 level25_NOR_FF(level24_NOR,clk,level25_NOR);
	DFlipFlop32 level25_XNOR_FF(level24_XNOR,clk,level25_XNOR);

	//26th clock cycle
	wire[31:0] level26_AND,level26_OR,level26_XOR,level26_NAND,level26_NOR,level26_XNOR;
	DFlipFlop32 level26_AND_FF(level25_AND,clk,level26_AND);
	DFlipFlop32 level26_OR_FF(level25_OR,clk,level26_OR);
	DFlipFlop32 level26_XOR_FF(level25_XOR,clk,level26_XOR);
	DFlipFlop32 level26_NAND_FF(level25_NAND,clk,level26_NAND);
	DFlipFlop32 level26_NOR_FF(level25_NOR,clk,level26_NOR);
	DFlipFlop32 level26_XNOR_FF(level25_XNOR,clk,level26_XNOR);

	//27th clock cycle
	wire[31:0] level27_AND,level27_OR,level27_XOR,level27_NAND,level27_NOR,level27_XNOR;
	DFlipFlop32 level27_AND_FF(level26_AND,clk,level27_AND);
	DFlipFlop32 level27_OR_FF(level26_OR,clk,level27_OR);
	DFlipFlop32 level27_XOR_FF(level26_XOR,clk,level27_XOR);
	DFlipFlop32 level27_NAND_FF(level26_NAND,clk,level27_NAND);
	DFlipFlop32 level27_NOR_FF(level26_NOR,clk,level27_NOR);
	DFlipFlop32 level27_XNOR_FF(level26_XNOR,clk,level27_XNOR);

	//28th clock cycle
	wire[31:0] level28_AND,level28_OR,level28_XOR,level28_NAND,level28_NOR,level28_XNOR;
	DFlipFlop32 level28_AND_FF(level27_AND,clk,level28_AND);
	DFlipFlop32 level28_OR_FF(level27_OR,clk,level28_OR);
	DFlipFlop32 level28_XOR_FF(level27_XOR,clk,level28_XOR);
	DFlipFlop32 level28_NAND_FF(level27_NAND,clk,level28_NAND);
	DFlipFlop32 level28_NOR_FF(level27_NOR,clk,level28_NOR);
	DFlipFlop32 level28_XNOR_FF(level27_XNOR,clk,level28_XNOR);

	//29th clock cycle
	wire[31:0] level29_AND,level29_OR,level29_XOR,level29_NAND,level29_NOR,level29_XNOR;
	DFlipFlop32 level29_AND_FF(level28_AND,clk,level29_AND);
	DFlipFlop32 level29_OR_FF(level28_OR,clk,level29_OR);
	DFlipFlop32 level29_XOR_FF(level28_XOR,clk,level29_XOR);
	DFlipFlop32 level29_NAND_FF(level28_NAND,clk,level29_NAND);
	DFlipFlop32 level29_NOR_FF(level28_NOR,clk,level29_NOR);
	DFlipFlop32 level29_XNOR_FF(level28_XNOR,clk,level29_XNOR);

	//30th clock cycle
	wire[31:0] level30_AND,level30_OR,level30_XOR,level30_NAND,level30_NOR,level30_XNOR;
	DFlipFlop32 level30_AND_FF(level29_AND,clk,level30_AND);
	DFlipFlop32 level30_OR_FF(level29_OR,clk,level30_OR);
	DFlipFlop32 level30_XOR_FF(level29_XOR,clk,level30_XOR);
	DFlipFlop32 level30_NAND_FF(level29_NAND,clk,level30_NAND);
	DFlipFlop32 level30_NOR_FF(level29_NOR,clk,level30_NOR);
	DFlipFlop32 level30_XNOR_FF(level29_XNOR,clk,level30_XNOR);

	//31th clock cycle
	wire[31:0] level31_AND,level31_OR,level31_XOR,level31_NAND,level31_NOR,level31_XNOR;
	DFlipFlop32 level31_AND_FF(level30_AND,clk,level31_AND);
	DFlipFlop32 level31_OR_FF(level30_OR,clk,level31_OR);
	DFlipFlop32 level31_XOR_FF(level30_XOR,clk,level31_XOR);
	DFlipFlop32 level31_NAND_FF(level30_NAND,clk,level31_NAND);
	DFlipFlop32 level31_NOR_FF(level30_NOR,clk,level31_NOR);
	DFlipFlop32 level31_XNOR_FF(level30_XNOR,clk,level31_XNOR);

	//32th clock cycle
	wire[31:0] level32_AND,level32_OR,level32_XOR,level32_NAND,level32_NOR,level32_XNOR;
	DFlipFlop32 level32_AND_FF(level31_AND,clk,level32_AND);
	DFlipFlop32 level32_OR_FF(level31_OR,clk,level32_OR);
	DFlipFlop32 level32_XOR_FF(level31_XOR,clk,level32_XOR);
	DFlipFlop32 level32_NAND_FF(level31_NAND,clk,level32_NAND);
	DFlipFlop32 level32_NOR_FF(level31_NOR,clk,level32_NOR);
	DFlipFlop32 level32_XNOR_FF(level31_XNOR,clk,level32_XNOR);

	//33th clock cycle
	wire[31:0] level33_AND,level33_OR,level33_XOR,level33_NAND,level33_NOR,level33_XNOR;
	DFlipFlop32 level33_AND_FF(level32_AND,clk,level33_AND);
	DFlipFlop32 level33_OR_FF(level32_OR,clk,level33_OR);
	DFlipFlop32 level33_XOR_FF(level32_XOR,clk,level33_XOR);
	DFlipFlop32 level33_NAND_FF(level32_NAND,clk,level33_NAND);
	DFlipFlop32 level33_NOR_FF(level32_NOR,clk,level33_NOR);
	DFlipFlop32 level33_XNOR_FF(level32_XNOR,clk,level33_XNOR);

	//34th clock cycle
	wire[31:0] level34_AND,level34_OR,level34_XOR,level34_NAND,level34_NOR,level34_XNOR;
	DFlipFlop32 level34_AND_FF(level33_AND,clk,level34_AND);
	DFlipFlop32 level34_OR_FF(level33_OR,clk,level34_OR);
	DFlipFlop32 level34_XOR_FF(level33_XOR,clk,level34_XOR);
	DFlipFlop32 level34_NAND_FF(level33_NAND,clk,level34_NAND);
	DFlipFlop32 level34_NOR_FF(level33_NOR,clk,level34_NOR);
	DFlipFlop32 level34_XNOR_FF(level33_XNOR,clk,level34_XNOR);

	//35th clock cycle
	wire[31:0] level35_AND,level35_OR,level35_XOR,level35_NAND,level35_NOR,level35_XNOR;
	DFlipFlop32 level35_AND_FF(level34_AND,clk,level35_AND);
	DFlipFlop32 level35_OR_FF(level34_OR,clk,level35_OR);
	DFlipFlop32 level35_XOR_FF(level34_XOR,clk,level35_XOR);
	DFlipFlop32 level35_NAND_FF(level34_NAND,clk,level35_NAND);
	DFlipFlop32 level35_NOR_FF(level34_NOR,clk,level35_NOR);
	DFlipFlop32 level35_XNOR_FF(level34_XNOR,clk,level35_XNOR);

	//36th clock cycle
	wire[31:0] level36_AND,level36_OR,level36_XOR,level36_NAND,level36_NOR,level36_XNOR;
	DFlipFlop32 level36_AND_FF(level35_AND,clk,level36_AND);
	DFlipFlop32 level36_OR_FF(level35_OR,clk,level36_OR);
	DFlipFlop32 level36_XOR_FF(level35_XOR,clk,level36_XOR);
	DFlipFlop32 level36_NAND_FF(level35_NAND,clk,level36_NAND);
	DFlipFlop32 level36_NOR_FF(level35_NOR,clk,level36_NOR);
	DFlipFlop32 level36_XNOR_FF(level35_XNOR,clk,level36_XNOR);

	/*LOGICAL AND,OR,XOR,NAND,NOR,XNOR -- end */

	/*NOT (cin=0) and 2's complement (cin=1) of A -- start */
	wire[31:0] NOT_A, A_2COMPL;
	assign NOT_A = ~A;

	//feed '~A' to PREFIX ADDER
	wire PA_2COMPL_cout;
	prefixAdder PA_2COMPLEMENT(NOT_A,32'd0,cin,PA_2COMPL_cout,A_2COMPL,clk);

	//5th clock cycle
	wire[31:0] LEVEL5_NOT_COMPL;
	DFlipFlop32 level5_NOT_FF(A_2COMPL,clk,LEVEL5_NOT_COMPL);

	//6th clock cycle
	wire[31:0] LEVEL6_NOT_COMPL;
	DFlipFlop32 level6_NOT_FF(LEVEL5_NOT_COMPL,clk,LEVEL6_NOT_COMPL);

	//7th clock cycle
	wire[31:0] LEVEL7_NOT_COMPL;
	DFlipFlop32 level7_NOT_FF(LEVEL6_NOT_COMPL,clk,LEVEL7_NOT_COMPL);

	//8th clock cycle
	wire[31:0] LEVEL8_NOT_COMPL;
	DFlipFlop32 level8_NOT_FF(LEVEL7_NOT_COMPL,clk,LEVEL8_NOT_COMPL);

	//9th clock cycle
	wire[31:0] LEVEL9_NOT_COMPL;
	DFlipFlop32 level9_NOT_FF(LEVEL8_NOT_COMPL,clk,LEVEL9_NOT_COMPL);

	//10th clock cycle
	wire[31:0] LEVEL10_NOT_COMPL;
	DFlipFlop32 level10_NOT_FF(LEVEL9_NOT_COMPL,clk,LEVEL10_NOT_COMPL);

	//11th clock cycle
	wire[31:0] LEVEL11_NOT_COMPL;
	DFlipFlop32 level11_NOT_FF(LEVEL10_NOT_COMPL,clk,LEVEL11_NOT_COMPL);

	//12th clock cycle
	wire[31:0] LEVEL12_NOT_COMPL;
	DFlipFlop32 level12_NOT_FF(LEVEL11_NOT_COMPL,clk,LEVEL12_NOT_COMPL);

	//13th clock cycle
	wire[31:0] LEVEL13_NOT_COMPL;
	DFlipFlop32 level13_NOT_FF(LEVEL12_NOT_COMPL,clk,LEVEL13_NOT_COMPL);

	//14th clock cycle
	wire[31:0] LEVEL14_NOT_COMPL;
	DFlipFlop32 level14_NOT_FF(LEVEL13_NOT_COMPL,clk,LEVEL14_NOT_COMPL);

	//15th clock cycle
	wire[31:0] LEVEL15_NOT_COMPL;
	DFlipFlop32 level15_NOT_FF(LEVEL14_NOT_COMPL,clk,LEVEL15_NOT_COMPL);

	//16th clock cycle
	wire[31:0] LEVEL16_NOT_COMPL;
	DFlipFlop32 level16_NOT_FF(LEVEL15_NOT_COMPL,clk,LEVEL16_NOT_COMPL);

	//17th clock cycle
	wire[31:0] LEVEL17_NOT_COMPL;
	DFlipFlop32 level17_NOT_FF(LEVEL16_NOT_COMPL,clk,LEVEL17_NOT_COMPL);

	//18th clock cycle
	wire[31:0] LEVEL18_NOT_COMPL;
	DFlipFlop32 level18_NOT_FF(LEVEL17_NOT_COMPL,clk,LEVEL18_NOT_COMPL);

	//19th clock cycle
	wire[31:0] LEVEL19_NOT_COMPL;
	DFlipFlop32 level19_NOT_FF(LEVEL18_NOT_COMPL,clk,LEVEL19_NOT_COMPL);

	//20th clock cycle
	wire[31:0] LEVEL20_NOT_COMPL;
	DFlipFlop32 level20_NOT_FF(LEVEL19_NOT_COMPL,clk,LEVEL20_NOT_COMPL);

	//21th clock cycle
	wire[31:0] LEVEL21_NOT_COMPL;
	DFlipFlop32 level21_NOT_FF(LEVEL20_NOT_COMPL,clk,LEVEL21_NOT_COMPL);

	//22th clock cycle
	wire[31:0] LEVEL22_NOT_COMPL;
	DFlipFlop32 level22_NOT_FF(LEVEL21_NOT_COMPL,clk,LEVEL22_NOT_COMPL);

	//23th clock cycle
	wire[31:0] LEVEL23_NOT_COMPL;
	DFlipFlop32 level23_NOT_FF(LEVEL22_NOT_COMPL,clk,LEVEL23_NOT_COMPL);

	//24th clock cycle
	wire[31:0] LEVEL24_NOT_COMPL;
	DFlipFlop32 level24_NOT_FF(LEVEL23_NOT_COMPL,clk,LEVEL24_NOT_COMPL);

	//25th clock cycle
	wire[31:0] LEVEL25_NOT_COMPL;
	DFlipFlop32 level25_NOT_FF(LEVEL24_NOT_COMPL,clk,LEVEL25_NOT_COMPL);

	//26th clock cycle
	wire[31:0] LEVEL26_NOT_COMPL;
	DFlipFlop32 level26_NOT_FF(LEVEL25_NOT_COMPL,clk,LEVEL26_NOT_COMPL);

	//27th clock cycle
	wire[31:0] LEVEL27_NOT_COMPL;
	DFlipFlop32 level27_NOT_FF(LEVEL26_NOT_COMPL,clk,LEVEL27_NOT_COMPL);

	//28th clock cycle
	wire[31:0] LEVEL28_NOT_COMPL;
	DFlipFlop32 level28_NOT_FF(LEVEL27_NOT_COMPL,clk,LEVEL28_NOT_COMPL);

	//29th clock cycle
	wire[31:0] LEVEL29_NOT_COMPL;
	DFlipFlop32 level29_NOT_FF(LEVEL28_NOT_COMPL,clk,LEVEL29_NOT_COMPL);

	//30th clock cycle
	wire[31:0] LEVEL30_NOT_COMPL;
	DFlipFlop32 level30_NOT_FF(LEVEL29_NOT_COMPL,clk,LEVEL30_NOT_COMPL);

	//31th clock cycle
	wire[31:0] LEVEL31_NOT_COMPL;
	DFlipFlop32 level31_NOT_FF(LEVEL30_NOT_COMPL,clk,LEVEL31_NOT_COMPL);

	//32th clock cycle
	wire[31:0] LEVEL32_NOT_COMPL;
	DFlipFlop32 level32_NOT_FF(LEVEL31_NOT_COMPL,clk,LEVEL32_NOT_COMPL);

	//33th clock cycle
	wire[31:0] LEVEL33_NOT_COMPL;
	DFlipFlop32 level33_NOT_FF(LEVEL32_NOT_COMPL,clk,LEVEL33_NOT_COMPL);

	//34th clock cycle
	wire[31:0] LEVEL34_NOT_COMPL;
	DFlipFlop32 level34_NOT_FF(LEVEL33_NOT_COMPL,clk,LEVEL34_NOT_COMPL);

	//35th clock cycle
	wire[31:0] LEVEL35_NOT_COMPL;
	DFlipFlop32 level35_NOT_FF(LEVEL34_NOT_COMPL,clk,LEVEL35_NOT_COMPL);

	//36th clock cycle
	wire[31:0] LEVEL36_NOT_COMPL;
	DFlipFlop32 level36_NOT_FF(LEVEL35_NOT_COMPL,clk,LEVEL36_NOT_COMPL);
	/*NOT and 2's complement of A -- end */


	/*Propogate OP_SELECT 1st to 36th clock cycle -- start */

	//1st clock cycle
	wire[3:0] level1_OP;
	DFlipFlop4 level1_OP_FF(OP_SELECT,clk,level1_OP);

	//2th clock cycle
	wire[3:0] level2_OP;
	DFlipFlop4 level2_OP_FF(level1_OP,clk,level2_OP);

	//3th clock cycle
	wire[3:0] level3_OP;
	DFlipFlop4 level3_OP_FF(level2_OP,clk,level3_OP);

	//4th clock cycle
	wire[3:0] level4_OP;
	DFlipFlop4 level4_OP_FF(level3_OP,clk,level4_OP);

	//5th clock cycle
	wire[3:0] level5_OP;
	DFlipFlop4 level5_OP_FF(level4_OP,clk,level5_OP);

	//6th clock cycle
	wire[3:0] level6_OP;
	DFlipFlop4 level6_OP_FF(level5_OP,clk,level6_OP);

	//7th clock cycle
	wire[3:0] level7_OP;
	DFlipFlop4 level7_OP_FF(level6_OP,clk,level7_OP);

	//8th clock cycle
	wire[3:0] level8_OP;
	DFlipFlop4 level8_OP_FF(level7_OP,clk,level8_OP);

	//9th clock cycle
	wire[3:0] level9_OP;
	DFlipFlop4 level9_OP_FF(level8_OP,clk,level9_OP);

	//10th clock cycle
	wire[3:0] level10_OP;
	DFlipFlop4 level10_OP_FF(level9_OP,clk,level10_OP);

	//11th clock cycle
	wire[3:0] level11_OP;
	DFlipFlop4 level11_OP_FF(level10_OP,clk,level11_OP);

	//12th clock cycle
	wire[3:0] level12_OP;
	DFlipFlop4 level12_OP_FF(level11_OP,clk,level12_OP);

	//13th clock cycle
	wire[3:0] level13_OP;
	DFlipFlop4 level13_OP_FF(level12_OP,clk,level13_OP);

	//14th clock cycle
	wire[3:0] level14_OP;
	DFlipFlop4 level14_OP_FF(level13_OP,clk,level14_OP);

	//15th clock cycle
	wire[3:0] level15_OP;
	DFlipFlop4 level15_OP_FF(level14_OP,clk,level15_OP);

	//16th clock cycle
	wire[3:0] level16_OP;
	DFlipFlop4 level16_OP_FF(level15_OP,clk,level16_OP);

	//17th clock cycle
	wire[3:0] level17_OP;
	DFlipFlop4 level17_OP_FF(level16_OP,clk,level17_OP);

	//18th clock cycle
	wire[3:0] level18_OP;
	DFlipFlop4 level18_OP_FF(level17_OP,clk,level18_OP);

	//19th clock cycle
	wire[3:0] level19_OP;
	DFlipFlop4 level19_OP_FF(level18_OP,clk,level19_OP);

	//20th clock cycle
	wire[3:0] level20_OP;
	DFlipFlop4 level20_OP_FF(level19_OP,clk,level20_OP);

	//21th clock cycle
	wire[3:0] level21_OP;
	DFlipFlop4 level21_OP_FF(level20_OP,clk,level21_OP);

	//22th clock cycle
	wire[3:0] level22_OP;
	DFlipFlop4 level22_OP_FF(level21_OP,clk,level22_OP);

	//23th clock cycle
	wire[3:0] level23_OP;
	DFlipFlop4 level23_OP_FF(level22_OP,clk,level23_OP);

	//24th clock cycle
	wire[3:0] level24_OP;
	DFlipFlop4 level24_OP_FF(level23_OP,clk,level24_OP);

	//25th clock cycle
	wire[3:0] level25_OP;
	DFlipFlop4 level25_OP_FF(level24_OP,clk,level25_OP);

	//26th clock cycle
	wire[3:0] level26_OP;
	DFlipFlop4 level26_OP_FF(level25_OP,clk,level26_OP);

	//27th clock cycle
	wire[3:0] level27_OP;
	DFlipFlop4 level27_OP_FF(level26_OP,clk,level27_OP);

	//28th clock cycle
	wire[3:0] level28_OP;
	DFlipFlop4 level28_OP_FF(level27_OP,clk,level28_OP);

	//29th clock cycle
	wire[3:0] level29_OP;
	DFlipFlop4 level29_OP_FF(level28_OP,clk,level29_OP);

	//30th clock cycle
	wire[3:0] level30_OP;
	DFlipFlop4 level30_OP_FF(level29_OP,clk,level30_OP);

	//31th clock cycle
	wire[3:0] level31_OP;
	DFlipFlop4 level31_OP_FF(level30_OP,clk,level31_OP);

	//32th clock cycle
	wire[3:0] level32_OP;
	DFlipFlop4 level32_OP_FF(level31_OP,clk,level32_OP);

	//33th clock cycle
	wire[3:0] level33_OP;
	DFlipFlop4 level33_OP_FF(level32_OP,clk,level33_OP);

	//34th clock cycle
	wire[3:0] level34_OP;
	DFlipFlop4 level34_OP_FF(level33_OP,clk,level34_OP);

	//35th clock cycle
	wire[3:0] level35_OP;
	DFlipFlop4 level35_OP_FF(level34_OP,clk,level35_OP);

	//36th clock cycle
	wire[3:0] level36_OP;
	DFlipFlop4 level36_OP_FF(level35_OP,clk,level36_OP);

	/*Propogate OP_SELECT 1st to 36th clock cycle -- end */


	/*Preparing INPUTS for MUX  -- start */
	wire[63:0] MUX_IN_SUM;
	assign MUX_IN_SUM[31:0] = level36_SUM;
	assign MUX_IN_SUM[32]   = level36_cout;
	assign MUX_IN_SUM[63:33]= 31'd0;

	//level36_PRODUCT 	: MUX INPUT from INTEGER PRODUCT (already 64 bits)
	wire[63:0] MUX_IN_PRODUCT;
	assign MUX_IN_PRODUCT = level36_PRODUCT;

	//FPA_SUM_FFOUT		: MUX INPUT from FP ADDITION
	wire[63:0] MUX_IN_FPADD;
	assign MUX_IN_FPADD[31:0]  = FPA_SUM_FFOUT;
	assign MUX_IN_FPADD[63:32] = 32'd0;

	//level36_FPM_PRO	: MUX INPUT from FP MULTIPLICATION
	wire[63:0] MUX_IN_FPMUL;
	assign MUX_IN_FPMUL[31:0]  = level36_FPM_PRO;
	assign MUX_IN_FPMUL[63:32] = 32'd0;

	//level36_AND,level36_OR,level36_XOR,level36_NAND,level36_NOR,level36_XNOR : MUX INPUT LOGIC UNIT
	wire[63:0] MUX_IN_AND,MUX_IN_OR,MUX_IN_XOR,MUX_IN_NAND,MUX_IN_NOR,MUX_IN_XNOR;
	
	assign MUX_IN_AND[31:0]  = level36_AND;
	assign MUX_IN_AND[63:32] = 32'd0;

	assign MUX_IN_OR[31:0]  = level36_OR;
	assign MUX_IN_OR[63:32] = 32'd0;

	assign MUX_IN_XOR[31:0]  = level36_XOR;
	assign MUX_IN_XOR[63:32] = 32'd0;

	assign MUX_IN_NAND[31:0]  = level36_NAND;
	assign MUX_IN_NAND[63:32] = 32'd0;

	assign MUX_IN_NOR[31:0]  = level36_NOR;
	assign MUX_IN_NOR[63:32] = 32'd0;

	assign MUX_IN_XNOR[31:0]  = level36_XNOR;
	assign MUX_IN_XNOR[63:32] = 32'd0;

	//MUX INPUT : NOT and 2's complement
	wire[63:0] MUX_IN_NOT;

	assign MUX_IN_NOT[31:0]  = LEVEL36_NOT_COMPL;
	assign MUX_IN_NOT[63:32] = 32'd0;

	/*Preparing INPUTS for MUX  -- end */
	
	//38th clock cycle OUTPUT
	MUX64bit_16x1 MUX_OP_SELECT(MUX_IN_SUM,MUX_IN_SUM,MUX_IN_SUM,MUX_IN_SUM,MUX_IN_PRODUCT,MUX_IN_FPADD,MUX_IN_FPADD,MUX_IN_FPMUL,MUX_IN_AND,MUX_IN_OR,MUX_IN_XOR,MUX_IN_NAND,MUX_IN_NOR,MUX_IN_XNOR,MUX_IN_NOT,MUX_IN_NOT,level36_OP,OUT,clk);

	
endmodule // ALU

`endif
