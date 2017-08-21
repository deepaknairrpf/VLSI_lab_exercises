//header guards
`ifndef _CSA_vh_
`define _CSA_vh_

module fullAdder(a,b,cin,sum,cout);
	input a, b, cin;
	output cout, sum;
	
	assign sum = a^b^cin;
	assign cout= (a&b) | (b&cin) | (cin&a);
	
endmodule //fullAdder

module CSA63bit(A,B,C,SUM,CARRY);

	input[62:0] A,B,C;
	output[62:0] SUM,CARRY;

	assign CARRY[0]=0;

  //fullAdder FA0(A[0],B[0],C[0],SUM[0],CARRY[1]);
	fullAdder FA0(A[0],B[0],C[0],SUM[0],CARRY[1]);
	fullAdder FA1(A[1],B[1],C[1],SUM[1],CARRY[2]);
	fullAdder FA2(A[2],B[2],C[2],SUM[2],CARRY[3]);
	fullAdder FA3(A[3],B[3],C[3],SUM[3],CARRY[4]);
	fullAdder FA4(A[4],B[4],C[4],SUM[4],CARRY[5]);
	fullAdder FA5(A[5],B[5],C[5],SUM[5],CARRY[6]);
	fullAdder FA6(A[6],B[6],C[6],SUM[6],CARRY[7]);
	fullAdder FA7(A[7],B[7],C[7],SUM[7],CARRY[8]);
	fullAdder FA8(A[8],B[8],C[8],SUM[8],CARRY[9]);
	fullAdder FA9(A[9],B[9],C[9],SUM[9],CARRY[10]);
	fullAdder FA10(A[10],B[10],C[10],SUM[10],CARRY[11]);
	fullAdder FA11(A[11],B[11],C[11],SUM[11],CARRY[12]);
	fullAdder FA12(A[12],B[12],C[12],SUM[12],CARRY[13]);
	fullAdder FA13(A[13],B[13],C[13],SUM[13],CARRY[14]);
	fullAdder FA14(A[14],B[14],C[14],SUM[14],CARRY[15]);
	fullAdder FA15(A[15],B[15],C[15],SUM[15],CARRY[16]);
	fullAdder FA16(A[16],B[16],C[16],SUM[16],CARRY[17]);
	fullAdder FA17(A[17],B[17],C[17],SUM[17],CARRY[18]);
	fullAdder FA18(A[18],B[18],C[18],SUM[18],CARRY[19]);
	fullAdder FA19(A[19],B[19],C[19],SUM[19],CARRY[20]);
	fullAdder FA20(A[20],B[20],C[20],SUM[20],CARRY[21]);
	fullAdder FA21(A[21],B[21],C[21],SUM[21],CARRY[22]);
	fullAdder FA22(A[22],B[22],C[22],SUM[22],CARRY[23]);
	fullAdder FA23(A[23],B[23],C[23],SUM[23],CARRY[24]);
	fullAdder FA24(A[24],B[24],C[24],SUM[24],CARRY[25]);
	fullAdder FA25(A[25],B[25],C[25],SUM[25],CARRY[26]);
	fullAdder FA26(A[26],B[26],C[26],SUM[26],CARRY[27]);
	fullAdder FA27(A[27],B[27],C[27],SUM[27],CARRY[28]);
	fullAdder FA28(A[28],B[28],C[28],SUM[28],CARRY[29]);
	fullAdder FA29(A[29],B[29],C[29],SUM[29],CARRY[30]);
	fullAdder FA30(A[30],B[30],C[30],SUM[30],CARRY[31]);
	fullAdder FA31(A[31],B[31],C[31],SUM[31],CARRY[32]);
	fullAdder FA32(A[32],B[32],C[32],SUM[32],CARRY[33]);
	fullAdder FA33(A[33],B[33],C[33],SUM[33],CARRY[34]);
	fullAdder FA34(A[34],B[34],C[34],SUM[34],CARRY[35]);
	fullAdder FA35(A[35],B[35],C[35],SUM[35],CARRY[36]);
	fullAdder FA36(A[36],B[36],C[36],SUM[36],CARRY[37]);
	fullAdder FA37(A[37],B[37],C[37],SUM[37],CARRY[38]);
	fullAdder FA38(A[38],B[38],C[38],SUM[38],CARRY[39]);
	fullAdder FA39(A[39],B[39],C[39],SUM[39],CARRY[40]);
	fullAdder FA40(A[40],B[40],C[40],SUM[40],CARRY[41]);
	fullAdder FA41(A[41],B[41],C[41],SUM[41],CARRY[42]);
	fullAdder FA42(A[42],B[42],C[42],SUM[42],CARRY[43]);
	fullAdder FA43(A[43],B[43],C[43],SUM[43],CARRY[44]);
	fullAdder FA44(A[44],B[44],C[44],SUM[44],CARRY[45]);
	fullAdder FA45(A[45],B[45],C[45],SUM[45],CARRY[46]);
	fullAdder FA46(A[46],B[46],C[46],SUM[46],CARRY[47]);
	fullAdder FA47(A[47],B[47],C[47],SUM[47],CARRY[48]);
	fullAdder FA48(A[48],B[48],C[48],SUM[48],CARRY[49]);
	fullAdder FA49(A[49],B[49],C[49],SUM[49],CARRY[50]);
	fullAdder FA50(A[50],B[50],C[50],SUM[50],CARRY[51]);
	fullAdder FA51(A[51],B[51],C[51],SUM[51],CARRY[52]);
	fullAdder FA52(A[52],B[52],C[52],SUM[52],CARRY[53]);
	fullAdder FA53(A[53],B[53],C[53],SUM[53],CARRY[54]);
	fullAdder FA54(A[54],B[54],C[54],SUM[54],CARRY[55]);
	fullAdder FA55(A[55],B[55],C[55],SUM[55],CARRY[56]);
	fullAdder FA56(A[56],B[56],C[56],SUM[56],CARRY[57]);
	fullAdder FA57(A[57],B[57],C[57],SUM[57],CARRY[58]);
	fullAdder FA58(A[58],B[58],C[58],SUM[58],CARRY[59]);
	fullAdder FA59(A[59],B[59],C[59],SUM[59],CARRY[60]);
	fullAdder FA60(A[60],B[60],C[60],SUM[60],CARRY[61]);
	fullAdder FA61(A[61],B[61],C[61],SUM[61],CARRY[62]);

	wire temp;
	fullAdder FA62(A[62],B[62],C[62],SUM[62],temp);

endmodule // CSA63bit

`endif