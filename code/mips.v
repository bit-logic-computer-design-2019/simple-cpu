module mips(
    Clk, Reset,
    CPU_out
);

input Clk, Reset;
output CPU_out;

wire [31:0] instruction;
wire [31:0] imm32;
wire [31:0] WData;  //被写进regfile的数据
wire [31:0] ALU;    //ALU的输出
wire [31:0] DM;     //memory的输出
wire [31:0] BusA;
wire [31:0] BusB; 
wire [31:0] ALU_input2;
wire [31:0] NPC, PC;
wire [3:0] ALUctr;
wire [4:0] RD; 
wire [31:0] CPU_out;

wire [2:0] nPC_sel,MemWr;
wire [1:0] ExtOp, MemtoReg,DMcut_sel;
wire Br, Zero, carrier;
wire RegWr, RegDst, ALUSrc;

assign CPU_out = WData;

//取指
npc npc1(.Imm(imm32),.nPC_sel(nPC_sel),.Zero(Zero),.NPC(NPC),.PC(PC),.JumpAddr(instruction[25:0]),.BusA(BusA));
pc pc1(.NPC(NPC),.Clk(Clk),.Reset(Reset),.PC(PC));
im im1(.PC(PC),.Reset(Reset),.Clk(Clk),.IM(instruction));

//拓展立即数
ext ext1(.imm16(instruction[15:0]),.ExtOp(ExtOp),.imm32(imm32));

//controller
controller con1(.instruction(instruction),.opcode(instruction[31:26]),.funct(instruction[5:0]),.nPC_sel(nPC_sel),.RegWr(RegWr),.RegDst(RegDst),.ExtOp(ExtOp),.ALUSrc(ALUSrc),.MemWr(MemWr),.MemtoReg(MemtoReg),.ALUctr(ALUctr),.DMcut_sel(DMcut_sel));
 
//ALU
alu alu1(.A(BusA),.B(ALU_input2),.ALUctr(ALUctr),.ALU(ALU),.Zero(Zero),.carrier(carrier),.shamt(instruction[10:6]));

//RegFile
RegFile regfile1(.RS1(instruction[25:21]),.RS2(instruction[20:16]),.RD(RD),.WData(WData),.RegWr(RegWr),.Clk(Clk),.Reset(Reset),.RD1(BusA),.RD2(BusB),.PC(PC));

//data_memory
Datamemory mem1(.Ad(ALU[15:0]),.WrData(BusB),.MemWr(MemWr),.Clk(Clk),.Reset(Reset),.DM(DM),.DMcut_sel(DMcut_sel));

//MUX
mux2_1_5 mux1(.input0(instruction[20:16]),.input1(instruction[15:11]),.Select(RegDst),.out(RD));
mux4_1_32 mux2(.input0(ALU),.input1(DM),.input2(PC+2),.input3(32'd0),.Select(MemtoReg),.out(WData));
mux2_1_32 mux3(.input0(BusB),.input1(imm32),.Select(ALUSrc),.out(ALU_input2));

endmodule // mips  