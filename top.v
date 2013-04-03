module top(
input clk ,
input reset ,
input [7:0] in_data ,
output [7:0] out_data
) ;
wire [7:0] c0,c1,c2,c3 ;

wire [7:0] out_mu1,out_mu2,out_mu3,out_mu4 ;
wire [7:0] out_de1,out_de2,out_de3,out_de4 ;
wire [7:0] out_de5,out_de6,out_de7 ;
wire [7:0] in_de5,in_de6,in_de7 ;
wire [7:0] out_ad1,out_ad2,out_ad3,out_ad4 ;
wire [7:0] in1_ad1,in1_ad2,in1_ad3,in1_ad4 ;
wire [7:0] in2_ad1,in2_ad2,in2_ad3,in2_ad4 ;

assign {c0,c1,c2,c3} = {8'd1
					   ,8'd1
					   ,8'd1
					   ,8'd1 } ;

mu mu1 (.in1(in_data),.in2(c0),.out(out_mu1));
mu mu2 (.in1(in_data),.in2(c1),.out(out_mu2));
mu mu3 (.in1(in_data),.in2(c2),.out(out_mu3));
mu mu4 (.in1(in_data),.in2(c3),.out(out_mu4));

de de1 (.in(out_mu1),.clk(clk),.reset(reset),.out(out_de1)) ;
de de2 (.in(out_mu2),.clk(clk),.reset(reset),.out(out_de2)) ;
de de3 (.in(out_mu3),.clk(clk),.reset(reset),.out(out_de3)) ;
de de4 (.in(out_mu4),.clk(clk),.reset(reset),.out(out_de4)) ;

ad ad1 (.in1(in1_ad1),.in2(out_de1),.out(out_data)) ;
ad ad2 (.in1(in1_ad2),.in2(out_de2),.out(in_de5)) ;
ad ad3 (.in1(in1_ad3),.in2(out_de3),.out(in_de6)) ;
ad ad4 (.in1(0),.in2(out_de4),.out(in_de7)) ;

de de5 (.in(in_de5),.clk(clk),.reset(reset),.out(in1_ad1)) ;
de de6 (.in(in_de6),.clk(clk),.reset(reset),.out(in1_ad2)) ;
de de7 (.in(in_de7),.clk(clk),.reset(reset),.out(in1_ad3)) ;

endmodule

/*
   *            1      		2          	3          4 
   *            1      		2          	3          4 
				1	5		2	6		3	7	   4
   */
