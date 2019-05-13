// 获取下一个pc
// if(rs==rt)PC=PC+4+(sign)imm<<2 # beq

module npc(
    Imm, Br, Zero,
    NPC
); 
    input [15:0] Imm;
    input Br;
    input Zero;
    output reg [31:2] NPC; //注意这里从第二位开始

    always @(*) begin
        
    if (Zero == 1)
        // 加等于立即数
        NPC = NPC + 1 + Imm;
    else
        NPC = NPC + 1;
    end

endmodule