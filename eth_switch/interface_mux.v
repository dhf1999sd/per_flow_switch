`timescale 1ns / 1ps
module interface_mux(
input              clk,
input              rstn,//1 active
output             rx_data_fifo_rd0,
input     [7:0]     rx_data_fifo_dout0,
output             rx_ptr_fifo_rd0,
input    [15:0]     rx_ptr_fifo_dout0,
input              rx_ptr_fifo_empty0,
output             rx_data_fifo_rd1,
input     [7:0]     rx_data_fifo_dout1,
output             rx_ptr_fifo_rd1,
input     [15:0]    rx_ptr_fifo_dout1,
input              rx_ptr_fifo_empty1,

output             rx_data_fifo_rd2,
input     [7:0]     rx_data_fifo_dout2,
output             rx_ptr_fifo_rd2,
input     [15:0]    rx_ptr_fifo_dout2,
input              rx_ptr_fifo_empty2,

output             rx_data_fifo_rd3,
input     [7:0]     rx_data_fifo_dout3,
output             rx_ptr_fifo_rd3,
input     [15:0]    rx_ptr_fifo_dout3,
input              rx_ptr_fifo_empty3,
input              sfifo_rd,
output    [7:0]     sfifo_dout,
output             sfifo_empty,
input              ptr_sfifo_rd,
output    [15:0]    ptr_sfifo_dout,
output             ptr_sfifo_empty

);
wire   [3:0]  source_portmap;
wire          bp;
reg    [3:0]  state ;
reg           error;
reg           sfifo_wr;
reg   [7:0]   sfifo_din;
wire  [11:0]  sfifo_cnt;
reg          ptr_sfifo_wr;
reg   [15:0]  ptr_sfifo_din;
wire         ptr_sfifo_full;
wire  [15:0]  rx_ptr_fifo_dout;
wire  [7:0]   rx_data_fifo_dout;
reg          rx_ptr_fifo_rd;
reg          rx_data_fifo_rd;
reg   [10:0]  cnt;
reg   [1:0]   sel;
reg   [1:0]   RR;
always@(posedge clk or negedge rstn)begin
    if(rstn)begin
        state<= 0;
        sfifo_wr<= 0;
		ptr_sfifo_wr<= 0;
        rx_ptr_fifo_rd<= 0;
        rx_data_fifo_rd<= 0;
        RR<= 0;
        sel<= 0;
        cnt<= 0;
        end
    else  begin
		case(state)
		0:begin
		if(!bp) begin
				case(RR)
				2'b00:begin
					if(!rx_ptr_fifo_empty0) begin sel<= 0; rx_ptr_fifo_rd<= 1;state<=1;     end
					else if(!rx_ptr_fifo_empty1)begin  sel<= 1;rx_ptr_fifo_rd<=1;state<=1; end
					else if(!rx_ptr_fifo_empty2)begin  sel<= 2;rx_ptr_fifo_rd<= 1;state<= 1; end
					else if(!rx_ptr_fifo_empty3)begin  sel<=3;rx_ptr_fifo_rd<= 1;state<= 1; end
					end
				2'b01:begin
					if(!rx_ptr_fifo_empty1) begin sel<= 1; rx_ptr_fifo_rd<= 1;state<= 1;     end
					else if(!rx_ptr_fifo_empty2)begin  sel<= 2;rx_ptr_fifo_rd<= 1;state<=1; end
					else if(!rx_ptr_fifo_empty3)begin  sel<=3;rx_ptr_fifo_rd<= 1;state<= 1; end
					else if(!rx_ptr_fifo_empty0)begin  sel<=0;rx_ptr_fifo_rd<= 1;state<= 1; end
					end
				2'b10:begin
					if(!rx_ptr_fifo_empty2) begin sel<= 2; rx_ptr_fifo_rd<= 1;state<=1;     end
					else if(!rx_ptr_fifo_empty3)begin  sel<= 3;rx_ptr_fifo_rd<= 1;state<= 1; end
					else if(!rx_ptr_fifo_empty0)begin  sel<= 0;rx_ptr_fifo_rd<= 1;state<= 1; end
					else if(!rx_ptr_fifo_empty1)begin  sel<= 1;rx_ptr_fifo_rd<= 1;state<= 1; end
					end
				2'b11:begin
					if(!rx_ptr_fifo_empty3) begin sel<= 3; rx_ptr_fifo_rd<= 1;state<= 1;     end
					else if(!rx_ptr_fifo_empty0)begin  sel<= 0;rx_ptr_fifo_rd<= 1;state<= 1; end
					else if(!rx_ptr_fifo_empty1)begin  sel<= 1;rx_ptr_fifo_rd<= 1;state<=1; end
					else if(!rx_ptr_fifo_empty2)begin  sel<= 2;rx_ptr_fifo_rd<=1;state<= 1; end
					end
				endcase
				end  //if的end
		end
        1:begin
            if(RR==2'B11) RR<= 0;
            else  RR<=RR+1;
            rx_ptr_fifo_rd<= 0;
            state<= 2;
            end
		2:begin
            cnt<= rx_ptr_fifo_dout[10:0];
            error<= rx_ptr_fifo_dout[14]|rx_ptr_fifo_dout[15];  //先确定指针没有问题
            rx_data_fifo_rd<= 1;
            state<= 3;
            end
		3:begin
            cnt<= cnt-1;
            state<= 4;
            end
		4:begin
			if(cnt>1)cnt<= cnt-1;
            else  begin
                cnt<= 0;
                rx_data_fifo_rd<= 0;
                state<= 5;
                end
            sfifo_wr<= !error;	

            sfifo_din<= rx_data_fifo_dout;
            end
		5:begin
            state<= 6;
            sfifo_din<= rx_data_fifo_dout;
			ptr_sfifo_din<= {1'b0,source_portmap,rx_ptr_fifo_dout[10:0]};
            end
		6:begin
            sfifo_wr<= 0;
            ptr_sfifo_wr<= !error;
            ptr_sfifo_din<= ptr_sfifo_din;	
            state<= 7;
            end 
		7:begin
            ptr_sfifo_wr<= 0;
            state<= 0;
            end
		endcase
		end
    end
assign     bp=(sfifo_cnt>15588)?1:ptr_sfifo_full;  //假设没有这种情况
assign     rx_ptr_fifo_rd0=rx_ptr_fifo_rd&(sel==0);
assign     rx_ptr_fifo_rd1=rx_ptr_fifo_rd&(sel==1);
assign     rx_ptr_fifo_rd2=rx_ptr_fifo_rd&(sel==2);
assign     rx_ptr_fifo_rd3=rx_ptr_fifo_rd&(sel==3);
assign    rx_data_fifo_rd0=rx_data_fifo_rd&(sel==0);
assign    rx_data_fifo_rd1=rx_data_fifo_rd&(sel==1);
assign    rx_data_fifo_rd2=rx_data_fifo_rd&(sel==2);
assign    rx_data_fifo_rd3=rx_data_fifo_rd&(sel==3);
assign    rx_ptr_fifo_dout=(sel==0)?rx_ptr_fifo_dout0:
                           (sel==1)?rx_ptr_fifo_dout1:
                           (sel==2)?rx_ptr_fifo_dout2:rx_ptr_fifo_dout3;    
assign    rx_data_fifo_dout=(sel==0)?rx_data_fifo_dout0:
                            (sel==1)?rx_data_fifo_dout1:
                            (sel==2)?rx_data_fifo_dout2:rx_data_fifo_dout3; 
assign    source_portmap=(sel==0)?4'b0001:
                         (sel==1)?4'b0010:
                         (sel==2)?4'b0100:4'b1000;
                         
                         
data_fifo_w8_d4k    u_data_fifo_w8_d4k(
    .clk(clk),
     .rst(rstn),
    .din(sfifo_din),
    .wr_en(sfifo_wr),
    .rd_en(sfifo_rd),
    .dout(sfifo_dout),
	.full(), 							
	.empty(sfifo_empty), 					
    .data_count(sfifo_cnt)
    );
    
ptr_fifo_w16_d32   u_ptr_fifo_w16_d32(
    .clk(clk),
    .rst(rstn),
    .din(ptr_sfifo_din),
    .wr_en(ptr_sfifo_wr),
    .rd_en(ptr_sfifo_rd),
    .dout(ptr_sfifo_dout),
    .full(ptr_sfifo_full),
    .empty(ptr_sfifo_empty),
	.data_count()	
    );    
                                  
endmodule
