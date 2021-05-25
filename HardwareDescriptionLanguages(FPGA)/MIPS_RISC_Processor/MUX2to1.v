
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:33 07/28/2020 
// Design Name: 
// Module Name:    mux32bit2to1 
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
module MUX2to1 	#(parameter N = 32)
		( input [N-1:0] in1, in2, 
		  input sel, 
		  output [N-1:0] out );

	assign out = (sel) ? in2 : in1;

endmodule

