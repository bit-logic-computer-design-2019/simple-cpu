//数据储存
module Datamemory(
    Ad, WrData, MemWr, Clk, Reset,
    DM
);
input Clk, Reset;
input [31:2] Ad;
input [31:0] WrData;
input MemWr;
output reg [31:0] DM; // alias ReadData

reg [7:0] memory[63:0];

// DMWr 控制读还是写
always @(posedge Clk or posedge Reset) begin
    if(Reset)
        $readmemb("E:/gitHub/simple-cpu/code/restfile/dm.txt", memory);
    else if(MemWr)
    // 若写使能�?1，则写入memory[Addr]
        memory[Ad] <= WrData;
    else
    // 否则读出
        DM <= memory[Ad];
end

endmodule // dm