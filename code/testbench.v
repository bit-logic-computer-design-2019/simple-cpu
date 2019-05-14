`timescale 1ns/1ps

module testbench();
    reg Clk;
    reg Reset;
    reg [31:0] result;
    reg [7:0] tempi;
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
        #1000000 Clk = ~ Clk;
      
    always @(posedge Clk)
    #1000000
    begin
    $display("opcode = %h", mips1.instruction[31:26]);
    $display("funct = %h", mips1.instruction[5:0]);
    $display("PC = %h", mips1.PC);
    $display("NPC = %h", mips1.NPC);
    $display("ALUctr = %b", mips1.ALUctr);
    $display("A = %h, B = %h",mips1.alu1.A, mips1.alu1.B);
    $display("ALU = %h", mips1.ALU);
    $display("RegWr = %b", mips1.RegWr);
    for(tempi=0;tempi<32;tempi=tempi+1)
        $display("R%d = %h",tempi,mips1.regfile1.regHeap[tempi]);
    $display("Reset = %d", Reset);

    if ( mips1.im1.txt[0] == 32'h3c10ffff) begin
        $display("success.");
    end
    else begin
        $display("error.");
    end
    Reset = 1'b0;
end
endmodule