//header guards
`ifndef _barrel_shifter_vh_
`define _barrel_shifter_vh_

`include "MUX2.v"
`include "D-FlipFlop.v"

//Barrel Shifter and Rotator
//1. Logical Right and Left Shift
//2. Left and Right Rotation
//3. Arithmetic Right and Left Shift

//7 clock cycles - clk 0 : input; clk 7: output
module barrelShifterRotator(DATA,AMOUNT,left,rotate,arithmetic,clk,OUT);
	input[31:0] DATA;
	input[4:0] AMOUNT;

	input left,rotate,arithmetic,clk;

	output[31:0] OUT;


	wire[31:0] REV_DATA;
	//DATA REVERSAL STAGE
	MUX2x1_DFF DATA_REV31(DATA[31],DATA[0],left,REV_DATA[31],clk);
	MUX2x1_DFF DATA_REV30(DATA[30],DATA[1],left,REV_DATA[30],clk);
	MUX2x1_DFF DATA_REV29(DATA[29],DATA[2],left,REV_DATA[29],clk);
	MUX2x1_DFF DATA_REV28(DATA[28],DATA[3],left,REV_DATA[28],clk);
	MUX2x1_DFF DATA_REV27(DATA[27],DATA[4],left,REV_DATA[27],clk);
	MUX2x1_DFF DATA_REV26(DATA[26],DATA[5],left,REV_DATA[26],clk);
	MUX2x1_DFF DATA_REV25(DATA[25],DATA[6],left,REV_DATA[25],clk);
	MUX2x1_DFF DATA_REV24(DATA[24],DATA[7],left,REV_DATA[24],clk);
	MUX2x1_DFF DATA_REV23(DATA[23],DATA[8],left,REV_DATA[23],clk);
	MUX2x1_DFF DATA_REV22(DATA[22],DATA[9],left,REV_DATA[22],clk);
	MUX2x1_DFF DATA_REV21(DATA[21],DATA[10],left,REV_DATA[21],clk);
	MUX2x1_DFF DATA_REV20(DATA[20],DATA[11],left,REV_DATA[20],clk);
	MUX2x1_DFF DATA_REV19(DATA[19],DATA[12],left,REV_DATA[19],clk);
	MUX2x1_DFF DATA_REV18(DATA[18],DATA[13],left,REV_DATA[18],clk);
	MUX2x1_DFF DATA_REV17(DATA[17],DATA[14],left,REV_DATA[17],clk);
	MUX2x1_DFF DATA_REV16(DATA[16],DATA[15],left,REV_DATA[16],clk);
	MUX2x1_DFF DATA_REV15(DATA[15],DATA[16],left,REV_DATA[15],clk);
	MUX2x1_DFF DATA_REV14(DATA[14],DATA[17],left,REV_DATA[14],clk);
	MUX2x1_DFF DATA_REV13(DATA[13],DATA[18],left,REV_DATA[13],clk);
	MUX2x1_DFF DATA_REV12(DATA[12],DATA[19],left,REV_DATA[12],clk);
	MUX2x1_DFF DATA_REV11(DATA[11],DATA[20],left,REV_DATA[11],clk);
	MUX2x1_DFF DATA_REV10(DATA[10],DATA[21],left,REV_DATA[10],clk);
	MUX2x1_DFF DATA_REV9(DATA[9],DATA[22],left,REV_DATA[9],clk);
	MUX2x1_DFF DATA_REV8(DATA[8],DATA[23],left,REV_DATA[8],clk);
	MUX2x1_DFF DATA_REV7(DATA[7],DATA[24],left,REV_DATA[7],clk);
	MUX2x1_DFF DATA_REV6(DATA[6],DATA[25],left,REV_DATA[6],clk);
	MUX2x1_DFF DATA_REV5(DATA[5],DATA[26],left,REV_DATA[5],clk);
	MUX2x1_DFF DATA_REV4(DATA[4],DATA[27],left,REV_DATA[4],clk);
	MUX2x1_DFF DATA_REV3(DATA[3],DATA[28],left,REV_DATA[3],clk);
	MUX2x1_DFF DATA_REV2(DATA[2],DATA[29],left,REV_DATA[2],clk);
	MUX2x1_DFF DATA_REV1(DATA[1],DATA[30],left,REV_DATA[1],clk);
	MUX2x1_DFF DATA_REV0(DATA[0],DATA[31],left,REV_DATA[0],clk);

	//shift right arithmetic
	wire sra,REV_level_sOUT;
	assign sra= ~rotate & ~left & arithmetic;
	MUX2x1_DFF REV_level_S(0,DATA[31],sra,REV_level_sOUT,clk);

	//propogating LEFT, ROTATE and ARITHMETIC INPUTS
	wire REV_level_leftOUT,REV_level_rotateOUT,REV_level_arithOUT;
	DFlipFlop REV_level_left(left,clk,REV_level_leftOUT);
	DFlipFlop REV_level_rotate(rotate,clk,REV_level_rotateOUT);
	DFlipFlop REV_level_arith(arithmetic,clk,REV_level_arithOUT);

	//propogating amount to shift
	wire[4:0] REV_level_amountOUT;
	DFlipFlop5 REV_level_AMOUNTFF(AMOUNT,clk,REV_level_amountOUT);

	//END OF DATA REVERSAL STAGE

	//STAGE 1 : SHIFT/ROTATE BY 16 bit
	wire level1_rotated16OUT[15:0];
	MUX2x1 STAGE1_ROTATE_31(REV_level_sOUT,REV_DATA[15],REV_level_rotateOUT,level1_rotated16OUT[15]);
	MUX2x1 STAGE1_ROTATE_30(REV_level_sOUT,REV_DATA[14],REV_level_rotateOUT,level1_rotated16OUT[14]);
	MUX2x1 STAGE1_ROTATE_29(REV_level_sOUT,REV_DATA[13],REV_level_rotateOUT,level1_rotated16OUT[13]);
	MUX2x1 STAGE1_ROTATE_28(REV_level_sOUT,REV_DATA[12],REV_level_rotateOUT,level1_rotated16OUT[12]);
	MUX2x1 STAGE1_ROTATE_27(REV_level_sOUT,REV_DATA[11],REV_level_rotateOUT,level1_rotated16OUT[11]);
	MUX2x1 STAGE1_ROTATE_26(REV_level_sOUT,REV_DATA[10],REV_level_rotateOUT,level1_rotated16OUT[10]);
	MUX2x1 STAGE1_ROTATE_25(REV_level_sOUT,REV_DATA[9],REV_level_rotateOUT,level1_rotated16OUT[9]);
	MUX2x1 STAGE1_ROTATE_24(REV_level_sOUT,REV_DATA[8],REV_level_rotateOUT,level1_rotated16OUT[8]);
	MUX2x1 STAGE1_ROTATE_23(REV_level_sOUT,REV_DATA[7],REV_level_rotateOUT,level1_rotated16OUT[7]);
	MUX2x1 STAGE1_ROTATE_22(REV_level_sOUT,REV_DATA[6],REV_level_rotateOUT,level1_rotated16OUT[6]);
	MUX2x1 STAGE1_ROTATE_21(REV_level_sOUT,REV_DATA[5],REV_level_rotateOUT,level1_rotated16OUT[5]);
	MUX2x1 STAGE1_ROTATE_20(REV_level_sOUT,REV_DATA[4],REV_level_rotateOUT,level1_rotated16OUT[4]);
	MUX2x1 STAGE1_ROTATE_19(REV_level_sOUT,REV_DATA[3],REV_level_rotateOUT,level1_rotated16OUT[3]);
	MUX2x1 STAGE1_ROTATE_18(REV_level_sOUT,REV_DATA[2],REV_level_rotateOUT,level1_rotated16OUT[2]);
	MUX2x1 STAGE1_ROTATE_17(REV_level_sOUT,REV_DATA[1],REV_level_rotateOUT,level1_rotated16OUT[1]);
	MUX2x1 STAGE1_ROTATE_16(REV_level_sOUT,REV_DATA[0],REV_level_rotateOUT,level1_rotated16OUT[0]);

	wire[31:0] level1_dataOUT;
	MUX2x1_DFF level1_dataOUT31(REV_DATA[31],level1_rotated16OUT[15],REV_level_amountOUT[4],level1_dataOUT[31],clk);
	MUX2x1_DFF level1_dataOUT30(REV_DATA[30],level1_rotated16OUT[14],REV_level_amountOUT[4],level1_dataOUT[30],clk);
	MUX2x1_DFF level1_dataOUT29(REV_DATA[29],level1_rotated16OUT[13],REV_level_amountOUT[4],level1_dataOUT[29],clk);
	MUX2x1_DFF level1_dataOUT28(REV_DATA[28],level1_rotated16OUT[12],REV_level_amountOUT[4],level1_dataOUT[28],clk);
	MUX2x1_DFF level1_dataOUT27(REV_DATA[27],level1_rotated16OUT[11],REV_level_amountOUT[4],level1_dataOUT[27],clk);
	MUX2x1_DFF level1_dataOUT26(REV_DATA[26],level1_rotated16OUT[10],REV_level_amountOUT[4],level1_dataOUT[26],clk);
	MUX2x1_DFF level1_dataOUT25(REV_DATA[25],level1_rotated16OUT[9],REV_level_amountOUT[4],level1_dataOUT[25],clk);
	MUX2x1_DFF level1_dataOUT24(REV_DATA[24],level1_rotated16OUT[8],REV_level_amountOUT[4],level1_dataOUT[24],clk);
	MUX2x1_DFF level1_dataOUT23(REV_DATA[23],level1_rotated16OUT[7],REV_level_amountOUT[4],level1_dataOUT[23],clk);
	MUX2x1_DFF level1_dataOUT22(REV_DATA[22],level1_rotated16OUT[6],REV_level_amountOUT[4],level1_dataOUT[22],clk);
	MUX2x1_DFF level1_dataOUT21(REV_DATA[21],level1_rotated16OUT[5],REV_level_amountOUT[4],level1_dataOUT[21],clk);
	MUX2x1_DFF level1_dataOUT20(REV_DATA[20],level1_rotated16OUT[4],REV_level_amountOUT[4],level1_dataOUT[20],clk);
	MUX2x1_DFF level1_dataOUT19(REV_DATA[19],level1_rotated16OUT[3],REV_level_amountOUT[4],level1_dataOUT[19],clk);
	MUX2x1_DFF level1_dataOUT18(REV_DATA[18],level1_rotated16OUT[2],REV_level_amountOUT[4],level1_dataOUT[18],clk);
	MUX2x1_DFF level1_dataOUT17(REV_DATA[17],level1_rotated16OUT[1],REV_level_amountOUT[4],level1_dataOUT[17],clk);
	MUX2x1_DFF level1_dataOUT16(REV_DATA[16],level1_rotated16OUT[0],REV_level_amountOUT[4],level1_dataOUT[16],clk);

	//MUX2x1_DFF level1_dataOUT15(REV_DATA[15],REV_DATA[31],REV_level_amountOUT[4],level1_dataOUT[15],clk);
	MUX2x1_DFF level1_dataOUT15(REV_DATA[15],REV_DATA[31],REV_level_amountOUT[4],level1_dataOUT[15],clk);
	MUX2x1_DFF level1_dataOUT14(REV_DATA[14],REV_DATA[30],REV_level_amountOUT[4],level1_dataOUT[14],clk);
	MUX2x1_DFF level1_dataOUT13(REV_DATA[13],REV_DATA[29],REV_level_amountOUT[4],level1_dataOUT[13],clk);
	MUX2x1_DFF level1_dataOUT12(REV_DATA[12],REV_DATA[28],REV_level_amountOUT[4],level1_dataOUT[12],clk);
	MUX2x1_DFF level1_dataOUT11(REV_DATA[11],REV_DATA[27],REV_level_amountOUT[4],level1_dataOUT[11],clk);
	MUX2x1_DFF level1_dataOUT10(REV_DATA[10],REV_DATA[26],REV_level_amountOUT[4],level1_dataOUT[10],clk);
	MUX2x1_DFF level1_dataOUT9(REV_DATA[9],REV_DATA[25],REV_level_amountOUT[4],level1_dataOUT[9],clk);
	MUX2x1_DFF level1_dataOUT8(REV_DATA[8],REV_DATA[24],REV_level_amountOUT[4],level1_dataOUT[8],clk);
	MUX2x1_DFF level1_dataOUT7(REV_DATA[7],REV_DATA[23],REV_level_amountOUT[4],level1_dataOUT[7],clk);
	MUX2x1_DFF level1_dataOUT6(REV_DATA[6],REV_DATA[22],REV_level_amountOUT[4],level1_dataOUT[6],clk);
	MUX2x1_DFF level1_dataOUT5(REV_DATA[5],REV_DATA[21],REV_level_amountOUT[4],level1_dataOUT[5],clk);
	MUX2x1_DFF level1_dataOUT4(REV_DATA[4],REV_DATA[20],REV_level_amountOUT[4],level1_dataOUT[4],clk);
	MUX2x1_DFF level1_dataOUT3(REV_DATA[3],REV_DATA[19],REV_level_amountOUT[4],level1_dataOUT[3],clk);
	MUX2x1_DFF level1_dataOUT2(REV_DATA[2],REV_DATA[18],REV_level_amountOUT[4],level1_dataOUT[2],clk);
	MUX2x1_DFF level1_dataOUT1(REV_DATA[1],REV_DATA[17],REV_level_amountOUT[4],level1_dataOUT[1],clk);
	MUX2x1_DFF level1_dataOUT0(REV_DATA[0],REV_DATA[16],REV_level_amountOUT[4],level1_dataOUT[0],clk);

	//propogating LEFT, ROTATE and ARITHMETIC INPUTS
	wire level1_leftOUT,level1_rotateOUT,level1_arithOUT;
	DFlipFlop level1_left(REV_level_leftOUT,clk,level1_leftOUT);
	DFlipFlop level1_rotate(REV_level_rotateOUT,clk,level1_rotateOUT);
	DFlipFlop level1_arith(REV_level_arithOUT,clk,level1_arithOUT);

	//propogating amount to shift
	wire[4:0] level1_amountOUT;
	DFlipFlop5 level1_AMOUNTFF(REV_level_amountOUT,clk,level1_amountOUT);

	//propogating sOut for LEFT SHIFT
	wire level1_sLeftOUT;
	DFlipFlop level1_sLeftOUTFF(REV_DATA[0],clk,level1_sLeftOUT);

	//propogating sOut for RIGHT shift
	wire level1_sOUT;
	DFlipFlop level1_sOutFF(REV_level_sOUT,clk,level1_sOUT);
	//END OF STAGE 1

	//STAGE 2 : SHIFT/ROTATE BY 8 bit
	wire[7:0] level2_rotated8OUT;
	
	MUX2x1 STAGE2_ROTATE_31(level1_sOUT,level1_dataOUT[7],level1_rotateOUT,level2_rotated8OUT[7]);
	MUX2x1 STAGE2_ROTATE_30(level1_sOUT,level1_dataOUT[6],level1_rotateOUT,level2_rotated8OUT[6]);
	MUX2x1 STAGE2_ROTATE_29(level1_sOUT,level1_dataOUT[5],level1_rotateOUT,level2_rotated8OUT[5]);
	MUX2x1 STAGE2_ROTATE_28(level1_sOUT,level1_dataOUT[4],level1_rotateOUT,level2_rotated8OUT[4]);
	MUX2x1 STAGE2_ROTATE_27(level1_sOUT,level1_dataOUT[3],level1_rotateOUT,level2_rotated8OUT[3]);
	MUX2x1 STAGE2_ROTATE_26(level1_sOUT,level1_dataOUT[2],level1_rotateOUT,level2_rotated8OUT[2]);
	MUX2x1 STAGE2_ROTATE_25(level1_sOUT,level1_dataOUT[1],level1_rotateOUT,level2_rotated8OUT[1]);
	MUX2x1 STAGE2_ROTATE_24(level1_sOUT,level1_dataOUT[0],level1_rotateOUT,level2_rotated8OUT[0]);

	wire[31:0] level2_dataOUT;
	MUX2x1_DFF level2_dataOUT31(level1_dataOUT[31],level2_rotated8OUT[7],level1_amountOUT[3],level2_dataOUT[31],clk);
	MUX2x1_DFF level2_dataOUT30(level1_dataOUT[30],level2_rotated8OUT[6],level1_amountOUT[3],level2_dataOUT[30],clk);
	MUX2x1_DFF level2_dataOUT29(level1_dataOUT[29],level2_rotated8OUT[5],level1_amountOUT[3],level2_dataOUT[29],clk);
	MUX2x1_DFF level2_dataOUT28(level1_dataOUT[28],level2_rotated8OUT[4],level1_amountOUT[3],level2_dataOUT[28],clk);
	MUX2x1_DFF level2_dataOUT27(level1_dataOUT[27],level2_rotated8OUT[3],level1_amountOUT[3],level2_dataOUT[27],clk);
	MUX2x1_DFF level2_dataOUT26(level1_dataOUT[26],level2_rotated8OUT[2],level1_amountOUT[3],level2_dataOUT[26],clk);
	MUX2x1_DFF level2_dataOUT25(level1_dataOUT[25],level2_rotated8OUT[1],level1_amountOUT[3],level2_dataOUT[25],clk);
	MUX2x1_DFF level2_dataOUT24(level1_dataOUT[24],level2_rotated8OUT[0],level1_amountOUT[3],level2_dataOUT[24],clk);
	

	//MUX2x1_DFF level2_dataOUT23(level1_dataOUT[23],level1_dataOUT[31],level1_amountOUT[3],level2_dataOUT[23],clk);
	MUX2x1_DFF level2_dataOUT23(level1_dataOUT[23],level1_dataOUT[31],level1_amountOUT[3],level2_dataOUT[23],clk);
	MUX2x1_DFF level2_dataOUT22(level1_dataOUT[22],level1_dataOUT[30],level1_amountOUT[3],level2_dataOUT[22],clk);
	MUX2x1_DFF level2_dataOUT21(level1_dataOUT[21],level1_dataOUT[29],level1_amountOUT[3],level2_dataOUT[21],clk);
	MUX2x1_DFF level2_dataOUT20(level1_dataOUT[20],level1_dataOUT[28],level1_amountOUT[3],level2_dataOUT[20],clk);
	MUX2x1_DFF level2_dataOUT19(level1_dataOUT[19],level1_dataOUT[27],level1_amountOUT[3],level2_dataOUT[19],clk);
	MUX2x1_DFF level2_dataOUT18(level1_dataOUT[18],level1_dataOUT[26],level1_amountOUT[3],level2_dataOUT[18],clk);
	MUX2x1_DFF level2_dataOUT17(level1_dataOUT[17],level1_dataOUT[25],level1_amountOUT[3],level2_dataOUT[17],clk);
	MUX2x1_DFF level2_dataOUT16(level1_dataOUT[16],level1_dataOUT[24],level1_amountOUT[3],level2_dataOUT[16],clk);
	MUX2x1_DFF level2_dataOUT15(level1_dataOUT[15],level1_dataOUT[23],level1_amountOUT[3],level2_dataOUT[15],clk);
	MUX2x1_DFF level2_dataOUT14(level1_dataOUT[14],level1_dataOUT[22],level1_amountOUT[3],level2_dataOUT[14],clk);
	MUX2x1_DFF level2_dataOUT13(level1_dataOUT[13],level1_dataOUT[21],level1_amountOUT[3],level2_dataOUT[13],clk);
	MUX2x1_DFF level2_dataOUT12(level1_dataOUT[12],level1_dataOUT[20],level1_amountOUT[3],level2_dataOUT[12],clk);
	MUX2x1_DFF level2_dataOUT11(level1_dataOUT[11],level1_dataOUT[19],level1_amountOUT[3],level2_dataOUT[11],clk);
	MUX2x1_DFF level2_dataOUT10(level1_dataOUT[10],level1_dataOUT[18],level1_amountOUT[3],level2_dataOUT[10],clk);
	MUX2x1_DFF level2_dataOUT9(level1_dataOUT[9],level1_dataOUT[17],level1_amountOUT[3],level2_dataOUT[9],clk);
	MUX2x1_DFF level2_dataOUT8(level1_dataOUT[8],level1_dataOUT[16],level1_amountOUT[3],level2_dataOUT[8],clk);
	MUX2x1_DFF level2_dataOUT7(level1_dataOUT[7],level1_dataOUT[15],level1_amountOUT[3],level2_dataOUT[7],clk);
	MUX2x1_DFF level2_dataOUT6(level1_dataOUT[6],level1_dataOUT[14],level1_amountOUT[3],level2_dataOUT[6],clk);
	MUX2x1_DFF level2_dataOUT5(level1_dataOUT[5],level1_dataOUT[13],level1_amountOUT[3],level2_dataOUT[5],clk);
	MUX2x1_DFF level2_dataOUT4(level1_dataOUT[4],level1_dataOUT[12],level1_amountOUT[3],level2_dataOUT[4],clk);
	MUX2x1_DFF level2_dataOUT3(level1_dataOUT[3],level1_dataOUT[11],level1_amountOUT[3],level2_dataOUT[3],clk);
	MUX2x1_DFF level2_dataOUT2(level1_dataOUT[2],level1_dataOUT[10],level1_amountOUT[3],level2_dataOUT[2],clk);
	MUX2x1_DFF level2_dataOUT1(level1_dataOUT[1],level1_dataOUT[9],level1_amountOUT[3],level2_dataOUT[1],clk);
	MUX2x1_DFF level2_dataOUT0(level1_dataOUT[0],level1_dataOUT[8],level1_amountOUT[3],level2_dataOUT[0],clk);

	//propogating LEFT, ROTATE and ARITHMETIC INPUTS
	wire level2_leftOUT,level2_rotateOUT,level2_arithOUT;
	DFlipFlop level2_left(level1_leftOUT,clk,level2_leftOUT);
	DFlipFlop level2_rotate(level1_rotateOUT,clk,level2_rotateOUT);
	DFlipFlop level2_arith(level1_arithOUT,clk,level2_arithOUT);

	//propogating amount to shift
	wire[4:0] level2_amountOUT;
	DFlipFlop5 level2_AMOUNTFF(level1_amountOUT,clk,level2_amountOUT);

	//propogating sOut for LEFT SHIFT
	wire level2_sLeftOUT;
	DFlipFlop level2_sLeftOUTFF(level1_sLeftOUT,clk,level2_sLeftOUT);

	//propogating sOut for RIGHT shift
	wire level2_sOUT;
	DFlipFlop level2_sOutFF(level1_sOUT,clk,level2_sOUT);

	//END OF STAGE 2


	//STAGE 3 : SHIFT/ROTATE BY 4 bit
	wire[3:0] level3_rotated4OUT;
	//module MUX2x1(data0,data1,select,out);

  //MUX2x1 STAGE3_ROTATE_31(level2_sOUT,level2_dataOUT[3],level2_amountOUT[2],level3_rotated4OUT[3]);
	MUX2x1 STAGE3_ROTATE_31(level2_sOUT,level2_dataOUT[3],level2_rotateOUT,level3_rotated4OUT[3]);
	MUX2x1 STAGE3_ROTATE_30(level2_sOUT,level2_dataOUT[2],level2_rotateOUT,level3_rotated4OUT[2]);
	MUX2x1 STAGE3_ROTATE_29(level2_sOUT,level2_dataOUT[1],level2_rotateOUT,level3_rotated4OUT[1]);
	MUX2x1 STAGE3_ROTATE_28(level2_sOUT,level2_dataOUT[0],level2_rotateOUT,level3_rotated4OUT[0]);

	wire[31:0] level3_dataOUT;
  //MUX2x1_DFF level3_dataOUT31(level2_dataOUT[31],level3_rotated4OUT[3],level2_amountOUT[2],level3_dataOUT[31],clk);
	MUX2x1_DFF level3_dataOUT31(level2_dataOUT[31],level3_rotated4OUT[3],level2_amountOUT[2],level3_dataOUT[31],clk);
	MUX2x1_DFF level3_dataOUT30(level2_dataOUT[30],level3_rotated4OUT[2],level2_amountOUT[2],level3_dataOUT[30],clk);
	MUX2x1_DFF level3_dataOUT29(level2_dataOUT[29],level3_rotated4OUT[1],level2_amountOUT[2],level3_dataOUT[29],clk);
	MUX2x1_DFF level3_dataOUT28(level2_dataOUT[28],level3_rotated4OUT[0],level2_amountOUT[2],level3_dataOUT[28],clk);

  //MUX2x1_DFF level3_dataOUT27(level2_dataOUT[27],level2_dataOUT[31],level2_amountOUT[2],level3_dataOUT[27],clk);
	MUX2x1_DFF level3_dataOUT27(level2_dataOUT[27],level2_dataOUT[31],level2_amountOUT[2],level3_dataOUT[27],clk);
	MUX2x1_DFF level3_dataOUT26(level2_dataOUT[26],level2_dataOUT[30],level2_amountOUT[2],level3_dataOUT[26],clk);
	MUX2x1_DFF level3_dataOUT25(level2_dataOUT[25],level2_dataOUT[29],level2_amountOUT[2],level3_dataOUT[25],clk);
	MUX2x1_DFF level3_dataOUT24(level2_dataOUT[24],level2_dataOUT[28],level2_amountOUT[2],level3_dataOUT[24],clk);
	MUX2x1_DFF level3_dataOUT23(level2_dataOUT[23],level2_dataOUT[27],level2_amountOUT[2],level3_dataOUT[23],clk);
	MUX2x1_DFF level3_dataOUT22(level2_dataOUT[22],level2_dataOUT[26],level2_amountOUT[2],level3_dataOUT[22],clk);
	MUX2x1_DFF level3_dataOUT21(level2_dataOUT[21],level2_dataOUT[25],level2_amountOUT[2],level3_dataOUT[21],clk);
	MUX2x1_DFF level3_dataOUT20(level2_dataOUT[20],level2_dataOUT[24],level2_amountOUT[2],level3_dataOUT[20],clk);
	MUX2x1_DFF level3_dataOUT19(level2_dataOUT[19],level2_dataOUT[23],level2_amountOUT[2],level3_dataOUT[19],clk);
	MUX2x1_DFF level3_dataOUT18(level2_dataOUT[18],level2_dataOUT[22],level2_amountOUT[2],level3_dataOUT[18],clk);
	MUX2x1_DFF level3_dataOUT17(level2_dataOUT[17],level2_dataOUT[21],level2_amountOUT[2],level3_dataOUT[17],clk);
	MUX2x1_DFF level3_dataOUT16(level2_dataOUT[16],level2_dataOUT[20],level2_amountOUT[2],level3_dataOUT[16],clk);
	MUX2x1_DFF level3_dataOUT15(level2_dataOUT[15],level2_dataOUT[19],level2_amountOUT[2],level3_dataOUT[15],clk);
	MUX2x1_DFF level3_dataOUT14(level2_dataOUT[14],level2_dataOUT[18],level2_amountOUT[2],level3_dataOUT[14],clk);
	MUX2x1_DFF level3_dataOUT13(level2_dataOUT[13],level2_dataOUT[17],level2_amountOUT[2],level3_dataOUT[13],clk);
	MUX2x1_DFF level3_dataOUT12(level2_dataOUT[12],level2_dataOUT[16],level2_amountOUT[2],level3_dataOUT[12],clk);
	MUX2x1_DFF level3_dataOUT11(level2_dataOUT[11],level2_dataOUT[15],level2_amountOUT[2],level3_dataOUT[11],clk);
	MUX2x1_DFF level3_dataOUT10(level2_dataOUT[10],level2_dataOUT[14],level2_amountOUT[2],level3_dataOUT[10],clk);
	MUX2x1_DFF level3_dataOUT9(level2_dataOUT[9],level2_dataOUT[13],level2_amountOUT[2],level3_dataOUT[9],clk);
	MUX2x1_DFF level3_dataOUT8(level2_dataOUT[8],level2_dataOUT[12],level2_amountOUT[2],level3_dataOUT[8],clk);
	MUX2x1_DFF level3_dataOUT7(level2_dataOUT[7],level2_dataOUT[11],level2_amountOUT[2],level3_dataOUT[7],clk);
	MUX2x1_DFF level3_dataOUT6(level2_dataOUT[6],level2_dataOUT[10],level2_amountOUT[2],level3_dataOUT[6],clk);
	MUX2x1_DFF level3_dataOUT5(level2_dataOUT[5],level2_dataOUT[9],level2_amountOUT[2],level3_dataOUT[5],clk);
	MUX2x1_DFF level3_dataOUT4(level2_dataOUT[4],level2_dataOUT[8],level2_amountOUT[2],level3_dataOUT[4],clk);
	MUX2x1_DFF level3_dataOUT3(level2_dataOUT[3],level2_dataOUT[7],level2_amountOUT[2],level3_dataOUT[3],clk);
	MUX2x1_DFF level3_dataOUT2(level2_dataOUT[2],level2_dataOUT[6],level2_amountOUT[2],level3_dataOUT[2],clk);
	MUX2x1_DFF level3_dataOUT1(level2_dataOUT[1],level2_dataOUT[5],level2_amountOUT[2],level3_dataOUT[1],clk);
	MUX2x1_DFF level3_dataOUT0(level2_dataOUT[0],level2_dataOUT[4],level2_amountOUT[2],level3_dataOUT[0],clk);

	//propogating LEFT, ROTATE and ARITHMETIC INPUTS
	wire level3_leftOUT,level3_rotateOUT,level3_arithOUT;
	DFlipFlop level3_left(level2_leftOUT,clk,level3_leftOUT);
	DFlipFlop level3_rotate(level2_rotateOUT,clk,level3_rotateOUT);
	DFlipFlop level3_arith(level2_arithOUT,clk,level3_arithOUT);

	//propogating amount to shift
	wire[4:0] level3_amountOUT;
	DFlipFlop5 level3_AMOUNTFF(level2_amountOUT,clk,level3_amountOUT);

	//propogating sOut for LEFT SHIFT
	wire level3_sLeftOUT;
	DFlipFlop level3_sLeftOUTFF(level2_sLeftOUT,clk,level3_sLeftOUT);

	//propogating sOut for RIGHT shift
	wire level3_sOUT;
	DFlipFlop level3_sOutFF(level2_sOUT,clk,level3_sOUT);
	//END OF STAGE 3


	//STAGE 4 : SHIFT/ROTATE BY 2 bit
	wire[1:0] level4_rotated2OUT;
	//module MUX2x1(data0,data1,select,out);
	MUX2x1 STAGE4_ROTATE_31(level3_sOUT,level3_dataOUT[1],level3_rotateOUT,level4_rotated2OUT[1]);
	MUX2x1 STAGE4_ROTATE_30(level3_sOUT,level3_dataOUT[0],level3_rotateOUT,level4_rotated2OUT[0]);

	wire[31:0] level4_dataOUT;
  //MUX2x1_DFF level3_dataOUT31(level2_dataOUT[31],level3_rotated4OUT[3],level2_amountOUT[2],level3_dataOUT[31],clk);
  	MUX2x1_DFF level4_dataOUT31(level3_dataOUT[31],level4_rotated2OUT[1],level3_amountOUT[1],level4_dataOUT[31],clk);
  	MUX2x1_DFF level4_dataOUT30(level3_dataOUT[30],level4_rotated2OUT[0],level3_amountOUT[1],level4_dataOUT[30],clk);


  //MUX2x1_DFF level4_dataOUT29(level3_dataOUT[29],level3_dataOUT[31],level3_amountOUT[1],level4_dataOUT[29],clk);
	MUX2x1_DFF level4_dataOUT29(level3_dataOUT[29],level3_dataOUT[31],level3_amountOUT[1],level4_dataOUT[29],clk);
	MUX2x1_DFF level4_dataOUT28(level3_dataOUT[28],level3_dataOUT[30],level3_amountOUT[1],level4_dataOUT[28],clk);
	MUX2x1_DFF level4_dataOUT27(level3_dataOUT[27],level3_dataOUT[29],level3_amountOUT[1],level4_dataOUT[27],clk);
	MUX2x1_DFF level4_dataOUT26(level3_dataOUT[26],level3_dataOUT[28],level3_amountOUT[1],level4_dataOUT[26],clk);
	MUX2x1_DFF level4_dataOUT25(level3_dataOUT[25],level3_dataOUT[27],level3_amountOUT[1],level4_dataOUT[25],clk);
	MUX2x1_DFF level4_dataOUT24(level3_dataOUT[24],level3_dataOUT[26],level3_amountOUT[1],level4_dataOUT[24],clk);
	MUX2x1_DFF level4_dataOUT23(level3_dataOUT[23],level3_dataOUT[25],level3_amountOUT[1],level4_dataOUT[23],clk);
	MUX2x1_DFF level4_dataOUT22(level3_dataOUT[22],level3_dataOUT[24],level3_amountOUT[1],level4_dataOUT[22],clk);
	MUX2x1_DFF level4_dataOUT21(level3_dataOUT[21],level3_dataOUT[23],level3_amountOUT[1],level4_dataOUT[21],clk);
	MUX2x1_DFF level4_dataOUT20(level3_dataOUT[20],level3_dataOUT[22],level3_amountOUT[1],level4_dataOUT[20],clk);
	MUX2x1_DFF level4_dataOUT19(level3_dataOUT[19],level3_dataOUT[21],level3_amountOUT[1],level4_dataOUT[19],clk);
	MUX2x1_DFF level4_dataOUT18(level3_dataOUT[18],level3_dataOUT[20],level3_amountOUT[1],level4_dataOUT[18],clk);
	MUX2x1_DFF level4_dataOUT17(level3_dataOUT[17],level3_dataOUT[19],level3_amountOUT[1],level4_dataOUT[17],clk);
	MUX2x1_DFF level4_dataOUT16(level3_dataOUT[16],level3_dataOUT[18],level3_amountOUT[1],level4_dataOUT[16],clk);
	MUX2x1_DFF level4_dataOUT15(level3_dataOUT[15],level3_dataOUT[17],level3_amountOUT[1],level4_dataOUT[15],clk);
	MUX2x1_DFF level4_dataOUT14(level3_dataOUT[14],level3_dataOUT[16],level3_amountOUT[1],level4_dataOUT[14],clk);
	MUX2x1_DFF level4_dataOUT13(level3_dataOUT[13],level3_dataOUT[15],level3_amountOUT[1],level4_dataOUT[13],clk);
	MUX2x1_DFF level4_dataOUT12(level3_dataOUT[12],level3_dataOUT[14],level3_amountOUT[1],level4_dataOUT[12],clk);
	MUX2x1_DFF level4_dataOUT11(level3_dataOUT[11],level3_dataOUT[13],level3_amountOUT[1],level4_dataOUT[11],clk);
	MUX2x1_DFF level4_dataOUT10(level3_dataOUT[10],level3_dataOUT[12],level3_amountOUT[1],level4_dataOUT[10],clk);
	MUX2x1_DFF level4_dataOUT9(level3_dataOUT[9],level3_dataOUT[11],level3_amountOUT[1],level4_dataOUT[9],clk);
	MUX2x1_DFF level4_dataOUT8(level3_dataOUT[8],level3_dataOUT[10],level3_amountOUT[1],level4_dataOUT[8],clk);
	MUX2x1_DFF level4_dataOUT7(level3_dataOUT[7],level3_dataOUT[9],level3_amountOUT[1],level4_dataOUT[7],clk);
	MUX2x1_DFF level4_dataOUT6(level3_dataOUT[6],level3_dataOUT[8],level3_amountOUT[1],level4_dataOUT[6],clk);
	MUX2x1_DFF level4_dataOUT5(level3_dataOUT[5],level3_dataOUT[7],level3_amountOUT[1],level4_dataOUT[5],clk);
	MUX2x1_DFF level4_dataOUT4(level3_dataOUT[4],level3_dataOUT[6],level3_amountOUT[1],level4_dataOUT[4],clk);
	MUX2x1_DFF level4_dataOUT3(level3_dataOUT[3],level3_dataOUT[5],level3_amountOUT[1],level4_dataOUT[3],clk);
	MUX2x1_DFF level4_dataOUT2(level3_dataOUT[2],level3_dataOUT[4],level3_amountOUT[1],level4_dataOUT[2],clk);
	MUX2x1_DFF level4_dataOUT1(level3_dataOUT[1],level3_dataOUT[3],level3_amountOUT[1],level4_dataOUT[1],clk);
	MUX2x1_DFF level4_dataOUT0(level3_dataOUT[0],level3_dataOUT[2],level3_amountOUT[1],level4_dataOUT[0],clk);

	//propogating LEFT, ROTATE and ARITHMETIC INPUTS
	wire level4_leftOUT,level4_rotateOUT,level4_arithOUT;
	DFlipFlop level4_left(level3_leftOUT,clk,level4_leftOUT);
	DFlipFlop level4_rotate(level3_rotateOUT,clk,level4_rotateOUT);
	DFlipFlop level4_arith(level3_arithOUT,clk,level4_arithOUT);

	//propogating amount to shift
	wire[4:0] level4_amountOUT;
	DFlipFlop5 level4_AMOUNTFF(level3_amountOUT,clk,level4_amountOUT);

	//propogating sOut for LEFT SHIFT
	wire level4_sLeftOUT;
	DFlipFlop level4_sLeftOUTFF(level3_sLeftOUT,clk,level4_sLeftOUT);

	//propogating sOut for RIGHT shift
	wire level4_sOUT;
	DFlipFlop level4_sOutFF(level3_sOUT,clk,level4_sOUT);
	//END OF STAGE 4

	//STAGE 5 : SHIFT/ROTATE BY 1 bit
	wire sla;
	assign sla = ~level4_rotateOUT & level4_leftOUT & level4_arithOUT;

	wire level5_rotated1OUT;
	//module MUX2x1(data0,data1,select,out);
	MUX2x1 STAGE5_ROTATE_31(level4_sOUT,level4_dataOUT[0],level4_rotateOUT,level5_rotated1OUT);

	wire[31:0] level5_dataOUT;
	wire level5_dataOUT_L0;
  //MUX2x1_DFF level4_dataOUT31(level3_dataOUT[31],level4_rotated2OUT[1],level3_amountOUT[1],level4_dataOUT[31],clk);
  	MUX2x1_DFF level5_dataOUT31(level4_dataOUT[31],level5_rotated1OUT,level4_amountOUT[0],level5_dataOUT[31],clk);
  
  //MUX2x1_DFF level5_dataOUT30(level4_dataOUT[30],level4_dataOUT[31],level4_amountOUT[0],level5_dataOUT[30],clk);
	MUX2x1_DFF level5_dataOUT30(level4_dataOUT[30],level4_dataOUT[31],level4_amountOUT[0],level5_dataOUT[30],clk);
	MUX2x1_DFF level5_dataOUT29(level4_dataOUT[29],level4_dataOUT[30],level4_amountOUT[0],level5_dataOUT[29],clk);
	MUX2x1_DFF level5_dataOUT28(level4_dataOUT[28],level4_dataOUT[29],level4_amountOUT[0],level5_dataOUT[28],clk);
	MUX2x1_DFF level5_dataOUT27(level4_dataOUT[27],level4_dataOUT[28],level4_amountOUT[0],level5_dataOUT[27],clk);
	MUX2x1_DFF level5_dataOUT26(level4_dataOUT[26],level4_dataOUT[27],level4_amountOUT[0],level5_dataOUT[26],clk);
	MUX2x1_DFF level5_dataOUT25(level4_dataOUT[25],level4_dataOUT[26],level4_amountOUT[0],level5_dataOUT[25],clk);
	MUX2x1_DFF level5_dataOUT24(level4_dataOUT[24],level4_dataOUT[25],level4_amountOUT[0],level5_dataOUT[24],clk);
	MUX2x1_DFF level5_dataOUT23(level4_dataOUT[23],level4_dataOUT[24],level4_amountOUT[0],level5_dataOUT[23],clk);
	MUX2x1_DFF level5_dataOUT22(level4_dataOUT[22],level4_dataOUT[23],level4_amountOUT[0],level5_dataOUT[22],clk);
	MUX2x1_DFF level5_dataOUT21(level4_dataOUT[21],level4_dataOUT[22],level4_amountOUT[0],level5_dataOUT[21],clk);
	MUX2x1_DFF level5_dataOUT20(level4_dataOUT[20],level4_dataOUT[21],level4_amountOUT[0],level5_dataOUT[20],clk);
	MUX2x1_DFF level5_dataOUT19(level4_dataOUT[19],level4_dataOUT[20],level4_amountOUT[0],level5_dataOUT[19],clk);
	MUX2x1_DFF level5_dataOUT18(level4_dataOUT[18],level4_dataOUT[19],level4_amountOUT[0],level5_dataOUT[18],clk);
	MUX2x1_DFF level5_dataOUT17(level4_dataOUT[17],level4_dataOUT[18],level4_amountOUT[0],level5_dataOUT[17],clk);
	MUX2x1_DFF level5_dataOUT16(level4_dataOUT[16],level4_dataOUT[17],level4_amountOUT[0],level5_dataOUT[16],clk);
	MUX2x1_DFF level5_dataOUT15(level4_dataOUT[15],level4_dataOUT[16],level4_amountOUT[0],level5_dataOUT[15],clk);
	MUX2x1_DFF level5_dataOUT14(level4_dataOUT[14],level4_dataOUT[15],level4_amountOUT[0],level5_dataOUT[14],clk);
	MUX2x1_DFF level5_dataOUT13(level4_dataOUT[13],level4_dataOUT[14],level4_amountOUT[0],level5_dataOUT[13],clk);
	MUX2x1_DFF level5_dataOUT12(level4_dataOUT[12],level4_dataOUT[13],level4_amountOUT[0],level5_dataOUT[12],clk);
	MUX2x1_DFF level5_dataOUT11(level4_dataOUT[11],level4_dataOUT[12],level4_amountOUT[0],level5_dataOUT[11],clk);
	MUX2x1_DFF level5_dataOUT10(level4_dataOUT[10],level4_dataOUT[11],level4_amountOUT[0],level5_dataOUT[10],clk);
	MUX2x1_DFF level5_dataOUT9(level4_dataOUT[9],level4_dataOUT[10],level4_amountOUT[0],level5_dataOUT[9],clk);
	MUX2x1_DFF level5_dataOUT8(level4_dataOUT[8],level4_dataOUT[9],level4_amountOUT[0],level5_dataOUT[8],clk);
	MUX2x1_DFF level5_dataOUT7(level4_dataOUT[7],level4_dataOUT[8],level4_amountOUT[0],level5_dataOUT[7],clk);
	MUX2x1_DFF level5_dataOUT6(level4_dataOUT[6],level4_dataOUT[7],level4_amountOUT[0],level5_dataOUT[6],clk);
	MUX2x1_DFF level5_dataOUT5(level4_dataOUT[5],level4_dataOUT[6],level4_amountOUT[0],level5_dataOUT[5],clk);
	MUX2x1_DFF level5_dataOUT4(level4_dataOUT[4],level4_dataOUT[5],level4_amountOUT[0],level5_dataOUT[4],clk);
	MUX2x1_DFF level5_dataOUT3(level4_dataOUT[3],level4_dataOUT[4],level4_amountOUT[0],level5_dataOUT[3],clk);
	MUX2x1_DFF level5_dataOUT2(level4_dataOUT[2],level4_dataOUT[3],level4_amountOUT[0],level5_dataOUT[2],clk);
	MUX2x1_DFF level5_dataOUT1(level4_dataOUT[1],level4_dataOUT[2],level4_amountOUT[0],level5_dataOUT[1],clk);

	MUX2x1 level5_dataOUTL0_FF(level4_dataOUT[0],level4_dataOUT[1],level4_amountOUT[0],level5_dataOUT_L0);

	MUX2x1_DFF level5_dataOUT0(level5_dataOUT_L0,level4_sLeftOUT,sla,level5_dataOUT[0],clk);


	//propogating LEFT INPUT
	wire level5_leftOUT;
	DFlipFlop level5_left(level4_leftOUT,clk,level5_leftOUT);

	//END OF STAGE 5

	//STAGE : REVERTING BACK REVERSED BITS
	wire[31:0] level_RE_REVERSEOUT;
	//MUX2x1 level_RE_REVERSE31(level5_dataOUT[31],level5_dataOUT[0],level5_leftOUT,level_RE_REVERSEOUT[31]);

	MUX2x1 level_RE_REVERSE31(level5_dataOUT[31],level5_dataOUT[0],level5_leftOUT,level_RE_REVERSEOUT[31]);
	MUX2x1 level_RE_REVERSE30(level5_dataOUT[30],level5_dataOUT[1],level5_leftOUT,level_RE_REVERSEOUT[30]);
	MUX2x1 level_RE_REVERSE29(level5_dataOUT[29],level5_dataOUT[2],level5_leftOUT,level_RE_REVERSEOUT[29]);
	MUX2x1 level_RE_REVERSE28(level5_dataOUT[28],level5_dataOUT[3],level5_leftOUT,level_RE_REVERSEOUT[28]);
	MUX2x1 level_RE_REVERSE27(level5_dataOUT[27],level5_dataOUT[4],level5_leftOUT,level_RE_REVERSEOUT[27]);
	MUX2x1 level_RE_REVERSE26(level5_dataOUT[26],level5_dataOUT[5],level5_leftOUT,level_RE_REVERSEOUT[26]);
	MUX2x1 level_RE_REVERSE25(level5_dataOUT[25],level5_dataOUT[6],level5_leftOUT,level_RE_REVERSEOUT[25]);
	MUX2x1 level_RE_REVERSE24(level5_dataOUT[24],level5_dataOUT[7],level5_leftOUT,level_RE_REVERSEOUT[24]);
	MUX2x1 level_RE_REVERSE23(level5_dataOUT[23],level5_dataOUT[8],level5_leftOUT,level_RE_REVERSEOUT[23]);
	MUX2x1 level_RE_REVERSE22(level5_dataOUT[22],level5_dataOUT[9],level5_leftOUT,level_RE_REVERSEOUT[22]);
	MUX2x1 level_RE_REVERSE21(level5_dataOUT[21],level5_dataOUT[10],level5_leftOUT,level_RE_REVERSEOUT[21]);
	MUX2x1 level_RE_REVERSE20(level5_dataOUT[20],level5_dataOUT[11],level5_leftOUT,level_RE_REVERSEOUT[20]);
	MUX2x1 level_RE_REVERSE19(level5_dataOUT[19],level5_dataOUT[12],level5_leftOUT,level_RE_REVERSEOUT[19]);
	MUX2x1 level_RE_REVERSE18(level5_dataOUT[18],level5_dataOUT[13],level5_leftOUT,level_RE_REVERSEOUT[18]);
	MUX2x1 level_RE_REVERSE17(level5_dataOUT[17],level5_dataOUT[14],level5_leftOUT,level_RE_REVERSEOUT[17]);
	MUX2x1 level_RE_REVERSE16(level5_dataOUT[16],level5_dataOUT[15],level5_leftOUT,level_RE_REVERSEOUT[16]);
	MUX2x1 level_RE_REVERSE15(level5_dataOUT[15],level5_dataOUT[16],level5_leftOUT,level_RE_REVERSEOUT[15]);
	MUX2x1 level_RE_REVERSE14(level5_dataOUT[14],level5_dataOUT[17],level5_leftOUT,level_RE_REVERSEOUT[14]);
	MUX2x1 level_RE_REVERSE13(level5_dataOUT[13],level5_dataOUT[18],level5_leftOUT,level_RE_REVERSEOUT[13]);
	MUX2x1 level_RE_REVERSE12(level5_dataOUT[12],level5_dataOUT[19],level5_leftOUT,level_RE_REVERSEOUT[12]);
	MUX2x1 level_RE_REVERSE11(level5_dataOUT[11],level5_dataOUT[20],level5_leftOUT,level_RE_REVERSEOUT[11]);
	MUX2x1 level_RE_REVERSE10(level5_dataOUT[10],level5_dataOUT[21],level5_leftOUT,level_RE_REVERSEOUT[10]);
	MUX2x1 level_RE_REVERSE9(level5_dataOUT[9],level5_dataOUT[22],level5_leftOUT,level_RE_REVERSEOUT[9]);
	MUX2x1 level_RE_REVERSE8(level5_dataOUT[8],level5_dataOUT[23],level5_leftOUT,level_RE_REVERSEOUT[8]);
	MUX2x1 level_RE_REVERSE7(level5_dataOUT[7],level5_dataOUT[24],level5_leftOUT,level_RE_REVERSEOUT[7]);
	MUX2x1 level_RE_REVERSE6(level5_dataOUT[6],level5_dataOUT[25],level5_leftOUT,level_RE_REVERSEOUT[6]);
	MUX2x1 level_RE_REVERSE5(level5_dataOUT[5],level5_dataOUT[26],level5_leftOUT,level_RE_REVERSEOUT[5]);
	MUX2x1 level_RE_REVERSE4(level5_dataOUT[4],level5_dataOUT[27],level5_leftOUT,level_RE_REVERSEOUT[4]);
	MUX2x1 level_RE_REVERSE3(level5_dataOUT[3],level5_dataOUT[28],level5_leftOUT,level_RE_REVERSEOUT[3]);
	MUX2x1 level_RE_REVERSE2(level5_dataOUT[2],level5_dataOUT[29],level5_leftOUT,level_RE_REVERSEOUT[2]);
	MUX2x1 level_RE_REVERSE1(level5_dataOUT[1],level5_dataOUT[30],level5_leftOUT,level_RE_REVERSEOUT[1]);
	MUX2x1 level_RE_REVERSE0(level5_dataOUT[0],level5_dataOUT[31],level5_leftOUT,level_RE_REVERSEOUT[0]);
	//END OF RE-REVERSAL STAGE

	assign OUT = level_RE_REVERSEOUT;


endmodule // barrelShifter

`endif