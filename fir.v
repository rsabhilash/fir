module fir(
input clk ,
input reset ,
input [16:0] x_in ,
input in_data_vld ,
input [16:0] c0 ,
input [16:0] c1 ,
input [16:0] c2 ,
input [16:0] c3 ,
output [35:0] y_out
);


localparam OUT_DATA_WIDTH = 21 ;

wire [35:0] product0 ;
wire [35:0] product1 ;
wire [35:0] product2 ;
wire [35:0] product3 ;
wire [33:0] product0_trim ;
wire [33:0] product1_trim ;
wire [33:0] product2_trim ;
wire [33:0] product3_trim ;
wire [35:0] product0_delay ;
wire [35:0] product1_delay ;
wire [35:0] product2_delay ;
wire [35:0] product3_delay ;
wire [35:0] delay1_out ;
wire [35:0] delay2_out ;
wire [35:0] delay3_out ;
wire [35:0] adder1_out ;
wire [35:0] adder2_out ;
wire [35:0] adder3_out ;

assign y_out =  adder1_out ;


wire [OUT_DATA_WIDTH-1:0] x1 ;
wire [OUT_DATA_WIDTH-1:0] x3 ;
wire [OUT_DATA_WIDTH-1:0] x5 ;
wire [OUT_DATA_WIDTH-1:0] x7 ;
wire [OUT_DATA_WIDTH-1:0] x9 ;
wire [OUT_DATA_WIDTH-1:0] x11 ;
wire [OUT_DATA_WIDTH-1:0] x13 ;
wire [OUT_DATA_WIDTH-1:0] x15 ;

assign product0 = {2'b0,product0_trim} ;
assign product1 = {2'b0,product1_trim} ;
assign product2 = {2'b0,product2_trim} ;
assign product3 = {2'b0,product3_trim} ;


checksum_four fir_mul0 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (x_in    ),
.polynomial  (c0  ),
.x1          (x1          ),
.x3          (x3          ),
.x5          (x5          ),
.x7          (x7          ),
.x9          (x9          ),
.x11         (x11         ),
.x13         (x13         ),
.x15         (x15         ),
.out_data    (product0_trim    ),
.out_data_vld(out_data_vld)
);

checksum_four fir_mul1 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (x_in    ),
.polynomial  (c1  ),
.x1          (x1          ),
.x3          (x3          ),
.x5          (x5          ),
.x7          (x7          ),
.x9          (x9          ),
.x11         (x11         ),
.x13         (x13         ),
.x15         (x15         ),
.out_data    (product1_trim    ),
.out_data_vld(out_data_vld)
);


checksum_four fir_mul2 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (x_in    ),
.polynomial  (c2  ),
.x1          (x1          ),
.x3          (x3          ),
.x5          (x5          ),
.x7          (x7          ),
.x9          (x9          ),
.x11         (x11         ),
.x13         (x13         ),
.x15         (x15         ),
.out_data    (product2_trim    ),
.out_data_vld(out_data_vld)
);


checksum_four fir_mul3 (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (x_in    ),
.polynomial  (c3  ),
.x1          (x1          ),
.x3          (x3          ),
.x5          (x5          ),
.x7          (x7          ),
.x9          (x9          ),
.x11         (x11         ),
.x13         (x13         ),
.x15         (x15         ),
.out_data    (product3_trim    ),
.out_data_vld(out_data_vld)
);



precomputer precomputer_uut (
.in_data(x_in),
.x1(x1), 
.x3(x3), 
.x5(x5), 
.x7(x7), 
.x9(x9), 
.x11(x11), 
.x13(x13), 
.x15(x15)
);

fir_delay fir_delay_product0 (
.clk(clk),
.reset(reset),
.in(product0),
.in_delay(product0_delay)
);


fir_delay fir_delay_product1 (
.clk(clk),
.reset(reset),
.in(product1),
.in_delay(product1_delay)
);


fir_delay fir_delay_product2 (
.clk(clk),
.reset(reset),
.in(product2),
.in_delay(product2_delay)
);


fir_delay fir_delay_product3 (
.clk(clk),
.reset(reset),
.in(product3),
.in_delay(product3_delay)
);


fir_delay fir_delay3 (
.clk(clk),
.reset(reset),
.in(product3_delay),
.in_delay(delay3_out)
);

		
fir_adder fir_adder3 (
.in1(delay3_out),
.in2(product2_delay),
.sum(adder3_out)
);

fir_delay fir_delay2 (
.clk(clk),
.reset(reset),
.in(adder3_out),
.in_delay(delay2_out)
);

		
fir_adder fir_adder2 (
.in1(delay2_out),
.in2(product1_delay),
.sum(adder2_out)
);

fir_delay fir_delay1 (
.clk(clk),
.reset(reset),
.in(adder2_out),
.in_delay(delay1_out)
);

fir_adder fir_adder1 (
.in1(delay1_out),
.in2(product0_delay),
.sum(adder1_out)
);

endmodule
