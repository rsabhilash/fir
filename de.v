module de (
input clk ,
input reset ,
input  [7:0] in ,
output reg [7:0] out 
);
always @ (posedge clk) begin : de
	if(reset)begin
		out <= 0 ; 
	end
	else begin
		out <= in ;
	end
end

endmodule

