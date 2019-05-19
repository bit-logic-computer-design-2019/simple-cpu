`timescale 1ns/1ps

module testbench();
    reg Clk;
    reg Reset;

    wire [6:0] seg7_0_7bit;
    wire  [6:0] seg7_1_7bit;
    wire  [3:0] seg7_0_an;
    wire [3:0] seg7_1_an;
    wire  seg7_0_dp;
    wire seg7_1_dp;

    top top1(
        .clk(Clk),
        .rst_n(Reset),
        .seg7_0_7bit(seg7_0_7bit),
        .seg7_1_7bit(seg7_1_7bit),
        .seg7_0_an(seg7_0_an),
        .seg7_1_an(seg7_1_an),
        .seg7_0_dp(seg7_0_dp),
        .seg7_1_dp(seg7_1_dp)
    );

    initial begin
        Reset = 1'b1;
        Clk = 1'b0;
        Reset = 1'b0;
        #5 Reset = 1'b1;   
    end 

    always
        #10 Clk = ~ Clk;

endmodule