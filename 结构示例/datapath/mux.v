module mux2_1(
    input0, input1, Select,
    out
);

assign out = (Select == 0) ? input0 : input1;

endmodule