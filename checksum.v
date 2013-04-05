module checksum 
#(parameter IN_DATA_WIDTH = 17,
  parameter OUT_DATA_WIDTH = 21
)
(
input clk ,
input reset ,
input in_data_vld ,
input [IN_DATA_WIDTH-1:0] in_data ,
input [3:0] polynomial ,
output  [OUT_DATA_WIDTH-1:0] out_data ,
output  out_data_vld 
) ;

wire [OUT_DATA_WIDTH-1:0] out_data1 ;
wire [OUT_DATA_WIDTH-1:0] out_data2 ;
wire [OUT_DATA_WIDTH-1:0] out_data3 ;
wire [OUT_DATA_WIDTH-1:0] out_data4 ;
wire [OUT_DATA_WIDTH-1:0] out_data5 ;
wire [OUT_DATA_WIDTH-1:0] out_data6 ;
wire [OUT_DATA_WIDTH-1:0] out_data7 ;
wire [OUT_DATA_WIDTH-1:0] out_data8 ;
wire [OUT_DATA_WIDTH-1:0] out_mux ;
wire [OUT_DATA_WIDTH-1:0] out_mux_modified ;
wire [OUT_DATA_WIDTH-1:0] out_i_shifter ;

wire [2:0] select_lines ;
wire [1:0] i_shifter_count ;
wire select_line_vld ;
wire polynomial_zero ;

reg [IN_DATA_WIDTH-1:0] in_data_latch ;

assign out_data = out_i_shifter ;
assign out_data_vld = select_line_vld ;
assign out_mux_modified = polynomial_zero ? 0 : out_mux ;

always @ (posedge clk) begin 
	if(reset)begin
		in_data_latch <= 0 ;
	end
	else begin
		in_data_latch <= in_data ;
	end
end

header_8_spliter header_8_spliter_uut (
.in_data  (in_data_latch),
.out_data1(out_data1), 
.out_data2(out_data2), 
.out_data3(out_data3), 
.out_data4(out_data4), 
.out_data5(out_data5), 
.out_data6(out_data6), 
.out_data7(out_data7), 
.out_data8(out_data8)
);

mux_8X1 mux_8X1_uut(
.in0          (out_data1),
.in1          (out_data2),
.in2          (out_data3),
.in3          (out_data4),
.in4          (out_data5),
.in5          (out_data6),
.in6          (out_data7),
.in7          (out_data8),
.out          (out_mux),
.select_lines (select_lines)
);

shifter shifter_uut (
.clk            (clk            ),
.reset          (reset          ),
.polynomial     (polynomial     ),
.in_data_vld    (in_data_vld    ),
.select_line    (select_lines    ),
.select_line_vld(select_line_vld),
.i_shifter_count(i_shifter_count),
.polynomial_zero(polynomial_zero)
);


i_shifter i_shifter_uut (
.select_line_vld   (select_line_vld ),
.i_shifter_count   (i_shifter_count ),
.in_data           (out_mux_modified),
.out_data          (out_i_shifter       )
);
always @ (posedge clk) begin 
if(!reset)begin
	if(select_line_vld) begin
		//$display("select_lines %d",select_lines);
		//$display("out_mux %d",out_mux) ;
	end
end
end

endmodule
