// 指向指令存储器
module pc(
    NPC,Clk,Reset,
    PC
);
input [31:2] NPC;
input Clk;
input Reset;
output [31:2] PC;

// At the very least, the program
// counter must have a reset
// signal to initialize its value
// when the processor turns on.
// MIPS processors initialize the
// PC to 0xBFC00000 on reset and
// begin executing code to start
// up the operating system (OS).
// The OS then loads an applica-
// tion program at 0x00400000
// and begins executing it.
// For simplicity in this chapter,
// we will reset the PC to
// 0x00000000 and place our
// programs there instead.

always @(posedge Clk or posedge Reset) begin
    if (Reset) // 暂时初始化为0
        PC <= 0x00000000;
    else
        PC <= NPC;
end

endmodule // pc