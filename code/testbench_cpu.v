`timescale 1ns/1ps

module testbench();
    reg Clk;
    reg Reset;
    reg [7:0] tempi;

    mips mips1(.Clk(Clk),.Reset(Reset));

    initial begin
        Reset = 1'b0;
        Clk = 1'b0;
        Reset = 1'b1;
        #3 Reset = 1'b0;

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
        // $monitor($time, " im0 = %h", mips1.im1.txt[0]);
        // $monitor($time, " im1 = %h", mips1.im1.txt[1]);
        // $monitor($time, " opcode = %h", mips1.instruction[31:26]);
        // $monitor($time, " funct = %h", mips1.instruction[5:0]);
        // $monitor($time, " instruction = %h", mips1.instruction[31:0]);
        // $monitor($time, " PC = %h", mips1.PC);
        // $monitor($time, " NPC = %h", mips1.NPC);
        // $monitor($time, " ALUctr = %b", mips1.ALUctr);
        // $monitor($time, " A = %h, B = %h",mips1.alu1.A, mips1.alu1.B);
        // $monitor($time, " ALU = %h", mips1.ALU);
        // $monitor($time, " RegWr = %b", mips1.RegWr);
        // $monitor($time, " RD = %b", mips1.RD);
        // $monitor($time, " WData = %h", mips1.WData);

        // forever #5 Clk = ~ Clk;

        //$monitor($time, " RegHeap[2] = %h",mips1.regfile1.regHeap[2]);
        // result = mips1.im1.txt[0];
        // result = mips1.im1.txt[1];    //指令写完了加�???????行这个@32(表示下一行是�???????50�???????....)
        //$monitor("Time %t, R16 = %h", $realtime, mips1.regfile1.regHeap[16]);
                
    end 

    // always
    //     #5 $display($time, " PC = %h NPC = %h", mips1.PC, mips1.NPC);
    always
        #5 Clk = ~ Clk;
    always @(posedge Clk or posedge Reset)
    //  #200
    #4
    begin
    // $display("opcode = %h", mips1.instruction[31:26]);
    // $display("funct = %h", mips1.instruction[5:0]);
    // $display("instruction = %h", mips1.instruction[31:0]);
    // $display("PC = %d", mips1.PC);
    // $display("NPC = %d", mips1.NPC);
    // $display("ALUctr = %b", mips1.ALUctr);
    // $display("A = %h, B = %h",mips1.alu1.A, mips1.alu1.B);
    // $display("ALU = %h", mips1.ALU);
    // $display("RegWr = %b", mips1.RegWr);
    // $display("DM = %h", mips1.DM[31:0]);
    // $display("Imm32 = %h", mips1.imm32[31:0]);
    // $display("Zero = %b", mips.Zero);
    // $display("ExtOp = %b", mips.ExtOp[1:0]);
    // $display("MemWr = %b", mips1.MemWr[2:0]);
    // $display("nPC_sel = %b", mips1.nPC_sel[2:0]);
    // $display("MemtoReg = %b", mips1.MemtoReg[1:0]);
    // $display("WData = %h", mips1.WData);
    // $display("RD = %b", mips1.RD);
    // for(tempi = 0 ; tempi < 32 ; tempi = tempi + 1)
    //     $display("R%d = %h", tempi, mips1.regfile1.regHeap[tempi]);
    // $display("M:a = %d", {mips1.mem1.memory[16'hffe8], mips1.mem1.memory[16'hffe9], mips1.mem1.memory[16'hffea], mips1.mem1.memory[16'hffeb]});
    $monitor("M:b = %d", {mips1.mem1.memory[16'hffec], mips1.mem1.memory[16'hffed], mips1.mem1.memory[16'hffee], mips1.mem1.memory[16'hffef]});
    $monitoron;
    //$display("M:count = %d", {mips1.mem1.memory[16'hfff0], mips1.mem1.memory[16'hfff1], mips1.mem1.memory[16'hfff2], mips1.mem1.memory[16'hfff3]});
    //$display("M:t = %d", {mips1.mem1.memory[16'hfff4], mips1.mem1.memory[16'hfff5], mips1.mem1.memory[16'hfff6], mips1.mem1.memory[16'hfff7]});
    //$display($time,"\n");
    // for(tempj = 16'hffff ; tempj > 16'hffe0 ; tempj = tempj - 1)
    //     $display("M%d = %h", tempj, mips1.mem1.memory[tempj]);
    // $display("\n");
    //$display("Reset = %d", Reset);

    //  if ( mips1.im1.txt[0] == 32'h3c10ffff) begin
    //      $display("success.");
    //  end
    //  else begin
    //      $display("error.");
    //  end
    // Reset = 1'b0;
end
endmodule