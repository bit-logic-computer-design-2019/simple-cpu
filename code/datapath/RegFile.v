module RegFile(
    RS1, RS2, RD, WData, RegWr, Clk, Reset,
    RD1, RD2
);
// The 32-element x 32-bit register file has two read ports and one write
// port. The read ports take 5-bit address inputs, A1 and A2, each specifying
// one of 2 5 x 32 registers as source operands. They read the 32-bit register
// values onto read data outputs RD1 and RD2, respectively. The write port
// takes a 5-bit address input, A3; a 32-bit write data input, WD; a write
// enable input, WE3; and a clock. If the write enable is 1, the register file
// writes the data into the specified register on the rising edge of the clock.
input [4:0] RS1, RS2, RD;
input [31:0] WData;
input RegWr, Clk, Reset; // RegWr �?-使能
output [31:0] RD1, RD2;

reg [31:0] regHeap[31:1];

assign RD1 = (RS1 == 5'd0) ? 32'd0 : regHeap[RS1];
assign RD2 = (RS2 == 5'd0) ? 32'd0 : regHeap[RS1];

// RegWr 为控制写的使�?
always @(posedge Clk or posedge Reset) begin
    if (Reset)
        $readmemb("E:/gitHub/simple-cpu/code/resetfile/regHeap.txt", regHeap); //系统任务从指定文件中读取数据到存储器
    else if (RegWr)
        regHeap[RD] <= WData;
end

endmodule // RegFile