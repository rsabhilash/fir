module comp_share_combined_top
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

localparam OUT_DATA_WIDTH = 21 ;

reg [SUM_WIDTH-1:0] out_data_pre_cal; 

wire [OUT_DATA_WIDTH-1:0] x1 ;
wire [OUT_DATA_WIDTH-1:0] x3 ;
wire [OUT_DATA_WIDTH-1:0] x5 ;
wire [OUT_DATA_WIDTH-1:0] x7 ;
wire [OUT_DATA_WIDTH-1:0] x9 ;
wire [OUT_DATA_WIDTH-1:0] x11 ;
wire [OUT_DATA_WIDTH-1:0] x13 ;
wire [OUT_DATA_WIDTH-1:0] x15 ;


comp_share_combined_block comp_share_combined_block (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial  ),
.x1          (x1          ),
.x3          (x3          ),
.x5          (x5          ),
.x7          (x7          ),
.x9          (x9          ),
.x11         (x11         ),
.x13         (x13         ),
.x15         (x15         ),
.out_data    (out_data    ),
.out_data_vld(out_data_vld)
);


precomputer precomputer_uut (
.in_data  (in_data),
.x1(x1), 
.x3(x3), 
.x5(x5), 
.x7(x7), 
.x9(x9), 
.x11(x11), 
.x13(x13), 
.x15(x15)
);


endmodule
