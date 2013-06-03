module shifter (
input clk ,
input reset,
input [3:0] polynomial,
input in_data_vld,
output reg [2:0] select_line,
output  select_line_vld,
output reg [1:0] i_shifter_count,
output reg polynomial_zero
);

assign select_line_vld = in_data_vld ;

always @ (*) begin 
	if(reset) begin
		select_line = 0 ;
		i_shifter_count = 0 ;
		polynomial_zero = 0 ;
	end
	else begin 
		polynomial_zero = 0 ;
		if(polynomial ==0) begin 
			select_line = 0 ;
			polynomial_zero = 1 ;
			i_shifter_count = 0 ;
		end
		else if(polynomial[0]) begin
			select_line = polynomial[3:1];
			i_shifter_count = 0 ;
		end
		else if(polynomial[1]) begin 
			select_line = {polynomial[0],polynomial[3:2]} ;
			i_shifter_count = 1 ;
		end
		else if(polynomial[2]) begin
			select_line = {polynomial[1],polynomial[0],polynomial[3]};
			i_shifter_count = 2 ;
		end
		else if(polynomial[3]) begin
			select_line = {polynomial[2],polynomial[1],polynomial[0]};
			i_shifter_count = 3 ;
		end
	end
end

endmodule
