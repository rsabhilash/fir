`timescale 1ns/1ns 
module test (
input clk,
input reset,
input [7:0] in_data,
input in_data_vld,
output reg [7:0] out_data,
output reg out_data_vld
);
localparam MEM0_WRITE   =  0 ;
localparam MEM1_WRITE   =  1 ;
localparam PROCESS_DATA =  2 ;


reg [4:0] state ;

reg [7:0] in_data_mem0,in_data_mem1 ;
reg [3:0] addr_wr_port_mem0,addr_wr_port_mem1 ;
reg [3:0] addr_rd_port_mem0,addr_rd_port_mem1 ;
reg we_wr_port_mem0,we_wr_port_mem1 ;
reg we_rd_port_mem0,we_rd_port_mem1 ;

wire [7:0] out_data_mem0,out_data_mem1 ;

reg [3:0] mem0_init_counter,mem1_init_counter ;

reg [7:0] in_data_dly1,in_data_dly2 ;
reg [10:0] process_counter ;

always @ (posedge clk) begin 
	if(reset) begin	
		state <= MEM0_WRITE ;
		mem0_init_counter <=  0 ;
		mem1_init_counter <=  0 ;
		process_counter <= 0 ;
		addr_rd_port_mem0 <= 0 ;
		addr_rd_port_mem1 <= 0 ;
	end
	else begin
		case(state) 	
			MEM0_WRITE : begin 
				if(in_data_vld) begin 
					mem0_init_counter <= mem0_init_counter + 1 ;
					in_data_mem0 <= in_data ;
					addr_wr_port_mem0 <= mem0_init_counter ;
					we_wr_port_mem0 <= 1 ;
				end
				else begin 
					we_wr_port_mem0 <= 0 ;
				end
				if(mem0_init_counter == 15) begin
					state <= MEM1_WRITE ;
				end
			end
			MEM1_WRITE : begin	
				we_wr_port_mem0 <= 0 ;
				mem1_init_counter <= mem1_init_counter + 1 ;
				in_data_mem1 <= in_data ;
				addr_wr_port_mem1 <= mem1_init_counter ;
				we_wr_port_mem1 <= 1 ;
				if(mem1_init_counter == 15) begin
					state <= PROCESS_DATA ;
				end
			end
			PROCESS_DATA: begin
				process_counter <= process_counter + 1 ;
				addr_rd_port_mem0 = addr_rd_port_mem0 + 1 ;
				addr_rd_port_mem1 = addr_rd_port_mem1 + 1 ;
				we_rd_port_mem0 = 0 ;
				we_rd_port_mem1 = 0 ;
				$display("in_data_dly1 %d in_data_dly2",in_data_dly1,in_data_dly2) ;
				$display(" %d \n %d",out_data_mem0,out_data_mem1) ;
				//#8 ;
				//#8 ;
				$display("mem0 %p",ram0.mem) ;
				$display("mem1 %p",ram1.mem) ;
				$display(" %d \n %d",out_data_mem0,out_data_mem1) ;
				$display("in_data_dly1 %d in_data_dly2",in_data_dly1,in_data_dly2) ;
				$display("process_counter %d",process_counter) ;
				$stop ;
			end
		endcase
	end
end

always @ (posedge clk) begin
	if(reset) begin	
		in_data_dly1 <= 0 ;
		in_data_dly2 <= 0 ;
	end
	else begin
		in_data_dly1 <= in_data ;
		in_data_dly2 <= in_data_dly1 ;
	end
end


dual_port_ram ram0 (
	.clk         (clk         ),
	.reset       (reset       ),
	.in_data     (in_data_mem0     ),
	.we_wr_port  (we_wr_port_mem0  ),
	.addr_wr_port(addr_wr_port_mem0), 
	.out_data    (out_data_mem0    ),
	.we_rd_port  (we_rd_port_mem0  ),
	.addr_rd_port(addr_rd_port_mem0)
	  
);

dual_port_ram ram1 (
	.clk         (clk         ),
	.reset       (reset       ),
	.in_data     (in_data_mem1     ),
	.we_wr_port  (we_wr_port_mem1  ),
	.addr_wr_port(addr_wr_port_mem1), 
	.out_data    (out_data_mem1    ),
	.we_rd_port  (we_rd_port_mem1  ),
	.addr_rd_port(addr_rd_port_mem1)
	  
);


endmodule
