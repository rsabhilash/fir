module csa_subtractor_block (
input[1:0] in1 ,
input[1:0] in2 ,
input cin ,
output [2:0] sum
);

wire [2:0] sum0 ;
wire [2:0] sum1 ;

n_bit_subtractor #(
.IN_DATAWIDTH(2)
)
n_bit_subtractor0
(
 .in1(in1),
 .in2(in2),
 .cin(1'b0),
 .sum(sum0)
);


n_bit_subtractor #(
.IN_DATAWIDTH(2)
)
n_bit_subtractor1
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
