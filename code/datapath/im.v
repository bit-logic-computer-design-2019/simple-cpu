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

reg [31:0] txt[63:0]; // 机器指令放在这里

always @(posedge Clk or posedge Reset) begin
    if (Reset)
        //$readmemh("E:/github/simple-cpu/code/resetfile/code.txt", txt);
        $readmemb("E:/github/simple-cpu/docs/dump.txt", txt);
        //$readmemb("/home/fky/code/git/mine/simple-cpu/code/resetfile/code.txt", memory);  //读取指令
end

assign IM = txt[PC];

endmodule //im