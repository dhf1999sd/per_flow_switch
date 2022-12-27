`timescale 1ns / 1ps
module frame_process(
input                	clk,
input                   rstn,
output  reg             sfifo_rd,
input        [7:0]      sfifo_dout,
output  reg             ptr_sfifo_rd,
input        [15:0]     ptr_sfifo_dout,
input                   ptr_sfifo_empty,

output  reg  [47:0]     se_mac,
output  reg  [15:0]     source_portmap,
output  reg  [9:0]      se_hash,
output  reg             se_source,
output  reg             se_req,
input                   se_ack,
input                   se_nak,
input        [15:0]     se_result,                    

input                   bp0,
input                   bp1,
input                   bp2,
input                   bp3,
output  reg             sof,
output  reg             dv,
output  reg  [7:0]      data    
);
reg     [47:0]     source_mac;
reg     [47:0]     desti_mac;
reg     [15:0]     length_type; 
reg     [5:0]      state;
reg     [10:0]     cnt;
reg     [3:0]      egress_portmap;
reg     [11:0]     length;
reg     [5:0]      pad_cnt;
reg				   broadcast;
always@(posedge clk or negedge rstn)begin
    if(rstn)begin
        sfifo_rd<= 0;
        ptr_sfifo_rd<= 0;
        se_mac<= 0;
        se_hash<= 0;
        se_req<= 0;
        source_portmap<= 0;
        sof<= 0;
        dv<= 0;
        data<= 0;
        state<= 0;
        cnt<= 0;
		se_source<= 0;
		broadcast<= 0;
        end
    else  begin
        case(state)
        0:begin
            dv<= 0;
            if(!ptr_sfifo_empty)begin
                ptr_sfifo_rd<= 1;   	
                state<= 1;         	
                end
            end
        1:begin
            ptr_sfifo_rd<= 0;
            sfifo_rd<= 1;	
            state<= 2;
            end
        2:begin
            cnt<= ptr_sfifo_dout[10:0];						
            length<= {1'b0,ptr_sfifo_dout[10:0]};				
            source_portmap<={12'b0,ptr_sfifo_dout[14:11]};	
            state<= 3;
            end
        3:begin
			length<= length+2;	
			desti_mac[47:40]<= sfifo_dout[7:0];
            state<= 4;
            end
        4:begin
			pad_cnt<=~length[5:0];	
			desti_mac[39:32]<= sfifo_dout[7:0];
            state<=5;
            end
        5:begin
            desti_mac[31:24]<=sfifo_dout[7:0];
            state<= 6;
            end
        6:begin
            desti_mac[23:16]<= sfifo_dout[7:0];
            state<= 7;
            end
        7:begin
            desti_mac[15:8]<=sfifo_dout[7:0];
            state<= 8;
            end
        8:begin
            desti_mac[7:0]<= sfifo_dout[7:0];
            state<= 9;
            end
        9:begin
            source_mac[47:40]<= sfifo_dout[7:0];
            state<= 10;
            end
        10:begin
            source_mac[39:32]<= sfifo_dout[7:0];
            state<= 11;
            end
        11:begin
            source_mac[31:24]<= sfifo_dout[7:0];
            state<= 12;
            end
        12:begin
            source_mac[23:16]<= sfifo_dout[7:0];
            state<= 13;
            end
        13:begin
            source_mac[15:8]<= sfifo_dout[7:0];
            state<= 14;
            end
        14:begin
            source_mac[7:0]<= sfifo_dout[7:0];
            state<= 15;
            end
        15:begin
            length_type[15:8]<= sfifo_dout[7:0];
            sfifo_rd<= 0;
            state<= 16;
            end
        16:begin
            length_type[7:0]<= sfifo_dout[7:0];
            cnt<= cnt-14;
			if(desti_mac==48'hff_ff_ff_ff_ff_ff) broadcast<= 1;
			else broadcast<= 0;
            state<= 19;
            end
        19:begin
            se_source<= 1;
            se_mac<= source_mac;
            se_hash<= source_mac[9:0];
            se_req<= 1;
            state<= 20;
            end
        20:begin
            if(se_ack|se_nak)begin
                se_source<= 0;
                se_hash<= desti_mac[9:0];
                se_mac<= desti_mac;
                state<= 21;
                end
                else state<=20;
            end
        21:begin
            if(se_ack)begin
                se_req<= 0;
                state<= 22;
                egress_portmap<= se_result[3:0];
                end
            if(se_nak | broadcast)begin
                se_req<= 0;
                state<= 22;
                egress_portmap<= (source_portmap==15'd1)?4'b1110:
                                (source_portmap==15'd2)?4'b1101:
                                (source_portmap==15'd4)?4'b1011:4'b0111;
                end
            end
        22:begin
            data<= {length[11:8],egress_portmap[3:0]};  
            dv<= 1;
            sof<=1;  
            state<= 23;
            end
        23:begin
            data<= length[7:0];
            state<= 24;
            sof<= 0;
            end
        24:begin
            data<= desti_mac[47:40];
            state<= 25;
            end
        25:begin
            data<= desti_mac[39:32];
            state<=26;
            end
        26:begin
            data<= desti_mac[31:24];
            state<= 27;
            end
        27:begin
            data<= desti_mac[23:16];
            state<= 28;
            end
        28:begin
            data<= desti_mac[15:8];
            state<= 29; 
            end
        29:begin
            data<=desti_mac[7:0];
            state<=30;
            end
        30:begin
            data<= source_mac[47:40];
            state<= 31;
            end
        31:begin
            data<= source_mac[39:32];
            state<= 32;
            end 
        32:begin
            data<= source_mac[31:24];
            state<= 33;
            end
        33:begin
            data<=source_mac[23:16];
            state<= 34;
            end
        34:begin
            data<= source_mac[15:8];
            state<= 35;
            end
        35:begin
            data<=source_mac[7:0];
            state<= 36;
            end
        36:begin
            data<= length_type[15:8];
            state<= 37;
            sfifo_rd<= 1;
            end
        37:begin
            data<=length_type[7:0];
            cnt<=cnt-1;
            state<= 38;
            end
        38:begin
            data<=sfifo_dout;
            if(cnt>1) cnt<=cnt-1;
            else begin
                cnt<= 0;
                sfifo_rd<= 0;
                state<= 39;
                end
            end
        39: begin
            data<= sfifo_dout;
			state<= 40;
			end
		40:begin
            data<= 0;
            if(pad_cnt==6'd63)begin
				dv<= 0;
				state<= 0;
				end
			else begin
                data<= 0;
				state<= 41;
                end
            end
		41:begin
			if(pad_cnt>0) begin
				data<= data+1;
				pad_cnt<=pad_cnt-1;
				end
			else begin
				dv<= 0;
				state<= 0;
				end
			end
        endcase
        end
    end
endmodule
