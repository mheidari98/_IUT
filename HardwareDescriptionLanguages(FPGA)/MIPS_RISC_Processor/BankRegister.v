
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:24:42 07/28/2020 
// Design Name: 
// Module Name:    BankRegister32x32bit 
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
module BankRegister 	#(parameter N = 32, BR = 5)
			( input [N-1:0] WriteData, 
			  input [BR-1:0] ReadRegister1, ReadRegister2, WriteRegister, 
			  input clk, RegWrite, 
			  output [N-1:0] ReadData1, ReadData2 );

	reg [N-1:0] zero_reg = 0;
	reg [N-1:0] Registers [1 : 31]; //2**BR - 1

	assign ReadData1 = (ReadRegister1 == 0) ? zero_reg : Registers[ReadRegister1];
	assign ReadData2 = (ReadRegister2 == 0) ? zero_reg : Registers[ReadRegister2];

	always @(posedge clk)
		if( RegWrite && WriteRegister != 0)
			Registers[WriteRegister] <= WriteData;

endmodule

