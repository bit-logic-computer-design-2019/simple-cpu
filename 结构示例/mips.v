module mips(
    Clk, Reset
);
input Clk, Reset;

wire [31:0] instruction;
wire [31:0] imm32;
wire [31:0] WData;  //被写进regfile的值
wire [31:0] ALU;    //ALU的输出
wire [31:0] DM;     //memory的输出
wire [31:0] BusA;
wire [31:0] BusB;
wire [31:0] ALU_input2;
wire [31:2] NPC, PC;
wire [2:0] ALUctr;
wire [4:0] RD; 

wire Br, Zero, carrier;
wire nPC_sel, RegWr, RegDst, ExtOp, ALUSrc, MemWr, MemtoReg;

//取指
module npc npc1(.Imm(instruction[15:0]),.Br(Br),.Zero(nPC_sel),.NPC(NPC));
module pc pc1(.NPC(NPC),.Clk(Clk),.Reset(Reset),PC(PC));
module im im1(.PC(PC),.Reset(Reset),.Clk(Clk),.IM(instruction));

//拓展立即数
module ext ext1(.imm16(instruction[15:0]),.Extop(Extop),.imm32(imm32));

//controller
module controller con1(.opcode(instruction[31:26]),.funct(instruction[5:0]),.nPC_sel(nPC_sel),.RegWr(RegWr),.RegDst(RegDst),.ExtOp(ExtOp),.ALUSrc(ALUSrc),.MemWr(MemWr),.MemtoReg(MemtoReg),.ALUctr(ALUctr));
 
//ALU
module alu alu1(.A(BusA),.B(ALU_input2),.ALUctr(ALUctr),.ALU(ALU),.Zero(Zero),.carrier(carrier));

//RegFile
module RegFile(.RS1(instruction[25:21]),.RS2(instruction[20:16]),.RD(RD),.WData(WData),.RegWr(RegWr),.Clk(Clk),.Reset(Reset),.RD1(BusA),.RD2(BusB));

//data_memory
module Datememory mem1(.Ad(ALU),.WrData(BusB),.MemWr(MemWr),.Clk(Clk),.Reset(Reset),.DM(DM));

//MUX
module mux2_1 mux1(.input0(instruction[20:16]),.input1(instruction[15:11]),.Select(RegDst),out(RD));
module mux2_1 mux2(.input0(ALU),.input1(DM),.Select(MemtoReg),out(WData));
module mux2_1 mux3(.input0(BusB),.input1(imm32),.Select(ALUSrc),out(ALU_input2));

endmodule // mips  