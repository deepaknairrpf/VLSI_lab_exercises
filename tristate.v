//header guards
`ifndef _tristate_vh_
`define _tristate_vh_

module tristateBuffer (in,enable,out);

	input in,enable;
	output out;

	assign out = enable ? in : 1'bz;
endmodule

module tristate32bit (DATAIN,enable,DATAOUT);

	input[31:0] DATAIN;
	input enable;

	output[31:0] DATAOUT;

  //tristateBuffer TSB0(DATAIN[0],enable,DATAOUT[0]);
	tristateBuffer TSB0(DATAIN[0],enable,DATAOUT[0]);
	tristateBuffer TSB1(DATAIN[1],enable,DATAOUT[1]);
	tristateBuffer TSB2(DATAIN[2],enable,DATAOUT[2]);
	tristateBuffer TSB3(DATAIN[3],enable,DATAOUT[3]);
	tristateBuffer TSB4(DATAIN[4],enable,DATAOUT[4]);
	tristateBuffer TSB5(DATAIN[5],enable,DATAOUT[5]);
	tristateBuffer TSB6(DATAIN[6],enable,DATAOUT[6]);
	tristateBuffer TSB7(DATAIN[7],enable,DATAOUT[7]);
	tristateBuffer TSB8(DATAIN[8],enable,DATAOUT[8]);
	tristateBuffer TSB9(DATAIN[9],enable,DATAOUT[9]);
	tristateBuffer TSB10(DATAIN[10],enable,DATAOUT[10]);
	tristateBuffer TSB11(DATAIN[11],enable,DATAOUT[11]);
	tristateBuffer TSB12(DATAIN[12],enable,DATAOUT[12]);
	tristateBuffer TSB13(DATAIN[13],enable,DATAOUT[13]);
	tristateBuffer TSB14(DATAIN[14],enable,DATAOUT[14]);
	tristateBuffer TSB15(DATAIN[15],enable,DATAOUT[15]);
	tristateBuffer TSB16(DATAIN[16],enable,DATAOUT[16]);
	tristateBuffer TSB17(DATAIN[17],enable,DATAOUT[17]);
	tristateBuffer TSB18(DATAIN[18],enable,DATAOUT[18]);
	tristateBuffer TSB19(DATAIN[19],enable,DATAOUT[19]);
	tristateBuffer TSB20(DATAIN[20],enable,DATAOUT[20]);
	tristateBuffer TSB21(DATAIN[21],enable,DATAOUT[21]);
	tristateBuffer TSB22(DATAIN[22],enable,DATAOUT[22]);
	tristateBuffer TSB23(DATAIN[23],enable,DATAOUT[23]);
	tristateBuffer TSB24(DATAIN[24],enable,DATAOUT[24]);
	tristateBuffer TSB25(DATAIN[25],enable,DATAOUT[25]);
	tristateBuffer TSB26(DATAIN[26],enable,DATAOUT[26]);
	tristateBuffer TSB27(DATAIN[27],enable,DATAOUT[27]);
	tristateBuffer TSB28(DATAIN[28],enable,DATAOUT[28]);
	tristateBuffer TSB29(DATAIN[29],enable,DATAOUT[29]);
	tristateBuffer TSB30(DATAIN[30],enable,DATAOUT[30]);
	tristateBuffer TSB31(DATAIN[31],enable,DATAOUT[31]);

endmodule // tristate32bit


module tristate22bit (DATAIN,enable,DATAOUT);

	input[21:0] DATAIN;
	input enable;

	output[21:0] DATAOUT;

  //tristateBuffer TSB0(DATAIN[0],enable,DATAOUT[0]);
	tristateBuffer TSB0(DATAIN[0],enable,DATAOUT[0]);
	tristateBuffer TSB1(DATAIN[1],enable,DATAOUT[1]);
	tristateBuffer TSB2(DATAIN[2],enable,DATAOUT[2]);
	tristateBuffer TSB3(DATAIN[3],enable,DATAOUT[3]);
	tristateBuffer TSB4(DATAIN[4],enable,DATAOUT[4]);
	tristateBuffer TSB5(DATAIN[5],enable,DATAOUT[5]);
	tristateBuffer TSB6(DATAIN[6],enable,DATAOUT[6]);
	tristateBuffer TSB7(DATAIN[7],enable,DATAOUT[7]);
	tristateBuffer TSB8(DATAIN[8],enable,DATAOUT[8]);
	tristateBuffer TSB9(DATAIN[9],enable,DATAOUT[9]);
	tristateBuffer TSB10(DATAIN[10],enable,DATAOUT[10]);
	tristateBuffer TSB11(DATAIN[11],enable,DATAOUT[11]);
	tristateBuffer TSB12(DATAIN[12],enable,DATAOUT[12]);
	tristateBuffer TSB13(DATAIN[13],enable,DATAOUT[13]);
	tristateBuffer TSB14(DATAIN[14],enable,DATAOUT[14]);
	tristateBuffer TSB15(DATAIN[15],enable,DATAOUT[15]);
	tristateBuffer TSB16(DATAIN[16],enable,DATAOUT[16]);
	tristateBuffer TSB17(DATAIN[17],enable,DATAOUT[17]);
	tristateBuffer TSB18(DATAIN[18],enable,DATAOUT[18]);
	tristateBuffer TSB19(DATAIN[19],enable,DATAOUT[19]);
	tristateBuffer TSB20(DATAIN[20],enable,DATAOUT[20]);
	tristateBuffer TSB21(DATAIN[21],enable,DATAOUT[21]);

endmodule // tristate22bit

`endif