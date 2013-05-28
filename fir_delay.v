module fir_delay(
input clk,
input reset,
input [35:0] in ,
output reg [35:0] in_delay
);

always @ (posedge clk) begin 
	if(reset)begin
		in_delay <= 0 ;
	end
	else begin
		in_delay <= in ;
	end
end


endmodule
