// 指令存储器，读入一个地址，输出那个地址所存储的数据
// instruction memory
module im(
    PC,
    IM
);
input PC[32:2];
output IM[32:0];

reg [31:0] text[0:63]; // 指令段

initial 
begin
        $readmemb("../code.txt", text);  //读取指令
end

IM <= text[PC];

endmodule //im