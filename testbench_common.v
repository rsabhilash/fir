module testbench_common ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;

reg clk ;
reg reset ;

integer i ;


initial begin 
	clk = 0 ;
	reset = 1 ;
	#(10*clock) ;
	reset =  0;
	$display("Simulation started") ;
	#(10*clock) ;
	$finish ;
end

always #(clock_by_2) clk = ~clk ;

endmodule
