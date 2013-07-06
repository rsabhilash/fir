module four_adder(
input [32:0] in_data_0 ,
input [32:0] in_data_1 ,
input [32:0] in_data_2 ,
input [32:0] in_data_3 ,
input poly_sign ,
output [33:0] sum_four 
);

wire [33:0] sum_four_unsigned ;
wire [34:0] sum_01 ;
wire [34:0] sum_23 ;
wire [36:0] sum_1234 ;
assign sum_four_unsigned = sum_1234[36:0] ;
assign sum_four = poly_sign ? (~sum_four_unsigned)+1 : sum_four_unsigned ;


n_bit_csa_adder #(
    .IN_DATAWIDTH(34)
)
adder_01
(
    .in1({1'b0,in_data_0}),        
    .in2({1'b0,in_data_1}),   
    .cin(1'b0),
    .sum(sum_01)
);

n_bit_csa_adder #(
    .IN_DATAWIDTH(34)
)
adder_23
(
    .in1({1'b0,in_data_2}),    
    .in2({1'b0,in_data_3}),   
    .cin(1'b0),
    .sum(sum_23)
);


n_bit_csa_adder #(
    .IN_DATAWIDTH(36)
)
adder_1234
(
    .in1({1'b0,sum_01}),        
    .in2({1'b0,sum_23}),   
    .cin(1'b0),
    .sum(sum_1234)
);


endmodule 
