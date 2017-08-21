//header guards
`ifndef _decoders_vh_
`define _decoders_vh_

module decoder1x2(enable,in,OUT);

	input enable,in;
	output[1:0] OUT;

	assign OUT[0]=enable&(~in);
	assign OUT[1]=enable&in;

endmodule // decoder1x2

module decoder2x4(enable,IN,OUT);

	input enable;
	input[1:0] IN;
	output[3:0] OUT;

	wire[1:0] layer1_OUT;
	decoder1x2 layer1_0(enable,IN[1],layer1_OUT);

	decoder1x2 layer2_0(layer1_OUT[0],IN[0],OUT[1:0]);
	decoder1x2 layer2_1(layer1_OUT[1],IN[0],OUT[3:2]);

endmodule // decoder2x4

//takes 4 gate stages
module decoder4x16(enable,IN,OUT);

	input enable;
	input[3:0] IN;
	output[15:0] OUT;

	wire[3:0] layer1_OUT;
	decoder2x4 layer1_0(enable,IN[3:2],layer1_OUT);

	decoder2x4 layer2_0(layer1_OUT[0],IN[1:0],OUT[3:0]);
	decoder2x4 layer2_1(layer1_OUT[1],IN[1:0],OUT[7:4]);
	decoder2x4 layer2_2(layer1_OUT[2],IN[1:0],OUT[11:8]);
	decoder2x4 layer2_3(layer1_OUT[3],IN[1:0],OUT[15:12]);

endmodule // decoder4x16


//takes 8 gate stages : May or may not be piplelined
module decoder8x256(enable,IN,OUT);

	input enable;
	input[7:0] IN;
	output[255:0] OUT;

	wire[15:0] layer1_OUT;

	decoder4x16 layer1_0(enable,IN[7:4],layer1_OUT);

  //decoder4x16 layer2_0(layer1_OUT[0],IN[3:0],OUT[0]);
	decoder4x16 layer2_0(layer1_OUT[0],IN[3:0],OUT[15:0]);
	decoder4x16 layer2_1(layer1_OUT[1],IN[3:0],OUT[31:16]);
	decoder4x16 layer2_2(layer1_OUT[2],IN[3:0],OUT[47:32]);
	decoder4x16 layer2_3(layer1_OUT[3],IN[3:0],OUT[63:48]);
	decoder4x16 layer2_4(layer1_OUT[4],IN[3:0],OUT[79:64]);
	decoder4x16 layer2_5(layer1_OUT[5],IN[3:0],OUT[95:80]);
	decoder4x16 layer2_6(layer1_OUT[6],IN[3:0],OUT[111:96]);
	decoder4x16 layer2_7(layer1_OUT[7],IN[3:0],OUT[127:112]);
	decoder4x16 layer2_8(layer1_OUT[8],IN[3:0],OUT[143:128]);
	decoder4x16 layer2_9(layer1_OUT[9],IN[3:0],OUT[159:144]);
	decoder4x16 layer2_10(layer1_OUT[10],IN[3:0],OUT[175:160]);
	decoder4x16 layer2_11(layer1_OUT[11],IN[3:0],OUT[191:176]);
	decoder4x16 layer2_12(layer1_OUT[12],IN[3:0],OUT[207:192]);
	decoder4x16 layer2_13(layer1_OUT[13],IN[3:0],OUT[223:208]);
	decoder4x16 layer2_14(layer1_OUT[14],IN[3:0],OUT[239:224]);
	decoder4x16 layer2_15(layer1_OUT[15],IN[3:0],OUT[255:240]);
	
endmodule // decoder8x256

module decoder5x32(enable,IN,OUT);
	
	input[4:0] IN;
	input enable;

	output[31:0] OUT;

	wire[1:0] layer1_OUT;
	decoder1x2 layer1_0(enable,IN[4],layer1_OUT);

	decoder4x16 layer2_0(layer1_OUT[0],IN[3:0],OUT[15:0]);
	decoder4x16 layer2_1(layer1_OUT[1],IN[3:0],OUT[31:16]);
	
endmodule // decoder5x32

`endif