module shifter (
input clk ,
input reset,
input [3:0] polynomial,
input in_data_vld,
output reg [2:0] select_line,
output reg select_line_vld,
output reg [1:0] i_shifter_count,
output reg polynomial_zero
);

reg [3:0] polynomial_latch ;
reg [1:0] i_shifter_count_local ;

reg [1:0] state ;
localparam IDLE = 0 ;
localparam PROCESS = 1 ;

always @ (posedge clk) begin 
	if(reset)begin
		state <= IDLE ;
		select_line_vld <= 0 ;
		select_line <= 0 ;
		i_shifter_count_local <= 0 ;
		polynomial_zero <= 0 ;
	end
	else begin
		case(state) 
			IDLE : begin
				select_line_vld <= 0 ;
				polynomial_zero <= 0 ;
				if(in_data_vld) begin
					if(polynomial[0]) begin
						select_line <= polynomial[3:1] ;
						select_line_vld <= 1 ;
						i_shifter_count <= 0 ;
					end
					else if(polynomial ==0) begin
						select_line <= 0 ;
						select_line_vld <= 1 ;
						polynomial_zero <= 1 ;
						i_shifter_count <= 0 ;
					end
					else begin
						state <= PROCESS ;
						polynomial_latch <= {polynomial[0],polynomial[3:1]} ;	
						i_shifter_count_local <=  1 ;
					end
				end
			end
			PROCESS : begin
				if(polynomial_latch[0]) begin
					select_line <= polynomial_latch[3:1] ;
					state <= IDLE ;
					select_line_vld <= 1 ;
					i_shifter_count <= i_shifter_count_local ;
				end
				else begin
					polynomial_latch <= {polynomial_latch[0],polynomial_latch[3:1]} ;
					i_shifter_count_local <= i_shifter_count_local + 1 ; 
				end
			end
		endcase
	end
end

//always @ (posedge clk) begin : debug
//	if(!reset)begin
//		if(select_line_vld) begin
//			$display("select_line %d %b",select_line,select_line) ;
//			$display("i_shifter_count %d",i_shifter_count) ;
//		end
//	end
//end

endmodule
