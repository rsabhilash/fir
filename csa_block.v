module csa_block (
input[1:0] in1 ,
input[1:0] in2 ,
input cin ,
output [2:0] sum
);

wire [2:0] sum0 ;
wire [2:0] sum1 ;

n_bit_adder #(
.IN_DATAWIDTH(2)
)
n_bit_adder_0
(
 .in1(in1),
 .in2(in2),
 .cin(1'b0),
 .sum(sum0)
);


n_bit_adder #(
.IN_DATAWIDTH(2)
)
n_bit_adder_1
(
 .in1(in1),
 .in2(in2),
 .cin(1'b1),
 .sum(sum1)
);

mux_2X1 #(
.DATA_WIDTH(3)
)
mux_2X1 
(
.in0(sum0),
.in1(sum1),
.sel(cin),
.out(sum)
);

endmodule
