`timescale 1ns/1ps

// instruction memory
module im(
    PC, Reset, Clk,
    IM
);
input Reset;
input Clk;
input [31:0] PC; 
output [31:0] IM;

reg [31:0] txt[63:0]; // 指令放在这里

always @(posedge Clk or posedge Reset) begin
    if (Reset)
        $readmemh("/home/fky/code/git/mine/simple-cpu/code/resetfile/code.txt", txt);  //读取指令
end

assign IM = txt[PC];

endmodule //im