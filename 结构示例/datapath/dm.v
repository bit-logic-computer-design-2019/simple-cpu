// 数据存储器
module dm(
    Ad,WrData,DMWr, Clk,
    DM
);
input [31:2] Ad;
input [31:0] WrData;
input DMWr, Clk;
output DM[31:0]; // alias ReadData

// 模拟内存，以32位为一字长存储，共64个字长
reg [7:0] memory[63:0];

initial begin
    $readmemb("../restfile/dm.txt", memory);
end


// DMWr 控制读还是写
always @(posedge Clk) begin
    if (DMWr)
    // 若写使能为1，则写入memory[Addr]中
        memory[Ad] <= WrData;
    else
    // 否则读出
        DM <= memory[Ad];
end

endmodule // dm