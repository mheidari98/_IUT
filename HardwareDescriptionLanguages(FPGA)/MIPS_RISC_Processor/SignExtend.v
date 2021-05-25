
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:34 07/28/2020 
// Design Name: 
// Module Name:    SignExtend 
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
module SignExtend 	#(parameter Nin = 16, Nout = 32)
			( input [Nin-1:0] in, 
			  input clk, 
			  output reg [Nout-1:0] out );

	always @(posedge clk)
		out <= { {(Nout-Nin){in[15]}} , in };

endmodule

