module RegFile(
    RS1,RS2,RD,WData,RegWr,Clk,Reset,
    RD1,RD2
);

input [4:0] RS1,RS2, RD;
input [31:0] WData;
input RegWr, Clk, Reset;
output [31:0] RD1, RD2;

// RegWr 为控制写的使能
always @(posedge Clk and RegWr) begin

end

// TODO

endmodule // RegFile