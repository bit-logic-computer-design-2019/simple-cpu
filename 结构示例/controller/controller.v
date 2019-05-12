module controller(
    opcode, funct,
    nPC_sel, RegWr, RegDst, ExtOp, ALUSrc, ALUctr, MemWr, MemtoReg
);

input [5:0] opcode, funct;   //指令操作码
output nPC_sel, RegWr, RegDst, ExtOp, ALUSrc, MemWr, MemtoReg;
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
/*  add 010 
    sub 110
    | 001
*/

wire add, sub, ori, lw, sw, beq;

assign add = (opcode == 6'h00)&&(funct == 6'h20);
assign sub = (opcode == 6'h00)&&(funct == 6'h22);
assign ori = (opcode == 6'hd);
assign lw = (opcode == 6'h23);
assign sw = (opcode == 6'h2b);
assign beq = (opcode == 6'h4);

always @(*) begin
    if(add || lw || sw)
        ALUctr = 3'b010;
    else if(ori)
        ALUctr = 3'b001;
    else if(sub || beq)
        ALUctr = 3'b110;
end

assign RegDst = add || sub;     //加和减的时候需要存入第三个寄存器
assign RegWr = add || sub || ori || lw; //这四个指令改变regFile的值

assign ALUSrc = ori || lw || sw;    //需要立即数的三个指令
assign ExtOp = lw || sw;    //lw和sw的时候是sign信号,ori时候是0, 不知道为啥....

assign MemtoReg = lw;   //lw从memory里加载数据
assign MemWr = sw;  //sw的时候写memory

assign nPC_sel = beq;   //beq的时候程序计数器不是+1

endmodule // controller