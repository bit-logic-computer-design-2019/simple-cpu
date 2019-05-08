module RegFile(
    RS1,RS2,RD,WData,RegWr,Clk,Reset,
    RD1,RD2
);
// The 32-element x 32-bit register file has two read ports and one write
// port. The read ports take 5-bit address inputs, A1 and A2, each specifying
// one of 2 5 x 32 registers as source operands. They read the 32-bit register
// values onto read data outputs RD1 and RD2, respectively. The write port
// takes a 5-bit address input, A3; a 32-bit write data input, WD; a write
// enable input, WE3; and a clock. If the write enable is 1, the register file
// writes the data into the specified register on the rising edge of the clock.
input [4:0] RS1,RS2, RD;
input [31:0] WData;
input RegWr, Clk, Reset; // RegWr 写-使能
output [31:0] RD1, RD2;

reg [31:0] regHeap[31:1];

// RegWr 为控制写的使能
always @(posedge Clk) begin
    RD1 = regHeap[RS1];
    RD2 = regHeap[RS2];
    if (RegWr)
        regHeap[RD] = WData;
end

endmodule // RegFile