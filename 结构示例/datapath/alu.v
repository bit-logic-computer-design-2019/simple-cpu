`timescale  1ns/1ns 

/*   
add   001 
sub   011
ori    010
lw     110
sw     111
beq   101
*/

module alu(
    A, B, ALUctrl,
    ALU, zero, carrier
);

input   [31:0]          A;                  // the 1st input data
input   [31:0]          B;                  // the 2nd input data
input   [2:0]           ALUctrl;               
output  [31:0]          ALU;                  // calculation result 
output                  carrier;   
output                  zero;            

reg     [32:0]          tmp; 

assign  ALU           = tmp[31:0] ;
assign  carrier        = (tmp[32]==1) ? 1 : 0 ;
assign  zero      =  (tmp[31:0]==0) ? 1 : 0 ;

always  @( * )
	case (ALUctrl)
	
		3'b001, 3'b110, 3'b111      :   tmp   <= {A[31], A} + {B[31], B} ;//add
		3'b011, 3'b101   :   tmp   <= {A[31], A} - {B[31], B};//sub
		3'b010    :   tmp   <={A[31], A} | {B[31], B}; //ori
	   
		default     :   tmp   <= B ;
	endcase


endmodule // alu  
