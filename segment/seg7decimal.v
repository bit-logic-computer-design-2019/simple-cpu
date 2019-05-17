`timescale 1ns / 1ps

module seg7decimal(
input [15:0] x,                //被显示的数，四位十六进制数                 
input clk,
input rst_n,                  //重置
output reg [6:0] a_to_g,      //输出，即该位的数字
output reg [3:0] an,          //输出，即选择哪位数字
output wire dp 
);


wire [1:0] s;     
reg [3:0] digit;
wire [3:0] aen;
reg [19:0] clkdiv;

assign dp = 0;
assign s = clkdiv[19:18];
assign aen = 4'b1111; // all turned off initially

always @(posedge clk)// or posedge clr)

case(s)
0:digit = x[3:0]; // digit gets assigned 4 bit value assigned to x[3:0]
1:digit = x[7:4]; //  digit gets assigned 4 bit value assigned to x[7:4]
2:digit = x[11:8]; //  digit gets assigned 4 bit value assigned to x[11:8
3:digit = x[15:12]; // digit gets assigned 4 bit value assigned to x[15:12]

default:digit = x[3:0];

endcase

//decoder or truth-table for 7a_to_g display values
always @(*)

case(digit)
//////////////gfedcba////////////////////////////////////////////   
//对于该数，在一个“8”上显示出来，其中字母是小写    
0:a_to_g = 7'b0111111;                                                                      
1:a_to_g = 7'b0000110;                                               
2:a_to_g = 7'b1011011;                                                                                                                           
3:a_to_g = 7'b1001111;                                            
4:a_to_g = 7'b1100110;                                                
5:a_to_g = 7'b1101101;                                             
6:a_to_g = 7'b1111101;
7:a_to_g = 7'b0000111;
8:a_to_g = 7'b1111111;
9:a_to_g = 7'b1101111;
'hA:a_to_g = 7'b1011111; 
'hB:a_to_g = 7'b1111100;
'hC:a_to_g = 7'b1011000;
'hD:a_to_g = 7'b1011110; 
'hE:a_to_g = 7'b1111001; 
'hF:a_to_g = 7'b1110001;
default: a_to_g = 7'b1111111;

endcase


always @(*)begin
an=4'b0000;
if(aen[s] == 1)
an[s] = 1;
end


//clkdiv

always @(posedge clk or negedge rst_n) begin
if ( !rst_n )
clkdiv <= 0;
else
clkdiv <= clkdiv+1;
end


endmodule
