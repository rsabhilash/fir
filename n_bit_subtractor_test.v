module n_bit_subtractor_test ;
parameter IN_DATAWIDTH = 8 ;
parameter OUT_DATAWIDTH = IN_DATAWIDTH+1 ;

reg [IN_DATAWIDTH-1:0] in1 ;
reg [IN_DATAWIDTH-1:0] in2 ;
reg cin ;
wire [OUT_DATAWIDTH-1:0] sum ;
reg [OUT_DATAWIDTH-1:0] sum_local ;


integer i,j ;

n_bit_subtractor #(
.IN_DATAWIDTH(IN_DATAWIDTH)
)
n_bit_subtractor
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
	for(i=0;i<256;i=i+1) begin 
		for(j=0;j<256;j=j+1) begin 
			in1 = i ; in2 = j ;
			sum_local = i-j-cin ;
			#1 ;
			if(sum==sum_local) begin 
			end
			else begin 
				$display("sum = %d actual = %d",sum,i+i) ;
				$display("ERROR") ;
			end
		end
	end
	$finish ;

end

endmodule
