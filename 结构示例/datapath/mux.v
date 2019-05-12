module mux2_1(
    input0, input1, Select,
    out
);
input input0, input1, Select;
output out;

assign out = (Select == 0) ? input0 : input1;

endmodule