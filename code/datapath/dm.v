//数据储存
module Datamemory(
    Ad, WrData, MemWr, Clk, Reset, DMcut_sel,
    DM
);
input Clk, Reset;
input [15:0] Ad;    //寻址范围�?0-65536(16'hffff) 高位截断(默认不会超出寻址范围�?....)
input [31:0] WrData; 
input [1:0] DMcut_sel;
input [2:0]MemWr;
output [31:0] DM; // alias ReadData

reg [7:0] memory[16'hffff:16'hff00];
//reg [7:0] memory[8'hff:8'h00];
wire [31:0] tmp;

// DMWr 控制读还是写
always @(posedge Clk or negedge Reset) begin
    if(!Reset)
        // $readmemb("E:/github/simple-cpu/code/resetfile/dm.txt", memory);
        $readmemb("/home/fky/code/git/mine/simple-cpu/code/resetfile/dm.txt", memory);
    else if(MemWr == 1)
    // 若写使能�??1，则写入memory[Addr]
        {memory[Ad], memory[Ad + 1'b1], memory[Ad + 2'b10], memory[Ad + 2'b11]} <= WrData;
    else if(MemWr == 2)
        memory[Ad] <= WrData[7:0];
    else if(MemWr == 3)
    begin
        {memory[Ad], memory[Ad + 1'b1], memory[Ad + 2'b10], memory[Ad + 2'b11]} <= WrData;
    end
    else if(MemWr == 4)
        {memory[Ad + 2'b10], memory[Ad + 2'b11]} <= WrData[15:0];

end

assign tmp = (MemWr == 3) ? 32'd1 : {memory[Ad], memory[Ad + 1'b1], memory[Ad + 2'b10], memory[Ad + 2'b11]};
assign DM = (DMcut_sel == 0)? tmp:
            (DMcut_sel == 1)? {24'd0,tmp[7:0]}:
            (DMcut_sel == 2)? {16'd0,tmp[15:0]}:
            tmp;
endmodule // dm