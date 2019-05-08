// 获取下一个pc值
// if(rs==rt)PC=PC+4+(sign)imm<<2 # beq

module npc(Imm, Br, Zero,  NPC)
    input [15:0] imm;
    input Br;
    input Zero;
    output [31:2] NPC; //注意这里从第二位开始

    always @(*) begin
        
    if (Br == 1)
        // 加等于立即数
        NPC = NPC + 1 + imm;
    else
        NPC = NPC + 1;
    end

endmodule