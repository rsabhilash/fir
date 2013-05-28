module  fir_top_test ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;

reg clk ;
reg reset ;
reg [16:0] x_in ;
reg [16:0] c0 ;
reg [16:0] c1 ;
reg [16:0] c2 ;
reg [16:0] c3 ;
wire [35:0] y_out ;

//reg [16:0] x[0:6] ;
//reg [16:0] c[0:3] ;

integer x[0:6] ;
integer c[0:6] ;

fir fir (
.clk(clk),
.reset(reset),
.x_in(x_in),
.c0(c0),
.c1(c1),
.c2(c2),
.c3(c3),
.y_out(y_out)
);


initial begin 
	clk = 0 ;
	reset = 1 ;
	x_in =0 ;
	c0=c[0] ;
	c1=c[1] ;
	c2=c[2] ;
	c3=c[3] ;
	//{x[0],x[1],x[2],x[3],x[4],x[5],x[6],x[7]} = {3,2,1,0,1,2,3} ;
	x[0]=3;
	x[1]=2;
	x[2]=1;
	x[3]=0;
	x[4]=1;
	x[5]=2;
	x[6]=3;
	c0=0;
	c1=1;
	c2=2;
	c3=3;
	#(10*clock) ;
	reset =0 ;
	$display("Simulation started") ;
	inject_data ;
	#(100*clock) ;
	$finish ;
end

always #(clock_by_2) clk = ~clk ;

task inject_data ;
	integer i ;
	begin 
		for(i=0;i<7;i=i+1) begin 
			x_in = x[i] ;
			//$display("x[%d] %d ",i,x[i]) ;
			#clock ;
			$display("%d ",y_out) ;
		end
		x_in = 0 ;
		for(i=0;i<4;i=i+1) begin 
			#clock ;
			$display("%d ",y_out) ;
		end
	end
endtask

always @ (y_out) begin 
	//$display("%d ",y_out) ;
end

endmodule
