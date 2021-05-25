
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:45 07/28/2020 
// Design Name: 
// Module Name:    ALU32bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU 	#(parameter N = 32, P = 4)
		( input [N-1:0] in1, in2, 
		  input [P-1:0] operation, 
		  input clk, 
		  output reg [N-1:0] result, 
		  output Zero );
						
	assign Zero = (in1 == in2);

	always @(posedge clk)
	begin
		case(operation)
			4'b0000 : result = in1 & in2;  //and
			4'b0001 : result = in1 | in2;  //or
			4'b0010 : result = in1 + in2;  //add
			4'b0110 : result = in1 - in2;  //subtract
			4'b0111 : result = (in1 < in2) ? in1 : in2;  //set on less than
			4'b1100 : result =  ~(in1 | in2);  //Nor
			default : result = 0;
		endcase
	end

endmodule

