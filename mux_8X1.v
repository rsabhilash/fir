module mux_8X1 
#(parameter OUT_DATA_WIDTH = 21
)
(
input [OUT_DATA_WIDTH-1:0] in0 ,				
input [OUT_DATA_WIDTH-1:0] in1 ,				
input [OUT_DATA_WIDTH-1:0] in2 ,				
input [OUT_DATA_WIDTH-1:0] in3 ,				
input [OUT_DATA_WIDTH-1:0] in4 ,				
input [OUT_DATA_WIDTH-1:0] in5 ,				
input [OUT_DATA_WIDTH-1:0] in6 ,				
input [OUT_DATA_WIDTH-1:0] in7 ,				
output reg [OUT_DATA_WIDTH-1:0] out,
input [2:0] select_lines
);

always @ (*) begin 
	case(select_lines)
		3'b000 : out = in0 ;
		3'b001 : out = in1 ;
		3'b010 : out = in2 ;
		3'b011 : out = in3 ;
		3'b100 : out = in4 ;
		3'b101 : out = in5 ;
		3'b110 : out = in6 ;
		3'b111 : out = in7 ;
	endcase
end

endmodule
