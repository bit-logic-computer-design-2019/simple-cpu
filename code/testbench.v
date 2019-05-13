`timescale 1ns/1ps

module testbench();
    reg Clk;
    reg Reset;
    reg [31:0] result;

    mips mips1(.Clk(Clk),.Reset(Reset));

    initial begin
        Reset = 1'b0;
        Clk = 1'b0;

        #30 Reset = 1'b1;
//     result = mips1.im1.txt[0];

        // result = mips1.im1.txt[1];    //指令写完了加一行这个@32(表示下一行是第50行....)
        $monitor("Time %t, R16 = %h", $realtime, mips1.regfile1.regHeap[16]);
        $monitor("im1 = %h", mips1.im1.txt[0] );
    end 

    always
        #20 Clk = ~ Clk;
      
    always @(posedge Clk)
    #2000000
    
    if ( mips1.im1.txt[0] == 32'h3c10ffff) begin
        $display("success.");
    end
    else begin
        $display("error.");
    end


endmodule