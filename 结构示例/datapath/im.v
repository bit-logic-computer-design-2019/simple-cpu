// 指令存储器，读入一个地址，输出那个地址所存储的数据
// instruction memory
module im(
    PC, Reset, Clk
    IM
);
input Reset;
input Clk;
input PC[32:2]; 
output IM[31:0];

reg [31:0] text[63:0]; // 指令段

always @(posedge Clk or posedge Reset) begin
    if (Reset)
        $readmemb("../code.txt", text);  //读取指令
end

assign IM = text[PC];

endmodule //im