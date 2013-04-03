module test_module ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;

reg clk ;
reg reset ;
reg [7:0] in_data ;
reg in_data_vld ;
wire [7:0] out_data ;
wire out_data_vld ;

integer i ;

top uut (
.clk(clk),
.reset(reset),
.in_data(in_data),
.out_data(out_data)
);

initial begin 
	clk = 0 ;
	reset = 1 ;
	in_data = 0;
	in_data_vld = 0 ;
	#(10*clock) ;
	reset =  0;
	$display("Simulation started") ;
	
	for(i=0;i<256;i=i+1) begin
		in_data = i ; 
		in_data_vld = 1 ;
		#clock ;
	end

	in_data_vld = 0 ;


	#(10*clock) ;
	$finish ;
end

always #(clock_by_2) clk = ~clk ;

endmodule
