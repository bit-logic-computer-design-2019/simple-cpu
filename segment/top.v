`timescale 1ns / 1ps

module top(
    input        clk,
    input      rst_n,
    output    wire [6:0] seg7_0_7bit,
   output   wire  [6:0] seg7_1_7bit,
   output   wire  [3:0] seg7_0_an,
   output    wire [3:0] seg7_1_an,
   output   wire  seg7_0_dp,
   output    wire seg7_1_dp
//   output  wire[31:0] testv
//   output  count;
    );
    
    wire [31:0] testv;
    reg  [31:0] count;

    reg m_clk;

    always@(posedge clk or negedge rst_n) begin
      if(!rst_n) begin
        count = 32'd0;
        m_clk = 1'b0;
      end
      else begin
        count = count + 1'b1;
        if(count == 4'd10) begin
          count = 32'd0;
          m_clk = ~m_clk;
        end
      end
    end

    mips mips1(.Clk(m_clk),.Reset(rst_n),.CPU_out(testv));

//分频
/*    always @(posedge clk ) 
        begin
	   if (rst_n) 
	       begin
		// reset
		  cnt <= 0;
	         end
	    else if (cnt == 100) 
	       begin
		      cnt <= 0;
	       end
	     else 
	       begin
		  cnt <= cnt + 1;
	       end
end  

always @(posedge clk ) 
    begin
	if (rst_n) 
	   begin
		// reset
		clk_out <= 0;
	end
	else if (cnt == 100) 
	       begin
		clk_out <= !clk_out;
	end
end  */

    // always @(posedge clk )
    //     begin 
    //         if(!rst_n )
    //             testv = 32'h1234abcd;
    //           else
    //             testv = testv + 1;
    //     end  
    
    seg7decimal seg7_0(
        .x          (testv[31:16]),
        .clk        (clk),
        .rst_n        (rst_n),
        .a_to_g     (seg7_0_7bit),
        .an         (seg7_0_an),
        .dp         (seg7_0_dp)
        );
    
      seg7decimal seg7_1(
        .x          (testv[15:0]),
        .clk        (clk),
        .rst_n        (rst_n),
        .a_to_g     (seg7_1_7bit),
        .an         (seg7_1_an),
        .dp         (seg7_1_dp)
        );    
    
endmodule
