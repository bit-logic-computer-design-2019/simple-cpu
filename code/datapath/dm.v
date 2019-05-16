//数据储存
module Datamemory(
    Ad, WrData, MemWr, Clk, Reset, DMcut_sel,
    DM
);
input Clk, Reset;
input [31:0] Ad;
input [31:0] WrData;
input [1:0] DMcut_sel;
reg [31:0] tmp;
input [2:0]MemWr;
output [31:0] DM; // alias ReadData

reg [31:0] memory[63:0];

// DMWr 控制读还是写
always @(posedge Clk or posedge Reset) begin
    if(Reset)
        $readmemh("E:/github/simple-cpu/code/resetfile/dm.txt", memory);
        //$readmemb("/home/fky/code/git/mine/simple-cpu/code/resetfile/dm.txt", memory);
    else if(MemWr == 1)
    // 若写使能为1，则写入memory[Addr]
        memory[Ad] <= WrData;
    else if(MemWr == 2)
        memory[Ad][7:0] <= WrData[7:0];
    else if(MemWr == 3)
    begin
        memory[Ad] <= WrData;
        tmp = 1; // TODO atomic?
    end
    else if(MemWr == 4)
        memory[Ad][15:0] <= WrData[15:0];
    else
    // 否则读出
        tmp <= memory[Ad];
end

assign DM = (DMcut_sel == 0)? tmp:
            (DMcut_sel == 1)? {24'b0,tmp[7:0]}:
            (DMcut_sel == 2)? {16'b0,tmp[15:0]}:
            tmp;
endmodule // dm