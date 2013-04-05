module  checksum_test ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;
parameter IN_DATA_WIDTH = 17 ;
parameter OUT_DATA_WIDTH = 21 ;
parameter POLY_WIDTH = 17 ;
parameter SUM_WIDTH = 34 ;

reg clk ;
reg reset ;
reg in_data_vld ;
reg [IN_DATA_WIDTH-1:0] in_data ;
reg [POLY_WIDTH-1:0] polynomial ;
reg [SUM_WIDTH-1:0] out_data_pre_cal ;
wire [SUM_WIDTH-1:0] out_data ;
wire out_data_vld ;

checksum_top uut (
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
	check_single_data  ;
	//for(i=131071;i>1;i=i-1) begin
	//	$display("info : loop %d ",i) ;
	//	for(j=0;j<15;j=j+1) begin
	//	in_data_vld = 1 ;
	//	in_data = i ;
	//	polynomial = j ;
	//	#clock ;
	//	in_data_vld = 0 ;
	//	#(10*clock);
	//	end
	//end
	//in_data_vld = 1 ; in_data = x ; polynomial = y ;#clock ; in_data_vld = 0 ; in_data = 0 ; polynomial = 0 ;

	#(10*clock) ;
	$finish ;
end

always #(clock_by_2) clk = ~clk ;

task check_single_data ;
	begin 
	$display("Task check_single_data started") ;
	in_data_vld = 1 ;
	in_data = 131071 ;
	polynomial = 131071 ;
	#clock ;
	in_data_vld = 0  ;
	out_data_pre_cal = polynomial[15:0]*in_data ;
	if(polynomial[16]) begin
		out_data_pre_cal = ~out_data_pre_cal + 1 ;
	end
	$display("TEST:out_data_pre_cal %d",out_data_pre_cal) ;
	end
endtask
always @ (posedge clk) begin 
if(!reset)begin
	if(out_data_vld) begin	
		$display("out_data %d ",out_data) ;
	end
end
end


//always @ (posedge clk) begin : catch_output
//if(!reset)begin
//	if(out_data_vld) begin 	
//		if(out_data == i*j) begin
//			//$display("out_data OK") ;
//		end
//		else begin
//			$display("out_data ERROR") ;
//			$stop ;
//		end
//	end
//
//	if (in_data_vld) begin
//		//$display("polynomial %d %b",polynomial,polynomial) ;
//	end
//end
//end


endmodule
