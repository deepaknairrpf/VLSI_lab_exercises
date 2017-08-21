module instruction_reg
	(
		BUSC_DATA_IN, //input from BUS C
		busc_in,instrn_out, //control lines
		INSTRN_DATA_OUT,
		clk
	);

	input[31:0] BUSC_DATA_IN;
	input busc_in, instrn_out; //control lines
	input clk;

	output[31:0] INSTRN_DATA_OUT;
	reg[31:0] INSTRN_DATA_OUT;
	
	reg[31:0] IR;

	always @(posedge clk)
	begin
		if(busc_in) begin
			IR <= BUSC_DATA_IN;
		end
	end

	always @(*)
	begin
		if(instrn_out) begin
			INSTRN_DATA_OUT <= IR;
		end else begin
			INSTRN_DATA_OUT <= 32'bZ;
		end
	end

endmodule // instruction_regs