module fir_adder(
input [35:0] in1 , //maximum data out is 36 bit 
input [35:0] in2 ,
output [35:0] sum
);

assign sum = in1 + in2 ;

endmodule 
