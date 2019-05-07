// 指向指令存储器
module pc(
    NPC,Clk,Reset,
    PC
);
input [31:2] NPC;
input Clk;
input Reset;
output [31:2] PC;

// 暂时还不知道Reset变量的作用

always @(posedge Clk or posedge Reset) begin
    PC <= NPC;
end

endmodule // pc