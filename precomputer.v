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

wire [OUT_DATA_WIDTH+1:0] x3_wire ;
wire [OUT_DATA_WIDTH+1:0] x5_wire ;
wire [OUT_DATA_WIDTH+1:0] x9_wire ;

wire [OUT_DATA_WIDTH+1:0] x7_wire ;
wire [OUT_DATA_WIDTH+1:0] x15_wire ;

wire [OUT_DATA_WIDTH+1:0] x10_wire ;
wire [OUT_DATA_WIDTH+1:0] x11_wire ;
wire [OUT_DATA_WIDTH+1:0] x12_wire ;
wire [OUT_DATA_WIDTH+1:0] x13_wire ;

//simple outcheck

assign x1 = in_data ;
assign x3 = x3_wire[OUT_DATA_WIDTH-1:0] ;
assign x5 = x5_wire[OUT_DATA_WIDTH-1:0] ;
assign x7 = x7_wire[OUT_DATA_WIDTH-1:0] ;
assign x9 = x9_wire[OUT_DATA_WIDTH-1:0] ;
assign x11 = x11_wire[OUT_DATA_WIDTH-1:0] ;
assign x13 = x13_wire[OUT_DATA_WIDTH-1:0] ;
assign x15 = x15_wire[OUT_DATA_WIDTH-1:0] ;

n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x3
(
.in1({5'b0,in_data}),
.in2({4'b0,in_data,1'b0}),
.cin(1'b0),
.sum(x3_wire)
);


n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x5
(
.in1({5'b0,in_data}),        //x
.in2({3'b0,in_data,2'b0}),   //4x
.cin(1'b0),
.sum(x5_wire)
);


n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x9
(
.in1({5'b0,in_data}),        //x
.in2({2'b0,in_data,3'b0}),   //8x
.cin(1'b0),
.sum(x9_wire)
);


n_bit_csa_subtractor #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x7
(
.in1({2'b0,in_data,3'b0}),   //8x
.in2({5'b0,in_data}),        //x
.cin(1'b0),
.sum(x7_wire)
);


n_bit_csa_subtractor #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x15
(
.in1({1'b0,in_data,4'b0}),   //16x
.in2({5'b0,in_data}),        //x
.cin(1'b0),
.sum(x15_wire)
);


n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x10
(
.in1({4'b0,in_data,1'b0}),   //2x
.in2({2'b0,in_data,3'b0}),   //8x
.cin(1'b0),
.sum(x10_wire)
);


n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x11
(
.in1(x10_wire[OUT_DATA_WIDTH:0]),         //10x
.in2({5'b0,in_data}),   //x
.cin(1'b0),
.sum(x11_wire)
);

n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x12
(
.in1({3'b0,in_data,2'b0}),   //4x
.in2({2'b0,in_data,3'b0}),   //8x
.cin(1'b0),
.sum(x12_wire)
);


n_bit_csa_adder #(
.IN_DATAWIDTH(OUT_DATA_WIDTH+1)
)
adder_x13
(
.in1(x12_wire[OUT_DATA_WIDTH:0]),         //10x
.in2({5'b0,in_data}),   //x
.cin(1'b0),
.sum(x13_wire)
);


endmodule 
