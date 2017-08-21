//header guards
`ifndef _priorityEncoder_vh_
`define _priorityEncoder_vh_

`include "D-FlipFlop.v"

//two clock cycles- input clk 0 ; output clk 2
//output for IN=32'd0 ; OUT=5'd0, input_valid = 0
 
module priorityEncoder32x5
	(
		IN, //inputs
		OUT,input_valid,	//outputs
		clk
	);

	input[31:0] IN;
	input clk;
	output[4:0] OUT;
	output input_valid;

	wire[15:0] level1_out, level1_FFOUT;

	assign level1_out[0] = IN[0] | IN[1];
	assign level1_out[1] = IN[2] | IN[3];
	assign level1_out[2] = IN[4] | IN[5];
	assign level1_out[3] = IN[6] | IN[7];
	assign level1_out[4] = IN[8] | IN[9];
	assign level1_out[5] = IN[10] | IN[11];
	assign level1_out[6] = IN[12] | IN[13];
	assign level1_out[7] = IN[14] | IN[15];
	assign level1_out[8] = IN[16] | IN[17];
	assign level1_out[9] = IN[18] | IN[19];
	assign level1_out[10] = IN[20] | IN[21];
	assign level1_out[11] = IN[22] | IN[23];
	assign level1_out[12] = IN[24] | IN[25];
	assign level1_out[13] = IN[26] | IN[27];
	assign level1_out[14] = IN[28] | IN[29];
	assign level1_out[15] = IN[30] | IN[31];

	wire[7:0] level2_out, level2_FFOUT;

	assign level2_out[0] = level1_out[0] | level1_out[1];
	assign level2_out[1] = level1_out[2] | level1_out[3];
	assign level2_out[2] = level1_out[4] | level1_out[5];
	assign level2_out[3] = level1_out[6] | level1_out[7];
	assign level2_out[4] = level1_out[8] | level1_out[9];
	assign level2_out[5] = level1_out[10] | level1_out[11];
	assign level2_out[6] = level1_out[12] | level1_out[13];
	assign level2_out[7] = level1_out[14] | level1_out[15];

	wire[3:0] level3_out, level3_FFOUT;

	assign level3_out[0] = level2_out[0] | level2_out[1];
	assign level3_out[1] = level2_out[2] | level2_out[3];
	assign level3_out[2] = level2_out[4] | level2_out[5];
	assign level3_out[3] = level2_out[6] | level2_out[7];

	wire[1:0] level4_out, level4_FFOUT;

	assign level4_out[0] = level3_out[0] | level3_out[1];
	assign level4_out[1] = level3_out[2] | level3_out[3];

	//capture all level outputs, original input
	wire[31:0] IN_FFOUT;
	DFlipFlop32 IN_FF(IN,clk,IN_FFOUT);
	DFlipFlop16 level1_FF(level1_out,clk,level1_FFOUT);
	DFlipFlop8 level2_FF(level2_out,clk,level2_FFOUT);
	DFlipFlop4 level3_FF(level3_out,clk,level3_FFOUT);
	DFlipFlop2 level4_FF(level4_out,clk,level4_FFOUT);

	/*Generating output bits -- start */
	assign input_valid = level4_FFOUT[0] | level4_FFOUT[1];
	assign OUT[4] = ~level4_FFOUT[0] & level4_FFOUT[1];
	assign OUT[3] = (~level3_FFOUT[0] & level3_FFOUT[1]) | (~level4_FFOUT[0] & (~level3_FFOUT[2] & level3_FFOUT[3]));
	assign OUT[2] = (~level2_FFOUT[0] & level2_FFOUT[1]) | (~level3_FFOUT[0] & (~level2_FFOUT[2] & level2_FFOUT[3]))
					| (~level4_FFOUT[0] & ((~level2_FFOUT[4] & level2_FFOUT[5]) | (~level3_FFOUT[2] & ~level2_FFOUT[6] & level2_FFOUT[7])));

	assign OUT[1] = ~level1_FFOUT[0]&level1_FFOUT[1] | ~level2_FFOUT[0]&~level1_FFOUT[2]&level1_FFOUT[3] | 
					~level3_FFOUT[0]&(~level1_FFOUT[4]&level1_FFOUT[5] | ~level2_FFOUT[2]&~level1_FFOUT[6]&level1_FFOUT[7]) |
					~level4_FFOUT[0]&(~level1_FFOUT[8]&level1_FFOUT[9] | ~level2_FFOUT[4]&~level1_FFOUT[10]&level1_FFOUT[11] | 
						~level3_FFOUT[2]&(~level1_FFOUT[12]&level1_FFOUT[13] | ~level2_FFOUT[6]&~level1_FFOUT[14]&level1_FFOUT[15]));
	
	assign OUT[0] = ~IN_FFOUT[0]&IN_FFOUT[1] | ~level1_FFOUT[0]&~IN_FFOUT[2]&IN_FFOUT[3] | ~level2_FFOUT[0]&(~IN_FFOUT[4]&IN_FFOUT[5] | ~level1_FFOUT[2]&~IN_FFOUT[6]&IN_FFOUT[7]) |
					~level3_FFOUT[0]&(~IN_FFOUT[8]&IN_FFOUT[9] | ~level1_FFOUT[4]&~IN_FFOUT[10]&IN_FFOUT[11] | ~level2_FFOUT[2]&(~IN_FFOUT[12]&IN_FFOUT[13] | ~level1_FFOUT[6]&~IN_FFOUT[14]&IN_FFOUT[15]))

					| ~level4_FFOUT[0]&(~IN_FFOUT[16]&IN_FFOUT[17] | ~level1_FFOUT[8]&~IN_FFOUT[18]&IN_FFOUT[19] | ~level2_FFOUT[4]&(~IN_FFOUT[20]&IN_FFOUT[21] | ~level1_FFOUT[10]&~IN_FFOUT[22]&IN_FFOUT[23]) | 
						~level3_FFOUT[2]&(~IN_FFOUT[24]&IN_FFOUT[25] | ~level1_FFOUT[12]&~IN_FFOUT[26]&IN_FFOUT[27] | ~level2_FFOUT[6]&(~IN_FFOUT[28])&IN_FFOUT[29] | ~level1_FFOUT[14]&~IN_FFOUT[30]&IN_FFOUT[31])); 
	/*Generating output bits -- end */

endmodule // priorityEncoder

`endif
