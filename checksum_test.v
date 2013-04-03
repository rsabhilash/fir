module  checksum_test ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;

reg clk ;
reg reset ;
reg in_data_vld ;
reg [7:0] in_data ;
reg [3:0] polynomial ;
wire [11:0] out_data ;
wire out_data_vld ;

checksum uut (
.clk         (clk         ),
.reset       (reset       ),
.in_data_vld (in_data_vld ),
.in_data     (in_data     ),
.polynomial  (polynomial  ),
.out_data    (out_data    ),
.out_data_vld(out_data_vld)
);

integer i,j,x,y ;


initial begin 
	clk = 0 ;
	reset = 1 ;
	in_data_vld = 0 ;
	in_data = 0 ;
	polynomial = 0 ;
	#(10*clock) ;
	reset =  0;
	x=1;
	y=15;
	$display("Simulation started") ;
	for(i=0;i<255;i=i+1) begin
		for(j=0;j<15;j=j+1) begin
		in_data_vld = 1 ;
		in_data = i ;
		polynomial = j ;
		#clock ;
		in_data_vld = 0 ;
		#(10*clock);
		end
	end
	//in_data_vld = 1 ; in_data = x ; polynomial = y ;#clock ; in_data_vld = 0 ; in_data = 0 ; polynomial = 0 ;

	#(10*clock) ;
	$finish ;
end

always #(clock_by_2) clk = ~clk ;

always @ (posedge clk) begin : catch_output
if(!reset)begin
	if(out_data_vld) begin 	
		if(out_data == i*j) begin
			//$display("out_data OK") ;
		end
		else begin
			$display("out_data ERROR") ;
		end
	end

	if (in_data_vld) begin
		//$display("polynomial %d %b",polynomial,polynomial) ;
	end
end
end


endmodule
