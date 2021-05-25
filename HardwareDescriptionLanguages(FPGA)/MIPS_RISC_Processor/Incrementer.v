
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:05 07/28/2020 
// Design Name: 
// Module Name:    incrementer32bit 
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
module Incrementer	#(parameter N = 32)
			( input [N-1:0] in, 
			  input clk, 
			  output [N-1:0] out );
	
	assign out = (in + 1);

//	always @(posedge clk)
//		out <= (in + 1);

endmodule

