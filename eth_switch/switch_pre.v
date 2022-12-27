
`timescale 1ns / 1ps
module switch_pre(
input					clk,
input					rst,
input					sof,
input					dv,
input		  	        [7:0]	din,
output	reg		    [127:0]	i_cell_data_fifo_pre_dout,
output	reg		    i_cell_data_fifo_pre_wr,
output	reg		    [15:0]	i_cell_ptr_fifo_pre_dout,
output	reg		    i_cell_ptr_fifo_pre_wr,	
input					i_cell_bp	,
output    reg	     [31:0]  flow_id,
output    reg          [2:0]   priority			
    );
reg	  	[7:0]	word_num;	
reg	  	[4:0]	state;
reg		[3:0]	i_cell_portmap;	

reg     [9:0]    i;	
reg     flow_crc_init;
reg     flow_crc_en;
reg     [7:0] flow_crc_din;
wire    [31:0] flow_crc_chk_result;
reg     flow_crc_dv;


always@(posedge clk or negedge rst)
	if(rst)
		begin
		word_num<=  0;
		state<=  0;
		i_cell_data_fifo_pre_dout<=  0;
		i_cell_portmap<=  0;
		i_cell_data_fifo_pre_wr<=  0;
		i_cell_ptr_fifo_pre_dout<=  0;
		i_cell_ptr_fifo_pre_wr<=  0;	
		flow_crc_dv<=  0;
		end
	else begin
		i_cell_data_fifo_pre_wr<=  0;
		i_cell_ptr_fifo_pre_wr<=  0;
		case(state)
		0:begin
			word_num<=  0;
			 i<=  0;
			if(sof & !i_cell_bp)begin
				i_cell_data_fifo_pre_dout[127:120]<=  din;
				i_cell_portmap<=  din[3:0];
			
				 if(i==1)
                    begin
                        flow_crc_din<=din[7:0];
                         flow_crc_dv<=1;
                    end
                      
				state<= 1;
				end
			end
		1:begin
			i_cell_data_fifo_pre_dout[119:112]<=  din;
			state<=  2;
			i<= i+1;
			if(i==0)
			begin
			flow_crc_init<=1;
			end
			else if(i==1)
                begin
                    flow_crc_din<=din[7:0];
                     flow_crc_dv<= 0;
                     flow_crc_en<=0;
                end
               
              
			end
		2:begin
			i_cell_data_fifo_pre_dout[111:104]<=  din;
			state<=  3;
			flow_crc_init<=0;
				if(i==1)
                    begin
                        flow_crc_din<=din[7:0];
                         flow_crc_dv<=1;
                         flow_crc_en<=1;
                    end
                  
			end
		3:begin
			i_cell_data_fifo_pre_dout[103:96]<=  din;
			state<=  4;
            if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		4:begin
			i_cell_data_fifo_pre_dout[95:88]<=  din;
			state<=  5;
				if(i==1)
                begin
                    flow_crc_din<=din[7:0];
                     flow_crc_dv<=1;
                end
			end
		5:begin
			i_cell_data_fifo_pre_dout[87:80]<= din;
			state<=  6;
				if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		6:begin
			i_cell_data_fifo_pre_dout[79:72]<=  din;
			state<=  7;
				if(i==1)
                begin
                    flow_crc_din<=din[7:0];
                     flow_crc_dv<=1;
                end
			end
		7:begin
			i_cell_data_fifo_pre_dout[71:64]<=  din;
			state<=  8;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
		  end
		8:begin
			i_cell_data_fifo_pre_dout[63:56]<= din;
			state<=  9;
			if(i==1)
                begin
                    flow_crc_din<=din[7:0];
                     flow_crc_dv<=1;
                end
			end
		9:begin
			i_cell_data_fifo_pre_dout[55:48]<=#2  din;
			state<=#2  10;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		10:begin
			i_cell_data_fifo_pre_dout[47:40]<=  din;
			state<=  11;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		11:begin
			i_cell_data_fifo_pre_dout[39:32]<= din;
			state<= 12;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		12:begin
			i_cell_data_fifo_pre_dout[31:24]<=  din;
			state<=  13;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
			end
		13:begin
			i_cell_data_fifo_pre_dout[23:16]<=  din;
			state<=  14;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                flow_crc_dv<=1;
            end
			end
		14:begin
			i_cell_data_fifo_pre_dout[15:8]<=  din;
			state<=  15;
			if(i==1)
            begin
                flow_crc_din<=din[7:0];
                 flow_crc_dv<=1;
            end
		  end
		15:begin
			i_cell_data_fifo_pre_dout[7:0]<=  din;
			i_cell_data_fifo_pre_wr<=  1;
			word_num<=  word_num+1;
			state<=  16;
			if(i==1)
			begin
			    flow_crc_din<=din;
			     flow_crc_dv<=1;
			end
			
		  end
		16:begin
			if(dv) begin
				i_cell_data_fifo_pre_dout[127:120]<=  din;
				state<= 1;
				if(i==10'd1)
			begin
				priority<= din[7:5];	
				flow_crc_din<=din;
				 flow_crc_dv<=1;
			end
				end
			else begin
				i_cell_ptr_fifo_pre_dout<= {1'b0,priority,i_cell_portmap[3:0],2'b0,word_num[7:2]};
				i_cell_ptr_fifo_pre_wr<= 1;
				state<= 0;
				end
			end
		endcase
		end
		


        crc32_8023  flow_id_crc(                       
                 .clk                               (clk),
                 .reset                            (rst),
                 .d                                 (flow_crc_din),
                 .load_init                      (flow_crc_init),
                 .calc                             (flow_crc_en),
                 .d_valid                        (flow_crc_dv),
                 .crc_reg                        (flow_crc_chk_result),
                 .crc                               ()
              ); 		

always@(posedge clk or negedge rst)
	begin
	  if(rst) flow_id<=32'd0;
	  else if(flow_crc_dv==0)
		  flow_id<=flow_crc_chk_result;
	end
	
		
	
		

		
		
endmodule




