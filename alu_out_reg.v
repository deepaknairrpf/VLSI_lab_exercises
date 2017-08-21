module ALU_OUTPUT_REG
	(
		ALU_IN_R, //input from ALU
		load_in, reg_out, //control lines
		REG_OUTPUT, //output from register
		clk
	);

	input[31:0] ALU_IN_R;
	input load_in, reg_out;
	input clk;

	output[31:0] REG_OUTPUT;
	reg[31:0] REG_OUTPUT;

	reg[31:0] R;

	always @(posedge clk)
	begin
		if(load_in) begin
			R <= ALU_IN_R;
		end
	end

	always @(*)
	begin
		if(reg_out) begin
			REG_OUTPUT <= R;
		end else begin
			REG_OUTPUT <= 32'bZ;
		end
	end

endmodule // ALU_OUPUT_REG