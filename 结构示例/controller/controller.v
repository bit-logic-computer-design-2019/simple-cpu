module controller(
    opcode, rs, rt, rd, funct, imm16,
    nPC_sel, RegWr, RegDst,ExtOp,ALUSrc,ALUctr,MemWr, MemtoReg
);
input [5,0] opcode,funct;
input [4,0] rs, rt, rd;
input [15:0] imm16;
output  nPC_sel, RegWr, RegDst,ExtOp,ALUSrc,ALUctr,MemWr, MemtoReg；




endmodule // controller