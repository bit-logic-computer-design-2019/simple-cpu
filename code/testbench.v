`timescale 1ns/1ps

module testbench();
    reg Clk;
    reg Reset;
    reg [31:0] result;
    reg [7:0] tempi;
    wire [31:0] CPU_out;
    wire [6:0] seg7_0_7bit;
    wire  [6:0] seg7_1_7bit;
    wire  [3:0] seg7_0_an;
    wire [3:0] seg7_1_an;
    wire  seg7_0_dp;
    wire seg7_1_dp;

    mips mips1(.Clk(Clk),.Reset(Reset),.CPU_out(CPU_out));
    seg7decimal seg7_0(
        .x          (CPU_out[31:16]),
        .clk        (Clk),
        .rst_n        (Reset),
        .a_to_g     (seg7_0_7bit),
        .an         (seg7_0_an),
        .dp         (seg7_0_dp)
        );
    
      seg7decimal seg7_1(
        .x          (CPU_out[15:0]),
        .clk        (Clk),
        .rst_n        (Reset),
        .a_to_g     (seg7_1_7bit),
        .an         (seg7_1_an),
        .dp         (seg7_1_dp)
        ); 

    initial begin
        Reset = 1'b0;
        Clk = 1'b0;
       
        #30 Reset = 1'b1;
//     result = mips1.im1.txt[0];

        // result = mips1.im1.txt[1];    //指令写完了加�?行这个@32(表示下一行是�?50�?....)
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