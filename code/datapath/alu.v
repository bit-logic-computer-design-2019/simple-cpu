`timescale  1ns/1ns 

/*  
ALUctr 
	add 010 
    sub 110
    | 001
*/

module alu(
    A, B, ALUctr, shamt,
    ALU, Zero, carrier
);

input   [31:0]          A;                  // the 1st input data
input   [31:0]          B;                  // the 2nd input data
input   [3:0]           ALUctr;       
input   [4:0] shamt;        
output  [31:0]          ALU;                  // calculation result 
output                  carrier;   
output                  Zero;            

reg     [32:0]          tmp; 

assign  ALU = tmp[31:0] ;
assign  carrier = (tmp[32]==1) ? 1 : 0 ;
assign  Zero = (tmp[31:0]==0) ? 1 : 0 ;

always  @( * )
	case (ALUctr)
	
		4'b0010 : tmp = {A[31], A} + {B[31], B} ;// add
		4'b0110 : tmp = {A[31], A} - {B[31], B};// sub
		4'b0001 : tmp = {A[31], A} | {B[31], B}; // or
		4'b0000 : tmp = {A[31], A} & {B[31], B};// and
		4'b0011 : tmp = ~({A[31], A} | {B[31], B}); // nor
		4'b0100 : tmp = (A<B)? 1:0; //TODO
		4'b1000 : tmp = {0,A} << shamt;
		4'b1001 : tmp = {0,A} >> shamt;
		4'b0101 : tmp = {1'b0,A};
		4'b0111 : tmp = {1'b0,B}; // 选择B
		default : tmp = B;

	endcase


endmodule // alu  
