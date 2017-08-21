//header guards
`ifndef _partialSum_vh_
`define _partialSum_vh_


module partialSum(A,b,OUT);

	input[31:0] A;
	input b;

	output[31:0] OUT;

	assign OUT[0] = A[0]&b;
	assign OUT[1] = A[1]&b;
	assign OUT[2] = A[2]&b;
	assign OUT[3] = A[3]&b;
	assign OUT[4] = A[4]&b;
	assign OUT[5] = A[5]&b;
	assign OUT[6] = A[6]&b;
	assign OUT[7] = A[7]&b;
	assign OUT[8] = A[8]&b;
	assign OUT[9] = A[9]&b;
	assign OUT[10] = A[10]&b;
	assign OUT[11] = A[11]&b;
	assign OUT[12] = A[12]&b;
	assign OUT[13] = A[13]&b;
	assign OUT[14] = A[14]&b;
	assign OUT[15] = A[15]&b;
	assign OUT[16] = A[16]&b;
	assign OUT[17] = A[17]&b;
	assign OUT[18] = A[18]&b;
	assign OUT[19] = A[19]&b;
	assign OUT[20] = A[20]&b;
	assign OUT[21] = A[21]&b;
	assign OUT[22] = A[22]&b;
	assign OUT[23] = A[23]&b;
	assign OUT[24] = A[24]&b;
	assign OUT[25] = A[25]&b;
	assign OUT[26] = A[26]&b;
	assign OUT[27] = A[27]&b;
	assign OUT[28] = A[28]&b;
	assign OUT[29] = A[29]&b;
	assign OUT[30] = A[30]&b;
	assign OUT[31] = A[31]&b;
	
endmodule // partialSum

`endif
