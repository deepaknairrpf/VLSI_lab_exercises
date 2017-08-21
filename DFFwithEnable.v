//header guards
`ifndef _DFFenable_vh_
`define _DFFenable_vh_

`include "D-FlipFlop.v"
`include "MUX2.v"

module DFFwithEnable(dataIN,clk,dataOUT,load);
	input dataIN,clk,load;
	output dataOUT;

	wire DFF_OUT,MUX_OUT;

	//MUX2x1(data0,data1,select,out);
	MUX2x1 MUX(DFF_OUT,dataIN,load,MUX_OUT);

	//DFlipFlop(data,clk,q);
	DFlipFlop DFF(MUX_OUT,clk,DFF_OUT);

	assign dataOUT=DFF_OUT;

endmodule // DFFwithEnable

//D-FlipFlop 32-bit Array with load
module DFF32bitEnable(DATAIN,clk,DATAOUT,load);

	input[31:0] DATAIN;
	input clk,load;

	output[31:0] DATAOUT;

  //DFFwithEnable DFF0(DATAIN[0],clk,DATAOUT[0],load);
	DFFwithEnable DFF0(DATAIN[0],clk,DATAOUT[0],load);
	DFFwithEnable DFF1(DATAIN[1],clk,DATAOUT[1],load);
	DFFwithEnable DFF2(DATAIN[2],clk,DATAOUT[2],load);
	DFFwithEnable DFF3(DATAIN[3],clk,DATAOUT[3],load);
	DFFwithEnable DFF4(DATAIN[4],clk,DATAOUT[4],load);
	DFFwithEnable DFF5(DATAIN[5],clk,DATAOUT[5],load);
	DFFwithEnable DFF6(DATAIN[6],clk,DATAOUT[6],load);
	DFFwithEnable DFF7(DATAIN[7],clk,DATAOUT[7],load);
	DFFwithEnable DFF8(DATAIN[8],clk,DATAOUT[8],load);
	DFFwithEnable DFF9(DATAIN[9],clk,DATAOUT[9],load);
	DFFwithEnable DFF10(DATAIN[10],clk,DATAOUT[10],load);
	DFFwithEnable DFF11(DATAIN[11],clk,DATAOUT[11],load);
	DFFwithEnable DFF12(DATAIN[12],clk,DATAOUT[12],load);
	DFFwithEnable DFF13(DATAIN[13],clk,DATAOUT[13],load);
	DFFwithEnable DFF14(DATAIN[14],clk,DATAOUT[14],load);
	DFFwithEnable DFF15(DATAIN[15],clk,DATAOUT[15],load);
	DFFwithEnable DFF16(DATAIN[16],clk,DATAOUT[16],load);
	DFFwithEnable DFF17(DATAIN[17],clk,DATAOUT[17],load);
	DFFwithEnable DFF18(DATAIN[18],clk,DATAOUT[18],load);
	DFFwithEnable DFF19(DATAIN[19],clk,DATAOUT[19],load);
	DFFwithEnable DFF20(DATAIN[20],clk,DATAOUT[20],load);
	DFFwithEnable DFF21(DATAIN[21],clk,DATAOUT[21],load);
	DFFwithEnable DFF22(DATAIN[22],clk,DATAOUT[22],load);
	DFFwithEnable DFF23(DATAIN[23],clk,DATAOUT[23],load);
	DFFwithEnable DFF24(DATAIN[24],clk,DATAOUT[24],load);
	DFFwithEnable DFF25(DATAIN[25],clk,DATAOUT[25],load);
	DFFwithEnable DFF26(DATAIN[26],clk,DATAOUT[26],load);
	DFFwithEnable DFF27(DATAIN[27],clk,DATAOUT[27],load);
	DFFwithEnable DFF28(DATAIN[28],clk,DATAOUT[28],load);
	DFFwithEnable DFF29(DATAIN[29],clk,DATAOUT[29],load);
	DFFwithEnable DFF30(DATAIN[30],clk,DATAOUT[30],load);
	DFFwithEnable DFF31(DATAIN[31],clk,DATAOUT[31],load);
endmodule //DFF32bitEnable

//D-FlipFlop 22-bit Array with load
module DFF22bitEnable(DATAIN,clk,DATAOUT,load);

	input[21:0] DATAIN;
	input clk,load;

	output[21:0] DATAOUT;

  //DFFwithEnable DFF0(DATAIN[0],clk,DATAOUT[0],load);
	DFFwithEnable DFF0(DATAIN[0],clk,DATAOUT[0],load);
	DFFwithEnable DFF1(DATAIN[1],clk,DATAOUT[1],load);
	DFFwithEnable DFF2(DATAIN[2],clk,DATAOUT[2],load);
	DFFwithEnable DFF3(DATAIN[3],clk,DATAOUT[3],load);
	DFFwithEnable DFF4(DATAIN[4],clk,DATAOUT[4],load);
	DFFwithEnable DFF5(DATAIN[5],clk,DATAOUT[5],load);
	DFFwithEnable DFF6(DATAIN[6],clk,DATAOUT[6],load);
	DFFwithEnable DFF7(DATAIN[7],clk,DATAOUT[7],load);
	DFFwithEnable DFF8(DATAIN[8],clk,DATAOUT[8],load);
	DFFwithEnable DFF9(DATAIN[9],clk,DATAOUT[9],load);
	DFFwithEnable DFF10(DATAIN[10],clk,DATAOUT[10],load);
	DFFwithEnable DFF11(DATAIN[11],clk,DATAOUT[11],load);
	DFFwithEnable DFF12(DATAIN[12],clk,DATAOUT[12],load);
	DFFwithEnable DFF13(DATAIN[13],clk,DATAOUT[13],load);
	DFFwithEnable DFF14(DATAIN[14],clk,DATAOUT[14],load);
	DFFwithEnable DFF15(DATAIN[15],clk,DATAOUT[15],load);
	DFFwithEnable DFF16(DATAIN[16],clk,DATAOUT[16],load);
	DFFwithEnable DFF17(DATAIN[17],clk,DATAOUT[17],load);
	DFFwithEnable DFF18(DATAIN[18],clk,DATAOUT[18],load);
	DFFwithEnable DFF19(DATAIN[19],clk,DATAOUT[19],load);
	DFFwithEnable DFF20(DATAIN[20],clk,DATAOUT[20],load);
	DFFwithEnable DFF21(DATAIN[21],clk,DATAOUT[21],load);
	
endmodule //DFF22bitEnable

`endif