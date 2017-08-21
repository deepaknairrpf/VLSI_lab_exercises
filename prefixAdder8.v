`ifndef _PA8_vh_
`define _PA8_vh_

//for use in FLOATING POINT MULTIPLIER

`include "basicBlocks.v"
`include "D-FlipFlop.v"

//3 clock cycles - input : clk 0 ; output : clk 3

module prefixAdder8bit(X,Y,cin,cout,SUM,clk);

	input[7:0] X,Y;
	input cin,clk;

	output[7:0] SUM;
	output cout;

	wire[7:0] P,G,A;

	assign P = X ^ Y;
	assign G = X & Y;
	assign A = X | Y;

	wire[7:0] carry;
	assign carry[0]=cin;


	wire[2:0] level01_FFIN_gOutL1,level01_FFIN_aOutL1;

	//stage 1 -- start
	blackBox level1_01(G[0],A[0],carry[0],carry[1]);

	whiteBox level1_02(G[2],A[2],G[1],A[1],level01_FFIN_gOutL1[0],level01_FFIN_aOutL1[0]);
	whiteBox level1_03(G[4],A[4],G[3],A[3],level01_FFIN_gOutL1[1],level01_FFIN_aOutL1[1]);
	whiteBox level1_04(G[6],A[6],G[5],A[5],level01_FFIN_gOutL1[2],level01_FFIN_aOutL1[2]);

	//propogate P, G, A
	wire[7:0] level01_FFOUT_P, level01_FFOUT_G, level01_FFOUT_A;
	DFlipFlop8 level01_P_FF(P,clk,level01_FFOUT_P);
	DFlipFlop8 level01_G_FF(G,clk,level01_FFOUT_G);
	DFlipFlop8 level01_A_FF(A,clk,level01_FFOUT_A);

	//propogate carry through levels
	wire[1:0] level_01_carryFF_OUT;
	DFlipFlop2IN layer01_CARRY_FF(carry[1],carry[0],clk,level_01_carryFF_OUT[1],level_01_carryFF_OUT[0]);

	//propogate gOut and aOut
	wire[2:0] level01_FFOUT_gOutL1, level01_FFOUT_aOutL1;
	DFlipFlop3 layer01_gOutL1_FF(level01_FFIN_gOutL1,clk,level01_FFOUT_gOutL1);
	DFlipFlop3 layer01_aOutL1_FF(level01_FFIN_aOutL1,clk,level01_FFOUT_aOutL1);

	
	//Stage 2  -- start

	wire[1:0] level02_FFIN_gOutL2, level02_FFIN_aOutL2;

	blackBox level2_01(level01_FFOUT_G[1],level01_FFOUT_A[1],level_01_carryFF_OUT[1],carry[2]);
	blackBox level2_02(level01_FFOUT_gOutL1[0],level01_FFOUT_aOutL1[0],level_01_carryFF_OUT[1],carry[3]);

	whiteBox level2_03(level01_FFOUT_G[5],level01_FFOUT_A[5],level01_FFOUT_gOutL1[1],level01_FFOUT_aOutL1[1],level02_FFIN_gOutL2[0],level02_FFIN_aOutL2[0]);
	whiteBox level2_04(level01_FFOUT_gOutL1[2],level01_FFOUT_aOutL1[2],level01_FFOUT_gOutL1[1],level01_FFOUT_aOutL1[1],level02_FFIN_gOutL2[1],level02_FFIN_aOutL2[1]);

	//propogate P, G, A
	wire[7:0] level02_FFOUT_P, level02_FFOUT_G, level02_FFOUT_A;

	DFlipFlop8 level02_P_FF(level01_FFOUT_P,clk,level02_FFOUT_P);
	DFlipFlop8 level02_G_FF(level01_FFOUT_G,clk,level02_FFOUT_G);
	DFlipFlop8 level02_A_FF(level01_FFOUT_A,clk,level02_FFOUT_A);

	//stage 2:propogate COMPUTED carry 
	wire[3:0] level_02_carryFF_OUT;
	DFlipFlop4IN layer02_CARRY_FF(carry[3:2],level_01_carryFF_OUT[1:0],clk,level_02_carryFF_OUT[3:0]);


	//propogate gOut and aOut

	//gOut and aOut from level 1
	wire[2:0] level02_FFOUT_gOutL1, level02_FFOUT_aOutL1;

	DFlipFlop3 layer02_gOutL1_FF(level01_FFOUT_gOutL1,clk,level02_FFOUT_gOutL1);
	DFlipFlop3 layer02_aOutL1_FF(level01_FFOUT_aOutL1,clk,level02_FFOUT_aOutL1);

	//gOut and aOut from level 2
	wire[1:0] level02_FFOUT_gOutL2, level02_FFOUT_aOutL2;

	DFlipFlop2 layer02_gOutL2_FF(level02_FFIN_gOutL2,clk,level02_FFOUT_gOutL2);
	DFlipFlop2 layer02_aOutL2_FF(level02_FFIN_aOutL2,clk,level02_FFOUT_aOutL2);

	//stage 3  -start
	blackBox level3_01(level02_FFOUT_G[3],level02_FFOUT_A[3],level_02_carryFF_OUT[3],carry[4]);
	blackBox level3_02(level02_FFOUT_gOutL1[1],level02_FFOUT_aOutL1[1],level_02_carryFF_OUT[3],carry[5]);
	blackBox level3_03(level02_FFOUT_gOutL2[0],level02_FFOUT_aOutL2[0],level_02_carryFF_OUT[3],carry[6]);
	blackBox level3_04(level02_FFOUT_gOutL2[1],level02_FFOUT_aOutL2[1],level_02_carryFF_OUT[3],carry[7]);

	//collecting all carries
	wire[7:0] level_03_carry_OUT;
	assign level_03_carry_OUT[7:4]=carry[7:4];
	assign level_03_carry_OUT[3:0]=level_02_carryFF_OUT;

	//last level for cout
	blackBox carry_out(level02_FFOUT_G[7],level02_FFOUT_A[7],carry[7],cout);

	assign SUM = level_03_carry_OUT ^ level02_FFOUT_P;

endmodule // prefixAdder8bit

`endif
