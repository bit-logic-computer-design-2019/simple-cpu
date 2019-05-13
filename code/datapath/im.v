// instruction memory
module im(
    PC, Reset, Clk,
    IM
);
input Reset;
input Clk;
input [32:2] PC; 
output [31:0] IM;

reg [31:0] text[63:0]; // 指令放在这里

always @(posedge Clk or posedge Reset) begin
    if (Reset)
        $readmemb("../code.txt", text);  //读取指令
end

assign IM = text[PC];

endmodule //im