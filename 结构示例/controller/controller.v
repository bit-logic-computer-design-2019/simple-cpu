module controller(
    opcode, rs, rt, rd, funct, imm16,
    nPC_sel, RegWr, RegDst,ExtOp,ALUSrc,ALUctr,MemWr, MemtoReg
);
input [5,0] opcode,funct;
input [4,0] rs, rt, rd;
input [15:0] imm16;
output  nPC_sel, RegWr, RegDst,ExtOp,ALUSrc,MemWr, MemtoReg；
output [2:0] ALUctr;
// 由与阵列和或阵列构成

wire add,sub,ori,lw,sw,beq;

assign add = (opcode == 6'h00) &&(funct == 6'h20);
assign sub = (opcode == 6'h00) &&(funct == 6'h22);
assign ori = (opcode == 6'hd) ;
assign lw = (opcode == 6'h23) ;
assign sw = (opcode == 6'h26) ;
assign beq = (opcode == 6'h4);

always @(*) begin
    

if (add||lw||sw)
    assign ALUctr = 3'b010;
else if (ori)
    assign ALUctr = 3'b001;
else if(sub||beq)
    assign ALUctr = 3'b110;

end

assign RegDst = add || sub;
assign ALUSrc = ori || lw|| sw;
assign MemtoReg = lw;
assign RegWr = add||sub||ori|| lw;
assign nPC_sel = beq;
assign ExtOp = beq;


endmodule // controller