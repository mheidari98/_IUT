
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:01 07/28/2020 
// Design Name: 
// Module Name:    register32bit 
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
module Register 	#(parameter N = 32)
			( input [N-1:0] in, 
			  input clk, 
			  output reg [N-1:0] out = -1 );

	always @(posedge clk)
	if( in !== 32'bx )
		out <= in;

endmodule

