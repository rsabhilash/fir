module n_bit_adder_test ;
parameter IN_DATAWIDTH = 4 ;
parameter OUT_DATAWIDTH = IN_DATAWIDTH+1 ;

reg [IN_DATAWIDTH-1:0] in1 ;
reg [IN_DATAWIDTH-1:0] in2 ;
reg cin ;
wire [OUT_DATAWIDTH-1:0] sum ;


integer i ;

n_bit_csa_adder #(
.IN_DATAWIDTH(IN_DATAWIDTH)
)
n_bit_csa_adder 
(
.in1(in1),
.in2(in2),
.cin(cin),
.sum(sum)
);

initial begin 
	in1 = 0 ;
	in2 = 0 ;
	cin = 0 ;
	#1 ;
	for(i=0;i<16;i=i+1) begin 
		in1 = i ; in2 = i ;
		#1 ;
		if(sum==i+i+cin) begin 
		end
		else begin 
			$display("sum = %d actual = %d",sum,i+i) ;
			$display("ERROR") ;
		end
	end
	$finish ;

end

endmodule
