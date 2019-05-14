`timescale  1ns/1ns 

/*  
ALUctr 
	add 010 
    sub 110
    | 001
*/

module alu(
    A, B, ALUctr,
    ALU, Zero, carrier
);

input   [31:0]          A;                  // the 1st input data
input   [31:0]          B;                  // the 2nd input data
input   [2:0]           ALUctr;               
output  [31:0]          ALU;                  // calculation result 
output                  carrier;   
output                  Zero;            

reg     [32:0]          tmp; 

assign  ALU = tmp[31:0] ;
assign  carrier = (tmp[32]==1) ? 1 : 0 ;
assign  Zero = (tmp[31:0]==0) ? 1 : 0 ;

always  @( * )
	case (ALUctr)
	
		3'b010 : tmp = {A[31], A} + {B[31], B} ;//add lw sw
		3'b110 : tmp = {A[31], A} - {B[31], B};//sub
		3'b001 : tmp = {A[31], A} | {B[31], B}; //ori
		3'b000 : tmp = {A[31], A} & {B[31], B};// and

		3'b101 : tmp = {1'b0,A};
		3'b111 : tmp = {1'b0,B}; // 选择B
		default : tmp = B;

	endcase


endmodule // alu  
