module dynamic_flow_new (
                    clk,
                    rst_n,
                    //写端�??
                    flow_id,
                    addr,
                    addr_num,
                    w_en,
                    priority,//接收完成后，输出�?个尾地址，当前流中的frame个数
                    frame_num,
                    flow_tail_addr,
                    info_valid,
                    //读端�??
                    r_en0,
                    done0,
                    addr_new0,
                    addr_head0,
                    rd_access0,
                    addr_head_valid0,
                    r_en1,
                    done1,
                    addr_new1,
                    addr_head1,
                    rd_access1,
                    addr_head_valid1,
                    r_en2,
                    done2,
                    addr_new2,
                    addr_head2,
                    rd_access2,
                    addr_head_valid2,
                    r_en3,
                    done3,
                    addr_new3,
                    addr_head3,
                    rd_access3,
                    addr_head_valid3,
                    r_en4,
                    done4,
                    addr_new4,
                    addr_head4,
                    rd_access4,
                    addr_head_valid4,
                    r_en5,
                    done5,
                    addr_new5,
                    addr_head5,
                    rd_access5,
                    addr_head_valid5,
                    r_en6,
                    done6,
                    addr_new6,
                    addr_head6,
                    rd_access6,
                    addr_head_valid6,
                    r_en7,
                    done7,
                    addr_new7,
                    addr_head7,
                    rd_access7,
                    addr_head_valid7
                        );
input clk;
input rst_n;
//写端�??
input [31:0]flow_id;
input [9:0]addr;
input [5:0]addr_num;
input w_en;
input [2:0]priority;
//读端�??
input r_en0;
input r_en1;
input r_en2;
input r_en3;
input r_en4;
input r_en5;
input r_en6;
input r_en7;
input done0;
input done1;
input done2;
input done3;
input done4;
input done5;
input done6;
input done7;
input [9:0] addr_new0;
input [9:0] addr_new1;
input [9:0] addr_new2;
input [9:0] addr_new3;
input [9:0] addr_new4;
input [9:0] addr_new5;
input [9:0] addr_new6;
input [9:0] addr_new7;
output [9:0] addr_head0;
output [9:0] addr_head1;
output [9:0] addr_head2;
output [9:0] addr_head3;
output [9:0] addr_head4;
output [9:0] addr_head5;
output [9:0] addr_head6;
output [9:0] addr_head7;
output addr_head_valid0;
output addr_head_valid1;
output addr_head_valid2;
output addr_head_valid3;
output addr_head_valid4;
output addr_head_valid5;
output addr_head_valid6;
output addr_head_valid7;
output rd_access0;
output rd_access1;
output rd_access2;
output rd_access3;
output rd_access4;
output rd_access5;
output rd_access6;
output rd_access7;


output [9:0]frame_num;
output [9:0]flow_tail_addr;
output info_valid;





parameter FRAME_BIT=6;//2^FRAME_BIT-1=FRAME NUMBER
parameter TABLE_AW=9;//table depth is 512
parameter TABLE_DW=62;//flow_id:51-20;head:19-10:tail:9-0;reserve:61-52.


parameter 
IDLE = 3'b000,
ID_COMPARE =3'b001,
TABLE_SEARCH =3'b010,
NEW_TABLE =3'b011,
NEW_TABLE1 =3'b100,
NEW_TABLE2 =3'b101;


parameter 
RR_WAIT=4'b0001,
RR=4'b0010,
RR_DELAY=4'b0011,
NEW_ADDR_WAIT=4'b0100,
NEW_ADDR=4'b0101,
TABLE_JUDGE=4'b0110,
ADDR_RECYCLE1=4'b0111,
ADDR_RECYCLE2=4'b1000,
TABLE_EMPTY=4'b1001;


reg table0_empty;//信号保留在内部，可以输出，升级功�??
reg table1_empty;
reg table2_empty;
reg table3_empty;
reg table4_empty;
reg table5_empty;
reg table6_empty;
reg table7_empty;
reg current_flow_empty0;
reg current_flow_empty1;
reg current_flow_empty2;
reg current_flow_empty3;
reg current_flow_empty4;
reg current_flow_empty5;
reg current_flow_empty6;
reg current_flow_empty7;
reg addr_head_valid0;
reg addr_head_valid1;
reg addr_head_valid2;
reg addr_head_valid3;
reg addr_head_valid4;
reg addr_head_valid5;
reg addr_head_valid6;
reg addr_head_valid7;

reg rd_access0;
reg rd_access1;
reg rd_access2;
reg rd_access3;
reg rd_access4;
reg rd_access5;
reg rd_access6;
reg rd_access7;

reg [TABLE_AW-1:0]fifo_counter;

reg addr_valid;
reg [FRAME_BIT-1:0]addr_counter;
reg init_done;

reg updata_done;




reg [9:0]addr_head0;
reg [9:0]addr_head1;
reg [9:0]addr_head2;
reg [9:0]addr_head3;
reg [9:0]addr_head4;
reg [9:0]addr_head5;
reg [9:0]addr_head6;
reg [9:0]addr_head7;



wire [TABLE_AW-1:0]fifo_data_out0;//FIFO中取出的地址
wire [TABLE_AW-1:0]fifo_data_out1;
wire [TABLE_AW-1:0]fifo_data_out2;
wire [TABLE_AW-1:0]fifo_data_out3;
wire [TABLE_AW-1:0]fifo_data_out4;
wire [TABLE_AW-1:0]fifo_data_out5;
wire [TABLE_AW-1:0]fifo_data_out6;
wire [TABLE_AW-1:0]fifo_data_out7;


wire [8:0]data0;
wire [8:0]data1;
wire [8:0]data2;
wire [8:0]data3;
wire [8:0]data4;
wire [8:0]data5;
wire [8:0]data6;
wire [8:0]data7;

reg fifo_wr;
reg fifo_wr0;
reg fifo_wr1;
reg fifo_wr2;
reg fifo_wr3;
reg fifo_wr4;
reg fifo_wr5;
reg fifo_wr6;
reg fifo_wr7;

reg fifo_wr0_empty;
reg fifo_wr1_empty;
reg fifo_wr2_empty;
reg fifo_wr3_empty;
reg fifo_wr4_empty;
reg fifo_wr5_empty;
reg fifo_wr6_empty;
reg fifo_wr7_empty;

reg[TABLE_AW-1:0]fifo_data_in;
reg[TABLE_AW-1:0] fifo_data_in0;
reg[TABLE_AW-1:0] fifo_data_in1;
reg[TABLE_AW-1:0] fifo_data_in2;
reg[TABLE_AW-1:0] fifo_data_in3;
reg[TABLE_AW-1:0] fifo_data_in4;
reg[TABLE_AW-1:0] fifo_data_in5;
reg[TABLE_AW-1:0] fifo_data_in6;
reg[TABLE_AW-1:0] fifo_data_in7;

reg [TABLE_AW-1:0]fifo_data_in0_empty;
reg [TABLE_AW-1:0]fifo_data_in1_empty;
reg [TABLE_AW-1:0]fifo_data_in2_empty;
reg [TABLE_AW-1:0]fifo_data_in3_empty;
reg [TABLE_AW-1:0]fifo_data_in4_empty;
reg [TABLE_AW-1:0]fifo_data_in5_empty;
reg [TABLE_AW-1:0]fifo_data_in6_empty;
reg [TABLE_AW-1:0]fifo_data_in7_empty;

/*�??要记录当前frame的首尾地�??，新流的话首尾地�??都更新�??*/

reg [9:0]frame_num;
reg [9:0]flow_tail_addr;
reg info_valid;
wire [9:0]new_frame_addr_head;
assign new_frame_addr_head=((w_en=='b1)&&(addr_counter=='b0))?addr:new_frame_addr_head;
/*入队�??对八：写入的frame信息依据priority分别存放在八个区�??*/
reg [2:0]wr_state_cs;
reg [2:0]wr_state_ns;
reg [TABLE_DW-1:0]table_mem0[(TABLE_AW-4):0];//分成八块，每�??64bits
reg [TABLE_DW-1:0]table_mem1[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem2[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem3[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem4[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem5[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem6[(TABLE_AW-4):0];
reg [TABLE_DW-1:0]table_mem7[(TABLE_AW-4):0];

reg [TABLE_DW-1:0]table_mem_w_reg;//写入只需要一个reg来缓存数�?
reg [TABLE_DW-1:0]table_mem0_r_reg;//读出�?要八个reg来缓存数�?
reg [TABLE_DW-1:0]table_mem1_r_reg;
reg [TABLE_DW-1:0]table_mem2_r_reg;
reg [TABLE_DW-1:0]table_mem3_r_reg;
reg [TABLE_DW-1:0]table_mem4_r_reg;
reg [TABLE_DW-1:0]table_mem5_r_reg;
reg [TABLE_DW-1:0]table_mem6_r_reg;
reg [TABLE_DW-1:0]table_mem7_r_reg;

reg [TABLE_DW-1:0]table_mem0_reg;//二维数组传�??
reg [TABLE_DW-1:0]table_mem1_reg;
reg [TABLE_DW-1:0]table_mem2_reg;
reg [TABLE_DW-1:0]table_mem3_reg;
reg [TABLE_DW-1:0]table_mem4_reg;
reg [TABLE_DW-1:0]table_mem5_reg;
reg [TABLE_DW-1:0]table_mem6_reg;
reg [TABLE_DW-1:0]table_mem7_reg;

reg [TABLE_DW-1:0]table_mem0_reg1;//二维数组传�??
reg [TABLE_DW-1:0]table_mem1_reg1;
reg [TABLE_DW-1:0]table_mem2_reg1;
reg [TABLE_DW-1:0]table_mem3_reg1;
reg [TABLE_DW-1:0]table_mem4_reg1;
reg [TABLE_DW-1:0]table_mem5_reg1;
reg [TABLE_DW-1:0]table_mem6_reg1;
reg [TABLE_DW-1:0]table_mem7_reg1;

reg rd0;
reg rd1;
reg rd2;
reg rd3;
reg rd4;
reg rd5;
reg rd6;
reg rd7;


integer i;
integer current_table_addr0;
integer current_table_addr1;
integer current_table_addr2;
integer current_table_addr3;
integer current_table_addr4;
integer current_table_addr5;
integer current_table_addr6;
integer current_table_addr7;



//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
/*------------------------------------读取操作-----------------------------------------------*/
//---------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
//读取可从8个子表中并行进行,每个子表进行轮询读出�??
integer rd_counter0;
integer rd_counter1;
integer rd_counter2;
integer rd_counter3;
integer rd_counter4;
integer rd_counter5;
integer rd_counter6;
integer rd_counter7;
//因为要对table_mem这个二维数组操作，所以最好在对该数组读操作时不与写操作冲突，受wr_state_cs的控�??
reg [3:0]rd_state_cs0;
reg [3:0]rd_state_ns0;
reg [3:0]rd_state_cs1;
reg [3:0]rd_state_ns1;
reg [3:0]rd_state_cs2;
reg [3:0]rd_state_ns2;
reg [3:0]rd_state_cs3;
reg [3:0]rd_state_ns3;
reg [3:0]rd_state_cs4;
reg [3:0]rd_state_ns4;
reg [3:0]rd_state_cs5;
reg [3:0]rd_state_ns5;
reg [3:0]rd_state_cs6;
reg [3:0]rd_state_ns6;
reg [3:0]rd_state_cs7;
reg [3:0]rd_state_ns7;


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access0<='b0;
    else if((rd_state_cs0=='b0)&&(rd_state_ns0=='b0))
        rd_access0<='b1;
    else 
        rd_access0<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access1<='b0;
    else if((rd_state_cs1=='b0)&&(rd_state_ns1=='b0))
        rd_access1<='b1;
    else 
        rd_access1<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access2<='b0;
    else if((rd_state_cs2=='b0)&&(rd_state_ns2=='b0))
        rd_access2<='b1;
    else 
        rd_access2<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access3<='b0;
    else if((rd_state_cs3=='b0)&&(rd_state_ns3=='b0))
        rd_access3<='b1;
    else 
        rd_access3<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access4<='b0;
    else if((rd_state_cs4=='b0)&&(rd_state_ns4=='b0))
        rd_access4<='b1;
    else 
        rd_access4<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access5<='b0;
    else if((rd_state_cs5=='b0)&&(rd_state_ns5=='b0))
        rd_access5<='b1;
    else 
        rd_access5<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access6<='b0;
    else if((rd_state_cs6=='b0)&&(rd_state_ns6=='b0))
        rd_access6<='b1;
    else 
        rd_access6<='b0;
end
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_access7<='b0;
    else if((rd_state_cs7=='b0)&&(rd_state_ns7=='b0))
        rd_access7<='b1;
    else 
        rd_access7<='b0;
end

/*-------------------------------------*/
//读取状�?�机0
/*---------------------------------------*/



always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs0<='b0;
    end
    else 
        rd_state_cs0<=rd_state_ns0;
end

always @(*)begin
    case(rd_state_cs0)
        IDLE:begin
            if((r_en0=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns0=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns0=RR;
            end
            else
                rd_state_ns0=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns0=RR;
        end
        RR:begin
            rd_state_ns0=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem0_reg=table_mem0[i];
                if(table_mem0_reg[9:0]!=table_mem0_reg[19:10])begin//首位指针相等�??
                    rd_state_ns0=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter0=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns0=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done0=='b1)
                rd_state_ns0=NEW_ADDR;
            else 
                rd_state_ns0=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns0=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem0[rd_counter0][9:0]==table_mem0[rd_counter0][19:10])
                rd_state_ns0=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns0=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns0=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns0=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns0=IDLE;
        end
        default:begin
            rd_state_ns0=IDLE;
            rd_counter0='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table0_empty<='b0;
        current_flow_empty0<='b0;
        addr_head_valid0<='b0;
        addr_head0<='b0;
        table_mem0_r_reg<='b0;
    end
    else begin
        case(rd_state_ns0)
            IDLE:begin
                table0_empty<='b0;
                current_flow_empty0<='b0;
                addr_head_valid0<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head0<=table_mem0[rd_counter0][19:10];//给出当前流的首地�??
                addr_head_valid0<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid0<='b0;
            end
            NEW_ADDR:begin
                table_mem0_r_reg[19:10]<=addr_new0;
                table_mem0_r_reg[61:52]<=table_mem0[rd_counter0][61:52]-1'b1;
                //table_mem0[rd_counter0][19:10]<=addr_new0;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty0<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr0_empty<='b1;
                fifo_data_in0_empty<=rd_counter0;
                table_mem0_r_reg<='b0;
                //table_mem0[rd_counter0]<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr0_empty<='b0;
                current_flow_empty0<='b0;
                fifo_data_in0_empty<='b0;
            end
            TABLE_EMPTY:begin
                table0_empty<='b1;
                addr_head_valid0<='b0;
            end
            default:begin
                table0_empty<='b0;
                current_flow_empty0<='b0;
            end
        endcase
    end
end


//读状态机1

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs1<='b0;
    end
    else 
        rd_state_cs1<=rd_state_ns1;
end


always @(*)begin
    case(rd_state_cs1)
        IDLE:begin
            if((r_en1=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns1=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns1=RR;
            end
            else
                rd_state_ns1=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns1=RR;
        end
        RR:begin
            rd_state_ns1=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem1_reg=table_mem1[i];
                if(table_mem1_reg[9:0]!=table_mem1_reg[19:10])begin//首位指针相等�??
                    rd_state_ns1=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter1=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns1=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done1=='b1)
                rd_state_ns1=NEW_ADDR;
            else 
                rd_state_ns1=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns1=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem1[rd_counter1][9:0]==table_mem1[rd_counter1][19:10])
                rd_state_ns1=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns1=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns1=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns1=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns1=IDLE;
        end
        default:begin
            rd_state_ns1=IDLE;
            rd_counter1='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table1_empty<='b0;
        current_flow_empty1<='b0;
        addr_head_valid1<='b0;
        addr_head1<='b0;
        table_mem1_r_reg<='b0;
    end
    else begin
        case(rd_state_ns1)
            IDLE:begin
                table1_empty<='b0;
                current_flow_empty1<='b0;
                addr_head_valid1<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head1<=table_mem1[rd_counter1][19:10];//给出当前流的首地�??
                addr_head_valid1<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid1<='b0;
            end
            NEW_ADDR:begin
                table_mem1_r_reg[19:10]<=addr_new1;
                table_mem1_r_reg[61:52]<=table_mem1[rd_counter1][61:52]-1'b1;
                //table_mem1[rd_counter1][19:10]<=addr_new1;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty1<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr1_empty<='b1;
                fifo_data_in1_empty<=rd_counter1;
                table_mem1_r_reg<='b0;
                //table_mem1[rd_counter1]<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr1_empty<='b0;
                current_flow_empty1<='b0;
                fifo_data_in1_empty<='b0;
            end
            TABLE_EMPTY:begin
                table1_empty<='b1;
                addr_head_valid1<='b0;
            end
            default:begin
                table1_empty<='b0;
                current_flow_empty1<='b0;
            end
        endcase
    end
end
//读状态机2
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs2<='b0;
    end
    else 
        rd_state_cs2<=rd_state_ns2;
end


always @(*)begin
    case(rd_state_cs2)
        IDLE:begin
            if((r_en2=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns2=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns2=RR;
            end
            else
                rd_state_ns2=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns2=RR;
        end
        RR:begin
            rd_state_ns2=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem2_reg=table_mem2[i];
                if(table_mem2_reg[9:0]!=table_mem2_reg[19:10])begin//首位指针相等�??
                    rd_state_ns2=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter2=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns2=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done2=='b1)
                rd_state_ns2=NEW_ADDR;
            else 
                rd_state_ns2=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns2=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem2[rd_counter2][9:0]==table_mem2[rd_counter2][19:10])
                rd_state_ns2=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns2=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns2=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns2=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns2=IDLE;
        end
        default:begin
            rd_state_ns2=IDLE;
            rd_counter2='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table2_empty<='b0;
        current_flow_empty2<='b0;
        addr_head_valid2<='b0;
        addr_head2<='b0;
        table_mem2_r_reg<='b0;
    end
    else begin
        case(rd_state_ns2)
            IDLE:begin
                table2_empty<='b0;
                current_flow_empty2<='b0;
                addr_head_valid2<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head2<=table_mem2[rd_counter2][19:10];//给出当前流的首地�??
                addr_head_valid2<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid2<='b0;
            end
            NEW_ADDR:begin
                table_mem2_r_reg[19:10]<=addr_new2;
                table_mem2_r_reg[61:52]<=table_mem2[rd_counter2][61:52]-1'b1;
                //table_mem2[rd_counter2][19:10]<=addr_new2;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty2<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr2_empty<='b1;
                fifo_data_in2_empty<=rd_counter2;
                table_mem2_r_reg<='b0;
                //table_mem2[rd_counter2]<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr2_empty<='b0;
                current_flow_empty2<='b0;
                fifo_data_in2_empty<='b0;
            end
            TABLE_EMPTY:begin
                table2_empty<='b1;
                addr_head_valid2<='b0;
            end
            default:begin
                table2_empty<='b0;
                current_flow_empty2<='b0;
            end
        endcase
    end
end


//读状态机3
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs3<='b0;
    end
    else 
        rd_state_cs3<=rd_state_ns3;
end


always @(*)begin
    case(rd_state_cs3)
        IDLE:begin
            if((r_en3=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns3=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns3=RR;
            end
            else
                rd_state_ns3=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns3=RR;
        end
        RR:begin
            rd_state_ns3=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem3_reg=table_mem3[i];
                if(table_mem3_reg[9:0]!=table_mem3_reg[19:10])begin//首位指针相等�??
                    rd_state_ns3=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter3=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns3=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done3=='b1)
                rd_state_ns3=NEW_ADDR;
            else 
                rd_state_ns3=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns3=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem3[rd_counter3][9:0]==table_mem3[rd_counter3][19:10])
                rd_state_ns3=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns3=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns3=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns3=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns3=IDLE;
        end
        default:begin
            rd_state_ns3=IDLE;
            rd_counter3='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table3_empty<='b0;
        current_flow_empty3<='b0;
        addr_head_valid3<='b0;
        addr_head3<='b0;
        table_mem3_r_reg<='b0;
    end
    else begin
        case(rd_state_ns3)
            IDLE:begin
                table3_empty<='b0;
                current_flow_empty3<='b0;
                addr_head_valid3<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head3<=table_mem3[rd_counter3][19:10];//给出当前流的首地�??
                addr_head_valid3<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid3<='b0;
            end
            NEW_ADDR:begin
                table_mem3_r_reg[19:10]<=addr_new3;
                table_mem3_r_reg[61:52]<=table_mem3[rd_counter3][61:52]-1'b1;
                //table_mem3[rd_counter3][19:10]<=addr_new3;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty3<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr3_empty<='b1;
                fifo_data_in3_empty<=rd_counter3;
                table_mem3_r_reg<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr3_empty<='b0;
                current_flow_empty3<='b0;
                fifo_data_in3_empty<='b0;
            end
            TABLE_EMPTY:begin
                table3_empty<='b1;
                addr_head_valid3<='b0;
            end
            default:begin
                table3_empty<='b0;
                current_flow_empty3<='b0;
            end
        endcase
    end
end

//读状态机4

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs4<='b0;
    end
    else 
        rd_state_cs4<=rd_state_ns4;
end


always @(*)begin
    case(rd_state_cs4)
        IDLE:begin
            if((r_en4=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns4=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns4=RR;
            end
            else
                rd_state_ns4=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns4=RR;
        end
        RR:begin
            rd_state_ns4=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem4_reg=table_mem4[i];
                if(table_mem4_reg[9:0]!=table_mem4_reg[19:10])begin//首位指针相等�??
                    rd_state_ns4=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter4=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns4=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done4=='b1)
                rd_state_ns4=NEW_ADDR;
            else 
                rd_state_ns4=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns4=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem4[rd_counter4][9:0]==table_mem4[rd_counter4][19:10])
                rd_state_ns4=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns4=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns4=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns4=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns4=IDLE;
        end
        default:begin
            rd_state_ns4=IDLE;
            rd_counter4='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table4_empty<='b0;
        current_flow_empty4<='b0;
        addr_head_valid4<='b0;
        addr_head4<='b0;
        table_mem4_r_reg<='b0;
    end
    else begin
        case(rd_state_ns4)
            IDLE:begin
                table4_empty<='b0;
                current_flow_empty4<='b0;
                addr_head_valid4<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head4<=table_mem4[rd_counter4][19:10];//给出当前流的首地�??
                addr_head_valid4<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid4<='b0;
            end
            NEW_ADDR:begin
                table_mem4_r_reg[19:10]<=addr_new4;
                table_mem4_r_reg[61:52]<=table_mem4[rd_counter4][61:52]-1'b1;
                //table_mem4[rd_counter4][19:10]<=addr_new4;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty4<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr4_empty<='b1;
                fifo_data_in4_empty<=rd_counter4;
                table_mem4_r_reg<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr4_empty<='b0;
                current_flow_empty4<='b0;
                fifo_data_in4_empty<='b0;
            end
            TABLE_EMPTY:begin
                table4_empty<='b1;
                addr_head_valid4<='b0;
            end
            default:begin
                table4_empty<='b0;
                current_flow_empty4<='b0;
            end
        endcase
    end
end

//读状态机5
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs5<='b0;
    end
    else 
        rd_state_cs5<=rd_state_ns5;
end


always @(*)begin
    case(rd_state_cs5)
        IDLE:begin
            if((r_en5=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns5=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns5=RR;
            end
            else
                rd_state_ns5=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns5=RR;
        end
        RR:begin
            rd_state_ns5=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem5_reg=table_mem5[i];
                if(table_mem5_reg[9:0]!=table_mem5_reg[19:10])begin//首位指针相等�??
                    rd_state_ns5=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter5=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns5=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done5=='b1)
                rd_state_ns5=NEW_ADDR;
            else 
                rd_state_ns5=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns5=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem5[rd_counter5][9:0]==table_mem5[rd_counter5][19:10])
                rd_state_ns5=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns5=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns5=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns5=IDLE;
        end
        table0_empty:begin
            rd_state_ns5=IDLE;
        end
        default:begin
            rd_state_ns5=IDLE;
            rd_counter5='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table5_empty<='b0;
        current_flow_empty5<='b0;
        addr_head_valid5<='b0;
        addr_head5<='b0;
        table_mem5_r_reg<='b0;
    end
    else begin
        case(rd_state_ns5)
            IDLE:begin
                table5_empty<='b0;
                current_flow_empty5<='b0;
                addr_head_valid5<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head5<=table_mem5[rd_counter5][19:10];//给出当前流的首地�??
                addr_head_valid5<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid5<='b0;
            end
            NEW_ADDR:begin
                table_mem5_r_reg[19:10]<=addr_new5;
                table_mem5_r_reg[61:52]<=table_mem5[rd_counter5][61:52]-1'b1;
                //table_mem5[rd_counter5][19:10]<=addr_new5;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty5<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr5_empty<='b1;
                fifo_data_in5_empty<=rd_counter5;
                table_mem5_r_reg<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr5_empty<='b0;
                current_flow_empty5<='b0;
                fifo_data_in5_empty<='b0;
            end
            TABLE_EMPTY:begin
                table5_empty<='b1;
                addr_head_valid5<='b0;
            end
            default:begin
                table5_empty<='b0;
                current_flow_empty5<='b0;
            end
        endcase
    end
end

//读状态机6

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs6<='b0;
    end
    else 
        rd_state_cs6<=rd_state_ns6;
end


always @(*)begin
    case(rd_state_cs6)
        IDLE:begin
            if((r_en6=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns6=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns6=RR;
            end
            else
                rd_state_ns6=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns6=RR;
        end
        RR:begin
            rd_state_ns6=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem6_reg=table_mem6[i];
                if(table_mem6_reg[9:0]!=table_mem6_reg[19:10])begin//首位指针相等�??
                    rd_state_ns6=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter6=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns6=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done6=='b1)
                rd_state_ns6=NEW_ADDR;
            else 
                rd_state_ns6=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns6=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem6[rd_counter6][9:0]==table_mem6[rd_counter6][19:10])
                rd_state_ns6=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns6=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns6=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns6=IDLE;
        end
        TABLE_EMPTY:begin
            rd_state_ns6=IDLE;
        end
        default:begin
            rd_state_ns6=IDLE;
            rd_counter6='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table6_empty<='b0;
        current_flow_empty6<='b0;
        addr_head_valid6<='b0;
        addr_head6<='b0;
        table_mem6_r_reg<='b0;
    end
    else begin
        case(rd_state_ns6)
            IDLE:begin
                table6_empty<='b0;
                current_flow_empty6<='b0;
                addr_head_valid6<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head6<=table_mem6[rd_counter6][19:10];//给出当前流的首地�??
                addr_head_valid6<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid6<='b0;
            end
            NEW_ADDR:begin
                table_mem6_r_reg[19:10]<=addr_new6;
                table_mem6_r_reg[61:52]<=table_mem6[rd_counter6][61:52]-1'b1;
                //table_mem6[rd_counter6][19:10]<=addr_new6;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty6<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr6_empty<='b1;
                fifo_data_in6_empty<=rd_counter6;
                table_mem6_r_reg<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr6_empty<='b0;
                current_flow_empty6<='b0;
                fifo_data_in6_empty<='b0;
            end
            TABLE_EMPTY:begin
                table6_empty<='b1;
                addr_head_valid6<='b0;
            end
            default:begin
                table6_empty<='b0;
                current_flow_empty6<='b0;
            end
        endcase
    end
end
//读取状�?�机7
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd_state_cs7<='b0;
    end
    else 
        rd_state_cs7<=rd_state_ns7;
end


always @(*)begin
    case(rd_state_cs7)
        IDLE:begin
            if((r_en7=='b1))begin//写优先标志，不能同时对table_mem操作
                if((wr_state_ns==NEW_TABLE2)||(wr_state_ns==TABLE_SEARCH))
                    rd_state_ns7=RR_WAIT;//当写入table_mem时，读等待一个clk
                else 
                rd_state_ns7=RR;
            end
            else
                rd_state_ns7=IDLE;
        end
        RR_WAIT:begin
            rd_state_ns7=RR;
        end
        RR:begin
            rd_state_ns7=TABLE_EMPTY;
            for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录
                table_mem7_reg=table_mem7[i];
                if(table_mem7_reg[9:0]!=table_mem7_reg[19:10])begin//首位指针相等�??
                    rd_state_ns7=RR_DELAY;//该优先级的流有就出，目前没�?�虑调度规则�??
                    rd_counter7=i;//等待�??个clk才能采到rd_counter0的�??
                end
            end
        end
        RR_DELAY:begin
            rd_state_ns7=NEW_ADDR_WAIT;
        end
        NEW_ADDR_WAIT:begin
            if(done7=='b1)
                rd_state_ns7=NEW_ADDR;
            else 
                rd_state_ns7=NEW_ADDR_WAIT;
        end
        NEW_ADDR:begin
            rd_state_ns7=TABLE_JUDGE;
        end
        TABLE_JUDGE:begin
            if(table_mem7[rd_counter7][9:0]==table_mem7[rd_counter7][19:10])
                rd_state_ns7=ADDR_RECYCLE1;//当前流为空时，下�??步地�??回收
            else 
                rd_state_ns7=IDLE;//当前流非空时，回到IDLE,等待下一次读取�??

        end
        ADDR_RECYCLE1:begin
            rd_state_ns7=ADDR_RECYCLE2;
        end
        ADDR_RECYCLE2:begin
            rd_state_ns7=IDLE;
        end
        table0_empty:begin
            rd_state_ns7=IDLE;
        end
        default:begin
            rd_state_ns7=IDLE;
            rd_counter7='b0;
        end
    endcase
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        table7_empty<='b0;
        current_flow_empty7<='b0;
        addr_head_valid7<='b0;
        addr_head7<='b0;
        table_mem7_r_reg<='b0;
    end
    else begin
        case(rd_state_ns7)
            IDLE:begin
                table7_empty<='b0;
                current_flow_empty7<='b0;
                addr_head_valid7<='b0;
            end
            RR_WAIT:begin

            end
            RR:begin

            end
            RR_DELAY:begin
                addr_head7<=table_mem7[rd_counter7][19:10];//给出当前流的首地�??
                addr_head_valid7<='b1;               
            end
            NEW_ADDR_WAIT:begin
                addr_head_valid7<='b0;
            end
            NEW_ADDR:begin
                table_mem7_r_reg[19:10]<=addr_new7;
                table_mem7_r_reg[61:52]<=table_mem7[rd_counter7][61:52]-1'b1;
                //table_mem7[rd_counter7][19:10]<=addr_new7;//将新地址更近在表�??
            end
            TABLE_JUDGE:begin

            end
            ADDR_RECYCLE1:begin
                current_flow_empty7<='b1;//拉高�??个clk表示当前流全部读�??
                fifo_wr7_empty<='b1;
                fifo_data_in7_empty<=rd_counter7;
                table_mem7_r_reg<='b0;//将该表项擦除
            end
            ADDR_RECYCLE2:begin
                fifo_wr7_empty<='b0;
                current_flow_empty7<='b0;
                fifo_data_in7_empty<='b0;
            end
            TABLE_EMPTY:begin
                table7_empty<='b1;
                addr_head_valid7<='b0;
            end
            default:begin
                table7_empty<='b0;
                current_flow_empty7<='b0;
            end
        endcase
    end
end



/*---------------------------------------------------------------------------------------------
------------写入操作---------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------*/

/*地址有效判断,addr_valid拉高�??个clk，然后fsm�??始跳转，完成对当前frame的存�??*/
reg[2:0] inter_addr_counter;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr_counter<='b0;
         inter_addr_counter<='b0;end
    else if(addr_counter==addr_num)
        addr_counter<='b0;
    else if(w_en=='b1)begin
       inter_addr_counter<=inter_addr_counter+1;
       if(inter_addr_counter=='d3)begin
        addr_counter<=addr_counter+1;
        inter_addr_counter<=0;
        end
        end
    else 
        addr_counter<=addr_counter;
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        addr_valid<='b0;
    else if(addr_counter==addr_num)
        addr_valid<='b1;
    else 
        addr_valid<='b0;
end







/*------------------------------frame信息写入的状态机-------------------------------------*/
//------------------------------------------------------------------------------------------//
/*当新的frame到达时，�??要从八分fifo中�?�一个取出地�??，将frame信息存入对应的子表中*/


//
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        wr_state_cs<='b0;
    else if(init_done=='b1)
        wr_state_cs<=wr_state_ns;
    else 
        wr_state_cs<=wr_state_cs;
end



always @(*)begin 
    if(init_done==1'b1)begin
        case(wr_state_cs)
            IDLE:begin
                if(addr_valid!='b0)
                    wr_state_ns=ID_COMPARE;
                else
                    wr_state_ns=wr_state_ns;
            end
            ID_COMPARE:begin
                wr_state_ns=NEW_TABLE;
               // current_table_addr0='b0;
                case(priority)//根据不同的priority从不同的子表中查找流信息
                    'b000:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�?
                            table_mem0_reg1=table_mem0[i];
                            if(flow_id==table_mem0_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr0=i;
                            end
                    end 
                    end
                    'b001:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem1_reg1=table_mem1[i];
                            if(flow_id==table_mem1_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr1=i;
                            end
                    end 
                    end
                    'b010:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem2_reg1=table_mem2[i];
                            if(flow_id==table_mem2_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr2=i;
                            end
                    end 
                    end
                    'b011:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem3_reg1=table_mem3[i];
                            if(flow_id==table_mem3_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr3=i;
                            end
                    end 
                    end
                    'b100:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem4_reg1=table_mem4[i];
                            if(flow_id==table_mem4_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr4=i;
                            end
                    end 
                    end
                    'b101:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem5_reg1=table_mem5[i];
                            if(flow_id==table_mem5_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr5=i;
                            end
                    end 
                    end
                    'b110:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                            table_mem6_reg1=table_mem6[i];
                            if(flow_id==table_mem6_reg1[51:20])begin
                                wr_state_ns=TABLE_SEARCH;
                                current_table_addr6=i;
                            end
                    end 
                    end
                    'b111:begin
                        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)begin//记录当前流id的表项位�??
                        table_mem7_reg1=table_mem7[i];
                        if(flow_id==table_mem7_reg1[51:20])begin
                            wr_state_ns=TABLE_SEARCH;
                            current_table_addr7=i;
                        end
                    end 
                    end
                    default:begin
                        wr_state_ns=IDLE;
                    end
                endcase
            end
            TABLE_SEARCH:begin//已经存在表项，更新该表项
                if(updata_done ==1'b1)
                    wr_state_ns=IDLE;
                else begin
                    wr_state_ns=TABLE_SEARCH;
                    wr_state_ns=IDLE;
                end
            end
            NEW_TABLE:begin
                wr_state_ns=NEW_TABLE1;
            end
            NEW_TABLE1:begin
                wr_state_ns=NEW_TABLE2;
            end
            NEW_TABLE2:begin
                wr_state_ns=IDLE;

            end
            default:begin
                wr_state_ns='b0;
                current_table_addr0='b0;
                current_table_addr1='b0;
                current_table_addr2='b0;
                current_table_addr3='b0;
                current_table_addr4='b0;
                current_table_addr5='b0;
                current_table_addr6='b0;
                current_table_addr7='b0;
                wr_state_ns=IDLE;
            end
        endcase
    end
    else begin
        wr_state_ns='b0;
        current_table_addr0='b0;
        current_table_addr1='b0;
        current_table_addr2='b0;
        current_table_addr3='b0;
        current_table_addr4='b0;
        current_table_addr5='b0;
        current_table_addr6='b0;
        current_table_addr7='b0;
    end 
end






always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        rd0='b0;
        rd1='b0;
        rd2='b0;
        rd3='b0;
        rd4='b0;
        rd5='b0;
        rd6='b0;
        rd7='b0;
        table_mem_w_reg<='b0;
//       fifo_rd<='b0;
        updata_done<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem0[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem1[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem2[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem3[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem4[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem5[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem6[i]<='b0;
        // for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        //     table_mem7[i]<='b0;
    end
    else if(init_done=='b1) begin 
        case(wr_state_ns)
            IDLE:begin
                updata_done<='b0;
                info_valid<='b0;
                frame_num<='b0;
                flow_tail_addr<='b0;
            end
            ID_COMPARE:begin
            
            end
            TABLE_SEARCH:begin 
                case(priority)
                    'b000:begin
                        info_valid<='b1;
                        frame_num<=table_mem0[current_table_addr0][61:52];
                        flow_tail_addr<=table_mem0[current_table_addr0][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem0[current_table_addr0][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b001:begin
                        info_valid<='b1;
                        frame_num<=table_mem1[current_table_addr1][61:52];
                        flow_tail_addr<=table_mem1[current_table_addr1][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem1[current_table_addr1][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b010:begin
                        info_valid<='b1;
                        frame_num<=table_mem2[current_table_addr2][61:52];
                        flow_tail_addr<=table_mem2[current_table_addr2][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem2[current_table_addr2][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b011:begin
                        info_valid<='b1;
                        frame_num<=table_mem3[current_table_addr3][61:52];
                        flow_tail_addr<=table_mem3[current_table_addr3][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem3[current_table_addr3][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b100:begin
                        info_valid<='b1;
                        frame_num<=table_mem4[current_table_addr4][61:52];
                        flow_tail_addr<=table_mem4[current_table_addr4][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem4[current_table_addr4][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b101:begin
                        info_valid<='b1;
                        frame_num<=table_mem5[current_table_addr5][61:52];
                        flow_tail_addr<=table_mem5[current_table_addr5][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem5[current_table_addr5][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b110:begin
                        info_valid<='b1;
                        frame_num<=table_mem6[current_table_addr6][61:52];
                        flow_tail_addr<=table_mem6[current_table_addr6][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        table_mem_w_reg[61:52]<=table_mem6[current_table_addr6][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    'b111:begin
                        info_valid<='b1;
                        frame_num<=table_mem7[current_table_addr7][61:52];
                        flow_tail_addr<=table_mem7[current_table_addr7][9:0];
                        table_mem_w_reg[9:0]<=addr;
                        //当前流frame数量�?1
                        table_mem_w_reg[61:52]<=table_mem7[current_table_addr7][61:52]+1'b1;
                        updata_done<='b1;
                    end
                    default:begin

                    end
                endcase
            end
            NEW_TABLE:begin//从对应fifo中拿出存放在表中的地�??
                case(priority)
                    'b000:rd0='b1;//该写使能与输入的写使能不是同�??个；
                    'b001:rd1='b1;
                    'b010:rd2='b1;
                    'b011:rd3='b1;
                    'b100:rd4='b1;
                    'b101:rd5='b1;
                    'b110:rd6='b1;
                    'b111:rd7='b1;
                    default:begin

                    end
                endcase
            end
            NEW_TABLE1:begin
                rd0='b0;
                rd1='b0;
                rd2='b0;
                rd3='b0;
                rd4='b0;
                rd5='b0;
                rd6='b0;
                rd7='b0;
            end
            NEW_TABLE2:begin
                info_valid<='b1;
                frame_num<='b0;
                flow_tail_addr<='b0;
                case(priority)
                //新frame的情况下�?61�?52字段�?1
                'b000:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b001:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b010:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b011:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b100:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b101:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b110:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                'b111:table_mem_w_reg<={10'b1,flow_id,new_frame_addr_head,addr};
                default:begin

                end
                endcase
            end
            default:begin
                rd0='b0;
                rd1='b0;
                rd2='b0;
                rd3='b0;
                rd4='b0;
                rd5='b0;
                rd6='b0;
                rd7='b0;
//                fifo_rd<='b0;
                updata_done<='b0;
            end
        endcase   
    end

end

//--------------------------------------------------------------------------------------------
//----------------------------将输入更新入表中-------------------------------------------------
//--------------------------------------------------------------------------------------------
//写入的情况下，只�?要一个reg来缓存更新到表项的数�?
//读出的情况下，需�?8个reg来缓存更新到表项的数�?
//�?0
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem0[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b000))
        table_mem0[fifo_data_out0-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b000))begin
        table_mem0[current_table_addr0][9:0]<=table_mem_w_reg[9:0];
        table_mem0[current_table_addr0][61:52]<=table_mem_w_reg[61:52];
        //旧表项更新尾地址和frame数量
    end
    else if(rd_state_cs0==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem0[rd_counter0][19:10]<=table_mem0_r_reg[19:10];//table_mem0_r_reg
        table_mem0[rd_counter0][61:52]<=table_mem0_r_reg[61:52];
    end
    else if(rd_state_cs0==ADDR_RECYCLE1)
        table_mem0[rd_counter0]<=table_mem0_r_reg;
end

//�?1
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem1[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b001))
            table_mem1[fifo_data_out1-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b001))begin
            table_mem1[current_table_addr1][9:0]<=table_mem_w_reg[9:0];//旧表�?
            table_mem1[current_table_addr1][61:52]<=table_mem_w_reg[61:52];
    end 
    else if(rd_state_cs1==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem1[rd_counter1][19:10]<=table_mem1_r_reg[19:10];//table_mem0_r_reg
        table_mem1[rd_counter1][61:52]<=table_mem1_r_reg[61:52];
    end
    else if(rd_state_cs1==ADDR_RECYCLE1)
        table_mem1[rd_counter1]<=table_mem1_r_reg;
end

//�?2
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem2[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b010))
        table_mem2[fifo_data_out2-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b010))begin
        table_mem2[current_table_addr2][9:0]<=table_mem_w_reg[9:0];//旧表�?
        table_mem2[current_table_addr2][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs2==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem2[rd_counter2][19:10]<=table_mem2_r_reg[19:10];//table_mem0_r_reg
        table_mem2[rd_counter2][61:52]<=table_mem2_r_reg[61:52];
    end
    else if(rd_state_cs2==ADDR_RECYCLE1)
        table_mem2[rd_counter2]<=table_mem2_r_reg;
end

//�?3
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem3[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b011))
        table_mem3[fifo_data_out3-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b011))begin
        table_mem3[current_table_addr3][9:0]<=table_mem_w_reg[9:0];//旧表�?
        table_mem3[current_table_addr3][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs3==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem3[rd_counter3][19:10]<=table_mem3_r_reg[19:10];//table_mem0_r_reg
        table_mem3[rd_counter3][61:52]<=table_mem3_r_reg[61:52];
    end
    else if(rd_state_cs3==ADDR_RECYCLE1)
        table_mem3[rd_counter3]<=table_mem3_r_reg;
end

//�?4
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem4[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b100))
            table_mem4[fifo_data_out4-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b100))begin
            table_mem4[current_table_addr4][9:0]<=table_mem_w_reg[9:0];//旧表�?
            table_mem4[current_table_addr4][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs4==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem4[rd_counter4][19:10]<=table_mem4_r_reg[19:10];//table_mem0_r_reg
        table_mem4[rd_counter4][61:52]<=table_mem4_r_reg[61:52];
    end
    else if(rd_state_cs4==ADDR_RECYCLE1)
        table_mem4[rd_counter4]<=table_mem4_r_reg;
end

//�?5
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem5[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b101))
        table_mem5[fifo_data_out5-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b101))begin
        table_mem5[current_table_addr5][9:0]<=table_mem_w_reg[9:0];//旧表�?
        table_mem5[current_table_addr5][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs5==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem5[rd_counter5][19:10]<=table_mem5_r_reg[19:10];//table_mem0_r_reg
        table_mem5[rd_counter5][61:52]<=table_mem5_r_reg[61:52];
    end
    else if(rd_state_cs5==ADDR_RECYCLE1)
        table_mem5[rd_counter5]<=table_mem5_r_reg;
end

//�?6
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem6[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b110))
        table_mem6[fifo_data_out6-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b110))begin
        table_mem6[current_table_addr6][9:0]<=table_mem_w_reg[9:0];//旧表�?
        table_mem6[current_table_addr6][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs6==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem6[rd_counter6][19:10]<=table_mem6_r_reg[19:10];//table_mem0_r_reg
        table_mem6[rd_counter6][61:52]<=table_mem6_r_reg[61:52];
    end
    else if(rd_state_cs6==ADDR_RECYCLE1)
        table_mem6[rd_counter6]<=table_mem6_r_reg;
end

//�?7
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for(i=0;i<{(TABLE_AW-3){1'b1}};i=i+1)
        table_mem7[i]<='b0;
    end
    else if((wr_state_cs===NEW_TABLE2)&&(priority==3'b111))
        table_mem7[fifo_data_out7-1'b1]<=table_mem_w_reg;//新表�?
    else if((wr_state_cs==TABLE_SEARCH)&&(priority==3'b111))begin
        table_mem7[current_table_addr7][9:0]<=table_mem_w_reg[9:0];//旧表�?
        table_mem7[current_table_addr7][61:52]<=table_mem_w_reg[61:52];
    end
    else if(rd_state_cs7==NEW_ADDR)begin//读出操作对一个表操作，八个可并行进行�?
        table_mem7[rd_counter7][19:10]<=table_mem7_r_reg[19:10];
        table_mem7[rd_counter7][61:52]<=table_mem7_r_reg[61:52];
        //读取完成后更新head和frame数量
    end
    else if(rd_state_cs7==ADDR_RECYCLE1)
        table_mem7[rd_counter7]<=table_mem7_r_reg;
end





//--------------------------------------------------------------------
//--------------------------------------------------------------------
/*8个fifo的初始化*/
//--------------------------------------------------------------------
//--------------------------------------------------------------------

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        fifo_counter<='b0;
    else if(fifo_counter=={(TABLE_AW-3){1'b1}}) 
        fifo_counter<='b0;
    else if(init_done=='b0) 
        fifo_counter<=fifo_counter+1; 
    else 
        fifo_counter<=fifo_counter;  
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        fifo_data_in<='b0;
    else if(fifo_data_in=={(TABLE_AW-3){1'b1}}) 
        fifo_data_in<='b0;
    else if(init_done=='b0)
        fifo_data_in<=fifo_data_in+1; 
    else 
        fifo_data_in<=fifo_data_in;                                                            
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        fifo_wr<='b0;
    else if(fifo_counter=={(TABLE_AW-3){1'b1}})
        fifo_wr<='b0; 
    else if(init_done=='b0)
        fifo_wr<='b1;  
    else 
        fifo_wr<=fifo_wr;
end


always @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        init_done<='b0;
    else if(init_done==0 && fifo_counter=={(TABLE_AW-3){1'b1}})
        init_done<='b1;
    else 
        init_done<=init_done;
end
/*初始化FIFO，八个fifo同时被初始化，输入数据皆相同*/


always@(*)
begin
    fifo_wr0='b0;
    fifo_wr1='b0;
    fifo_wr2='b0;
    fifo_wr3='b0;
    fifo_wr4='b0;
    fifo_wr5='b0;
    fifo_wr6='b0;
    fifo_wr7='b0;
    if(init_done=='b0)begin
        fifo_wr0=fifo_wr;//fifo_wr为初始化FIFO的使能；还需要受到读出一个流的读使能控制
        fifo_wr1=fifo_wr;
        fifo_wr2=fifo_wr;
        fifo_wr3=fifo_wr;
        fifo_wr4=fifo_wr;
        fifo_wr5=fifo_wr;
        fifo_wr6=fifo_wr;
        fifo_wr7=fifo_wr;
    end
    else begin
        fifo_wr0='b0;
        fifo_wr1='b0;
        fifo_wr2='b0;
        fifo_wr3='b0;
        fifo_wr4='b0;
        fifo_wr5='b0;
        fifo_wr6='b0;
        fifo_wr7='b0;
    end
end

/*初始化FIFO的�?�择�??2:fifo_data选择�??*/

always@(*)
begin
    fifo_data_in0='b0;//对于写入fifo的操作，受到初始化和表项中取走一个流的控�??
    fifo_data_in1='b0;
    fifo_data_in2='b0;
    fifo_data_in3='b0;
    fifo_data_in4='b0;
    fifo_data_in5='b0;
    fifo_data_in6='b0;
    fifo_data_in7='b0;
    if(init_done=='b0)begin
        fifo_data_in0=fifo_data_in;//fifo_data_in为初始化FIFO的数据；
        fifo_data_in1=fifo_data_in;
        fifo_data_in2=fifo_data_in;
        fifo_data_in3=fifo_data_in;
        fifo_data_in4=fifo_data_in;
        fifo_data_in5=fifo_data_in;
        fifo_data_in6=fifo_data_in;
        fifo_data_in7=fifo_data_in;
    end
    else begin
        fifo_data_in0='b0;
        fifo_data_in1='b0;
        fifo_data_in2='b0;
        fifo_data_in3='b0;
        fifo_data_in4='b0;
        fifo_data_in5='b0;
        fifo_data_in6='b0;
        fifo_data_in7='b0;
    end

end
wire  wr0,wr1,wr2,wr3,wr4,wr5,wr6,wr7;
//fifo_wr_empty为该流读空时，回收地�??时的使能；对于写入fifo的操作，受到初始化和表项中取走一个流的控�??
assign wr0=(init_done=='b0)?fifo_wr0:fifo_wr0_empty;
assign wr1=(init_done=='b0)?fifo_wr1:fifo_wr1_empty;
assign wr2=(init_done=='b0)?fifo_wr2:fifo_wr2_empty;
assign wr3=(init_done=='b0)?fifo_wr3:fifo_wr3_empty;
assign wr4=(init_done=='b0)?fifo_wr4:fifo_wr4_empty;
assign wr5=(init_done=='b0)?fifo_wr5:fifo_wr5_empty;
assign wr6=(init_done=='b0)?fifo_wr6:fifo_wr6_empty;
assign wr7=(init_done=='b0)?fifo_wr7:fifo_wr7_empty;
//fifo_data_in_empty为该流读空时，回收的地址
assign data0=(init_done=='b0)?fifo_data_in0:fifo_data_in0_empty;
assign data1=(init_done=='b0)?fifo_data_in1:fifo_data_in1_empty;
assign data2=(init_done=='b0)?fifo_data_in2:fifo_data_in2_empty;
assign data3=(init_done=='b0)?fifo_data_in3:fifo_data_in3_empty;
assign data4=(init_done=='b0)?fifo_data_in4:fifo_data_in4_empty;
assign data5=(init_done=='b0)?fifo_data_in5:fifo_data_in5_empty;
assign data6=(init_done=='b0)?fifo_data_in6:fifo_data_in6_empty;
assign data7=(init_done=='b0)?fifo_data_in7:fifo_data_in7_empty;






reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo0
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr0),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data0),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd0),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out0)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo1
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr1),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data1),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd1),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out1)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo2
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr2),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data2),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd2),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out2)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo3
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr3),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data3),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd3),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out3)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo4
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr4),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data4),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd4),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out4)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo5
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr5),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data5),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd5),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out5)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo6
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr6),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data6),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd6),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out6)
           );
reg_asyn_fifo #(.AW(TABLE_AW-3), .DW(TABLE_AW))
dynamic_table_addr_fifo7
            (
           .wrclk(clk),
           .wr_rst(rst_n),
           .wr_soft_rst(rst_n),
           .wrreq(wr7),
           .wrusedw(),
           .wrempty(),
           .wrfull(),
           .data(data7),
           .rdclk(clk),
           .rd_rst(rst_n),
           .rd_soft_rst(rst_n),
           .rdreq(rd7),
           .rdusedw(),
           .rdempty(),
           .rdfull(),
           .q(fifo_data_out7)
           );
endmodule