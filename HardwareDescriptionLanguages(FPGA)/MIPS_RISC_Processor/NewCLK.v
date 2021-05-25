
module ClkChanger 	#(parameter N = 2)
			( input clk, Reset, 
			  output NewCLK );


	reg [ N-1 : 0 ] counter = 0;

	always @(posedge clk)
	begin
		counter <= counter + 1;
		if( Reset )
			counter <= 0;
	end

	assign NewCLK = (counter == 1) ? 1 : 0;

endmodule
