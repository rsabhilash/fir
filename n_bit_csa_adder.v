module n_bit_csa_adder #(
parameter IN_DATAWIDTH = 8 ,
parameter OUT_DATAWIDTH = IN_DATAWIDTH + 1 
)
(
input [IN_DATAWIDTH-1:0] in1 ,
input [IN_DATAWIDTH-1:0] in2 ,
input cin ,
output [OUT_DATAWIDTH-1:0] sum
);

wire [IN_DATAWIDTH-1:0] sum_only ;
wire [IN_DATAWIDTH/2-1:-1] carry_pass ;

assign sum = {carry_pass[IN_DATAWIDTH/2-1],sum_only};
assign carry_pass[-1] = cin ;

genvar i ;
generate 
    for(i=0;i<IN_DATAWIDTH/2;i=i+1) begin 
        csa_block csa_block
        (                                                                       
        .in1({in1[i*2+1],in1[i*2]}),                                                              
        .in2({in2[i*2+1],in2[i*2]}),                                                              
        .cin(carry_pass[i-1]),                                                              
        .sum({carry_pass[i],sum_only[i*2+1],sum_only[i*2]})                                                               
        );                                                                      
    end
endgenerate 



//synthesis translate_off

initial begin 
    if(IN_DATAWIDTH%2) begin
        $display("ERROR: Failed to add module %m, IN_DATAWIDTH must be even number\n") ;
        $finish ;
    end
end
//synthesis translate_on


endmodule


