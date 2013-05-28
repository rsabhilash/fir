module fir(
input clk ,
input reset ,
input [16:0] x_in ,
input [16:0] c0 ,
input [16:0] c1 ,
input [16:0] c2 ,
input [16:0] c3 ,
output [35:0] y_out
);

wire [35:0] product0 ;
wire [35:0] product1 ;
wire [35:0] product2 ;
wire [35:0] product3 ;
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

fir_mul fir_mul0 (
.x_in(x_in),
.c(c0),
.product(product0)
);


fir_mul fir_mul1 (
.x_in(x_in),
.c(c1),
.product(product1)
);


fir_mul fir_mul2 (
.x_in(x_in),
.c(c2),
.product(product2)
);


fir_mul fir_mul3 (
.x_in(x_in),
.c(c3),
.product(product3)
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
