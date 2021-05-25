
module MipsProcessor	( input clk,
			  output [31:0] PcOut, Instruction, ReadData1, ReadData2, AluResult, ReadData, WriteData,
			  output [4:0] WriteRegister, 
			  output [3:0] op, 
			  output [1:0] ALUop, 
			  output RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite, Jump, Jal, Jr, Zero);

	// Inputs should be reg
	// Outputs should be wire
	wire [31:0] SignOut, PcInBeforeJump, PcInAfterJump, PcInAfterJr, Pc_Incremented, PcAddOut, AluIn2, JumpMuxIN2, WriteDataBeforeJal ;
	wire [4:0] WriteRegisterBeforeJal;
	wire NewCLK;

	defparam PcClk.N = 2;  //duty cycle = 1 / (2**N)
	ClkChanger PcClk(	.clk( clk ), 
				.Reset( 1'b0 ), 
				.NewCLK( NewCLK )	);
	// PC Register
	defparam PC.N = 32;  //32bit register
	Register PC(	.in( PcInAfterJr ), 
			.clk( NewCLK ), 
			.out( PcOut )     );

	
	// PC Incrementer
	defparam PcPlusPplus.N = 32;  //32bit Incrementer
	Incrementer PcPlusPplus(	.in( PcOut ), 
					.clk( clk ), 
					.out( Pc_Incremented )	);


	// InstructionMemory
	defparam InsMem.IM = 5;  //2**5=32 = Instruction Height
	defparam InsMem.N = 32;  //32bit = Instruction Width
	InstructionMemory InsMem(	.InstructionAddress( PcOut[4:0] ), 
					.Instruction( Instruction ));

	defparam SE.Nin = 16;   //16bit input
	defparam SE.Nout = 32;  //32bit ouput
	SignExtend SE(	.in( Instruction[15:0] ), 
			.clk( clk ), 
			.out( SignOut )	);

	defparam PcAdd.N = 32;  //32bit Adder
	Add PcAdd(	.in1( Pc_Incremented ), 
			.in2( SignOut ), 
			.out( PcAddOut ) 	);


	Control ctrl(	.inst_in( Instruction[31:26] ), 
			.RegDst( RegDst ), 
			.Branch( Branch ), 
			.MemRead( MemRead ), 
			.MemtoReg( MemtoReg ), 
			.ALUop( ALUop ), 
			.MemWrite( MemWrite ), 
			.ALUsrc( ALUsrc ), 
			.RegWrite( RegWrite ),
			.Jump(Jump),
			.Jal(Jal),
			.Jr(Jr)		);


	defparam BankRegMux.N = 5;  //32bit Mux 2 to 1
	MUX2to1 BankRegMux(	.in1( Instruction[20:16] ), 
				.in2( Instruction[15:11] ), 
				.sel( RegDst ), 
				.out( WriteRegisterBeforeJal ) 	);

	defparam BankRegJalMux.N = 5;  //32bit Mux 2 to 1
	MUX2to1 BankRegJalMux(	.in1( WriteRegisterBeforeJal ), 
				.in2( 5'd31 ), 
				.sel( Jal ), 
				.out( WriteRegister ) 	);

	defparam BankReg.BR = 5;  //2**5=32 = BankRegister Height
	defparam BankReg.N = 32;  //32bit = register Width
	BankRegister BankReg(	.WriteData( WriteData ), 
				.ReadRegister1( Instruction[25:21] ), 
				.ReadRegister2( Instruction[20:16] ), 
				.WriteRegister( WriteRegister ), 
				.RegWrite( RegWrite ), 
				.clk( clk ), 
				.ReadData1( ReadData1 ), 
				.ReadData2( ReadData2 )	);


	defparam AluMux.N = 32;  //32bit Mux 2 to 1
	MUX2to1 AluMux(	.in1( ReadData2 ), 
			.in2( SignOut ), 
			.sel( ALUsrc ), 
			.out( AluIn2 ) 	);

	ALU_control AluCtrl(	.ALU_op( ALUop ), 
				.inst( Instruction[5:0] ), 
				.op( op )		);

	defparam MainAlu.P = 4;  //2**4=16 operator ( default 6 set )
	defparam MainAlu.N = 32;  //32bit operand
	ALU MainAlu(	.in1( ReadData1 ), 
			.in2( AluIn2 ), 
			.operation( op ), 
			.clk( clk ), 
			.result( AluResult ), 
			.Zero( Zero )	);

	defparam PcMux.N = 32;  //32bit Mux 2 to 1
	MUX2to1 PcMux(	.in1( Pc_Incremented ), 
			.in2( PcAddOut ), 
			.sel( Branch&Zero ), 
			.out( PcInBeforeJump )	);

	assign JumpMuxIN2 = {Pc_Incremented[31:26],Instruction[25:0]};
	defparam JumpMux.N = 32;  //32bit Mux 2 to 1
	MUX2to1 JumpMux(	.in1( PcInBeforeJump ), 
				.in2( JumpMuxIN2 ), 
				.sel( Jump | Jal ), 
				.out( PcInAfterJump )	);	
				
	assign JrMuxIN2 = {Pc_Incremented[31:26],Instruction[25:0]};
	defparam JrMux.N = 32;  //32bit Mux 2 to 1
	MUX2to1 JrMux(		.in1( PcInAfterJump ), 
				.in2( ReadData1 ), 
				.sel( Jr & (Instruction[5:0]==6'b001000) ), 
				.out( PcInAfterJr )	);		

	defparam DataMem.DM = 7;  //2**7=128 = DataMemory Height
	defparam DataMem.N = 32;  //32bit = DataMemory Width
	DataMemory DataMem(	.WriteData( ReadData2 ), 
				.Address( AluResult[6:0] ), 
				.MemRead( MemRead ), 
				.MemWrite( MemWrite ), 
				.clk( clk ), 
				.ReadData( ReadData )	);

	defparam DataMemMux.N = 32;  //32bit Mux 2 to 1
	MUX2to1 DataMemMux(	.in1( AluResult ), 
				.in2( ReadData ), 
				.sel( MemtoReg ), 
				.out( WriteDataBeforeJal ) 	);

	defparam DataMemMuxJal.N = 32;  //32bit Mux 2 to 1
	MUX2to1 DataMemMuxJal(	.in1( WriteDataBeforeJal ), 
				.in2( Pc_Incremented ), 
				.sel( Jal ), 
				.out( WriteData ) 	);


endmodule
