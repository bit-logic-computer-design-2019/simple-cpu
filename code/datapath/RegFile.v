`timescale 1ns/1ps

module RegFile(
    RS1, RS2, RD, WData, RegWr, Clk, Reset, PC,
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
input [31:0] WData, PC;
input RegWr, Clk, Reset; // RegWr 写-使能
output [31:0] RD1, RD2;

reg [31:0] regHeap[31:0];

assign RD1 = (RS1 == 5'd0) ? 32'd0 : regHeap[RS1];
assign RD2 = (RS2 == 5'd0) ? 32'd0 : regHeap[RS2];

// RegWr 为控制写的使能
always @(posedge Clk or posedge Reset) begin
    if (Reset)
        $readmemh("E:/github/simple-cpu/code/resetfile/regHeap.txt", regHeap); //系统任务从指定文件中读取数据到存储器
        //$readmemb("/home/fky/code/git/mine/simple-cpu/code/resetfile/dm.txt", memory);
    else if (RegWr)
        // $monitor($time, " RegHeap[0] = %h", mips1.regfile1.regHeap[0]);
        // $monitor($time, " RegHeap[1] = %h", mips1.regfile1.regHeap[1]);      
        // $monitor($time, " RegHeap[2] = %h", mips1.regfile1.regHeap[2]);
        // $monitor($time, " RegHeap[3] = %h", mips1.regfile1.regHeap[3]);
        // $monitor($time, " RegHeap[4] = %h", mips1.regfile1.regHeap[4]);
        // $monitor($time, " RegHeap[5] = %h", mips1.regfile1.regHeap[5]);
        // $monitor($time, " RegHeap[6] = %h", mips1.regfile1.regHeap[6]);
        // $monitor($time, " RegHeap[7] = %h", mips1.regfile1.regHeap[7]);
        // $monitor($time, " RegHeap[8] = %h", mips1.regfile1.regHeap[8]);
        // $monitor($time, " RegHeap[9] = %h", mips1.regfile1.regHeap[9]);
        // $monitor($time, " RegHeap[10] = %h", mips1.regfile1.regHeap[10]);
        // $monitor($time, " RegHeap[11] = %h", mips1.regfile1.regHeap[11]);
        // $monitor($time, " RegHeap[12] = %h", mips1.regfile1.regHeap[12]);
        // $monitor($time, " RegHeap[13] = %h", mips1.regfile1.regHeap[13]);
        // $monitor($time, " RegHeap[14] = %h", mips1.regfile1.regHeap[14]);
        // $monitor($time, " RegHeap[15] = %h", mips1.regfile1.regHeap[15]);
        // $monitor($time, " RegHeap[16] = %h", mips1.regfile1.regHeap[16]);
        // $monitor($time, " RegHeap[17] = %h", mips1.regfile1.regHeap[17]);
        // $monitor($time, " RegHeap[18] = %h", mips1.regfile1.regHeap[18]);
        // $monitor($time, " RegHeap[19] = %h", mips1.regfile1.regHeap[19]);      
        // $monitor($time, " RegHeap[20] = %h", mips1.regfile1.regHeap[20]);
        // $monitor($time, " RegHeap[21] = %h", mips1.regfile1.regHeap[21]);
        // $monitor($time, " RegHeap[22] = %h", mips1.regfile1.regHeap[22]);
        // $monitor($time, " RegHeap[23] = %h", mips1.regfile1.regHeap[23]);
        // $monitor($time, " RegHeap[24] = %h", mips1.regfile1.regHeap[24]);
        // $monitor($time, " RegHeap[25] = %h", mips1.regfile1.regHeap[25]);
        // $monitor($time, " RegHeap[26] = %h", mips1.regfile1.regHeap[26]);
        // $monitor($time, " RegHeap[27] = %h", mips1.regfile1.regHeap[27]);
        // $monitor($time, " RegHeap[28] = %h", mips1.regfile1.regHeap[28]);
        // $monitor($time, " RegHeap[29] = %h", mips1.regfile1.regHeap[29]);
        // $monitor($time, " RegHeap[30] = %h", mips1.regfile1.regHeap[30]);
        // $monitor($time, " RegHeap[31] = %h", mips1.regfile1.regHeap[31]);
        $monitoron;
        regHeap[RD] <= WData;
end

endmodule // RegFile