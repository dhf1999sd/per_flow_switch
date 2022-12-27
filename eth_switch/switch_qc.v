`timescale 1ns / 1ps

//核心点队列管理外包
module switch_qc(
input					clk,
input					rst,

input		  [15:0]	q_din,   	
input					q_wr,
output					q_full,
	
output	wire	           [15:0]ptr_dout,   //最终只能出一个
output               ptr_rdy,
input                  ptr_ack,
input                  [9:0]flow_tail_address,      //流队列管理传输的尾巴
input                  [5:0]flow_frame_num ,//根据这个确定头和尾是否相同
input                   info_valid,

input  rd_access0,      //可以读有效,读的标志位。一个来
input  rd_access1,
input  rd_access2,
input  rd_access3,
input  rd_access4,
input  rd_access5,
input  rd_access6,
input  rd_access7,

output reg r_en0,        //读使能
output reg r_en1,
output reg r_en2,
output reg r_en3,
output reg r_en4,
output reg r_en5,
output reg r_en6,
output reg r_en7,

output reg done0,
output reg done1,
output reg done2,
output reg done3,
output reg done4,
output reg done5,
output reg done6,
output reg done7,

output reg[9:0] addr_new0,        //给一个新头
output reg[9:0] addr_new1,
output reg[9:0] addr_new2,
output reg[9:0] addr_new3,
output reg[9:0] addr_new4,
output reg[9:0] addr_new5,
output reg[9:0] addr_new6,
output reg[9:0] addr_new7,


input [9:0] addr_head0,
input [9:0] addr_head1,
input [9:0] addr_head2,
input [9:0] addr_head3,
input [9:0] addr_head4,
input [9:0] addr_head5,
input [9:0] addr_head6,
input [9:0] addr_head7,

input addr_head_valid0,
input addr_head_valid1,
input addr_head_valid2,
input addr_head_valid3,
input addr_head_valid4,
input addr_head_valid5,
input addr_head_valid6,
input addr_head_valid7

    );
    

reg	            [15:0]	ptr_din;
reg				ptr_wr;
reg				q_rd;
wire             [15:0]	q_dout;
wire	             q_empty;
reg              [15:0]  flow_head;  

 

fifo_w16_d256 u_ptr_wr_fifo0 (
  .clk(clk),
  .srst(rst), 
  .din(q_din[15:0]), 
  .wr_en(q_wr), 
  .rd_en(q_rd),
  .dout(q_dout), 
  .full(q_full),
  .empty(q_empty),
  .data_count()
);	
reg	  [2:0]		wr_state;
reg				ptr_wr_ack;
reg   [2:0]    link_priority;
reg   [9:0]  inter_flow_tail_address;

always@(posedge clk or negedge rst)
	if(rst)begin
		ptr_din<=  0;
		ptr_wr<= 0;
		q_rd<= 0;
		wr_state<=  0;
		link_priority<=0;

		end
	else begin
		case(wr_state)	
		0:	begin
			if(info_valid)
                    begin wr_state<=  1;
                  inter_flow_tail_address<= flow_tail_address;
                    end
                    end
		1:begin					
			if(!q_empty)begin
	
            q_rd<=  1;
            wr_state<=  2;
			end
		  end
		2:begin
			q_rd<= 0;      
			wr_state<=  3;
		  end
		3:begin
			ptr_din<=  q_dout[15:0];	
			link_priority<=q_dout[12:10];	
			ptr_wr<=  1;           //写入请求
			wr_state<=  4;	
			end
		4:begin
			if(ptr_wr_ack)begin	
				ptr_wr<=  0;
				if(q_dout[15])begin wr_state<=  0;end
				else begin  wr_state<=1;end
				end
			end
		endcase
		end

reg				ptr_rd;

reg				ptr_rd_ack_0;
reg				ptr_rd_ack_1;
reg				ptr_rd_ack_2;
reg				ptr_rd_ack_3;
reg				ptr_rd_ack_4;
reg				ptr_rd_ack_5;
reg				ptr_rd_ack_6;
reg				ptr_rd_ack_7;

reg	  [15:0]	ptr_fifo_din_0;
reg	  [15:0]	ptr_fifo_din_1;
reg	  [15:0]	ptr_fifo_din_2;
reg	  [15:0]	ptr_fifo_din_3;
reg	  [15:0]	ptr_fifo_din_4;
reg	  [15:0]	ptr_fifo_din_5;
reg	  [15:0]	ptr_fifo_din_6;
reg	  [15:0]	ptr_fifo_din_7;

reg	  [15:0]	head_inter_0;
reg	  [15:0]	tail_inter_0;
reg	  [15:0]	ptr_ram_din_0;
wire  [15:0]	ptr_ram_dout_0;
reg				ptr_ram_wr_0;
reg   [9:0]  ptr_ram_addr_0;


reg	  [15:0]	head_inter_1;
reg	  [15:0]	tail_inter_1;
reg	  [15:0]	ptr_ram_din_1;
wire  [15:0]	ptr_ram_dout_1;
reg				ptr_ram_wr_1;
reg   [9:0]  ptr_ram_addr_1;


reg	  [15:0]	head_inter_2;
reg	  [15:0]	tail_inter_2;
reg	  [15:0]	ptr_ram_din_2;
wire  [15:0]	ptr_ram_dout_2;
reg				ptr_ram_wr_2;
reg   [9:0]  ptr_ram_addr_2;


reg	  [15:0]	head_inter_3;
reg	  [15:0]	tail_inter_3;
reg	  [15:0]	ptr_ram_din_3;
wire  [15:0]	ptr_ram_dout_3;
reg				ptr_ram_wr_3;
reg   [9:0]  ptr_ram_addr_3;


reg	  [15:0]	head_inter_4;
reg	  [15:0]	tail_inter_4;
reg	  [15:0]	ptr_ram_din_4;
wire  [15:0]	ptr_ram_dout_4;
reg				ptr_ram_wr_4;
reg   [9:0]  ptr_ram_addr_4;


reg	  [15:0]	head_inter_5;
reg	  [15:0]	tail_inter_5;
reg	  [15:0]	ptr_ram_din_5;
wire  [15:0]	ptr_ram_dout_5;
reg				ptr_ram_wr_5;
reg   [9:0]  ptr_ram_addr_5;


reg	  [15:0]	head_inter_6;
reg	  [15:0]	tail_inter_6;
reg	  [15:0]	ptr_ram_din_6;
wire  [15:0]	ptr_ram_dout_6;
reg				ptr_ram_wr_6;
reg   [9:0]  ptr_ram_addr_6;


reg	  [15:0]	head_inter_7;
reg	  [15:0]	tail_inter_7;
reg	  [15:0]	ptr_ram_din_7;
wire  [15:0]	ptr_ram_dout_7;
reg				ptr_ram_wr_7;
reg   [9:0]  ptr_ram_addr_7;

reg	  [3:0]		mstate;

reg     cell_depth_flag_0;
reg     cell_depth_flag_1;
reg     cell_depth_flag_2;
reg     cell_depth_flag_3;
reg     cell_depth_flag_4;
reg     cell_depth_flag_5;
reg     cell_depth_flag_6;
reg     cell_depth_flag_7;

reg   [5:0]  full_frame_flag_0;
reg    [5:0]   full_frame_flag_1;
reg     [5:0]  full_frame_flag_2;
reg     [5:0]  full_frame_flag_3;
reg     [5:0]  full_frame_flag_4;
reg     [5:0]  full_frame_flag_5;
reg     [5:0]  full_frame_flag_6;
reg     [5:0]  full_frame_flag_7;



reg      [15:0]head_inter_0_reg;
reg      [15:0]head_inter_1_reg;
reg      [15:0]head_inter_2_reg;
reg      [15:0]head_inter_3_reg;
reg      [15:0]head_inter_4_reg;
reg      [15:0]head_inter_5_reg;
reg      [15:0]head_inter_6_reg;
reg      [15:0]head_inter_7_reg;

reg addr_head_valid0_reg;
reg addr_head_valid1_reg;
reg addr_head_valid2_reg;
reg addr_head_valid3_reg;
reg addr_head_valid4_reg;
reg addr_head_valid5_reg;
reg addr_head_valid6_reg;
reg addr_head_valid7_reg;


reg  read_flag_0;
reg  read_flag_1;
reg  read_flag_2;
reg  read_flag_3;
reg  read_flag_4;
reg  read_flag_5;
reg  read_flag_6;
reg  read_flag_7;
always@(posedge clk or negedge rst)
	if(rst)	begin
		mstate<=  0;
		ptr_wr_ack<=  0;
	    ptr_ram_wr_0<=  0;
		tail_inter_0 <=  0;	
		head_inter_0 <=  0;	
        ptr_rd_ack_0<=0;
        ptr_rd_ack_1<=0;
        ptr_rd_ack_2<=0;
        ptr_rd_ack_3<=0;
        ptr_rd_ack_4<=0;
        ptr_rd_ack_5<=0;
        ptr_rd_ack_6<=0;
        ptr_rd_ack_7<=0;
		ptr_ram_din_0<=  0;
		ptr_ram_addr_0<=  0;
		ptr_fifo_din_0<=  0;
		ptr_fifo_din_1<=  0;
		ptr_fifo_din_2<=  0;
		ptr_fifo_din_3<=  0;
		ptr_fifo_din_4<=  0;
		ptr_fifo_din_5<=  0;
		ptr_fifo_din_6<=  0;
		ptr_fifo_din_7<=  0;
		full_frame_flag_0<=0;
	    full_frame_flag_1<=0;
	    full_frame_flag_2<=0;
		full_frame_flag_3<=0;
		full_frame_flag_4<=0;
		full_frame_flag_5<=0;
		full_frame_flag_6<=0;
		full_frame_flag_7<=0;
		end
	else begin
		ptr_wr_ack<=  0;	
		ptr_rd_ack_0<=0;
        ptr_rd_ack_1<=0;
        ptr_rd_ack_2<=0;
        ptr_rd_ack_3<=0;
        ptr_rd_ack_4<=0;
        ptr_rd_ack_5<=0;
        ptr_rd_ack_6<=0;
        ptr_rd_ack_7<=0;
		ptr_ram_wr_0<=  0;	
        ptr_ram_wr_1<=  0;    
        ptr_ram_wr_2<=  0;    
        ptr_ram_wr_3<=  0;    
        ptr_ram_wr_4<=  0;    
        ptr_ram_wr_5<=  0;    
        ptr_ram_wr_6<=  0;    
        ptr_ram_wr_7<=  0; 

 

		case(mstate)					
		0:begin			
            done0<=1'b0;			
            done1<=1'b0;			
            done2<=1'b0;			
            done3<=1'b0;			
            done4<=1'b0;				
            done5<=1'b0;				
            done6<=1'b0;		
            done7<=1'b0;					
			if(ptr_wr)begin           //写入链表
				mstate<=  1;
				end
			else if(ptr_rd)             //读出链表
                    begin					
                    if(addr_head_valid0_reg)begin
                        head_inter_0<=head_inter_0_reg;    
                        ptr_ram_addr_0[9:0]<=  head_inter_0[9:0];
                        ptr_fifo_din_0<={1'b0,1'b1,1'b0,3'd0,head_inter_0};  
                        read_flag_0<=1;
                        mstate<=  3;         end
            
                if(addr_head_valid1_reg)begin
                    head_inter_1<=head_inter_1_reg;    
                    ptr_ram_addr_1[9:0]<=  head_inter_1[9:0];
                    ptr_fifo_din_1 <={1'b0,1'b1,1'b0,3'd1,head_inter_1};  
                    read_flag_1<=1;
                    mstate<=  3;         end
                
                if(addr_head_valid2_reg)begin
                    head_inter_2<=head_inter_2_reg;    
                    ptr_ram_addr_2[9:0]<=  head_inter_2[9:0];
                    ptr_fifo_din_2 <={1'b0,1'b1,1'b0,3'd2,head_inter_2};  
                    read_flag_2<=1;
                    mstate<=  3;         end    
            
                if(addr_head_valid3_reg)begin
                    head_inter_3<=head_inter_3_reg;    
                    ptr_ram_addr_3[9:0]<=  head_inter_3[9:0];
                    ptr_fifo_din_3 <={1'b0,1'b1,1'b0,3'd3,head_inter_3};   
                   read_flag_3<=1;
                    mstate<=  3;         end
                    
           if(addr_head_valid4_reg)begin
             head_inter_4<=head_inter_4_reg;    
                 ptr_ram_addr_4[9:0]<=  head_inter_4[9:0];
                 ptr_fifo_din_4 <={1'b0,1'b1,1'b0,3'd4,head_inter_4};  
                read_flag_4<=1;
                 mstate<=  3;         end
                 
            if(addr_head_valid5_reg)begin
                  head_inter_5<=head_inter_5_reg;    
                  ptr_ram_addr_5[9:0]<=  head_inter_5[9:0];
                  ptr_fifo_din_5 <={1'b0,1'b1,1'b0,3'd5,head_inter_5};  
                 read_flag_5<=1;
                  mstate<=  3;         end                            
                
                if(addr_head_valid6_reg)begin
                    head_inter_6<=head_inter_6_reg;	
                    ptr_ram_addr_6[9:0]<=  head_inter_6[9:0];
                    ptr_fifo_din_6 <={1'b0,1'b1,1'b0,3'd6,head_inter_6};  
                    read_flag_6<=1;
                    mstate<=  3;         end             
                if(addr_head_valid7_reg)begin
                     head_inter_7<=head_inter_7_reg;    
                     ptr_ram_addr_7[9:0]<=  head_inter_7[9:0];
                     ptr_fifo_din_7 <={1'b0,1'b1,1'b0,3'd7,head_inter_7};  
                    read_flag_7<=1;
                     mstate<=  3;         end
                           end
                      end
		  
		
		1:begin
        case(link_priority)	
   3'd0: begin     
         if(flow_frame_num||cell_depth_flag_0)    
     begin  //深度不为0，链表有东西    

           if(ptr_din[14])begin  
           ptr_ram_addr_0[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
           ptr_ram_din_0[15:0]<=  ptr_din[15:0];    
           tail_inter_0 <= ptr_din[15:0];
           cell_depth_flag_0<=1;
           ptr_ram_wr_0<=  1;
           end
           else begin   //旧流的其他包
           ptr_ram_addr_0[9:0]<=  tail_inter_0[9:0];    
           ptr_ram_din_0[15:0]<=  ptr_din[15:0];    
           tail_inter_0<=ptr_din;
           cell_depth_flag_0<=1;
           ptr_ram_wr_0<=  1;
           if(ptr_din[15])begin      //尾信元
           full_frame_flag_0<=full_frame_flag_0+1;
           cell_depth_flag_0<=0;
           end
           end
           end
       else begin   
           ptr_ram_wr_0<=  1;                       //  新流允许读
           ptr_ram_addr_0[9:0]<=  ptr_din[9:0];
           ptr_ram_din_0[15:0]<=  ptr_din[15:0];
           tail_inter_0 <= ptr_din;
           head_inter_0<=ptr_din;
           cell_depth_flag_0<=1;
           end    
       ptr_wr_ack<=  1;                
       mstate<=  2;
       end
					
    3'd1: begin
                        
         if(flow_frame_num||cell_depth_flag_1)    
         begin  //深度不为0，链表有东西    

               if(ptr_din[14])begin  
               ptr_ram_addr_1[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
               ptr_ram_din_1[15:0]<=  ptr_din[15:0];    
               tail_inter_1 <= ptr_din[15:0];
               cell_depth_flag_1<=1;
               ptr_ram_wr_1<=  1;
               end
               else begin   //旧流的其他包
               ptr_ram_addr_1[9:0]<=  tail_inter_1[9:0];    
               ptr_ram_din_1[15:0]<=  ptr_din[15:0];    
               tail_inter_1<=ptr_din;
               cell_depth_flag_1<=1;
               ptr_ram_wr_1<=  1;
               if(ptr_din[15])begin      //尾信元
               full_frame_flag_1<=full_frame_flag_1+1;
               cell_depth_flag_1<=0;
               end
               end
               end
           else begin   
               ptr_ram_wr_1<=  1;                       //  新流允许读
               ptr_ram_addr_1[9:0]<=  ptr_din[9:0];
               ptr_ram_din_1[15:0]<=  ptr_din[15:0];
               tail_inter_1 <= ptr_din;
               head_inter_1<=ptr_din;
               cell_depth_flag_1<=1;
               end    
           ptr_wr_ack<=  1;                
           mstate<=  2;
           end
			
    3'd2: begin
            
         if(flow_frame_num||cell_depth_flag_2)    
         begin  //深度不为0，链表有东西    

               if(ptr_din[14])begin  
               ptr_ram_addr_2[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
               ptr_ram_din_2[15:0]<=  ptr_din[15:0];    
               tail_inter_2 <= ptr_din[15:0];
               cell_depth_flag_2<=1;
               ptr_ram_wr_2<=  1;
               end
               else begin   //旧流的其他包
               ptr_ram_addr_2[9:0]<=  tail_inter_2[9:0];    
               ptr_ram_din_2[15:0]<=  ptr_din[15:0];    
               tail_inter_2<=ptr_din;
               cell_depth_flag_2<=1;
               ptr_ram_wr_2<=  1;
               if(ptr_din[15])begin      //尾信元
               full_frame_flag_2<=full_frame_flag_2+1;
               cell_depth_flag_2<=0;
               end
               end
               end
           else begin   
               ptr_ram_wr_2<=  1;                       //  新流允许读
               ptr_ram_addr_2[9:0]<=  ptr_din[9:0];
               ptr_ram_din_2[15:0]<=  ptr_din[15:0];
               tail_inter_2 <= ptr_din;
               head_inter_2<=ptr_din;
               cell_depth_flag_2<=1;
               end    
           ptr_wr_ack<=  1;                
           mstate<=  2;
           end
			
     3'd3: begin
                        
         if(flow_frame_num||cell_depth_flag_3)    
         begin  //深度不为0，链表有东西    

               if(ptr_din[14])begin  
               ptr_ram_addr_3[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
               ptr_ram_din_3[15:0]<=  ptr_din[15:0];    
               tail_inter_3 <= ptr_din[15:0];
               cell_depth_flag_3<=1;
               ptr_ram_wr_3<=  1;
               end
               else begin   //旧流的其他包
               ptr_ram_addr_3[9:0]<=  tail_inter_3[9:0];    
               ptr_ram_din_3[15:0]<=  ptr_din[15:0];    
               tail_inter_3<=ptr_din;
               cell_depth_flag_3<=1;
               ptr_ram_wr_3<=  1;
               if(ptr_din[15])begin      //尾信元
               full_frame_flag_3<=full_frame_flag_3+1;
               cell_depth_flag_3<=0;
               end
               end
               end
           else begin   
               ptr_ram_wr_3<=  1;                       //  新流允许读
               ptr_ram_addr_3[9:0]<=  ptr_din[9:0];
               ptr_ram_din_3[15:0]<=  ptr_din[15:0];
               tail_inter_3 <= ptr_din;
               head_inter_3<=ptr_din;
               cell_depth_flag_3<=1;
               end    
           ptr_wr_ack<=  1;                
           mstate<=  2;
           end

      3'd4: begin
             			
         if(flow_frame_num||cell_depth_flag_4)    
          begin  //深度不为0，链表有东西	

				if(ptr_din[14])begin  
				ptr_ram_addr_4[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
				ptr_ram_din_4[15:0]<=  ptr_din[15:0];	
				tail_inter_4 <= ptr_din[15:0];
				cell_depth_flag_4<=1;
				ptr_ram_wr_4<=  1;
				end
				else begin   //旧流的其他包
				ptr_ram_addr_6[9:0]<=  tail_inter_4[9:0];	
                ptr_ram_din_4[15:0]<=  ptr_din[15:0];	
				tail_inter_4<=ptr_din;
				cell_depth_flag_4<=1;
			    ptr_ram_wr_4<=  1;
				if(ptr_din[15])begin      //尾信元
				full_frame_flag_4<=full_frame_flag_4+1;
				cell_depth_flag_4<=0;
				end
				end
				end
			else begin   
				ptr_ram_wr_4<=  1;			           //  新流允许读
				ptr_ram_addr_4[9:0]<=  ptr_din[9:0];
				ptr_ram_din_4[15:0]<=  ptr_din[15:0];
				tail_inter_4 <= ptr_din;
				head_inter_4<=ptr_din;
				cell_depth_flag_4<=1;
				end	
			ptr_wr_ack<=  1;				
			mstate<=  2;
			end
			
   3'd5: begin
                        
         if(flow_frame_num||cell_depth_flag_5)    
         begin  //深度不为0，链表有东西    
               if(ptr_din[14])begin  
               ptr_ram_addr_5[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
               ptr_ram_din_5[15:0]<=  ptr_din[15:0];    
               tail_inter_5 <= ptr_din[15:0];
               cell_depth_flag_5<=1;
               ptr_ram_wr_5<=  1;
               end
               else begin   //旧流的其他包
               ptr_ram_addr_5[9:0]<=  tail_inter_5[9:0];    
               ptr_ram_din_5[15:0]<=  ptr_din[15:0];    
               tail_inter_5<=ptr_din;
               cell_depth_flag_5<=1;
               ptr_ram_wr_5<=  1;
               if(ptr_din[15])begin      //尾信元
               full_frame_flag_5<=full_frame_flag_5+1;
               cell_depth_flag_5<=0;
               end
               end
               end
           else begin   
               ptr_ram_wr_5<=  1;                       //  新流允许读
               ptr_ram_addr_5[9:0]<=  ptr_din[9:0];
               ptr_ram_din_5[15:0]<=  ptr_din[15:0];
               tail_inter_5 <= ptr_din;
               head_inter_5<=ptr_din;
               cell_depth_flag_5<=1;
               end    
           ptr_wr_ack<=  1;                
           mstate<=  2;
           end
          			
    3'd6: begin
    ptr_wr_ack<=  1;				
    mstate<=  2;
         if(flow_frame_num||cell_depth_flag_6)    
           begin  //深度不为0，链表有东西	
				if(ptr_din[14])begin  
				ptr_ram_addr_6[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
				ptr_ram_din_6[15:0]<=  ptr_din[15:0];	
				tail_inter_6 <= ptr_din[15:0];
				cell_depth_flag_6<=1;
				ptr_ram_wr_6<=  1;
				end
			else begin   //旧流的其他包
				ptr_ram_addr_6[9:0]<=  tail_inter_6[9:0];	
                ptr_ram_din_6[15:0]<=  ptr_din[15:0];	
				tail_inter_6<=ptr_din;
				cell_depth_flag_6<=1;
			    ptr_ram_wr_6<=  1;
				if(ptr_din[15])begin      //尾信元
				full_frame_flag_6<=full_frame_flag_6+1;
				cell_depth_flag_6<=0;
				end
				end
				end
			else begin   
				ptr_ram_wr_6<=  1;			           //  新流允许读
				ptr_ram_addr_6[9:0]<=  ptr_din[9:0];
				ptr_ram_din_6[15:0]<=  ptr_din[15:0];
				tail_inter_6 <= ptr_din;
				head_inter_6<=ptr_din;
				cell_depth_flag_6<=1;
				end	
				end
						
    3'd7: begin                      
         if(flow_frame_num||cell_depth_flag_7)    
         begin  //深度不为0，链表有东西    
               if(ptr_din[14])begin  
                   ptr_ram_addr_7[9:0]<=  inter_flow_tail_address[9:0];       //旧流的第一个包
                   ptr_ram_din_7[15:0]<=  ptr_din[15:0];    
                   tail_inter_7 <= ptr_din[15:0];
                   cell_depth_flag_7<=1;
                   ptr_ram_wr_7<=  1;
                   end
               else begin   //旧流的其他包
                   ptr_ram_addr_7[9:0]<=  tail_inter_7[9:0];    
                   ptr_ram_din_7[15:0]<=  ptr_din[15:0];    
                   tail_inter_7<=ptr_din;
                   cell_depth_flag_7<=1;
                   ptr_ram_wr_7<=  1;
                       if(ptr_din[15])begin      //尾信元
                       full_frame_flag_7<=full_frame_flag_7+1;
                       cell_depth_flag_7<=0;
                       end
               end
               end
           else begin   
               ptr_ram_wr_7<=  1;                       //  新流允许读
               ptr_ram_addr_7[9:0]<=  ptr_din[9:0];
               ptr_ram_din_7[15:0]<=  ptr_din[15:0];
               tail_inter_7 <= ptr_din;
               head_inter_7<=ptr_din;
               cell_depth_flag_7<=1;
               end    
           ptr_wr_ack<=  1;                
           mstate<=  2;
           end

			endcase
			end
	
		2:begin
		case(link_priority)
                3'd0: begin
                        ptr_ram_addr_0<=  tail_inter_0[9:0];
                        ptr_ram_din_0<=  tail_inter_0[15:0];
                        ptr_ram_wr_0<=  1;
                        mstate<= 0;
                    end
                    3'd1: begin
                        ptr_ram_addr_1<=  tail_inter_1[9:0];
                        ptr_ram_din_1    <=  tail_inter_1[15:0];
                        ptr_ram_wr_1<=  1;
                        mstate<=  0;
                    end
                    3'd2: begin
                        ptr_ram_addr_2<=  tail_inter_2[9:0];
                        ptr_ram_din_2   <=  tail_inter_2[15:0];
                        ptr_ram_wr_2<=  1;
                        mstate<=  0;
                    end
                    3'd3: begin
                        ptr_ram_addr_3<=  tail_inter_3[9:0];
                        ptr_ram_din_3  <=  tail_inter_3[15:0];
                        ptr_ram_wr_3<=  1;
                        mstate<=  0;
                    end
                    3'd4: begin
                        ptr_ram_addr_4<=  tail_inter_4[9:0];
                        ptr_ram_din_4    <=  tail_inter_4[15:0];
                        ptr_ram_wr_4<=  1;
                        mstate<=  0;
                    end
                    3'd5: begin
                        ptr_ram_addr_5<=  tail_inter_5[9:0];
                        ptr_ram_din_5    <=  tail_inter_5[15:0];
                        ptr_ram_wr_5<=  1;
                        mstate<=  0;
                    end
                    3'd6: begin
                        ptr_ram_addr_6<=  tail_inter_6[9:0];
                        ptr_ram_din_6    <=  tail_inter_6[15:0];
                        ptr_ram_wr_6<=  1;
                        mstate<=  0;
                    end
                    3'd7: begin
                        ptr_ram_addr_7<=  tail_inter_7[9:0];
                        ptr_ram_din_7    <=  tail_inter_7[15:0];
                        ptr_ram_wr_7<=  1;
                        mstate<=  0;
                    end
		  endcase
		  end
		3:begin
                done0<=1'b0;			
                done1<=1'b0;            
                done2<=1'b0;            
                done3<=1'b0;            
                done4<=1'b0;                
                done5<=1'b0;                
                done6<=1'b0;        
                done7<=1'b0;        
        
                if(read_flag_0)	ptr_rd_ack_0<=  1;		
                if(read_flag_1)	ptr_rd_ack_1<=  1;		
                if(read_flag_2)	ptr_rd_ack_2<=  1;		
                if(read_flag_3)	ptr_rd_ack_3<=  1;		
                if(read_flag_4)	ptr_rd_ack_4<=  1;					
                if(read_flag_5)	ptr_rd_ack_5<=  1;					
                if(read_flag_6)	ptr_rd_ack_6<=  1;		
                if(read_flag_7)	ptr_rd_ack_7<=  1;						
                                
			mstate<=  4;
		  end
		4:begin
		ptr_fifo_din_0<= ptr_ram_dout_0 ;
        ptr_fifo_din_1<= ptr_ram_dout_1 ;
        ptr_fifo_din_2<= ptr_ram_dout_2 ;
        ptr_fifo_din_3<= ptr_ram_dout_3 ;
        ptr_fifo_din_4<= ptr_ram_dout_4 ;
        ptr_fifo_din_5<= ptr_ram_dout_5 ;
        ptr_fifo_din_6<= ptr_ram_dout_6 ;
        ptr_fifo_din_7<= ptr_ram_dout_7 ;
         ptr_ram_addr_0[9:0]<=  ptr_ram_dout_0[9:0];
         ptr_ram_addr_1[9:0]<=  ptr_ram_dout_1[9:0];
         ptr_ram_addr_2[9:0]<=  ptr_ram_dout_2[9:0];
         ptr_ram_addr_3[9:0]<=  ptr_ram_dout_3[9:0];
         ptr_ram_addr_4[9:0]<=  ptr_ram_dout_4[9:0];
         ptr_ram_addr_5[9:0]<=  ptr_ram_dout_5[9:0];
         ptr_ram_addr_6[9:0]<=  ptr_ram_dout_6[9:0];
         ptr_ram_addr_7[9:0]<=  ptr_ram_dout_7[9:0];
         
   if(ptr_ram_dout_0[15]) //尾信元   
     begin 
     done0<=1'b1;addr_new0<=ptr_ram_dout_0[9:0];
     mstate<=  0;
     ptr_rd_ack_0<=1;
     read_flag_0<=  0;            
     if(!full_frame_flag_0) full_frame_flag_6<=full_frame_flag_0;
      else  full_frame_flag_0<= full_frame_flag_0-1;
      end
     else  begin  mstate<= 3; end 

   if(ptr_ram_dout_1[15]) //尾信元   
     begin 
     done1<=1'b1;addr_new1<=ptr_ram_dout_1[9:0];
     mstate<=  0;
     ptr_rd_ack_1<=1;
     read_flag_1<=  0;            
     if(!full_frame_flag_1) full_frame_flag_1<=full_frame_flag_1;
      else  full_frame_flag_1<= full_frame_flag_1-1;
      end
     else  begin  mstate<= 3; end 

   if(ptr_ram_dout_2[15]) //尾信元   
        begin 
        done2<=1'b1;addr_new2<=ptr_ram_dout_2[9:0];
        mstate<=  0;
        ptr_rd_ack_2<=1;
        read_flag_2<=  0;			
        if(!full_frame_flag_2) full_frame_flag_6<=full_frame_flag_2;
         else  full_frame_flag_2<= full_frame_flag_2-1;
         end
        else  begin  mstate<= 3; end 

   if(ptr_ram_dout_3[15]) //尾信元   
        begin 
        done3<=1'b1;addr_new3<=ptr_ram_dout_3[9:0];
        mstate<=  0;
        ptr_rd_ack_3<=1;
        read_flag_3<=  0;			
        if(!full_frame_flag_3) full_frame_flag_3<=full_frame_flag_3;
         else  full_frame_flag_3<= full_frame_flag_3-1;
         end
        else  begin  mstate<= 3; end 

   if(ptr_ram_dout_4[15]) //尾信元   
        begin 
        done4<=1'b1;addr_new4<=ptr_ram_dout_4[9:0];
        mstate<=  0;
        ptr_rd_ack_4<=1;
        read_flag_4<=  0;			
        if(!full_frame_flag_4) full_frame_flag_6<=full_frame_flag_4;
         else  full_frame_flag_4<= full_frame_flag_4-1;
         end
        else  begin  mstate<= 3; end 


   if(ptr_ram_dout_5[15]) //尾信元   
     begin 
     done5<=1'b1;addr_new5<=ptr_ram_dout_5[9:0];
     mstate<=  0;
     ptr_rd_ack_5<=1;
     read_flag_5<=  0;            
     if(!full_frame_flag_5) full_frame_flag_5<=full_frame_flag_5;
      else  full_frame_flag_5<= full_frame_flag_5-1;
      end
     else  begin  mstate<= 3; end 

      if(ptr_ram_dout_6[15]) //尾信元   
        begin 
        done6<=1'b1;addr_new6<=ptr_ram_dout_6[9:0];
        mstate<=  0;
        ptr_rd_ack_6<=1;
        read_flag_6<=  0;			
        if(!full_frame_flag_6) full_frame_flag_6<=full_frame_flag_6;
         else  full_frame_flag_6<= full_frame_flag_6-1;
         end
        else  begin  mstate<= 3; end 
   
         if(ptr_ram_dout_7[15]) //尾信元   
          begin 
              done7<=1'b1;addr_new7<=ptr_ram_dout_7[9:0];
              mstate<=  0;
              ptr_rd_ack_7<=1;
              read_flag_7<=  0;            
          if(!full_frame_flag_7) full_frame_flag_7<=full_frame_flag_7;
           else  full_frame_flag_7<= full_frame_flag_7-1;
           end
         
         else  begin  mstate<= 3; end 
     
		  end
		endcase
		end
		
reg   [2:0]	rd_state;
wire		ptr_full_0;
wire		ptr_full_1;
wire		ptr_full_2;
wire		ptr_full_3;
wire		ptr_full_4;
wire		ptr_full_5;
wire		ptr_full_6;
wire		ptr_full_7;


wire		ptr_empty_0;
wire		ptr_empty_1;
wire		ptr_empty_2;
wire		ptr_empty_3;
wire		ptr_empty_4;
wire		ptr_empty_5;
wire		ptr_empty_6;
wire		ptr_empty_7;
wire  rd_en_0, rd_en_1,rd_en_2,rd_en_3,rd_en_4,rd_en_5,rd_en_6,rd_en_7;


always@(posedge clk or negedge rst)
	if(rst)
		begin
		ptr_rd<=  0;	
		rd_state<=  0;
		
		end
	else begin
     addr_head_valid0_reg<=0; 
    addr_head_valid1_reg<=0; 
    addr_head_valid2_reg<=0; 
    addr_head_valid3_reg<=0; 
    addr_head_valid4_reg<=0; 
    addr_head_valid5_reg<=0;   
    addr_head_valid6_reg<=0; 
    addr_head_valid7_reg<=0; 
		case(rd_state)					
		0:begin							
			if(rd_access0)  begin r_en0<=((full_frame_flag_0==6'd0)?0:1);   if(r_en0)  begin rd_state<=  1;  r_en0<=0; end end
            if(rd_access1)	begin	r_en1<=((full_frame_flag_1==6'd0)?0:1);   if(r_en1)  begin rd_state<=  1;   r_en1<=0; end end
            if(rd_access2)	begin	r_en2<=((full_frame_flag_2==6'd0)?0:1);   if(r_en2)  begin rd_state<=  1; r_en2<=0; end  end
            if(rd_access3)	begin	r_en3<=((full_frame_flag_3==6'd0)?0:1);   if(r_en3) begin rd_state<=  1;   r_en3<=0; end end
            if(rd_access4)	begin	r_en4<=((full_frame_flag_4==6'd0)?0:1);   if(r_en4)  begin rd_state<=  1;  r_en4<=0; end end
            if(rd_access5)	begin	r_en5<=((full_frame_flag_5==6'd0)?0:1);   if(r_en5) begin rd_state<=  1;  r_en5<=0; end end
            if(rd_access6)	begin	r_en6<=((full_frame_flag_6==6'd0)?0:1);   if(r_en6)  begin rd_state<=  1;  r_en6<=0; end end
            if(rd_access7)	begin	r_en7<=((full_frame_flag_7==6'd0)?0:1);  if(r_en7)   begin rd_state<=  1;  r_en7<=0; end end
				
			end
			1:begin
			if(addr_head_valid0||addr_head_valid1||addr_head_valid2||addr_head_valid3||addr_head_valid4||addr_head_valid5||addr_head_valid6||addr_head_valid7)begin
                            ptr_rd<= 1;      
                            rd_state<=  2;    
                            head_inter_0_reg<=addr_head0;    
                            head_inter_1_reg<=addr_head1;
                            head_inter_2_reg<=addr_head2;
                            head_inter_3_reg<=addr_head3;
                            head_inter_4_reg<=addr_head4;
                            head_inter_5_reg<=addr_head5;
                            head_inter_6_reg<=addr_head6;
                            head_inter_7_reg<=addr_head7;
                            addr_head_valid0_reg<=addr_head_valid0;
                            addr_head_valid1_reg<=addr_head_valid1;
                            addr_head_valid2_reg<=addr_head_valid2;
                            addr_head_valid3_reg<=addr_head_valid3;
                            addr_head_valid4_reg<=addr_head_valid4;
                            addr_head_valid5_reg<=addr_head_valid5;
                            addr_head_valid6_reg<=addr_head_valid6;
                            addr_head_valid7_reg<=addr_head_valid7;
                 		end
				     //读使能
				end
		2:begin
			if(ptr_rd_ack_0|ptr_rd_ack_1|ptr_rd_ack_2|ptr_rd_ack_3|ptr_rd_ack_4|ptr_rd_ack_5|ptr_rd_ack_6|ptr_rd_ack_7)begin
                    ptr_rd<=  0;
                    rd_state<=  3;
				end
			end
		3:rd_state<=  0;
		endcase
		end

//链表存储区
sram_w16_d512 u_ptr_ram_0 (
  .clka(clk), 			
  .wea(ptr_ram_wr_0),     
  .addra(ptr_ram_addr_0[8:0]), 
  .dina(ptr_ram_din_0),   
  .douta(ptr_ram_dout_0) 
);	
sram_w16_d512 u_ptr_ram_1 (
  .clka(clk), 			
  .wea(ptr_ram_wr_1),     
  .addra(ptr_ram_addr_1[8:0]), 
  .dina(ptr_ram_din_1),   
  .douta(ptr_ram_dout_1) 
);	
sram_w16_d512 u_ptr_ram_2 (
  .clka(clk), 			
  .wea(ptr_ram_wr_2),     
  .addra(ptr_ram_addr_2[8:0]), 
  .dina(ptr_ram_din_2),   
  .douta(ptr_ram_dout_2) 
);	
sram_w16_d512 u_ptr_ram_3 (
  .clka(clk), 			
  .wea(ptr_ram_wr_3),     
  .addra(ptr_ram_addr_3[8:0]), 
  .dina(ptr_ram_din_3),   
  .douta(ptr_ram_dout_3) 
);	
sram_w16_d512 u_ptr_ram_4 (
  .clka(clk), 			
  .wea(ptr_ram_wr_4),     
  .addra(ptr_ram_addr_4[8:0]), 
  .dina(ptr_ram_din_4),   
  .douta(ptr_ram_dout_4) 
);	
sram_w16_d512 u_ptr_ram_5 (
  .clka(clk), 			
  .wea(ptr_ram_wr_5),     
  .addra(ptr_ram_addr_5[8:0]), 
  .dina(ptr_ram_din_5),   
  .douta(ptr_ram_dout_5) 
);	
sram_w16_d512 u_ptr_ram_6 (
  .clka(clk), 			
  .wea(ptr_ram_wr_6),     
  .addra(ptr_ram_addr_6[8:0]), 
  .dina(ptr_ram_din_6),   
  .douta(ptr_ram_dout_6) 
);	

sram_w16_d512 u_ptr_ram_7 (
  .clka(clk), 			
  .wea(ptr_ram_wr_7),     
  .addra(ptr_ram_addr_7[8:0]), 
  .dina(ptr_ram_din_7),   
  .douta(ptr_ram_dout_7) 
);	

wire          [15:0]ptr_dout_0;
wire          [15:0]ptr_dout_1;
wire          [15:0]ptr_dout_2;
wire          [15:0]ptr_dout_3;
wire          [15:0]ptr_dout_4;
wire          [15:0]ptr_dout_5;
wire          [15:0]ptr_dout_6;
wire          [15:0]ptr_dout_7;

//八个优先级队列FIFO



fifo_ft_w16_d256 u_ptr_fifo0 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_0[15:0]), 	
  .wr_en(ptr_rd_ack_0), 	
  .rd_en(rd_en_0), 	
  .dout(ptr_dout_0[15:0]), 		
  .full(ptr_full_0), 		
  .empty(ptr_empty_0),
  .data_count()  
);

fifo_ft_w16_d256 u_ptr_fifo1 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_1[15:0]), 	
  .wr_en(ptr_rd_ack_1), 	
  .rd_en(rd_en_1), 	
  .dout(ptr_dout_1[15:0]), 		
  .full(ptr_full_1), 		
  .empty(ptr_empty_1),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo2 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_2[15:0]), 	
  .wr_en(ptr_rd_ack_2), 	
  .rd_en(rd_en_2), 	
  .dout(ptr_dout_2[15:0]), 		
  .full(ptr_full_2), 		
  .empty(ptr_empty_2),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo3 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_3[15:0]), 	
  .wr_en(ptr_rd_ack_3), 	
  .rd_en(rd_en_3), 	
  .dout(ptr_dout_3[15:0]), 		
  .full(ptr_full_3), 		
  .empty(ptr_empty_3),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo4 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_4[15:0]), 	
  .wr_en(ptr_rd_ack_4), 	
  .rd_en(rd_en_4), 	
  .dout(ptr_dout_4[15:0]), 		
  .full(ptr_full_4), 		
  .empty(ptr_empty_4),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo5 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_5[15:0]), 	
  .wr_en(ptr_rd_ack_5), 	
  .rd_en(rd_en_5), 	
  .dout(ptr_dout_5[15:0]), 		
  .full(ptr_full_5), 		
  .empty(ptr_empty_5),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo6 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_6[15:0]), 	
  .wr_en(ptr_rd_ack_6), 	
  .rd_en(rd_en_6), 	
  .dout(ptr_dout_6[15:0]), 		
  .full(ptr_full_6), 		
  .empty(ptr_empty_6),
  .data_count()  
);
fifo_ft_w16_d256 u_ptr_fifo7 (
  .clk(clk),
  .rst(rst), 					
  .din(ptr_fifo_din_7[15:0]), 	
  .wr_en(ptr_rd_ack_7), 	
  .rd_en(rd_en_7), 	
  .dout(ptr_dout_7[15:0]), 		
  .full(ptr_full_7), 		
  .empty(ptr_empty_7),
  .data_count()  
);

wire   [7:0]dequeue_response;
wire  [7:0]dequeue_req;
reg      rd_en_6_reg;
assign ptr_rdy=!ptr_empty_7||!ptr_empty_6||!ptr_empty_5||!ptr_empty_4||!ptr_empty_3||!ptr_empty_2||!ptr_empty_1||!ptr_empty_0;
assign rd_en_7=(!ptr_empty_7)?ptr_ack:0;
assign rd_en_6=(ptr_empty_7&&!ptr_empty_6)?ptr_ack:0;
assign rd_en_5=(ptr_empty_7&&ptr_empty_6&&!ptr_empty_5)?ptr_ack:0;
assign rd_en_4=(ptr_empty_7&&ptr_empty_6&&ptr_empty_5&&!ptr_empty_4)?ptr_ack:0;
assign rd_en_3=(ptr_empty_7&&ptr_empty_6&&ptr_empty_5&&ptr_empty_4&&!ptr_empty_3)?ptr_ack:0;
assign rd_en_2=(ptr_empty_7&&ptr_empty_6&&ptr_empty_5&&ptr_empty_4&&ptr_empty_3&&!ptr_empty_2)?ptr_ack:0;
assign rd_en_1=(ptr_empty_7&&ptr_empty_6&&ptr_empty_5&&ptr_empty_4&&ptr_empty_3&&ptr_empty_2&&!ptr_empty_1)?ptr_ack:0;
assign rd_en_0=(ptr_empty_7&&ptr_empty_6&&ptr_empty_5&&ptr_empty_4&&ptr_empty_3&&ptr_empty_2&&ptr_empty_1&&!ptr_empty_0)?ptr_ack:0;


assign ptr_dout=(ptr_empty_7==0)?ptr_dout_7:(ptr_empty_6==0)?ptr_dout_6:(ptr_empty_5==0)?ptr_dout_5:(ptr_empty_4==0)?ptr_dout_4:(ptr_empty_3==0)?ptr_dout_3:
(ptr_empty_2==0)?ptr_dout_2:(ptr_empty_1==0)?ptr_dout_1:(ptr_empty_0==0)?ptr_dout_0:16'd0;

//assign  dequeue_req={(!ptr_empty_7),(!ptr_empty_6),(!ptr_empty_5),(!ptr_empty_4),(!ptr_empty_3),
//(!ptr_empty_2),(!ptr_empty_1),(!ptr_empty_0)};

//优先级输出


//Fixed_priority_arbiter  u_Fixed_priority_arbiter(  
//  . dequeue_req(dequeue_req),
//  . dequeue_response(dequeue_response)
//);

endmodule

