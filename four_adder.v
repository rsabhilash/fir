module four_adder(
input [32:0] in_data_0 ,
input [32:0] in_data_1 ,
input [32:0] in_data_2 ,
input [32:0] in_data_3 ,
input poly_sign ,
output [33:0] sum_four 
);

wire [33:0] sum_four_unsigned ;
assign sum_four_unsigned = in_data_3 + in_data_2 + in_data_1 + in_data_0 ;
assign sum_four = poly_sign ? (~sum_four_unsigned)+1 : sum_four_unsigned ;

endmodule 
