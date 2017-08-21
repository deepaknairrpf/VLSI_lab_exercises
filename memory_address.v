//if both BUS 'B' and 'C' write at same time: BUS 'B' given higher priority
module memory_add_reg
	(
		BUSB_DATA, BUSC_DATA, //input from BUS
		busb_in,busc_in, //BUS control lines
		MEM_ADDRESS, //output to memory
		clk		
	);

	input[21:0] BUSB_DATA,BUSC_DATA;
	input busb_in,busc_in;
	input clk;

	output[21:0] MEM_ADDRESS;
	reg[21:0] MEM_ADDRESS;

	always @(posedge clk)
	begin
		if(busb_in) begin
			MEM_ADDRESS <= BUSB_DATA;
		end else if(busc_in) begin
			MEM_ADDRESS <= BUSC_DATA;
		end
	end

endmodule // MAR