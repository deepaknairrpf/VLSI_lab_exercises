//header guards
`ifndef _FPM32_vh_
`define _FPM32_vh_

//11 clock cycles - input : clk 0 ; output : clk 11

`include "prefixAdder8.v"
`include "wallaceMultiplier.v"

//FPM ignores special cases, rounding of IEEE 754 format
module FPM(A,B,SUM,clk);

	input[31:0] A,B;
	input clk;

	output[31:0] SUM;


	/*PROCESSING OF EXPONENTS -- start */

	//ignores cout from exponent from PA
	wire exponentSUM_PA_cout;
	
	wire[7:0] exponent_SUM_FFIN;
	prefixAdder8bit exponentSUM_PA8(A[30:23],B[30:23],0,exponentSUM_PA_cout,exponent_SUM_FFIN,clk);

	//capture exponent sum in FlipFlop
	wire[7:0] exponent_SUM_FFOUT;
	DFlipFlop8 exponentSUM_FF(exponent_SUM_FFIN,clk,exponent_SUM_FFOUT);

	wire exp_normalise_cout0, exp_normalise_cout1;


	wire[7:0] exp_normalise0__FFIN, exp_normalise1__FFIN;

	//Precomputing normalised exponents : Case 0: without Shift; Case 1: with shift
	prefixAdder8bit exp_normalisePA_case0(exponent_SUM_FFOUT,8'b10000001,0,exp_normalise_cout0,exp_normalise0__FFIN,clk);
	prefixAdder8bit exp_normalisePA_case1(exponent_SUM_FFOUT,8'b10000001,1,exp_normalise_cout1,exp_normalise1__FFIN,clk);


	/*Waiting for mantissa product : delay Normalised exponents*/
	
	//at the 6th clock cycle
	wire[7:0] exp_normalise0__FF0OUT, exp_normalise1__FF0OUT;
	
	DFlipFlop8 expSUM_norm_FF0_level0(exp_normalise0__FFIN,clk,exp_normalise0__FF0OUT);
	DFlipFlop8 expSUM_norm_FF1_level0(exp_normalise1__FFIN,clk,exp_normalise1__FF0OUT);

	//at the 7th clock cycle
	wire[7:0] exp_normalise0__FF1OUT, exp_normalise1__FF1OUT;

	DFlipFlop8 expSUM_norm_FF0_level1(exp_normalise0__FF0OUT,clk,exp_normalise0__FF1OUT);
	DFlipFlop8 expSUM_norm_FF1_level1(exp_normalise1__FF0OUT,clk,exp_normalise1__FF1OUT);

	//at the 8th clock cycle
	wire[7:0] exp_normalise0__FF2OUT, exp_normalise1__FF2OUT;

	DFlipFlop8 expSUM_norm_FF0_level2(exp_normalise0__FF1OUT,clk,exp_normalise0__FF2OUT);
	DFlipFlop8 expSUM_norm_FF1_level2(exp_normalise1__FF1OUT,clk,exp_normalise1__FF2OUT);
	

	//at the 9th clock cycle
	wire[7:0] exp_normalise0__FF3OUT, exp_normalise1__FF3OUT;

	DFlipFlop8 expSUM_norm_FF0_level3(exp_normalise0__FF2OUT,clk,exp_normalise0__FF3OUT);
	DFlipFlop8 expSUM_norm_FF1_level3(exp_normalise1__FF2OUT,clk,exp_normalise1__FF3OUT);

	//at the 10th clock cycle
	wire[7:0] exp_normalise0__FFOUT, exp_normalise1__FFOUT;

	DFlipFlop8 expSUM_norm_FF0(exp_normalise0__FF3OUT,clk,exp_normalise0__FFOUT);
	DFlipFlop8 expSUM_norm_FF1(exp_normalise1__FF3OUT,clk,exp_normalise1__FFOUT);

	/*PROCESSING OF EXPONENTS -- end */


	/*PROCESSING OF MANTISSAs --start */

	wire[31:0] mantissa_A, mantissa_B;

	assign mantissa_A[22:0] = A[22:0];
	assign mantissa_B[22:0] = B[22:0];

	assign mantissa_A[23]=1;
	assign mantissa_B[23]=1;

	assign mantissa_A[31:24] = 8'd0;
	assign mantissa_B[31:24] = 8'd0;

	wire[63:0] mantissa_product_FFIN, mantissa_product_FFOUT;

	wallaceMultiplier mantissas_WM(mantissa_A,mantissa_B,mantissa_product_FFIN,clk);

	//at the 10th clock cycle
	DFlipFlop64 mantissa_product_FF(mantissa_product_FFIN,clk,mantissa_product_FFOUT);

	/*PROCESSING OF MANTISSAs --end */

	/* COMBINING RESULTS of MANTISSA and EXPONENT -- start*/
	
	//module MUX8bit_2x1(DATA0,DATA1,select,OUT)
	MUX8bit_2x1 MUX_exp_norm(exp_normalise0__FFOUT, exp_normalise1__FFOUT, mantissa_product_FFOUT[47],SUM[30:23]);

	wire[23:0] mantissa_pro_shifted;
	MUX_24bitShifter mantissa_shifter(mantissa_product_FFOUT[46:23],mantissa_product_FFOUT[47],mantissa_pro_shifted);

	assign SUM[22:0] = mantissa_pro_shifted[22:0];

	/* COMBINING RESULTS of MANTISSA and EXPONENT -- end*/
	

	
	/*SIGN COMPUTATION and DELAY --start*/
	assign SUM_sign = A[31] ^ B[31];

	//delay sign by 10 clock cycles
	delay10_1bit_DFF sign_delay_FFs(SUM_sign,clk,SUM[31]);

	/*SIGN COMPUTATION and DELAY --end*/

endmodule // FPM

`endif
