module checksum_top 
#(
parameter IN_DATA_WIDTH = 17,
parameter SUM_WIDTH = 34 ,
parameter POLY_WIDTH = 17
)
(
input clk ,
input reset ,
input in_data_vld ,
input [IN_DATA_WIDTH-1:0] in_data ,
input [POLY_WIDTH-1:0] polynomial ,
output  [SUM_WIDTH-1:0] out_data ,
output  out_data_vld
);

reg [SUM_WIDTH-1:0] out_data_pre_cal; 

wire [20:0] out_data_0,out_data_1,out_data_2,out_data_3 ;
wire [32:0] out_data_0_shifted,out_data_1_shifted,out_data_2_shifted,out_data_3_shifted ;
wire out_data_vld_0, out_data_vld_1, out_data_vld_2, out_data_vld_3 ;
assign out_data_vld = out_data_vld_0& out_data_vld_1& out_data_vld_2& out_data_vld_3 ;

assign out_data_3_shifted = {out_data_3,12'b0} ;
assign out_data_2_shifted = {out_data_2,8'b0} ;
assign out_data_1_shifted = {out_data_1,4'b0} ;
assign out_data_0_shifted = {out_data_0} ;

checksum checksum0 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial[3:0]),
.out_data    (out_data_0   ),
.out_data_vld(out_data_vld_0)
			 );
checksum checksum1 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial[7:4]),
.out_data    (out_data_1   ),
.out_data_vld(out_data_vld_1)
			 );
checksum checksum2 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial[11:8]),
.out_data    (out_data_2   ),
.out_data_vld(out_data_vld_2)
			 );
checksum checksum3 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial[15:12]),
.out_data    (out_data_3   ),
.out_data_vld(out_data_vld_3)
			 );

four_adder four_adder (
.in_data_0(out_data_0_shifted),
.in_data_1(out_data_1_shifted),
.in_data_2(out_data_2_shifted),
.in_data_3(out_data_3_shifted),
.poly_sign(polynomial[16]),
.sum_four(out_data)
				);

//always @ (posedge clk) begin : debug
//	if(!reset)begin
//		if(out_data_vld_0 & out_data_vld_1 & out_data_vld_2 & out_data_vld_3) begin 	
//			$display("%b%b%b%b",out_data_vld_0,out_data_vld_1,out_data_vld_2,out_data_vld_3) ;
//			$display("%d %d %d %d",out_data_0,out_data_1,out_data_2,out_data_3) ;
//			$display("%b %b %b %b",out_data_0,out_data_1,out_data_2,out_data_3) ;
//			out_data_pre_cal = {out_data_3,12'b0} + {out_data_2,8'b0} + {out_data_1,4'b0} + out_data_0 ;
//			if(polynomial[16]) begin
//				out_data_pre_cal = ~out_data_pre_cal +1 ;
//			end
//			$display("TOP:out_data_pre_cal %d",out_data_pre_cal) ;
//			$stop ;
//		end
//	end
//end


endmodule
