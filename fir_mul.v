module fir_mul(
input [16:0] x_in ,
input [16:0] c ,
output [35:0] product
);

assign product = x_in * c ;

endmodule 
