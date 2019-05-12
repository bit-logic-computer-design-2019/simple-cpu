// 零扩展，左边�?0
module ext(
    input [15:0] imm16, ExtOp,
    output [31:0] imm32
);

assign imm32[15:0] = imm16;
assign imm32[31:16] = 16'h0000;

endmodule // ext  