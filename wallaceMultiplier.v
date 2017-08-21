//header guards
`ifndef _wallaceMult_vh_
`define _wallaceMult_vh_

`include "CSA.v"
`include "partialSum.v"
`include "prefixAdder64.v"

//10 clock cycles - clk 0 : input; clk10 : output
module wallaceMultiplier(A,B,OUT,clk);

	input[31:0] A,B;
	input clk;

	output[63:0] OUT;

	//STAGE 1: Generating 63 bit partial sums
	wire[62:0] level1_partial_sum[0:31];

	assign level1_partial_sum[0][62:32]=31'b0;

	assign level1_partial_sum[1][0]=0;
	assign level1_partial_sum[1][62:33]=30'b0;

	assign level1_partial_sum[2][1:0]=2'b0;
	assign level1_partial_sum[2][62:34]=29'b0;

	assign level1_partial_sum[3][2:0]=3'b0;
	assign level1_partial_sum[3][62:35]=28'b0;

	assign level1_partial_sum[4][3:0]=4'b0;
	assign level1_partial_sum[4][62:36]=27'b0;

	assign level1_partial_sum[5][4:0]=5'b0;
	assign level1_partial_sum[5][62:37]=26'b0;

	assign level1_partial_sum[6][5:0]=6'b0;
	assign level1_partial_sum[6][62:38]=25'b0;

	assign level1_partial_sum[7][6:0]=7'b0;
	assign level1_partial_sum[7][62:39]=24'b0;

	assign level1_partial_sum[8][7:0]=8'b0;
	assign level1_partial_sum[8][62:40]=23'b0;

	assign level1_partial_sum[9][8:0]=9'b0;
	assign level1_partial_sum[9][62:41]=22'b0;

	assign level1_partial_sum[10][9:0]=10'b0;
	assign level1_partial_sum[10][62:42]=21'b0;

	assign level1_partial_sum[11][10:0]=11'b0;
	assign level1_partial_sum[11][62:43]=20'b0;

	assign level1_partial_sum[12][11:0]=12'b0;
	assign level1_partial_sum[12][62:44]=19'b0;

	assign level1_partial_sum[13][12:0]=13'b0;
	assign level1_partial_sum[13][62:45]=18'b0;

	assign level1_partial_sum[14][13:0]=14'b0;
	assign level1_partial_sum[14][62:46]=17'b0;

	assign level1_partial_sum[15][14:0]=15'b0;
	assign level1_partial_sum[15][62:47]=16'b0;

	assign level1_partial_sum[16][15:0]=16'b0;
	assign level1_partial_sum[16][62:48]=15'b0;

	assign level1_partial_sum[17][16:0]=17'b0;
	assign level1_partial_sum[17][62:49]=14'b0;

	assign level1_partial_sum[18][17:0]=18'b0;
	assign level1_partial_sum[18][62:50]=13'b0;

	assign level1_partial_sum[19][18:0]=19'b0;
	assign level1_partial_sum[19][62:51]=12'b0;

	assign level1_partial_sum[20][19:0]=20'b0;
	assign level1_partial_sum[20][62:52]=11'b0;

	assign level1_partial_sum[21][20:0]=21'b0;
	assign level1_partial_sum[21][62:53]=10'b0;

	assign level1_partial_sum[22][21:0]=22'b0;
	assign level1_partial_sum[22][62:54]=9'b0;

	assign level1_partial_sum[23][22:0]=23'b0;
	assign level1_partial_sum[23][62:55]=8'b0;

	assign level1_partial_sum[24][23:0]=24'b0;
	assign level1_partial_sum[24][62:56]=7'b0;

	assign level1_partial_sum[25][24:0]=25'b0;
	assign level1_partial_sum[25][62:57]=6'b0;

	assign level1_partial_sum[26][25:0]=26'b0;
	assign level1_partial_sum[26][62:58]=5'b0;

	assign level1_partial_sum[27][26:0]=27'b0;
	assign level1_partial_sum[27][62:59]=4'b0;

	assign level1_partial_sum[28][27:0]=28'b0;
	assign level1_partial_sum[28][62:60]=3'b0;

	assign level1_partial_sum[29][28:0]=29'b0;
	assign level1_partial_sum[29][62:61]=2'b0;

	assign level1_partial_sum[30][29:0]=30'b0;
	assign level1_partial_sum[30][62]=1'b0;

	assign level1_partial_sum[31][30:0]=31'b0;

	partialSum level1_PS0(A,B[0],level1_partial_sum[0][31:0]);
	partialSum level1_PS1(A,B[1],level1_partial_sum[1][32:1]);
	partialSum level1_PS2(A,B[2],level1_partial_sum[2][33:2]);
	partialSum level1_PS3(A,B[3],level1_partial_sum[3][34:3]);
	partialSum level1_PS4(A,B[4],level1_partial_sum[4][35:4]);
	partialSum level1_PS5(A,B[5],level1_partial_sum[5][36:5]);
	partialSum level1_PS6(A,B[6],level1_partial_sum[6][37:6]);
	partialSum level1_PS7(A,B[7],level1_partial_sum[7][38:7]);
	partialSum level1_PS8(A,B[8],level1_partial_sum[8][39:8]);
	partialSum level1_PS9(A,B[9],level1_partial_sum[9][40:9]);
	partialSum level1_PS10(A,B[10],level1_partial_sum[10][41:10]);
	partialSum level1_PS11(A,B[11],level1_partial_sum[11][42:11]);
	partialSum level1_PS12(A,B[12],level1_partial_sum[12][43:12]);
	partialSum level1_PS13(A,B[13],level1_partial_sum[13][44:13]);
	partialSum level1_PS14(A,B[14],level1_partial_sum[14][45:14]);
	partialSum level1_PS15(A,B[15],level1_partial_sum[15][46:15]);
	partialSum level1_PS16(A,B[16],level1_partial_sum[16][47:16]);
	partialSum level1_PS17(A,B[17],level1_partial_sum[17][48:17]);
	partialSum level1_PS18(A,B[18],level1_partial_sum[18][49:18]);
	partialSum level1_PS19(A,B[19],level1_partial_sum[19][50:19]);
	partialSum level1_PS20(A,B[20],level1_partial_sum[20][51:20]);
	partialSum level1_PS21(A,B[21],level1_partial_sum[21][52:21]);
	partialSum level1_PS22(A,B[22],level1_partial_sum[22][53:22]);
	partialSum level1_PS23(A,B[23],level1_partial_sum[23][54:23]);
	partialSum level1_PS24(A,B[24],level1_partial_sum[24][55:24]);
	partialSum level1_PS25(A,B[25],level1_partial_sum[25][56:25]);
	partialSum level1_PS26(A,B[26],level1_partial_sum[26][57:26]);
	partialSum level1_PS27(A,B[27],level1_partial_sum[27][58:27]);
	partialSum level1_PS28(A,B[28],level1_partial_sum[28][59:28]);
	partialSum level1_PS29(A,B[29],level1_partial_sum[29][60:29]);
	partialSum level1_PS30(A,B[30],level1_partial_sum[30][61:30]);
	partialSum level1_PS31(A,B[31],level1_partial_sum[31][62:31]);

	wire[62:0] level1_PS_FFIN[0:21];

  //module CSA63bit(A,B,C,SUM,CARRY);
  //CSA63bit CSA_level1_0(level1_partial_sum[0],level1_partial_sum[1],level1_partial_sum[2],level1_PS_FFIN[0],level1_PS_FFIN[1]);

	CSA63bit CSA_level1_0(level1_partial_sum[0],level1_partial_sum[1],level1_partial_sum[2],level1_PS_FFIN[0],level1_PS_FFIN[1]);
	CSA63bit CSA_level1_1(level1_partial_sum[3],level1_partial_sum[4],level1_partial_sum[5],level1_PS_FFIN[2],level1_PS_FFIN[3]);
	CSA63bit CSA_level1_2(level1_partial_sum[6],level1_partial_sum[7],level1_partial_sum[8],level1_PS_FFIN[4],level1_PS_FFIN[5]);
	CSA63bit CSA_level1_3(level1_partial_sum[9],level1_partial_sum[10],level1_partial_sum[11],level1_PS_FFIN[6],level1_PS_FFIN[7]);
	CSA63bit CSA_level1_4(level1_partial_sum[12],level1_partial_sum[13],level1_partial_sum[14],level1_PS_FFIN[8],level1_PS_FFIN[9]);
	CSA63bit CSA_level1_5(level1_partial_sum[15],level1_partial_sum[16],level1_partial_sum[17],level1_PS_FFIN[10],level1_PS_FFIN[11]);
	CSA63bit CSA_level1_6(level1_partial_sum[18],level1_partial_sum[19],level1_partial_sum[20],level1_PS_FFIN[12],level1_PS_FFIN[13]);
	CSA63bit CSA_level1_7(level1_partial_sum[21],level1_partial_sum[22],level1_partial_sum[23],level1_PS_FFIN[14],level1_PS_FFIN[15]);
	CSA63bit CSA_level1_8(level1_partial_sum[24],level1_partial_sum[25],level1_partial_sum[26],level1_PS_FFIN[16],level1_PS_FFIN[17]);
	CSA63bit CSA_level1_9(level1_partial_sum[27],level1_partial_sum[28],level1_partial_sum[29],level1_PS_FFIN[18],level1_PS_FFIN[19]);

	assign level1_PS_FFIN[20] = level1_partial_sum[30];
	assign level1_PS_FFIN[21] = level1_partial_sum[31];
	

	wire[62:0] level1_PS_FFOUT[0:21];

  //DFlipFlop63bit level1_PSFF0(level1_PS_FFIN[0],clk,level1_PS_FFOUT[0]);
	DFlipFlop63bit level1_PSFF0(level1_PS_FFIN[0],clk,level1_PS_FFOUT[0]);
	DFlipFlop63bit level1_PSFF1(level1_PS_FFIN[1],clk,level1_PS_FFOUT[1]);
	DFlipFlop63bit level1_PSFF2(level1_PS_FFIN[2],clk,level1_PS_FFOUT[2]);
	DFlipFlop63bit level1_PSFF3(level1_PS_FFIN[3],clk,level1_PS_FFOUT[3]);
	DFlipFlop63bit level1_PSFF4(level1_PS_FFIN[4],clk,level1_PS_FFOUT[4]);
	DFlipFlop63bit level1_PSFF5(level1_PS_FFIN[5],clk,level1_PS_FFOUT[5]);
	DFlipFlop63bit level1_PSFF6(level1_PS_FFIN[6],clk,level1_PS_FFOUT[6]);
	DFlipFlop63bit level1_PSFF7(level1_PS_FFIN[7],clk,level1_PS_FFOUT[7]);
	DFlipFlop63bit level1_PSFF8(level1_PS_FFIN[8],clk,level1_PS_FFOUT[8]);
	DFlipFlop63bit level1_PSFF9(level1_PS_FFIN[9],clk,level1_PS_FFOUT[9]);
	DFlipFlop63bit level1_PSFF10(level1_PS_FFIN[10],clk,level1_PS_FFOUT[10]);
	DFlipFlop63bit level1_PSFF11(level1_PS_FFIN[11],clk,level1_PS_FFOUT[11]);
	DFlipFlop63bit level1_PSFF12(level1_PS_FFIN[12],clk,level1_PS_FFOUT[12]);
	DFlipFlop63bit level1_PSFF13(level1_PS_FFIN[13],clk,level1_PS_FFOUT[13]);
	DFlipFlop63bit level1_PSFF14(level1_PS_FFIN[14],clk,level1_PS_FFOUT[14]);
	DFlipFlop63bit level1_PSFF15(level1_PS_FFIN[15],clk,level1_PS_FFOUT[15]);
	DFlipFlop63bit level1_PSFF16(level1_PS_FFIN[16],clk,level1_PS_FFOUT[16]);
	DFlipFlop63bit level1_PSFF17(level1_PS_FFIN[17],clk,level1_PS_FFOUT[17]);
	DFlipFlop63bit level1_PSFF18(level1_PS_FFIN[18],clk,level1_PS_FFOUT[18]);
	DFlipFlop63bit level1_PSFF19(level1_PS_FFIN[19],clk,level1_PS_FFOUT[19]);
	DFlipFlop63bit level1_PSFF20(level1_PS_FFIN[20],clk,level1_PS_FFOUT[20]);
	DFlipFlop63bit level1_PSFF21(level1_PS_FFIN[21],clk,level1_PS_FFOUT[21]);

	//END OF STAGE 1

	//STAGE 2: CSAs Level 2
	wire[62:0] level2_partial_sum[0:14];

  //CSA63bit CSA_level2_0(level1_PS_FFOUT[0],level1_PS_FFOUT[1],level1_PS_FFOUT[2],level2_partial_sum[0],level2_partial_sum[1]);
	CSA63bit CSA_level2_0(level1_PS_FFOUT[0],level1_PS_FFOUT[1],level1_PS_FFOUT[2],level2_partial_sum[0],level2_partial_sum[1]);
	CSA63bit CSA_level2_1(level1_PS_FFOUT[3],level1_PS_FFOUT[4],level1_PS_FFOUT[5],level2_partial_sum[2],level2_partial_sum[3]);
	CSA63bit CSA_level2_2(level1_PS_FFOUT[6],level1_PS_FFOUT[7],level1_PS_FFOUT[8],level2_partial_sum[4],level2_partial_sum[5]);
	CSA63bit CSA_level2_3(level1_PS_FFOUT[9],level1_PS_FFOUT[10],level1_PS_FFOUT[11],level2_partial_sum[6],level2_partial_sum[7]);
	CSA63bit CSA_level2_4(level1_PS_FFOUT[12],level1_PS_FFOUT[13],level1_PS_FFOUT[14],level2_partial_sum[8],level2_partial_sum[9]);
	CSA63bit CSA_level2_5(level1_PS_FFOUT[15],level1_PS_FFOUT[16],level1_PS_FFOUT[17],level2_partial_sum[10],level2_partial_sum[11]);
	CSA63bit CSA_level2_6(level1_PS_FFOUT[18],level1_PS_FFOUT[19],level1_PS_FFOUT[20],level2_partial_sum[12],level2_partial_sum[13]);
	
	assign level2_partial_sum[14] = level1_PS_FFOUT[21];
	
	//END OF STAGE 2

	//STAGE 3: CSAs Level 3
	wire[62:0] level3_partial_sum[0:9];

  //CSA63bit CSA_level3_0(level2_partial_sum[0],level2_partial_sum[1],level2_partial_sum[2],level3_partial_sum[0],level3_partial_sum[1]);
	CSA63bit CSA_level3_0(level2_partial_sum[0],level2_partial_sum[1],level2_partial_sum[2],level3_partial_sum[0],level3_partial_sum[1]);
	CSA63bit CSA_level3_1(level2_partial_sum[3],level2_partial_sum[4],level2_partial_sum[5],level3_partial_sum[2],level3_partial_sum[3]);
	CSA63bit CSA_level3_2(level2_partial_sum[6],level2_partial_sum[7],level2_partial_sum[8],level3_partial_sum[4],level3_partial_sum[5]);
	CSA63bit CSA_level3_3(level2_partial_sum[9],level2_partial_sum[10],level2_partial_sum[11],level3_partial_sum[6],level3_partial_sum[7]);
	CSA63bit CSA_level3_4(level2_partial_sum[12],level2_partial_sum[13],level2_partial_sum[14],level3_partial_sum[8],level3_partial_sum[9]);

	wire[62:0] level3_PS_FFOUT[0:9];
  //DFlipFlop63bit level3_PSFF0(level3_partial_sum[0],clk,level3_PS_FFOUT[0]);
	DFlipFlop63bit level3_PSFF0(level3_partial_sum[0],clk,level3_PS_FFOUT[0]);
	DFlipFlop63bit level3_PSFF1(level3_partial_sum[1],clk,level3_PS_FFOUT[1]);
	DFlipFlop63bit level3_PSFF2(level3_partial_sum[2],clk,level3_PS_FFOUT[2]);
	DFlipFlop63bit level3_PSFF3(level3_partial_sum[3],clk,level3_PS_FFOUT[3]);
	DFlipFlop63bit level3_PSFF4(level3_partial_sum[4],clk,level3_PS_FFOUT[4]);
	DFlipFlop63bit level3_PSFF5(level3_partial_sum[5],clk,level3_PS_FFOUT[5]);
	DFlipFlop63bit level3_PSFF6(level3_partial_sum[6],clk,level3_PS_FFOUT[6]);
	DFlipFlop63bit level3_PSFF7(level3_partial_sum[7],clk,level3_PS_FFOUT[7]);
	DFlipFlop63bit level3_PSFF8(level3_partial_sum[8],clk,level3_PS_FFOUT[8]);
	DFlipFlop63bit level3_PSFF9(level3_partial_sum[9],clk,level3_PS_FFOUT[9]);
	//END OF STAGE 3

	//STAGE 4: CSAs Level 4
	wire[62:0] level4_partial_sum[0:6];

	CSA63bit CSA_level4_0(level3_PS_FFOUT[0],level3_PS_FFOUT[1],level3_PS_FFOUT[2],level4_partial_sum[0],level4_partial_sum[1]);
	CSA63bit CSA_level4_1(level3_PS_FFOUT[3],level3_PS_FFOUT[4],level3_PS_FFOUT[5],level4_partial_sum[2],level4_partial_sum[3]);
	CSA63bit CSA_level4_2(level3_PS_FFOUT[6],level3_PS_FFOUT[7],level3_PS_FFOUT[8],level4_partial_sum[4],level4_partial_sum[5]);

	assign level4_partial_sum[6] = level3_PS_FFOUT[9];
	//END OF STAGE 4

	//STAGE 5: CSAs Level 5
	wire[62:0] level5_partial_sum[0:4];

	CSA63bit CSA_level5_0(level4_partial_sum[0],level4_partial_sum[1],level4_partial_sum[2],level5_partial_sum[0],level5_partial_sum[1]);
	CSA63bit CSA_level5_1(level4_partial_sum[3],level4_partial_sum[4],level4_partial_sum[5],level5_partial_sum[2],level5_partial_sum[3]);

	assign level5_partial_sum[4] = level4_partial_sum[6];

	wire[62:0] level5_PS_FFOUT[0:4];
	DFlipFlop63bit level5_PSFF0(level5_partial_sum[0],clk,level5_PS_FFOUT[0]);
	DFlipFlop63bit level5_PSFF1(level5_partial_sum[1],clk,level5_PS_FFOUT[1]);
	DFlipFlop63bit level5_PSFF2(level5_partial_sum[2],clk,level5_PS_FFOUT[2]);
	DFlipFlop63bit level5_PSFF3(level5_partial_sum[3],clk,level5_PS_FFOUT[3]);
	DFlipFlop63bit level5_PSFF4(level5_partial_sum[4],clk,level5_PS_FFOUT[4]);

	//END OF STAGE 5

	//STAGE 6: CSAs Level 6
	wire[62:0] level6_partial_sum[0:3];
	CSA63bit CSA_level6_0(level5_PS_FFOUT[0],level5_PS_FFOUT[1],level5_PS_FFOUT[2],level6_partial_sum[0],level6_partial_sum[1]);

	assign level6_partial_sum[2] = level5_PS_FFOUT[3];
	assign level6_partial_sum[3] = level5_PS_FFOUT[4];
	//END OF STAGE 6

	//STAGE 7: CSAs Level 7
	wire[62:0] level7_partial_sum[0:2];

	CSA63bit CSA_level7_0(level6_partial_sum[0],level6_partial_sum[1],level6_partial_sum[2],level7_partial_sum[0],level7_partial_sum[1]);
	assign level7_partial_sum[2] = level6_partial_sum[3];

	wire[62:0] level7_PS_FFOUT[0:2];
	DFlipFlop63bit level7_PSFF0(level7_partial_sum[0],clk,level7_PS_FFOUT[0]);
	DFlipFlop63bit level7_PSFF1(level7_partial_sum[1],clk,level7_PS_FFOUT[1]);
	DFlipFlop63bit level7_PSFF2(level7_partial_sum[2],clk,level7_PS_FFOUT[2]);

	//END OF STAGE 7

	//STAGE 8: CSAs Level 8
	wire[62:0] level8_partial_sum[0:1];
	CSA63bit CSA_level8_0(level7_PS_FFOUT[0],level7_PS_FFOUT[1],level7_PS_FFOUT[2],level8_partial_sum[0],level8_partial_sum[1]);

	//END OF STAGE 8

	//convert partial sums to 64 bit numbers
	wire[63:0] partial_sumA,partial_sumB;

	assign partial_sumA[62:0] = level8_partial_sum[0];
	assign partial_sumB[62:0] = level8_partial_sum[1];

	assign partial_sumA[63] = 0;
	assign partial_sumB[63] = 0;

	wire temp_cout;
  //module prefixAdder64(A,B,cin,cout,SUM,clk);

	prefixAdder64 PS_finalFF(partial_sumA,partial_sumB,0,temp_cout,OUT,clk);
endmodule // wallaceMultiplier

`endif
