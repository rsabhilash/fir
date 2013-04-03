module header_8_spliter (
input [7:0] in_data ,
output [11:0] out_data1 ,
output [11:0] out_data2 ,
output [11:0] out_data3 ,
output [11:0] out_data4 ,
output [11:0] out_data5 ,
output [11:0] out_data6 ,
output [11:0] out_data7 ,
output [11:0] out_data8 
);	

//simple outcheck

assign out_data1 = in_data ;
assign out_data2 = in_data*3 ;
assign out_data3 = in_data*5 ;
assign out_data4 = in_data*7 ;
assign out_data5 = in_data*9 ;
assign out_data6 = in_data*11 ;
assign out_data7 = in_data*13 ;
assign out_data8 = in_data*15 ;

endmodule 
