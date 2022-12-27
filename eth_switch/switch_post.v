`timescale 1ns / 1ps
module switch_post(
input					clk,
input					rstn,
//与switch_core连接的信号
input					o_cell_data_fifo_wr,         //switch_core,允许输入
input		  [127:0]	o_cell_data_fifo_din,        //从sram中读取的数据
input					o_cell_data_first,
input					o_cell_data_last,
output	reg				o_cell_data_fifo_bp,
//与mac_t连接的信号
input					ptr_fifo_rd,
output		  [15:0]	ptr_fifo_dout,
output					ptr_fifo_empty,
input					data_fifo_rd,
output		  [7:0]		data_fifo_dout
);
		
reg				o_cell_data_fifo_rd;
wire  [143:0]	o_cell_data_fifo_dout;
wire			o_cell_data_fifo_empty;
wire  [8:0]		o_cell_data_fifo_depth;
//先将来自switch_core的信元缓存到一个位宽为144FIFO中
fifo_144x256 u_o_cell_fifo(
  .clk(clk),
  .rst(rstn), 
  .din({o_cell_data_first,o_cell_data_last,14'b0,o_cell_data_fifo_din[127:0]}), 
  .wr_en(o_cell_data_fifo_wr), 
  .rd_en(o_cell_data_fifo_rd), 
  .dout(o_cell_data_fifo_dout[143:0]), 
  .full(), 
  .empty(o_cell_data_fifo_empty),
  .data_count(o_cell_data_fifo_depth[8:0]) 
);
always @(posedge clk) 
	if(o_cell_data_fifo_depth>240) o_cell_data_fifo_bp<= 1;
	else o_cell_data_fifo_bp<= 0;

reg	  [15:0]	ptr_fifo_din;
wire			ptr_fifo_full;
wire			data_fifo_wr;
reg   [7:0]		data_fifo_din;   //准备写入mac_t的8位数据
wire  [11:0]	data_fifo_depth;
reg				bp;
always @(posedge clk) 
	bp<= (data_fifo_depth>2578)|ptr_fifo_full;       //反压指示信号

reg				ptr_fifo_wr;
reg   [4:0]		mstate;
reg	  [11:0]	byte_cnt;			      //长度计数器
reg				byte_dv;			       //信源字节有效指示，包括填充字节
reg   [11:0]	frame_len;
reg   [11:0]	frame_len_with_pad;
		
always@(posedge clk or negedge rstn)
	if(rstn)
		begin
		mstate<=  0;
		byte_cnt<= 0;
		byte_dv<= 0;
		frame_len<= 0;
		frame_len_with_pad<= 0;
		o_cell_data_fifo_rd<= 0;
		data_fifo_din<= 0;
		ptr_fifo_wr<= 0;
		ptr_fifo_din<= 0;
		end
	else begin
		o_cell_data_fifo_rd<= 0;
		ptr_fifo_wr<= 0;
		if(byte_dv) byte_cnt<= byte_cnt+1;
		case(mstate)
		0:begin
			byte_dv<= 0;
			byte_cnt<= 0;
			if(!o_cell_data_fifo_empty & o_cell_data_fifo_dout[143] & !bp) begin  //
				frame_len<= {o_cell_data_fifo_dout[127:124],o_cell_data_fifo_dout[119:112]};  //
				frame_len_with_pad<= {o_cell_data_fifo_dout[127:124],o_cell_data_fifo_dout[119:112]};	
				mstate<=  1;
				end
			end
		1:begin
		//frame_len_with_pad用于存储包括本地包头和填充字节在内的帧长度值，
//		它是根据数据帧本地头中携带的帧长度值（包括本地头，但不包括填充字节）计算得到的
		
		
		
			if(frame_len_with_pad[5:0]!==6'b0) 
                        frame_len_with_pad<= {frame_len_with_pad[11:6],6'b0}+64;
                        frame_len<=  frame_len-2;		
                        byte_dv<= 1;
                        data_fifo_din<=  o_cell_data_fifo_dout[111:104];
                    mstate<= 5;                //本地包头不需要写入后级，跳过状234，直接进入5
                end
		2:begin
			data_fifo_din<=  o_cell_data_fifo_dout[127:120];
			mstate<= 3;
			end
		3:begin
			data_fifo_din<=  o_cell_data_fifo_dout[119:112];
			mstate<=  4;
			end
		4:begin
			data_fifo_din<=  o_cell_data_fifo_dout[111:104];
			mstate<= 5;
		  end 
		5:begin
			data_fifo_din<=  o_cell_data_fifo_dout[103:96];
			mstate<=  6;
			end
		6:begin
			data_fifo_din<=  o_cell_data_fifo_dout[95:88];
			mstate<=  7;
			end
		7:begin
			data_fifo_din<=  o_cell_data_fifo_dout[87:80];
			mstate<=  8;
			end
		8:begin
			data_fifo_din<=  o_cell_data_fifo_dout[79:72];
			mstate<=  9;
			end
		9:begin
			data_fifo_din<=  o_cell_data_fifo_dout[71:64];
			mstate<=  10;
			end
		10:begin
			data_fifo_din<=  o_cell_data_fifo_dout[63:56];
			mstate<=  11;
			end
		11:begin
			data_fifo_din<=  o_cell_data_fifo_dout[55:48];
			mstate<=  12;
			end
		12:begin
			data_fifo_din<=  o_cell_data_fifo_dout[47:40];
			mstate<=  13;
			end
		13:begin
			data_fifo_din<=  o_cell_data_fifo_dout[39:32];
			mstate<=  14;
			end
		14:begin
			data_fifo_din<=  o_cell_data_fifo_dout[31:24];
			mstate<= 15;
			end
		15:begin
			data_fifo_din<=  o_cell_data_fifo_dout[23:16];
			mstate<=  16;
			end
		16:begin
			data_fifo_din<=  o_cell_data_fifo_dout[15:8];
			o_cell_data_fifo_rd<= 1;
			if(frame_len_with_pad>16) begin
				frame_len_with_pad<= frame_len_with_pad-16;
				mstate<=  17;
				end
			else mstate<= 18;
			end
		17:begin
			data_fifo_din<=  o_cell_data_fifo_dout[7:0];
			mstate<=  2;
			end
		18:begin
			data_fifo_din<=  o_cell_data_fifo_dout[7:0];
			ptr_fifo_din<=  {4'b0,frame_len[11:0]};
			ptr_fifo_wr<=  1;
			mstate<=  0;
			end
		endcase
		end
assign data_fifo_wr=byte_dv & (byte_cnt<frame_len);
			
fifo_8x2k u_data_fifo(
  .clk(clk), 
  .rst(rstn), 
  .din(data_fifo_din[7:0]),  //mac_t中的数据FIFO
  .wr_en(data_fifo_wr), 
  .rd_en(data_fifo_rd), 
  .dout(data_fifo_dout[7:0]), 
  .full(), 
  .empty(),
  .data_count(data_fifo_depth[11:0])
);

fifo_16x256 u_ptr_fifo(
  .clk(clk),
  .rst(rstn), 
  .din(ptr_fifo_din[15:0]),     //mac_t中的指针FIFO
  .wr_en(ptr_fifo_wr), 
  .rd_en(ptr_fifo_rd), 
  .dout(ptr_fifo_dout[15:0]), 
  .full(ptr_fifo_full), 
  .empty(ptr_fifo_empty),
  .data_count()
  );
endmodule
