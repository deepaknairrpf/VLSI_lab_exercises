//header guards
`ifndef _DFlipFlop_vh_
`define _DFlipFlop_vh_

module DFlipFlop(data,clk,q);

input data,clk;
output reg  q;

always@ (posedge clk)
begin
	q <= data;
end

endmodule // DFlipFlop

module DFlipFlop2(DATA,clk,OUT);

input[1:0] DATA;

input clk;

output[1:0] OUT;
reg[1:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop2


module DFlipFlop2IN(data1,data2,clk,out1,out2);

input data1, data2, clk;
output reg out1, out2;

always @(posedge clk)
begin
	out1 <= data1;
	out2 <= data2;
end


endmodule //DFlipFlop2IN


module DFlipFlop3(DATA,clk,OUT);

input[2:0] DATA;

input clk;

output[2:0] OUT;
reg[2:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop3


module DFlipFlop4(DATA,clk,OUT);

input[3:0] DATA;

input clk;

output[3:0] OUT;
reg[3:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop4


module DFlipFlop4IN(DATA1,DATA2,clk,OUT);

input[1:0] DATA1;
input[1:0] DATA2;

input clk;

output[3:0] OUT;
reg[3:0] OUT;

always @(posedge clk)
begin
	OUT[3:2] <= DATA1;
	OUT[1:0] <= DATA2;
end


endmodule //DFlipFlop4IN

//for use in Barrel Shifter
module DFlipFlop5(DATA,clk,OUT);

input[4:0] DATA;

input clk;

output[4:0] OUT;
reg[4:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop5


module DFlipFlop8IN(DATA1,DATA2,clk,OUT);

input[3:0] DATA1;
input[3:0] DATA2;

input clk;

output[7:0] OUT;
reg[7:0] OUT;

always @(posedge clk)
begin
	OUT[7:4] <= DATA1;
	OUT[3:0] <= DATA2;
end

endmodule //DFlipFlop8IN


module DFlipFlop8(DATA,clk,OUT);

input[7:0] DATA;

input clk;

output[7:0] OUT;
reg[7:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end


endmodule //DFlipFlop8

module DFlipFlop12(DATA,clk,OUT);

input[11:0] DATA;

input clk;

output[11:0] OUT;
reg[11:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end


endmodule //DFlipFlop12

module DFlipFlop14(DATA,clk,OUT);

input[13:0] DATA;

input clk;

output[13:0] OUT;
reg[13:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end


endmodule //DFlipFlop14

module DFlipFlop15(DATA,clk,OUT);

input[14:0] DATA;

input clk;

output[14:0] OUT;
reg[14:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop15


module DFlipFlop16(DATA,clk,OUT);

input[15:0] DATA;

input clk;

output[15:0] OUT;
reg[15:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop16


module DFlipFlop16IN(DATA1,DATA2,clk,OUT);

input[7:0] DATA1;
input[7:0] DATA2;
input clk;

output[15:0] OUT;
reg[15:0] OUT;

always @(posedge clk)
begin
	OUT[15:8] <= DATA1;
	OUT[7:0] <= DATA2;
end


endmodule //DFlipFlop16IN


//D-Flip Flop 23 bit array input
module DFlipFlop23(DATA,clk, OUT);

input [22:0] DATA;
input clk;
output[22:0] OUT;

reg[22:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop23

//D-Flip Flop 24 bit array input
module DFlipFlop24(DATA,clk, OUT);

input [23:0] DATA;
input clk;
output[23:0] OUT;

reg[23:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop24

//D-Flip Flop two 16-bit array input
module DFlipFlop32IN(DATA1,DATA2,clk,OUT);

input [15:0] DATA1;
input [15:0] DATA2;

input clk;

output[31:0] OUT;

reg[31:0] OUT;

always @(posedge clk)
begin
	OUT[31:16] <= DATA1;
	OUT[15:0]  <= DATA2;
end

endmodule //DFlipFlop32


//D-Flip Flop 32 bit array input
module DFlipFlop32(DATA,clk, OUT);

input [31:0] DATA;
input clk;
output[31:0] OUT;

reg[31:0] OUT;

always @(posedge clk)
begin
	OUT <= DATA;
end

endmodule //DFlipFlop32

module DFlipFlop63bit(DATA,clk,OUT);

input[62:0] DATA;
input clk;

output[62:0] OUT;
reg[62:0] OUT;

always@ (posedge clk)
begin
	OUT <= DATA;
end

endmodule // DFlipFlop63bit

module DFlipFlop64(DATA,clk,OUT);

input[63:0] DATA;
input clk;

output[63:0] OUT;
reg[63:0] OUT;

always@ (posedge clk)
begin
	OUT <= DATA;
end

endmodule // DFlipFlop64

//delay 1 bit input by 10 clock cycles : D-FlipFlop Shift Register
module delay10_1bit_DFF(in,clk,out);

	input in,clk;
	output out;
	
	//1st clock cycle
	wire level1_FF_OUT;
	DFlipFlop DFF_layer1(in,clk,level1_FF_OUT);

	//2nd clock cycle
	wire level2_FF_OUT;
	DFlipFlop DFF_layer2(level1_FF_OUT,clk,level2_FF_OUT);

	//3rd clock cycle
	wire level3_FF_OUT;
	DFlipFlop DFF_layer3(level2_FF_OUT,clk,level3_FF_OUT);

	//4th clock cycle
	wire level4_FF_OUT;
	DFlipFlop DFF_layer4(level3_FF_OUT,clk,level4_FF_OUT);

	//5th clock cycle
	wire level5_FF_OUT;
	DFlipFlop DFF_layer5(level4_FF_OUT,clk,level5_FF_OUT);

	//6th clock cycle
	wire level6_FF_OUT;
	DFlipFlop DFF_layer6(level5_FF_OUT,clk,level6_FF_OUT);

	//7th clock cycle
	wire level7_FF_OUT;
	DFlipFlop DFF_layer7(level6_FF_OUT,clk,level7_FF_OUT);

	//8th clock cycle
	wire level8_FF_OUT;
	DFlipFlop DFF_layer8(level7_FF_OUT,clk,level8_FF_OUT);

	//9th clock cycle
	wire level9_FF_OUT;
	DFlipFlop DFF_layer9(level8_FF_OUT,clk,level9_FF_OUT);

	//10th clock cycle
	wire level10_FF_OUT;
	DFlipFlop DFF_layer10(level9_FF_OUT,clk,out);

endmodule

`endif
