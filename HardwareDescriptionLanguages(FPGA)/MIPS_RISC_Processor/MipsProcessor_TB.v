
`timescale 1ns / 1ps

module MipsProcessor_TB;

	// Inputs
	reg Clock;
	// Outputs
	wire [31:0] PcOut, Instruction, ReadData1, ReadData2, AluResult, ReadData, WriteData;
	wire [4:0] WriteRegister;
	wire [3:0] op;
	wire [1:0] ALUop;
	wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite, Jump, Jal, Jr, Zero;

	// Instantiate the Unit Under Test (UUT)
	MipsProcessor	uut( 
			.clk( Clock ), 
			.PcOut(PcOut), 
			.Instruction(Instruction), 
			.ReadData1(ReadData1), 
			.ReadData2(ReadData2), 
			.AluResult(AluResult), 
			.ReadData(ReadData), 
			.WriteData(WriteData),
			.WriteRegister(WriteRegister), 
			.op(op), 
			.ALUop(ALUop), 
			.RegDst(RegDst), 
			.Branch(Branch), 
			.MemRead(MemRead), 
			.MemtoReg(MemtoReg), 
			.MemWrite(MemWrite), 
			.ALUsrc(ALUsrc), 
			.RegWrite(RegWrite), 
			.Jump(Jump),
			.Jal(Jal),
			.Jr(Jr),
			.Zero(Zero)	);

	initial begin
		Clock = 1;
		forever #10 Clock=~Clock; //50MHz
	end

endmodule
