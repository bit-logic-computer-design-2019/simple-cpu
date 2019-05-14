module controller(
    opcode, funct,
    nPC_sel, RegWr, RegDst, ExtOp, ALUSrc, ALUctr, MemWr, MemtoReg, DMcut_sel
);

input [5:0] opcode, funct;   //指令操作码
output RegWr, RegDst, ALUSrc;
output [1:0] MemtoReg, DMcut_sel;
output [2:0] MemWr;
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
output reg [3:0] ALUctr;
output reg  [2:0] nPC_sel;
output reg [1:0] ExtOp;
/*  add 010 
    sub 110
    | 001
*/

wire add, sub, ori, lw, sw, beq;
wire lui, addi, and_, andi, bne, j,
jal, jr, lbu, lhu, ll, nor_, or_,
slt, slti, sltiu, sltu, sll, srl, sb,
sc, sh;

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
assign bne = (opcode == 6'h5);
assign j = (opcode == 6'h2);
assign jal = (opcode == 6'h3);
assign jr = (opcode == 6'h0) && (funct == 6'h8);
assign lbu = (opcode == 6'h24);
assign lhu = (opcode == 6'h25);
assign ll = (opcode == 6'h30);
assign nor_ = (opcode == 6'h0) && (funct == 6'h27);
assign or_ = (opcode == 6'h0) && (funct == 6'h25);
assign slt = (opcode == 6'h0) && (funct == 6'h2a);
assign slti = (opcode == 6'ha);
assign sltiu = (opcode == 6'hb);
assign sltu = (opcode == 6'h0) && (funct == 6'h2b);
assign sll = (opcode == 6'h0) && (funct == 6'h00);
assign srl = (opcode == 6'h0) && (funct == 6'h02);
assign sb = (opcode == 6'h28);
assign sc = (opcode == 6'h38);
assign sh = (opcode == 6'h29);
assign sw = (opcode == 6'h2b);

assign DMcut_sel[0] = lbu;
assign DMcut_sel[1] = lhu;

// 控制ALU的具体运算功能
always @(*) begin

    if(add || lw || sw || addi ||lbu||lhu||ll||sb||sc||sh) // add
        ALUctr = 4'b0010;
    else if(nor_) // nor
        ALUctr = 4'b0011;
    else if(ori||or_) // or
        ALUctr = 4'b0001;
    else if(sub || beq || bne) // sub
        ALUctr = 4'b0110;
    else if(slt||slti || sltiu || sltu) // slt
        ALUctr = 4'b0100;
    else if(jr) // Send A
        ALUctr = 4'b0101;
    else if(lui) // Send B
        ALUctr = 4'b0111;
    else if(and_ || andi) // and &
        ALUctr = 4'b0000;
    else if(sll) // left shamt
        ALUctr = 4'b1000;
    else if(srl) // right shamt
        ALUctr = 4'b1001;


end

// 是否使用第三个寄存器
assign RegDst = nor_|| or_|| slt || sltu || sll|| srl|| add || sub || and_;     //加和减的时候需要存入第三个寄存器

// 是否向R中写入值
assign RegWr = jal || lbu || lhu || ll || nor_ || or_ || slt || slti || sltiu || sltu || sll || srl || add || sub || ori || lw || lui || addi || and_ || andi || sc; //改变regFile的值

// 加载立即数
assign ALUSrc = lbu|| lhu||ll||slti||sltiu||sb||sc||sh|| bne || ori || lw || sw || lui || addi || andi || beq;    //需要立即数

// 是否用有符号扩展
always @(*) begin
    if(andi)
        // unsigned
        ExtOp = 2'b00;
    else if(lw||sw||addi||lbu||lhu||ll||slti||sltiu||sb||sc||sh)
        // signed
        ExtOp = 2'b01;
    else if(lui)
        // lui
        ExtOp = 2'b10;
    else if(beq || bne)
        ExtOp = 2'b11;

end

// 1：从DataMemroy加载数据，0：从ALU加载数据
assign MemtoReg[0] = lw ||lbu||lhu||ll||sc;   //lw从memory里加载数据
// 2: 从PC加载数据
assign MemtoReg[1] = jal;

// 是否写入DataMemory
assign MemWr[0] = sw || sc;  //sw的时候写memory
assign MemWr[1] = sb || sc;
assign MemWr[2] = sh;

// nPC是否不再是简简单单的加1
always @(*) begin
    if(beq) // beq
        nPC_sel = 3'b001;
    else if(bne) // bne
        nPC_sel = 3'b010;
    else if(j)
        nPC_sel = 3'b011;
    else if(jal)
        nPC_sel = 3'b100;
    else if(jr)
        nPC_sel = 3'b101;
    else
        nPC_sel = 3'b000;
end


endmodule // controller