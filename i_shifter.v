module i_shifter 
#(parameter OUT_DATA_WIDTH = 21
	
)
(
input select_line_vld ,
input [1:0] i_shifter_count ,
input [OUT_DATA_WIDTH-1:0] in_data ,
output reg [OUT_DATA_WIDTH-1:0] out_data
);

always @ (*) begin 
	case(i_shifter_count) 
	 2'b00 : begin
	 	out_data = in_data  ;
	 end
	 2'b01 : begin
	 	out_data = {in_data[OUT_DATA_WIDTH-2:0],1'b0}  ;
	 end
	 2'b10 : begin
	 	out_data = {in_data[OUT_DATA_WIDTH-3:0],2'b00}  ;
	 end
	 2'b11 : begin
	 	out_data = {in_data[OUT_DATA_WIDTH-4:0],3'b000}  ;
	 end

	endcase
end

always @ (select_line_vld) begin
	if(select_line_vld) begin	
		//$display("in_data %d \ni_shifter_count %d",in_data,i_shifter_count) ;
	end
end

endmodule
