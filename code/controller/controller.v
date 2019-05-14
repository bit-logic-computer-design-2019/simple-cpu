module controller(
    opcode, funct,
    nPC_sel, RegWr, RegDst, ExtOp, ALUSrc, ALUctr, MemWr, MemtoReg
);

input [5:0] opcode, funct;   //指令操作码
output nPC_sel, RegWr, RegDst, ALUSrc, MemWr, MemtoReg;
/* 
nPc_sel 0-->+4 
        1-->branch
RegWr   0-->No action
        1-->write register
RegDst  0-->rt(I型指令)
        1-->rd(R型指令)
ExtOp   0-->zero
        1-->sign不知道这是干什么的.....
ALUSrc  0-->ALU的操作数均不是立即数
        1-->ALU的一个操作数是立即数
MemWr   0-->No action
        1-->write memory(sw时候用)
MemtoReg    0-->write RegFile from ALU
            1-->write RegFile from Memory
*/
output reg [2:0] ALUctr;
output reg [1:0] ExtOp;
/*  add 010 
    sub 110
    | 001
*/

wire add, sub, ori, lw, sw, beq;
wire lui, addi,and_,andi;

assign add = (opcode == 6'h00)&&(funct == 6'h20 || funct == 6'h21);
assign addi = (opcode == 6'h8||opcode == 6'h9);
assign sub = (opcode == 6'h00)&&(funct == 6'h22 || funct == 6'h23);
assign ori = (opcode == 6'hd);
assign lw = (opcode == 6'h23);
assign sw = (opcode == 6'h2b);
assign beq = (opcode == 6'h4);
assign lui = (opcode == 6'hf);
assign and_ = (opcode == 6'h0) && (funct == 6'h24);
assign andi = (opcode == 6'hc);

// 控制ALU的具体运算功能
always @(*) begin

    if(add || lw || sw || addi) // add
        ALUctr = 3'b010;
    else if(ori) // or
        ALUctr = 3'b001;
    else if(sub || beq) // sub
        ALUctr = 3'b110;
    else if(lui)
        ALUctr = 3'b111;
    else if(and_ || andi) // and &
        ALUctr = 3'b000;


end

// 是否使用第三个寄存器
assign RegDst = add || sub || and_;     //加和减的时候需要存入第三个寄存器

// 是否向R中写入值
assign RegWr = add || sub || ori || lw || lui || addi || and_ || andi; //这四个指令改变regFile的值

// 加载立即数
assign ALUSrc = ori || lw || sw || lui || addi || andi;    //需要立即数的三个指令

// 是否用有符号扩展
always @(*) begin
    if(andi)
        // unsigned
        ExtOp = 2'b00;
    else if(lw||sw||addi)
        // signed
        ExtOp = 2'b01;
    else if(lui)
        // lui
        ExtOp = 2'b10;

end

// 1：从DataMemroy加载数据，0：从ALU加载数据
assign MemtoReg = lw;   //lw从memory里加载数据

// 是否写入DataMemory
assign MemWr = sw;  //sw的时候写memory

// nPC是否不再是简简单单的加1
assign nPC_sel = beq;   //beq的时候程序计数器不是+1

endmodule // controller