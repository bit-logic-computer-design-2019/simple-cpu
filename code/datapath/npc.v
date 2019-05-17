// 获取下一个pc
// if(rs==rt)PC=PC+4+(sign)imm<<2 # beq

module npc(
    Imm, nPC_sel, Zero, PC, JumpAddr, BusA,
    NPC
); 
    input [15:0] Imm;
    input [2:0] nPC_sel;
    input Zero;
    input [31:0] PC, BusA;
    input [25:0] JumpAddr;
    output reg [31:0] NPC; //注意这里从第二位�?�?

always @(*) begin
    if (nPC_sel == 3'b001 && Zero == 1)
        // 加等于立即数
        NPC = PC + 1 + Imm;
    else if (nPC_sel == 3'b010 && Zero == 0)
        NPC = PC + 1 + Imm;
    else if (nPC_sel == 3'b011) // j
        NPC = JumpAddr;
    else if (nPC_sel == 3'b100) // jal
        NPC = JumpAddr;
    else if (nPC_sel == 3'b101) // jr
        NPC = BusA;
    else
        NPC = PC + 1;
end

endmodule