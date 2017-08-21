//header guards
`ifndef _prefix64_vh_
`define _prefix64_vh_

`include "prefixAdder.v"
`include "MUX2.v"

//6 clock cycles - clk 0 : input ; clk 6 : output
module prefixAdder64(A,B,cin,cout,SUM,clk);
	
	input[63:0] A,B;
	input cin,clk;

	output[63:0] SUM;
	output cout;

	wire PA32_LSB_cout;
	wire[31:0] PA32_LSB_SUM;

	prefixAdder PA32_LSB(A[31:0],B[31:0],cin,PA32_LSB_cout,PA32_LSB_SUM,clk);

	wire PA32_MSB_cout0,PA32_MSB_cout1;

	wire[31:0] PA32_MSB_SUM0;
	wire[31:0] PA32_MSB_SUM1;

	prefixAdder PA32_MSB_0(A[63:32],B[63:32],0,PA32_MSB_cout0,PA32_MSB_SUM0,clk);
	prefixAdder PA32_MSB_1(A[63:32],B[63:32],1,PA32_MSB_cout1,PA32_MSB_SUM1,clk);

	//capture all SUMs and COUTs in D-Flip Flops
	wire[31:0] LSB_SUM_OUT,MSB_SUM0_OUT,MSB_SUM1_OUT;

	DFlipFlop32 SUM_LSB_FF(PA32_LSB_SUM,clk,LSB_SUM_OUT);

	DFlipFlop32 SUM_MSB_FF0(PA32_MSB_SUM0,clk,MSB_SUM0_OUT);
	DFlipFlop32 SUM_MSB_FF1(PA32_MSB_SUM1,clk,MSB_SUM1_OUT);

	wire LSB_cout_OUT,MSB_cout0_OUT,MSB_cout1_OUT;

	DFlipFlop cout_LSB_FF(PA32_LSB_cout,clk,LSB_cout_OUT);
	DFlipFlop cout_MSB0_FF(PA32_MSB_cout0,clk,MSB_cout0_OUT);
	DFlipFlop cout_MSB1_FF(PA32_MSB_cout1,clk,MSB_cout1_OUT);

	//Using MUX to choose the CORRECT SUM
	assign SUM[31:0] = LSB_SUM_OUT;

	MUX32bit_2x1 SUM_SELECT(MSB_SUM0_OUT,MSB_SUM1_OUT,LSB_cout_OUT,SUM[63:32]);

	MUX2x1 cout_Select(MSB_cout0_OUT,MSB_cout1_OUT,LSB_cout_OUT,cout);
	
endmodule // prefixAdder64

`endif
