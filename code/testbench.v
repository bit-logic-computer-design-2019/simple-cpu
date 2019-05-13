module testbench();
    reg Clk;
    reg Reset;
    reg [31:0] result;

    mips mips1(.Clk(Clk),.Reset(Reset));

    initial begin
        Reset = 1'b0;
        Clk = 1'b0;

        #30 Reset = 1'b1;

        result = mips1.im1.text[50];    //指令写完了加一行这个@32(表示下一行是第50行....)
        $monitor("Time %t, R16 = %h", $realtime, mips1.regfile1.regHeap[16]);
        
    end 

    always
        #20 Clk = ~ Clk;

    always @(posedge Clk)
    #200
    if (result == mips1.regfile1.regHeap[16]) begin
        $display("success.\n");
    end
    else begin
        $display("error.\n");
    end


endmodule