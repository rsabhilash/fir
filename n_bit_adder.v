module n_bit_adder#(
parameter IN_DATAWIDTH = 8 ,
parameter OUT_DATAWIDTH = IN_DATAWIDTH+1
)
(
input [IN_DATAWIDTH-1:0] in1 ,
input [IN_DATAWIDTH-1:0] in2 ,
input cin ,
output [OUT_DATAWIDTH-1:0] sum
);

wire [IN_DATAWIDTH-1:-1] cin_wire ;
wire [IN_DATAWIDTH-1:0] sum_only ;
//wire [OUT_DATAWIDTH-1:1 cout ;

assign sum = {cin_wire[IN_DATAWIDTH-1],sum_only} ;
assign cin_wire[-1] = cin ;

genvar i ;

generate 
	for(i=0;i<IN_DATAWIDTH;i=i+1) begin 
		full_adder full_adder (
		.in1(in1[i]),
		.in2(in2[i]),
		.cin(cin_wire[i-1]),
		.cout(cin_wire[i]),
		.sum(sum_only[i])
		);
	end
endgenerate 

endmodule
