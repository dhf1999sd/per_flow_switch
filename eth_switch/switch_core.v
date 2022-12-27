`timescale 1ns / 1ps
module switch_core(
input					clk,
input					rst,
//switch_pre输入的数据和指针		
input		  [127:0]	i_cell_data_fifo_din,		
input		 			i_cell_data_fifo_wr,					
input		  [15:0]	i_cell_ptr_fifo_din,				
input		 			i_cell_ptr_fifo_wr,					
output	reg				i_cell_bp,
//与switch post相连的信号
output	reg				o_cell_fifo_wr,
output	reg  [3:0]		o_cell_fifo_sel,
output	     [127:0]	o_cell_fifo_din,
output					    o_cell_first,
output					    o_cell_last,
input		   [3:0]      o_cell_bp,
input 	       [31:0]    flow_id,
input          [2:0]      priority		
    );
reg 	[3:0]	qc_portmap;
wire 	[127:0]	sram_din_a;				
wire 	[127:0]	sram_dout_b;			
wire 	[11:0]	sram_addr_a;			
wire 	[11:0]	sram_addr_b;			
wire			sram_wr_a;				
reg  			i_cell_data_fifo_rd;	
wire [127:0]	i_cell_data_fifo_dout;	
wire [8:0]		i_cell_data_fifo_depth;	

reg				i_cell_ptr_fifo_rd;
wire [15:0]		i_cell_ptr_fifo_dout;
wire			i_cell_ptr_fifo_full;
wire			i_cell_ptr_fifo_empty;
reg	 [5:0]		cell_number;
reg				i_cell_last;
reg				i_cell_first;
			
reg  [15:0]		FQ_din;		
reg				FQ_wr;
reg				FQ_rd;
reg  [9:0]		FQ_dout;	

reg	 [1:0]		sram_cnt_a;	
reg	 [1:0]		sram_cnt_b;
reg				sram_rd;	
reg				sram_rd_dv;
reg  [4:0]		wr_state;		
reg  [3:0]		qc_wr_ptr_wr_en;
wire			qc_ptr_full0;
wire			qc_ptr_full1;
wire			qc_ptr_full2;
wire			qc_ptr_full3;
reg				qc_ptr_full;
wire [9:0]		ptr_dout_s;		
reg  [15:0]		qc_wr_ptr_din;	
		
wire 			FQ_empty;
wire[11:0]		MC_ram_addra;	
wire [3:0]		MC_ram_dina;	
reg	 			MC_ram_wra;		
reg				MC_ram_wrb;		
reg  [3:0]		MC_ram_dinb;	
wire [3:0]		MC_ram_doutb;	
reg [5:0]addr_num;




 reg [31:0]flow_id_0 ;
 reg [9:0]addr_0;
 reg [5:0]addr_num_0;
 reg w_en_0;
reg[2:0]priority_0;

 reg [31:0]flow_id_1 ;
 reg [9:0]addr_1;
 reg [5:0]addr_num_1;
 reg w_en_1;
reg[2:0]priority_1;

 reg [31:0]flow_id_2 ;
 reg [9:0]addr_2;
 reg [5:0]addr_num_2;
 reg w_en_2;
reg[2:0]priority_2;

 reg [31:0]flow_id_3 ;
 reg [9:0]addr_3;
 reg [5:0]addr_num_3;
 reg w_en_3;
reg[2:0]priority_3;


wire  qc0_rd_access0;     //可以读有效,读的标志位。一个来
wire  qc0_rd_access1;
wire  qc0_rd_access2;
wire  qc0_rd_access3;
wire  qc0_rd_access4;
wire  qc0_rd_access5;
wire qc0_rd_access6;
wire  qc0_rd_access7;

 wire qc0_r_en0;       //读使能
 wire qc0_r_en1;
 wire qc0_r_en2;
 wire qc0_r_en3;
 wire qc0_r_en4;
 wire qc0_r_en5;
 wire qc0_r_en6;
 wire qc0_r_en7;

 wire qc0_done0;
 wire qc0_done1;
 wire qc0_done2;
 wire qc0_done3;
 wire qc0_done4;
 wire qc0_done5;
 wire qc0_done6;
 wire qc0_done7;

 wire[9:0] qc0_addr_new0;       //给一个新头
 wire[9:0] qc0_addr_new1;
 wire[9:0] qc0_addr_new2;
 wire[9:0] qc0_addr_new3;
 wire[9:0] qc0_addr_new4;
 wire[9:0] qc0_addr_new5;
 wire[9:0] qc0_addr_new6;
 wire[9:0] qc0_addr_new7;


wire [9:0] qc0_addr_head0;
wire [9:0] qc0_addr_head1;
wire [9:0] qc0_addr_head2;
wire [9:0] qc0_addr_head3;
wire [9:0] qc0_addr_head4;
wire [9:0] qc0_addr_head5;
wire [9:0] qc0_addr_head6;
wire [9:0] qc0_addr_head7;

wire qc0_addr_head_valid0;
wire qc0_addr_head_valid1;
wire qc0_addr_head_valid2;
wire qc0_addr_head_valid3;
wire qc0_addr_head_valid4;
wire qc0_addr_head_valid5;
wire qc0_addr_head_valid6;
wire qc0_addr_head_valid7;


wire  qc1_rd_access0;     //可以读有效,读的标志位。一个来
wire  qc1_rd_access1;
wire  qc1_rd_access2;
wire  qc1_rd_access3;
wire  qc1_rd_access4;
wire  qc1_rd_access5;
wire qc1_rd_access6;
wire  qc1_rd_access7;

 wire qc1_r_en0;       //读使能
 wire qc1_r_en1;
 wire qc1_r_en2;
 wire qc1_r_en3;
 wire qc1_r_en4;
 wire qc1_r_en5;
 wire qc1_r_en6;
 wire qc1_r_en7;

 wire qc1_done0;
 wire qc1_done1;
 wire qc1_done2;
 wire qc1_done3;
 wire qc1_done4;
 wire qc1_done5;
 wire qc1_done6;
 wire qc1_done7;

 wire[9:0] qc1_addr_new0;       //给一个新头
 wire[9:0] qc1_addr_new1;
 wire[9:0] qc1_addr_new2;
 wire[9:0] qc1_addr_new3;
 wire[9:0] qc1_addr_new4;
 wire[9:0] qc1_addr_new5;
 wire[9:0] qc1_addr_new6;
 wire[9:0] qc1_addr_new7;


wire [9:0] qc1_addr_head0;
wire [9:0] qc1_addr_head1;
wire [9:0] qc1_addr_head2;
wire [9:0] qc1_addr_head3;
wire [9:0] qc1_addr_head4;
wire [9:0] qc1_addr_head5;
wire [9:0] qc1_addr_head6;
wire [9:0] qc1_addr_head7;

wire qc1_addr_head_valid0;
wire qc1_addr_head_valid1;
wire qc1_addr_head_valid2;
wire qc1_addr_head_valid3;
wire qc1_addr_head_valid4;
wire qc1_addr_head_valid5;
wire qc1_addr_head_valid6;
wire qc1_addr_head_valid7;



wire  qc2_rd_access0;     //可以读有效,读的标志位。一个来
wire  qc2_rd_access1;
wire  qc2_rd_access2;
wire  qc2_rd_access3;
wire  qc2_rd_access4;
wire  qc2_rd_access5;
wire  qc2_rd_access6;
wire  qc2_rd_access7;

 wire qc2_r_en0;       //读使能
 wire qc2_r_en1;
 wire qc2_r_en2;
 wire qc2_r_en3;
 wire qc2_r_en4;
 wire qc2_r_en5;
 wire qc2_r_en6;
 wire qc2_r_en7;

 wire qc2_done0;
 wire qc2_done1;
 wire qc2_done2;
 wire qc2_done3;
 wire qc2_done4;
 wire qc2_done5;
 wire qc2_done6;
 wire qc2_done7;

 wire[9:0] qc2_addr_new0;       //给一个新头
 wire[9:0] qc2_addr_new1;
 wire[9:0] qc2_addr_new2;
 wire[9:0] qc2_addr_new3;
 wire[9:0] qc2_addr_new4;
 wire[9:0] qc2_addr_new5;
 wire[9:0] qc2_addr_new6;
 wire[9:0] qc2_addr_new7;


wire [9:0] qc2_addr_head0;
wire [9:0] qc2_addr_head1;
wire [9:0] qc2_addr_head2;
wire [9:0] qc2_addr_head3;
wire [9:0] qc2_addr_head4;
wire [9:0] qc2_addr_head5;
wire [9:0] qc2_addr_head6;
wire [9:0] qc2_addr_head7;

wire qc2_addr_head_valid0;
wire qc2_addr_head_valid1;
wire qc2_addr_head_valid2;
wire qc2_addr_head_valid3;
wire qc2_addr_head_valid4;
wire qc2_addr_head_valid5;
wire qc2_addr_head_valid6;
wire qc2_addr_head_valid7;





wire  qc3_rd_access0;     //可以读有效,读的标志位。一个来
wire  qc3_rd_access1;
wire  qc3_rd_access2;
wire  qc3_rd_access3;
wire  qc3_rd_access4;
wire  qc3_rd_access5;
wire  qc3_rd_access6;
wire  qc3_rd_access7;

 wire qc3_r_en0;       //读使能
 wire qc3_r_en1;
 wire qc3_r_en2;
 wire qc3_r_en3;
 wire qc3_r_en4;
 wire qc3_r_en5;
 wire qc3_r_en6;
 wire qc3_r_en7;

 wire qc3_done0;
 wire qc3_done1;
 wire qc3_done2;
 wire qc3_done3;
 wire qc3_done4;
 wire qc3_done5;
 wire qc3_done6;
 wire qc3_done7;

 wire[9:0] qc3_addr_new0;       //给一个新头
 wire[9:0] qc3_addr_new1;
 wire[9:0] qc3_addr_new2;
 wire[9:0] qc3_addr_new3;
 wire[9:0] qc3_addr_new4;
 wire[9:0] qc3_addr_new5;
 wire[9:0] qc3_addr_new6;
 wire[9:0] qc3_addr_new7;


wire [9:0] qc3_addr_head0;
wire [9:0] qc3_addr_head1;
wire [9:0] qc3_addr_head2;
wire [9:0] qc3_addr_head3;
wire [9:0] qc3_addr_head4;
wire [9:0] qc3_addr_head5;
wire [9:0] qc3_addr_head6;
wire [9:0] qc3_addr_head7;

wire qc3_addr_head_valid0;
wire qc3_addr_head_valid1;
wire qc3_addr_head_valid2;
wire qc3_addr_head_valid3;
wire qc3_addr_head_valid4;
wire qc3_addr_head_valid5;
wire qc3_addr_head_valid6;
wire qc3_addr_head_valid7;


always@(posedge clk)
	qc_ptr_full<= ({qc_ptr_full3,qc_ptr_full2,qc_ptr_full1,qc_ptr_full0}==4'b0)?0:1;
//输入信元缓冲区，Fall_Through模式
fifo_128x256 u_i_cell_ft_fifo(
  .clk(clk), 
  .rst(rst), 
  .din(i_cell_data_fifo_din[127:0]), 
  .wr_en(i_cell_data_fifo_wr), 
  .rd_en(i_cell_data_fifo_rd), 
  .dout(i_cell_data_fifo_dout[127:0]), 
  .full(), 
  .empty(),
  .data_count(i_cell_data_fifo_depth[8:0])
);
always @(posedge clk) 
	i_cell_bp<= (i_cell_data_fifo_depth[8:0]>161) | i_cell_ptr_fifo_full;

fifo_16x256 u_ptr_ft_fifo (
  .clk(clk), 					// input clk
  .rst(rst), 					// input rst
  .din(i_cell_ptr_fifo_din), 	// input [15 : 0] din
  .wr_en(i_cell_ptr_fifo_wr), 	// input wr_en
  .rd_en(i_cell_ptr_fifo_rd), 	// input rd_en
  .dout(i_cell_ptr_fifo_dout), 	// output [15 : 0] dout        
  .full(i_cell_ptr_fifo_full), 	// output full
  .empty(i_cell_ptr_fifo_empty),// output empty
  .data_count() 				// output [5 : 0] data_count
);


//==========================================================
//写入状态机
//===============================================================
always@(posedge clk or negedge rst)
	if(rst)
		begin
		wr_state<=  0;
		FQ_rd<=  0;
		MC_ram_wra<= 0;
		sram_cnt_a<=  0;
		i_cell_data_fifo_rd<=  0;
		i_cell_ptr_fifo_rd<= 0;
		qc_wr_ptr_wr_en<= 0;
		qc_wr_ptr_din<=  0;
		FQ_dout<=0;
		qc_portmap<= 0;
		cell_number<= 0;
		i_cell_last<= 0;
		i_cell_first<= 0;
		end
	else
		begin
		MC_ram_wra<=  0;              //多播计数器允许写入标志
		FQ_rd<=  0;
		qc_wr_ptr_wr_en<=  0;
		i_cell_ptr_fifo_rd<=  0;
		case(wr_state)
		0:begin
			sram_cnt_a<=  0;
			i_cell_last<= 0;
			i_cell_first<= 0;
			//输入指针缓冲区非空，队列控制器入口处的指针缓冲区均非满，
			//自由指针缓冲区非空时，可以将信源写入数据缓冲区
			//第一步先写进缓冲区FIFO中
			if(!i_cell_ptr_fifo_empty & !qc_ptr_full & !FQ_empty)begin   //存够一个信元后，存入SRAM里面
				i_cell_data_fifo_rd<=  1;                            //sram_wr_a=i_cell_data_fifo_rd;开始往sram的a端口写入
				i_cell_ptr_fifo_rd<=  1;
				qc_portmap<= i_cell_ptr_fifo_dout[11:8];      //这里的指的是映射
				FQ_rd<=  1;               //从地址分配器中读取一个自由指针
				FQ_dout<=  ptr_dout_s;        //读取到的自由指针，确定sram的地址
				cell_number[5:0]<= i_cell_ptr_fifo_dout[5:0];//信源的个数
				addr_num[5:0]<=i_cell_ptr_fifo_dout[5:0]; //以信源的个数作为地址的个数
				i_cell_first<= 1;
				if(i_cell_ptr_fifo_dout[5:0]==6'd1) i_cell_last<= 1;       //链表尾部指针为1，则只有一个信源
				wr_state<=1;			
				end
			end
		1:begin			
			cell_number<=cell_number-1;           //每写入一次，减一
			sram_cnt_a<= 1;                   //sram_cnt_a,存储一个完整信源占据的128位存储单元的个数
			qc_wr_ptr_din<=  {i_cell_last,i_cell_first,1'b0,priority,FQ_dout};  //进入队列的数据，15位是尾信源指示位，14是首信源
			if(qc_portmap[0])begin
			qc_wr_ptr_wr_en[0]<=  1;                       //根据映射的端口号，选择进入的队列
			 flow_id_0<= flow_id ;
             addr_num_0<=addr_num;
              priority_0<=priority;end
			if(qc_portmap[1])begin
              qc_wr_ptr_wr_en[1]<=  1;                       //根据映射的端口号，选择进入的队列
               flow_id_1<= flow_id ;
               addr_num_1<=addr_num;
                priority_1<=priority;end
			if(qc_portmap[2])begin
                    qc_wr_ptr_wr_en[2]<=  1;                       //根据映射的端口号，选择进入的队列
                     flow_id_2<= flow_id ;
                 
                     addr_num_2<=addr_num;
                      priority_2<=priority;end		
			if(qc_portmap[3])begin
                      qc_wr_ptr_wr_en[3]<=  1;                       //根据映射的端口号，选择进入的队列
                       flow_id_3<= flow_id ;

                       addr_num_3<=addr_num;
                        priority_3<=priority;end
                        MC_ram_wra<=  1;       //多播计数器开始写入，保存信源要去的端口数
                        wr_state<=  2;
		  end
		2:begin
			sram_cnt_a<=  2;                         //sram计数器
			 wr_state<=  3;
		  end
		3:begin
			sram_cnt_a<=  3;
			wr_state<= 4;
		  end
		4:begin
			i_cell_first<=  0;                  //链表开始的地方
			if(cell_number) begin                  //cell number还能存储
				if(!FQ_empty)begin                     //自由指针缓冲区
					FQ_rd		<=  1;
					FQ_dout		<=  ptr_dout_s;
					sram_cnt_a	<=  0;	
					wr_state	<= 1;
					if(cell_number==1) i_cell_last<= 1;
					else i_cell_last<= 0;
					end
				end
			else begin          //读完了，说明
				i_cell_data_fifo_rd<= 0;  
				wr_state	<= 0;
				end
			end
		default:wr_state<=  0;
		endcase
		end
		
always@(posedge clk or negedge rst) begin 
if(rst)begin


 w_en_0<=0;
 w_en_1<=0;
 w_en_2<=0;
 w_en_3<=0;
end
else begin

 if(qc_portmap[0]==1)begin w_en_0<=i_cell_data_fifo_rd;addr_0<=FQ_dout[9:0]; end
 if(qc_portmap[1]==1)begin w_en_1<=i_cell_data_fifo_rd;addr_1<=FQ_dout[9:0];end
 if(qc_portmap[2]==1)begin w_en_2<=i_cell_data_fifo_rd;addr_2<=FQ_dout[9:0];end
 if(qc_portmap[3]==1)begin w_en_3<=i_cell_data_fifo_rd;addr_3<=FQ_dout[9:0];end
 end
 end

assign  sram_wr_a=i_cell_data_fifo_rd;
assign	  sram_addr_a={FQ_dout[9:0],sram_cnt_a[1:0]};        //写入数据的地址
assign	sram_din_a=i_cell_data_fifo_dout[127:0];		     //写入数据

assign MC_ram_addra= {2'b0,FQ_dout[9:0]};                        //多播计数器a口地址信号
assign MC_ram_dina = qc_portmap[0]+qc_portmap[1]+qc_portmap[2]+qc_portmap[3];//多播计数器A口输入

//========================================================
//读出状态机
//========================================================

reg  [3:0]		rd_state;
wire [15:0]		qc_rd_ptr_dout0,qc_rd_ptr_dout1,
                qc_rd_ptr_dout2,qc_rd_ptr_dout3;
reg  [1:0]		RR;
reg  [3:0]		ptr_ack;
wire [3:0]		ptr_rd_req_pre;

wire			ptr_rdy0,ptr_rdy1,ptr_rdy2,ptr_rdy3;		
wire			ptr_ack0,ptr_ack1,ptr_ack2,ptr_ack3;
wire           [9:0]frame_num_0,frame_num_1,frame_num_2,frame_num_3;
wire           [9:0]flow_tail_addr_0,flow_tail_addr_1,flow_tail_addr_2,flow_tail_addr_3;
wire           info_valid_0,info_valid_1,info_valid_2,info_valid_3;

assign	  ptr_rd_req_pre={ptr_rdy3,ptr_rdy2,ptr_rdy1,ptr_rdy0} & (~o_cell_bp);     
//在某个队列中有完整数据帧，且对应输出端口无反压
assign  	{ptr_ack3,ptr_ack2,ptr_ack1,ptr_ack0}=ptr_ack;
assign   	sram_addr_b={FQ_din[9:0],sram_cnt_b[1:0]};         //从sram中确定地址
assign	o_cell_last=FQ_din[15];                            //位15是尾信源指示位
assign	o_cell_first=FQ_din[14];                            //位14是首信源指示位
assign	o_cell_fifo_din[127:0]= sram_dout_b[127:0];
always@(posedge clk or negedge rst)
	if(rst)begin
		rd_state<=  4'd0;
		FQ_wr<=  0;
		FQ_din<=  0;
		MC_ram_wrb<=  0;
		MC_ram_dinb<=  0;
		RR<=  0;
		ptr_ack<=  0;
		sram_rd<=  0;
		sram_rd_dv<=  0;
		sram_cnt_b<=  0;
		o_cell_fifo_wr<= 0;
		o_cell_fifo_sel<=  0;
		end
	else begin
            FQ_wr<=  0;
            MC_ram_wrb<=  0;
            ptr_ack<=  0;
            o_cell_fifo_wr<= sram_rd;
		case(rd_state)
		4'd0:begin
			sram_rd<= 0;
			sram_cnt_b<=  0;
			//当任意一个队列管理器中有完整的数据帧时，开始读出,读出
			if(ptr_rd_req_pre)	rd_state<= 4'd1;	 
			end
		
		4'd1:begin
			rd_state<=  4'd2;
			sram_rd<=  1;          //开始写入post电路
			RR<= RR+2'b01;
			//采用公平的轮询机制，轮流对四个端口进行发送轮询
			case(RR)						
			0:begin							
				casex(ptr_rd_req_pre[3:0])  //从0端口开始轮询
				4'bxxx1:begin FQ_din<=  qc_rd_ptr_dout0; o_cell_fifo_sel<=  4'b0001; ptr_ack<=  4'b0001; end        //0号端口准备好，将指针存入
				4'bxx10:begin FQ_din<=  qc_rd_ptr_dout1; o_cell_fifo_sel<=  4'b0010; ptr_ack<=  4'b0010; end
				4'bx100:begin FQ_din<=  qc_rd_ptr_dout2; o_cell_fifo_sel<=  4'b0100; ptr_ack<=  4'b0100; end
				4'b1000:begin FQ_din<=  qc_rd_ptr_dout3; o_cell_fifo_sel<=  4'b1000; ptr_ack<=  4'b1000; end
				endcase
			end
			1:begin
				casex({ptr_rd_req_pre[0],ptr_rd_req_pre[3:1]})//从1端口开始
				4'bxxx1:begin FQ_din<=  qc_rd_ptr_dout1; o_cell_fifo_sel<=  4'b0010; ptr_ack<=  4'b0010; end 
				
				4'bxx10:begin FQ_din<=  qc_rd_ptr_dout2; o_cell_fifo_sel<= 4'b0100; ptr_ack<=  4'b0100; end
				
				4'bx100:begin FQ_din<=  qc_rd_ptr_dout3; o_cell_fifo_sel<=  4'b1000; ptr_ack<=  4'b1000; end
				
				4'b1000:begin FQ_din<=  qc_rd_ptr_dout0; o_cell_fifo_sel<=  4'b0001; ptr_ack<=  4'b0001; end
				endcase
			end
			2:begin
				casex({ptr_rd_req_pre[1:0],ptr_rd_req_pre[3:2]}) //从2端口开始
				4'bxxx1:begin FQ_din<=  qc_rd_ptr_dout2; o_cell_fifo_sel<=  4'b0100; ptr_ack<=  4'b0100; end
				4'bxx10:begin FQ_din<=  qc_rd_ptr_dout3; o_cell_fifo_sel<=  4'b1000; ptr_ack<=  4'b1000; end
				4'bx100:begin FQ_din<=  qc_rd_ptr_dout0; o_cell_fifo_sel<=  4'b0001; ptr_ack<=  4'b0001; end
				4'b1000:begin FQ_din<=  qc_rd_ptr_dout1; o_cell_fifo_sel<=  4'b0010; ptr_ack<=  4'b0010; end
				endcase
			end
			3:begin
				casex({ptr_rd_req_pre[2:0],ptr_rd_req_pre[3]})//从3端口开始
				4'bxxx1:begin FQ_din<=  qc_rd_ptr_dout3; o_cell_fifo_sel<=  4'b1000; ptr_ack<=  4'b1000; end
				4'bxx10:begin FQ_din<=  qc_rd_ptr_dout0; o_cell_fifo_sel<=  4'b0001; ptr_ack<=  4'b0001; end
				4'bx100:begin FQ_din<=  qc_rd_ptr_dout1; o_cell_fifo_sel<=  4'b0010; ptr_ack<=  4'b0010; end
				4'b1000:begin FQ_din<=  qc_rd_ptr_dout2; o_cell_fifo_sel<=  4'b0100; ptr_ack<=  4'b0100; end
				endcase
				end
			endcase
			end
	
		4'd2: begin
            ptr_ack<=  0;  
			 //完毕
			sram_cnt_b<=  sram_cnt_b+1; //计数器加一
			rd_state<=  4'd3;
		  end
		4'd3:begin
		
			sram_cnt_b<=  sram_cnt_b+1;
			MC_ram_wrb<=  1;
			if(MC_ram_doutb==1)	 //多播计数器输出,存储的是需要往几个端口发送数据，最后一个端口数量
				begin
				MC_ram_dinb<=  0;
				FQ_wr<=  1;
				end
			else            //不是最后一个端口数量
				MC_ram_dinb<=  MC_ram_doutb-1;
			    rd_state<=  4'd4;
		  end
		4'd4:begin
			sram_cnt_b<=  sram_cnt_b+1;         //
			rd_state<=  4'd5;
		  end
		4'd5:begin
			sram_rd<=  0;
			rd_state<=  3'd0;
		  end
		default:rd_state<=  3'd0;
		
		endcase
		end

address_assign u_add_assign (              //自由指针队列管理
	.clk(clk), 
	.rst(rst), 
	.ptr_din({6'b0,FQ_din[9:0]}), 
	.FQ_wr(FQ_wr), 
	.FQ_rd(FQ_rd), 
	.ptr_dout_s(ptr_dout_s), 
	.ptr_fifo_empty(FQ_empty)        //FQ_empty==1   自由指针用完了
);

//多播计数器是一块双端口的RAM
dpsram_w4_d512 u_MC_dpram (          //多播计数器保存一个数值，这个数值表示要去往的端口数
  .clka(clk), 				
  .wea(MC_ram_wra), 		 //一个信源进入数据存储区后，写入状态机将对应的多播计数值从A端口写入
  .addra(MC_ram_addra[8:0]), 	
  .dina(MC_ram_dina), 		
  .douta(), 				
  .clkb(clk), 				
  .web(MC_ram_wrb), 		 //一个信源进入数据存储区后，写入状态机将对应的多播计数值从A端口写入
  .addrb(FQ_din[8:0]), 	
  .dinb(MC_ram_dinb), 		
  .doutb(MC_ram_doutb) 		
);

switch_qc  u_switch_qc_0 (
    .clk                     ( clk                        ),
    .rst                     ( rst                        ),
    .q_din                   ( qc_wr_ptr_din             ),
    .q_wr                    ( qc_wr_ptr_wr_en[0]                     ),
    .flow_tail_address     ( flow_tail_addr_0    ),
    .flow_frame_num      ( frame_num_0        ),
    .info_valid(info_valid_0),
    .ptr_rdy         (ptr_rdy0),
    .ptr_ack       (ptr_ack0),
    .rd_access0              ( qc0_rd_access0                 ),
    .rd_access1              ( qc0_rd_access1                 ),
    .rd_access2              ( qc0_rd_access2                 ),
    .rd_access3              ( qc0_rd_access3                 ),
    .rd_access4              ( qc0_rd_access4                 ),
    .rd_access5              ( qc0_rd_access5                 ),
    .rd_access6              ( qc0_rd_access6                 ),
    .rd_access7              ( qc0_rd_access7                 ),
    .addr_head0              ( qc0_addr_head0        ),
    .addr_head1              ( qc0_addr_head1        ),
    .addr_head2              ( qc0_addr_head2          ),
    .addr_head3              ( qc0_addr_head3      ),
    .addr_head4              ( qc0_addr_head4           ),
    .addr_head5              ( qc0_addr_head5        ),
    .addr_head6              ( qc0_addr_head6         ),
    .addr_head7              ( qc0_addr_head7        ),
    .addr_head_valid0        ( qc0_addr_head_valid0           ),
    .addr_head_valid1        ( qc0_addr_head_valid1           ),
    .addr_head_valid2        ( qc0_addr_head_valid2           ),
    .addr_head_valid3        ( qc0_addr_head_valid3           ),
    .addr_head_valid4        ( qc0_addr_head_valid4           ),
    .addr_head_valid5        ( qc0_addr_head_valid5           ),
    .addr_head_valid6        ( qc0_addr_head_valid6           ),
    .addr_head_valid7        ( qc0_addr_head_valid7           ),
    .q_full                  ( qc_ptr_full0                     ),
    .ptr_dout             ( qc_rd_ptr_dout0   ),
    .r_en0                   ( qc0_r_en0                      ),
    .r_en1                   (qc0_r_en1                      ),
    .r_en2                   ( qc0_r_en2                      ),
    .r_en3                   ( qc0_r_en3                      ),
    .r_en4                   ( qc0_r_en4                      ),
    .r_en5                   ( qc0_r_en5                      ),
    .r_en6                   ( qc0_r_en6                      ),
    .r_en7                   ( qc0_r_en7                      ),
    .done0                   ( qc0_done0                      ),
    .done1                   ( qc0_done1                      ),
    .done2                   ( qc0_done2                      ),
    .done3                   ( qc0_done3                      ),
    .done4                   ( qc0_done4                      ),
    .done5                   ( qc0_done5                      ),
    .done6                   ( qc0_done6                      ),
    .done7                   ( qc0_done7                      ),
    .addr_new0      (  qc0_addr_new0         ),
    .addr_new1      (  qc0_addr_new1         ),
    .addr_new2      (  qc0_addr_new2         ),
    .addr_new3      (  qc0_addr_new3         ),
    . addr_new4      (  qc0_addr_new4         ),
    .addr_new5      (  qc0_addr_new5         ),
    .addr_new6      ( qc0_addr_new6         ),
    .addr_new7      (  qc0_addr_new7         )
);

switch_qc  u_switch_qc_1(
    .clk                     ( clk                        ),
    .rst                     ( rst                        ),
    .q_din                   ( qc_wr_ptr_din             ),
    .q_wr                    ( qc_wr_ptr_wr_en[1]    ),
    .flow_tail_address       ( flow_tail_addr_1 ),
    .flow_frame_num          ( frame_num_1       ),
    .ptr_rdy         (ptr_rdy1),
    .ptr_ack       (ptr_ack1),
     .info_valid              (info_valid_1),
    .rd_access0              ( qc1_rd_access0                 ),
    .rd_access1              ( qc1_rd_access1                 ),
    .rd_access2              ( qc1_rd_access2                 ),
    .rd_access3              ( qc1_rd_access3                 ),
    .rd_access4              ( qc1_rd_access4                 ),
    .rd_access5              ( qc1_rd_access5                 ),
    .rd_access6              ( qc1_rd_access6                 ),
    .rd_access7              ( qc1_rd_access7                 ),
    .addr_head0              ( qc1_addr_head0         ),
    .addr_head1              ( qc1_addr_head1          ),
    .addr_head2              ( qc1_addr_head2         ),
    .addr_head3              ( qc1_addr_head3           ),
    .addr_head4              ( qc1_addr_head4         ),
    .addr_head5              ( qc1_addr_head5        ),
    .addr_head6              ( qc1_addr_head6        ),
    .addr_head7              ( qc1_addr_head7          ),
    .addr_head_valid0        ( qc1_addr_head_valid0           ),
    .addr_head_valid1        ( qc1_addr_head_valid1           ),
    .addr_head_valid2        ( qc1_addr_head_valid2           ),
    .addr_head_valid3        ( qc1_addr_head_valid3           ),
    .addr_head_valid4        ( qc1_addr_head_valid4           ),
    .addr_head_valid5        ( qc1_addr_head_valid5           ),
    .addr_head_valid6        ( qc1_addr_head_valid6           ),
    .addr_head_valid7        ( qc1_addr_head_valid7           ),
    .q_full                  ( qc_ptr_full1                     ),
    .ptr_dout             ( qc_rd_ptr_dout1   ),
    .r_en0                   ( qc1_r_en0                      ),
    .r_en1                   ( qc1_r_en1                      ),
    .r_en2                   ( qc1_r_en2                      ),
    .r_en3                   ( qc1_r_en3                      ),
    .r_en4                   ( qc1_r_en4                      ),
    .r_en5                   ( qc1_r_en5                      ),
    .r_en6                   ( qc1_r_en6                      ),
    .r_en7                   ( qc1_r_en7                      ),
    .done0                   ( qc1_done0                      ),
    .done1                   ( qc1_done1                      ),
    .done2                   ( qc1_done2                      ),
    .done3                   ( qc1_done3                      ),
    .done4                   ( qc1_done4                      ),
    .done5                   ( qc1_done5                      ),
    .done6                   ( qc1_done6                      ),
    .done7                   ( qc1_done7                      ),
    .addr_new0      (  qc1_addr_new0         ),
    .addr_new1      ( qc1_addr_new1         ),
    .addr_new2      (  qc1_addr_new2         ),
    .addr_new3      (  qc1_addr_new3         ),
    . addr_new4      ( qc1_addr_new4         ),
    .addr_new5      (  qc1_addr_new5         ),
    .addr_new6      ( qc1_addr_new6         ),
    .addr_new7      (  qc1_addr_new7         )
);

switch_qc  u_switch_qc_2 (
    .clk                     ( clk                        ),
    .rst                     ( rst                        ),
    .q_din                   ( qc_wr_ptr_din             ),
    .q_wr                    ( qc_wr_ptr_wr_en[2]                     ),
    .flow_tail_address       ( flow_tail_addr_2   ),
    .flow_frame_num          ( frame_num_2             ),
      .info_valid             (info_valid_2),
       .ptr_rdy         (ptr_rdy2),
       .ptr_ack       (ptr_ack2),
    .rd_access0              ( qc2_rd_access0                 ),
    .rd_access1              ( qc2_rd_access1                 ),
    .rd_access2              ( qc2_rd_access2                 ),
    .rd_access3              ( qc2_rd_access3                 ),
    .rd_access4              ( qc2_rd_access4                 ),
    .rd_access5              ( qc2_rd_access5                 ),
    .rd_access6              ( qc2_rd_access6                 ),
    .rd_access7              ( qc2_rd_access7                 ),
    .addr_head0              ( qc2_addr_head0           ),
    .addr_head1              ( qc2_addr_head1          [9:0] ),
    .addr_head2              ( qc2_addr_head2          [9:0] ),
    .addr_head3              ( qc2_addr_head3          [9:0] ),
    .addr_head4              ( qc2_addr_head4          [9:0] ),
    .addr_head5              ( qc2_addr_head5          [9:0] ),
    .addr_head6              ( qc2_addr_head6          [9:0] ),
    .addr_head7              ( qc2_addr_head7          [9:0] ),
    .addr_head_valid0        ( qc2_addr_head_valid0           ),
    .addr_head_valid1        ( qc2_addr_head_valid1           ),
    .addr_head_valid2        ( qc2_addr_head_valid2           ),
    .addr_head_valid3        ( qc2_addr_head_valid3           ),
    .addr_head_valid4        ( qc2_addr_head_valid4           ),
    .addr_head_valid5        ( qc2_addr_head_valid5           ),
    .addr_head_valid6        ( qc2_addr_head_valid6           ),
    .addr_head_valid7        ( qc2_addr_head_valid7           ),
    .q_full                  ( qc_ptr_full2                   ),
    .ptr_dout             ( qc_rd_ptr_dout2   ),
    .r_en0                   ( qc2_r_en0                      ),
    .r_en1                   ( qc2_r_en1                      ),
    .r_en2                   ( qc2_r_en2                      ),
    .r_en3                   ( qc2_r_en3                      ),
    .r_en4                   ( qc2_r_en4                      ),
    .r_en5                   ( qc2_r_en5                      ),
    .r_en6                   ( qc2_r_en6                      ),
    .r_en7                   ( qc2_r_en7                      ),
    .done0                   ( qc2_done0                      ),
    .done1                   ( qc2_done1                      ),
    .done2                   ( qc2_done2                      ),
    .done3                   ( qc2_done3                      ),
    .done4                   ( qc2_done4                      ),
    .done5                   ( qc2_done5                      ),
    .done6                   ( qc2_done6                      ),
    .done7                   ( qc2_done7                      ),
    .addr_new0      (  qc2_addr_new0         ),
    .addr_new1      (  qc2_addr_new1         ),
    .addr_new2      (  qc2_addr_new2         ),
    .addr_new3      (  qc2_addr_new3         ),
    . addr_new4      (  qc2_addr_new4         ),
    .addr_new5      (  qc2_addr_new5         ),
    .addr_new6      ( qc2_addr_new6         ),
    .addr_new7      (  qc2_addr_new7         )
);

switch_qc  u_switch_qc_3 (
    .clk                     ( clk                        ),
    .rst                     ( rst                       ),
    .q_din                   ( qc_wr_ptr_din             ),
    .q_wr                    ( qc_wr_ptr_wr_en[3]    ),
    .flow_tail_address       ( flow_tail_addr_3   ),
    .flow_frame_num          ( frame_num_3       ),
     .info_valid                (info_valid_3),
      .ptr_rdy         (ptr_rdy3),
      .ptr_ack        (ptr_ack3),
    .rd_access0              ( qc3_rd_access0                 ),
    .rd_access1              ( qc3_rd_access1                 ),
    .rd_access2              ( qc3_rd_access2                 ),
    .rd_access3              ( qc3_rd_access3                 ),
    .rd_access4              ( qc3_rd_access4                 ),
    .rd_access5              ( qc3_rd_access5                 ),
    .rd_access6              ( qc3_rd_access6                 ),
    .rd_access7              ( qc3_rd_access7                 ),
    .addr_head0              ( qc3_addr_head0          ),
    .addr_head1              ( qc3_addr_head1          ),
    .addr_head2              ( qc3_addr_head2         ),
    .addr_head3              ( qc3_addr_head3          ),
    .addr_head4              ( qc3_addr_head4        ),
    .addr_head5              ( qc3_addr_head5          ),
    .addr_head6              ( qc3_addr_head6         ),
    .addr_head7              ( qc3_addr_head7         ),
    .addr_head_valid0        ( qc3_addr_head_valid0           ),
    .addr_head_valid1        ( qc3_addr_head_valid1           ),
    .addr_head_valid2        ( qc3_addr_head_valid2           ),
    .addr_head_valid3        ( qc3_addr_head_valid3           ),
    .addr_head_valid4        ( qc3_addr_head_valid4           ),
    .addr_head_valid5        ( qc3_addr_head_valid5           ),
    .addr_head_valid6        ( qc3_addr_head_valid6           ),
    .addr_head_valid7        ( qc3_addr_head_valid7           ),

    .q_full                  ( qc_ptr_full3           ),
    .ptr_dout             ( qc_rd_ptr_dout3   ),
    .r_en0                   ( qc3_r_en0                      ),
    .r_en1                   ( qc3_r_en1                      ),
    .r_en2                   ( qc3_r_en2                      ),
    .r_en3                   (qc3_r_en3                      ),
    .r_en4                   ( qc3_r_en4                      ),
    .r_en5                   ( qc3_r_en5                      ),
    .r_en6                   ( qc3_r_en6                      ),
    .r_en7                   ( qc3_r_en7                      ),
    .done0                   ( qc3_done0                      ),
    .done1                   ( qc3_done1                      ),
    .done2                   ( qc3_done2                      ),
    .done3                   ( qc3_done3                      ),
    .done4                   ( qc3_done4                      ),
    .done5                   ( qc3_done5                      ),
    .done6                   ( qc3_done6                      ),
    .done7                   ( qc3_done7                      ),
    .addr_new0      (  qc3_addr_new0         ),
    .addr_new1      (  qc3_addr_new1         ),
    .addr_new2      (  qc3_addr_new2         ),
    .addr_new3      (  qc3_addr_new3         ),
    . addr_new4      (  qc3_addr_new4         ),
    .addr_new5      (  qc3_addr_new5         ),
    .addr_new6      ( qc3_addr_new6         ),
    .addr_new7      (  qc3_addr_new7         )
);

  
    
  dynamic_flow_new  u_dynamic_flow_0 (
        .clk                     ( clk                  ),
        .rst_n                  (!rst                 ),
        .flow_id               (flow_id_0           ),
        .addr                   (addr_0               ),
        .addr_num          (addr_num_0     ),
        .w_en                   ( w_en_0            ),
        .priority                (priority_0          ),
        .frame_num(frame_num_0),
        .flow_tail_addr(flow_tail_addr_0),
        .info_valid(info_valid_0),
            .r_en0                   ( qc0_r_en0                      ),
            .r_en1                   (qc0_r_en1                      ),
            .r_en2                   ( qc0_r_en2                      ),
            .r_en3                   ( qc0_r_en3                      ),
            .r_en4                   ( qc0_r_en4                      ),
            .r_en5                   ( qc0_r_en5                      ),
            .r_en6                   ( qc0_r_en6                      ),
            .r_en7                   ( qc0_r_en7                      ),
            .done0                   ( qc0_done0                      ),
            .done1                   ( qc0_done1                      ),
            .done2                   ( qc0_done2                      ),
            .done3                   ( qc0_done3                      ),
            .done4                   ( qc0_done4                      ),
            .done5                   ( qc0_done5                      ),
            .done6                   ( qc0_done6                      ),
            .done7                   ( qc0_done7                      ),
            .addr_new0      (  qc0_addr_new0         ),
            .addr_new1      (  qc0_addr_new1         ),
            .addr_new2      (  qc0_addr_new2         ),
            .addr_new3      (  qc0_addr_new3         ),
            . addr_new4      (  qc0_addr_new4         ),
            .addr_new5      (  qc0_addr_new5         ),
            .addr_new6      ( qc0_addr_new6         ),
            .addr_new7      (  qc0_addr_new7         ),
               .rd_access0              ( qc0_rd_access0                 ),
               .rd_access1              ( qc0_rd_access1                 ),
               .rd_access2              ( qc0_rd_access2                 ),
               .rd_access3              ( qc0_rd_access3                 ),
               .rd_access4              ( qc0_rd_access4                 ),
               .rd_access5              ( qc0_rd_access5                 ),
               .rd_access6              ( qc0_rd_access6                 ),
               .rd_access7              ( qc0_rd_access7                 ),
               .addr_head0              ( qc0_addr_head0      ),
               .addr_head1              ( qc0_addr_head1         ),
               .addr_head2              ( qc0_addr_head2        ),
               .addr_head3              ( qc0_addr_head3        ),
               .addr_head4              ( qc0_addr_head4       ),
               .addr_head5              ( qc0_addr_head5         ),
               .addr_head6              ( qc0_addr_head6       ),
               .addr_head7              ( qc0_addr_head7       ),
               .addr_head_valid0        ( qc0_addr_head_valid0           ),
               .addr_head_valid1        ( qc0_addr_head_valid1           ),
               .addr_head_valid2        ( qc0_addr_head_valid2           ),
               .addr_head_valid3        ( qc0_addr_head_valid3           ),
               .addr_head_valid4        ( qc0_addr_head_valid4           ),
               .addr_head_valid5        ( qc0_addr_head_valid5           ),
               .addr_head_valid6        ( qc0_addr_head_valid6           ),
               .addr_head_valid7        ( qc0_addr_head_valid7           )
    );
    
    
    
    
     dynamic_flow_new  u_dynamic_flow_1 (
           .clk                     ( clk                  ),
           .rst_n                  (!rst                 ),
           .flow_id               (flow_id_1          ),
           .addr                   (addr_1               ),
           .addr_num          (addr_num_1     ),
           .w_en                   ( w_en_1            ),
           .priority                (priority_1          ),
            .frame_num(frame_num_1),
           .flow_tail_addr(flow_tail_addr_1),
           .info_valid(info_valid_1),
             .r_en0                   ( qc1_r_en0                      ),
             .r_en1                   ( qc1_r_en1                      ),
             .r_en2                   ( qc1_r_en2                      ),
             .r_en3                   ( qc1_r_en3                      ),
             .r_en4                   ( qc1_r_en4                      ),
             .r_en5                   ( qc1_r_en5                      ),
             .r_en6                   ( qc1_r_en6                      ),
             .r_en7                   ( qc1_r_en7                      ),
             .done0                 ( qc1_done0                      ),
             .done1                 ( qc1_done1                      ),
             .done2                 ( qc1_done2                      ),
             .done3                 ( qc1_done3                      ),
             .done4                 ( qc1_done4                      ),
             .done5                 ( qc1_done5                      ),
             .done6                 ( qc1_done6                      ),
             .done7                 ( qc1_done7                      ),
             .addr_new0      (  qc1_addr_new0         ),
             .addr_new1      ( qc1_addr_new1         ),
             .addr_new2      (  qc1_addr_new2         ),
             .addr_new3      (  qc1_addr_new3         ),
             . addr_new4      ( qc1_addr_new4         ),
             .addr_new5      (  qc1_addr_new5         ),
             .addr_new6      ( qc1_addr_new6         ),
             .addr_new7      (  qc1_addr_new7         ),
             .rd_access0              ( qc1_rd_access0                 ),
             .rd_access1              ( qc1_rd_access1                 ),
             .rd_access2              ( qc1_rd_access2                 ),
             .rd_access3              ( qc1_rd_access3                 ),
             .rd_access4              ( qc1_rd_access4                 ),
             .rd_access5              ( qc1_rd_access5                 ),
             .rd_access6              ( qc1_rd_access6                 ),
             .rd_access7              ( qc1_rd_access7                 ),
             .addr_head0              ( qc1_addr_head0         ),
             .addr_head1              ( qc1_addr_head1          ),
             .addr_head2              ( qc1_addr_head2           ),
             .addr_head3              ( qc1_addr_head3         ),
             .addr_head4              ( qc1_addr_head4           ),
             .addr_head5              ( qc1_addr_head5           ),
             .addr_head6              ( qc1_addr_head6          ),
             .addr_head7              ( qc1_addr_head7          ),
             .addr_head_valid0        ( qc1_addr_head_valid0           ),
             .addr_head_valid1        ( qc1_addr_head_valid1           ),
             .addr_head_valid2        ( qc1_addr_head_valid2           ),
             .addr_head_valid3        ( qc1_addr_head_valid3           ),
             .addr_head_valid4        ( qc1_addr_head_valid4           ),
             .addr_head_valid5        ( qc1_addr_head_valid5           ),
             .addr_head_valid6        ( qc1_addr_head_valid6           ),
             .addr_head_valid7        ( qc1_addr_head_valid7           )
       );
       
       
       
       
       
     dynamic_flow_new  u_dynamic_flow_2 (
              .clk                     ( clk                  ),
              .rst_n                  (!rst                 ),
              .flow_id               (flow_id_2           ),
              .addr                   (addr_2               ),
              .addr_num          (addr_num_2     ),
              .w_en                   ( w_en_2            ),
              .priority                (priority_2          ),

                  .r_en0                   ( qc2_r_en0                      ),
                  .r_en1                   ( qc2_r_en1                      ),
                  .r_en2                   ( qc2_r_en2                      ),
                  .r_en3                   ( qc2_r_en3                      ),
                  .r_en4                   ( qc2_r_en4                      ),
                  .r_en5                   ( qc2_r_en5                      ),
                  .r_en6                   ( qc2_r_en6                      ),
                  .r_en7                   ( qc2_r_en7                      ),
                  .done0                   ( qc2_done0                      ),
                  .done1                   ( qc2_done1                      ),
                  .done2                   ( qc2_done2                      ),
                  .done3                   ( qc2_done3                      ),
                  .done4                   ( qc2_done4                      ),
                  .done5                   ( qc2_done5                      ),
                  .done6                   ( qc2_done6                      ),
                  .done7                   ( qc2_done7                      ),
                  .addr_new0      (  qc2_addr_new0         ),
                  .addr_new1      (  qc2_addr_new1         ),
                  .addr_new2      (  qc2_addr_new2         ),
                  .addr_new3      (  qc2_addr_new3         ),
                  . addr_new4      (  qc2_addr_new4         ),
                  .addr_new5      (  qc2_addr_new5         ),
                  .addr_new6      ( qc2_addr_new6         ),
                  .addr_new7      (  qc2_addr_new7         ),
                  .rd_access0              ( qc2_rd_access0                 ),
                  .rd_access1              ( qc2_rd_access1                 ),
                  .rd_access2              ( qc2_rd_access2                 ),
                  .rd_access3              ( qc2_rd_access3                 ),
                  .rd_access4              ( qc2_rd_access4                 ),
                  .rd_access5              ( qc2_rd_access5                 ),
                  .rd_access6              ( qc2_rd_access6                 ),
                  .rd_access7              ( qc2_rd_access7                 ),
                  .addr_head0              ( qc2_addr_head0       ),
                  .addr_head1              ( qc2_addr_head1        ),
                  .addr_head2              ( qc2_addr_head2         ),
                  .addr_head3              ( qc2_addr_head3          ),
                  .addr_head4              ( qc2_addr_head4         ),
                  .addr_head5              ( qc2_addr_head5          ),
                  .addr_head6              ( qc2_addr_head6         ),
                  .addr_head7              ( qc2_addr_head7         ),
                  .addr_head_valid0        ( qc2_addr_head_valid0           ),
                  .addr_head_valid1        ( qc2_addr_head_valid1           ),
                  .addr_head_valid2        ( qc2_addr_head_valid2           ),
                  .addr_head_valid3        ( qc2_addr_head_valid3           ),
                  .addr_head_valid4        ( qc2_addr_head_valid4           ),
                  .addr_head_valid5        ( qc2_addr_head_valid5           ),
                .addr_head_valid6        ( qc2_addr_head_valid6           ),
                .addr_head_valid7        ( qc2_addr_head_valid7           ),
                .frame_num(frame_num_2),
                .flow_tail_addr(flow_tail_addr_2),
                .info_valid(info_valid_2)
          );
    
     dynamic_flow_new  u_dynamic_flow_3 (
                 .clk                     ( clk                  ),
                 .rst_n                  (!rst                 ),
                 .flow_id               (flow_id_3           ),
                 .addr                   (addr_3               ),
                 .addr_num          (addr_num_3     ),
                 .w_en                   ( w_en_3            ),
                 .priority                (priority_3          ),
                  .frame_num(frame_num_3),
                 .flow_tail_addr(flow_tail_addr_3),
                 .info_valid(info_valid_3),
                    .r_en0                   ( qc3_r_en0                      ),
                    .r_en1                   ( qc3_r_en1                      ),
                    .r_en2                   ( qc3_r_en2                      ),
                    .r_en3                   (qc3_r_en3                      ),
                    .r_en4                   ( qc3_r_en4                      ),
                    .r_en5                   ( qc3_r_en5                      ),
                    .r_en6                   ( qc3_r_en6                      ),
                    .r_en7                   ( qc3_r_en7                      ),
                    .done0                   ( qc3_done0                      ),
                    .done1                   ( qc3_done1                      ),
                    .done2                   ( qc3_done2                      ),
                    .done3                   ( qc3_done3                      ),
                    .done4                   ( qc3_done4                      ),
                    .done5                   ( qc3_done5                      ),
                    .done6                   ( qc3_done6                      ),
                    .done7                   ( qc3_done7                      ),
                    .addr_new0      (  qc3_addr_new0         ),
                    .addr_new1      (  qc3_addr_new1         ),
                    .addr_new2      (  qc3_addr_new2         ),
                    .addr_new3      (  qc3_addr_new3         ),
                    . addr_new4      (  qc3_addr_new4         ),
                    .addr_new5      (  qc3_addr_new5         ),
                    .addr_new6      ( qc3_addr_new6         ),
                    .addr_new7      (  qc3_addr_new7         ),
                     .rd_access0              ( qc3_rd_access0                 ),
                    .rd_access1              ( qc3_rd_access1                 ),
                    .rd_access2              ( qc3_rd_access2                 ),
                    .rd_access3              ( qc3_rd_access3                 ),
                    .rd_access4              ( qc3_rd_access4                 ),
                    .rd_access5              ( qc3_rd_access5                 ),
                    .rd_access6              ( qc3_rd_access6                 ),
                    .rd_access7              ( qc3_rd_access7                 ),
                    .addr_head0              ( qc3_addr_head0          ),
                    .addr_head1              ( qc3_addr_head1           ),
                    .addr_head2              ( qc3_addr_head2         ),
                    .addr_head3              ( qc3_addr_head3          ),
                    .addr_head4              ( qc3_addr_head4          ),
                    .addr_head5              ( qc3_addr_head5     ),
                    .addr_head6              ( qc3_addr_head6          ),
                    .addr_head7              ( qc3_addr_head7       ),
                    .addr_head_valid0        ( qc3_addr_head_valid0           ),
                    .addr_head_valid1        ( qc3_addr_head_valid1           ),
                    .addr_head_valid2        ( qc3_addr_head_valid2           ),
                    .addr_head_valid3        ( qc3_addr_head_valid3           ),
                    .addr_head_valid4        ( qc3_addr_head_valid4           ),
                    .addr_head_valid5        ( qc3_addr_head_valid5           ),
                    .addr_head_valid6        ( qc3_addr_head_valid6           ),
                    .addr_head_valid7        ( qc3_addr_head_valid7           )
             );
    
   
            dpsram_w128_d2k   u_data_ram (
            .clka(clk), 			
            .wea(sram_wr_a), 		
            .addra(sram_addr_a[10:0]),	
            .dina(sram_din_a), 	
            .douta(), 			
            .clkb(clk), 		
            .web(1'b0), 			
            .addrb(sram_addr_b[10:0]), 	
            .dinb(128'b0), 		
            .doutb(sram_dout_b) 	
            );
endmodule
