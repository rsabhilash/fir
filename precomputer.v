module precomputer
#( parameter IN_DATA_WIDTH = 17 ,
   parameter OUT_DATA_WIDTH = 21 
)
(
input [IN_DATA_WIDTH-1:0] in_data ,
output [OUT_DATA_WIDTH-1:0] x1 ,
output [OUT_DATA_WIDTH-1:0] x3 ,
output [OUT_DATA_WIDTH-1:0] x5 ,
output [OUT_DATA_WIDTH-1:0] x7 ,
output [OUT_DATA_WIDTH-1:0] x9 ,
output [OUT_DATA_WIDTH-1:0] x11 ,
output [OUT_DATA_WIDTH-1:0] x13 ,
output [OUT_DATA_WIDTH-1:0] x15 
);	

//simple outcheck

assign x1 = in_data ;
assign x3 = in_data*3 ;
assign x5 = in_data*5 ;
assign x7 = in_data*7 ;
assign x9 = in_data*9 ;
assign x11 = in_data*11 ;
assign x13 = in_data*13 ;
assign x15 = in_data*15 ;

endmodule 
