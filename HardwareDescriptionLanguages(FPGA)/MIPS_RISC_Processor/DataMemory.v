
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:18 07/28/2020 
// Design Name: 
// Module Name:    DataMemory128x32bit 
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
module DataMemory	#(parameter N = 32, DM = 7)
			( input [N-1:0] WriteData, 
			  input [DM-1:0] Address, 
			  input clk, MemRead, MemWrite, 
			  output reg [N-1:0] ReadData );

	reg [N-1:0] memory [0 : 2**DM -1];

	always @(posedge clk)
	begin
		if(MemRead)
			ReadData <= memory[Address];
		if(MemWrite)
			memory[Address] <= WriteData;
	end

endmodule


