// 获取下一个pc
// if(rs==rt)PC=PC+4+(sign)imm<<2 # beq

module npc(
    Imm, Br, Zero, Reset,PC,
    NPC
); 
    input [15:0] Imm;
    input Br;
    input Zero;
    input Reset;
    input [31:0] PC;
    output reg [31:0] NPC; //注意这里从第二位开始

  
always @(*) begin
    if (Reset == 1)
        NPC = 1;
    else if (Br == 1 && Zero == 1)
        // 加等于立即数
        NPC = PC + 1 + Imm;
    else
        NPC = PC + 1;
end

endmodule