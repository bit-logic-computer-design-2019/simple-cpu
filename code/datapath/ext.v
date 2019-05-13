//零拓展成32位
module ext(
    input [15:0] imm16, [1:0]ExtOp,
    output [31:0] imm32
);



assign imm32 = (ExtOp == 2'b00)?{16'h0,imm16}:
                (ExtOp == 2'b01)?{{16{imm16[15]}},imm16}:
                (ExtOp == 2'b10)?{imm16,16'h0}:
                32'h0;

endmodule // ext  