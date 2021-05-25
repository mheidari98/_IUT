
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:16:20 07/28/2020 
// Design Name: 
// Module Name:    InstructionMemory32x32bit 
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
module InstructionMemory 	#(parameter N = 32, IM = 5)
				( input [IM-1:0] InstructionAddress, 
				  output reg [N-1:0] Instruction );

	reg [N-1:0] memory [0 : 2**IM - 1 ];

	initial  
	begin  
		memory[ 2**IM - 1 ] = 32'b0; 
		$readmemb("instruction.mem",memory,0);
	end  

	always @(*)
	begin
		// 	SERI 1
/*		memory[0] = 32'b001000_00000_00001_0000000000000011;	//R1 <= R0 + 3
		memory[1] = 32'b001000_00000_00010_0000000000000011;	//R2 <= R0 + 3
		memory[2] = 32'b000000_00001_00010_00011_00000_011000;	//R3 <= R1 + R2
		memory[3] = 32'b101011_00001_00010_0000000000001010;
		memory[4] = 32'b100011_00010_00001_0000000000001010;	//R1= Mem( R2 + 100)
		memory[5] = 32'b000100_00001_00010_0000000000010100;	//if R2= R1 then PC = 20
*/
		// 	SERI 2
/*		memory[0] = 32'b001000_00000_00001_0000000000000011; 		//R1 <- 3
		memory[1] = 32'b001000_00000_00010_0000000000000111; 		//R2 <- 7
		memory[2] = 32'b000010_00000000000000000000000000; 		//jump to ins[0]
*/
		// 	SERI 3
/*		memory[0] = 32'b001000_00000_00001_0000000000000011; // R1 <- 3
		memory[1] = 32'b000011_00000000000000000000000101; // jal to ins[5]
		memory[5] = 32'b000000_00001_11111_00011_00000_011000; // R3 <- R1+ R31
*/
		// 	SERI 4
/*		memory[0] = 32'b001000_00000_00010_0000000000000111;//R2 <- 7
		memory[1] = 32'b000011_00000000000000000000000011;//jal 3
		memory[2] = 32'b000000_10001_00010_00011_00000_011000;//R3 <- R17 + R2 
		memory[3] = 32'b001000_00000_10001_0000000000000100;//R17 <- 4
		memory[4] = 32'b000000_11111_00000_00000_00000_001000;//jr $ra
*/

		Instruction = memory[InstructionAddress];
	end



endmodule

