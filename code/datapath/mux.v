module mux2_1(
    input0, input1, Select,
    out
);
input input0, input1, Select;
output out;

assign out = (Select == 0) ? input0 : input1;

endmodule

// 2选1 5bits
module mux2_1_5(
    input0, input1, Select,
    out
);
input [4:0] input0,input1;
input Select;
output [4:0]out;

assign out = (Select == 0) ? input0:input1; 
endmodule // mux2_1_5

// 2 to 1   32 bits
module mux2_1_32(
    input0, input1, Select,
    out
);
input [31:0] input0,input1;
input Select;
output [31:0]out;

assign out = (Select == 0) ? input0:input1; 
endmodule // mux2_1_5