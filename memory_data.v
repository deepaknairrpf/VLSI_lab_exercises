module memory_data_reg
	(
		BUSC_DATA_OUT, //output to BUS
		BUSA_DATA_IN, BUSB_DATA_IN, //inputs from BUS
	 	busc_out, busa_in, busb_in, //control lines from BUS
	 	MEMDATA_IN, MEMDATA_OUT, //input, output from MEMORY
	 	mem_in,mem_out, //control lines for MEMORY transfer
	 	clk
	);

	input[31:0] BUSA_DATA_IN, BUSB_DATA_IN, MEMDATA_IN;
	input busc_out, busa_in, busb_in, mem_in, mem_out; //control lines
	input clk;
	
	output[31:0] BUSC_DATA_OUT, MEMDATA_OUT;
	reg[31:0] BUSC_DATA_OUT, MEMDATA_OUT;

	reg[31:0] MDR;

	always @(posedge clk) 
	begin
		if(mem_in) begin
			MDR <= MEMDATA_IN;
		end else if(busa_in) begin
			MDR <= BUSA_DATA_IN;
		end else if(busb_in) begin
			MDR <= BUSB_DATA_IN;
		end
	end

	always @(*)
	begin
		if(mem_out) begin
			MEMDATA_OUT <= MDR;
		end else begin
			MEMDATA_OUT <= 32'bZ;
		end
	end

	always @(*)
	begin
		if(busc_out) begin
			BUSC_DATA_OUT <= MDR;
		end else begin
			BUSC_DATA_OUT <= 32'bZ;
		end
	end

endmodule // memory_data_reg