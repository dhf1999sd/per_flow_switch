`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 


`timescale 1ns / 1ps
module address_assign(
input					clk,
input					rst,

input		  [15:0]	ptr_din,
input					FQ_wr,
input					FQ_rd,
output		  [9:0]		ptr_dout_s,
output		  			ptr_fifo_empty
    );
reg	  [6:0]		FQ_state;
reg	  [9:0]		addr_cnt;
reg	  [9:0]		ptr_fifo_din;
reg				ptr_fifo_wr;
		
always@(posedge clk or negedge rst)begin
	if(rst)
		begin
		FQ_state<= 0;
		addr_cnt<= 0;
		ptr_fifo_wr<= 0;
		ptr_fifo_din<=0;
		end
	  else begin
		ptr_fifo_wr<= 0;
		ptr_fifo_din<= ptr_din[9:0];
		case(FQ_state)
		0:FQ_state<= 1;
			1:FQ_state<= 2;
				2:FQ_state<= 8;

		8:begin				
			ptr_fifo_din<= addr_cnt;
			if(addr_cnt<10'h1ff) 		
				addr_cnt<= addr_cnt+1;
			if(ptr_fifo_din<10'h1ff)	//地址回收模块
				ptr_fifo_wr<= 1;
			else begin
				FQ_state<= 9;
				ptr_fifo_wr<= 0;
				end
			end
	    9:begin								
			if(FQ_wr)ptr_fifo_wr<= 1;
			end
		endcase
	end
end
	fifo_ft_w10_d512   u_address_assign_fifo (
      .clk(clk),                // input wire clk
      .rst(rst),                // input wire rst
      .din(ptr_fifo_din[9:0]),                // input wire [9 : 0] din
      .wr_en(ptr_fifo_wr),            // input wire wr_en
      .rd_en(FQ_rd),            // input wire rd_en
      .dout(ptr_dout_s[9:0]),              // output wire [9 : 0] dout
      .full(),              // output wire full
      .empty(ptr_fifo_empty),            // output wire empty
      .data_count()  // output wire [9 : 0] data_count
    );

endmodule

