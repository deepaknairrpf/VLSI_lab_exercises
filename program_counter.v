module program_counter
	(
		DATA_IN, //input to PC
		pc_in, pc_out, pc_increment, //PC control lines
		DATA_OUT, //output from PC
		clk
	);

	input[21:0] DATA_IN;
	input pc_in,pc_out,pc_increment,clk;
	
	output[31:0] DATA_OUT;
	reg[31:0] DATA_OUT;

	reg[21:0] PC;

	always @(posedge clk)
	begin
		if (pc_in) begin
			PC <= DATA_IN;
		end else if(pc_increment) begin
			PC <= PC+1;
		end
	end

	always @(*)
	begin
		if(pc_out) begin
			DATA_OUT[21:0] <= PC;
			DATA_OUT[31:22] <= 10'd0;
		end else begin
			DATA_OUT <= 32'bZ;
		end
	end

endmodule // program_counter