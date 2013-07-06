`define INPUT_FILE "x_inputs.txt"
`define COEFFICIENT_FILE "coefficients_input.txt"
module  fir_top_test ;

parameter clock_by_2 = 4 ;
parameter clock = clock_by_2*2 ;

reg clk ;
reg reset ;
reg [16:0] x_in ;
reg in_data_vld ;
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
.in_data_vld(in_data_vld),
.c0({c[0][16:0]}),
.c1({c[1][16:0]}),
.c2({c[2][16:0]}),
.c3({c[3][16:0]}),
.y_out(y_out)
);


initial begin 
	clk = 0 ;
	reset = 1 ;
	x_in =0 ;
	in_data_vld = 0 ;
    $readmemh(`INPUT_FILE,x) ;
    $readmemh(`COEFFICIENT_FILE,c) ;
	#(10*clock) ;
	reset =0 ;
	$display("Simulation started") ;
	$display(" Input data vector is %p",x) ;
	$display(" Coefficients are %p",c);
	inject_data ;
    pre_calclate_fir ;
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
		for(i=0;i<3;i=i+1) begin 
			#clock ;
			$display("%d ",y_out) ;
		end
	end
endtask

task pre_calclate_fir ;
    integer i ;
    integer y[0:9] ;
    begin 
        //$display("Precalculated result %p",x) ;
        //$display("Coefficients %p",c) ;
        for (i=0; i<10; i=i+1) begin
            if (i>=3 && i<=6) begin 
                y[i] = c[0]*x[i] + c[1]*x[i-1] + c[2]*x[i-2] + c[3]*x[i-3] ;
            end
            else if(i==2) begin
                y[i] = c[0]*x[i] + c[1]*x[i-1] + c[2]*x[i-2]  ;
            end
            else if(i==1) begin
                y[i] = c[0]*x[i] + c[1]*x[i-1]  ;
            end
            else if(i==0) begin
                y[i] = c[0]*x[i]  ;
            end
            else if(i==7) begin
                y[i] = c[1]*x[i-1] + c[2]*x[i-2] + c[3]*x[i-3] ;
            end
            else if(i==8) begin
                y[i] = c[2]*x[i-2] + c[3]*x[i-3] ;
            end
            else if(i==9) begin
                y[i] = c[3]*x[i-3] ;
            end
        end
        $display("Precalculated result %p",y) ;
    end
endtask


always @ (y_out) begin 
	//$display("%d ",y_out) ;
end

endmodule
