//**********************************************************
//********bowen li******************************************
//********Wenrise*******************************************
//********Copy right, 4/27/2019*****************************
//********The module is for GMII transmit interface*********

`timescale 1 ns / 100 ps

module eth_gmii_tx (
  clk,            //125MHz clock
  reset,          //reset input, 0: active

  gmii_txd,
  gmii_tx_en,
  gmii_tx_er,
  sgmii_clk_en,

  data_fifo_rd,
  data_fifo_data_out,
  data_fifo_empty,
  cmd_fifo_rd,
  cmd_fifo_data_out,
  cmd_fifo_empty

 );
	
  input                         clk;
  input                         reset;

  output  [7:0]                 gmii_txd;
  output                        gmii_tx_en;
  output                        gmii_tx_er;
  input                         sgmii_clk_en;

  output                        data_fifo_rd;
  input   [8:0]                 data_fifo_data_out;
  input                         data_fifo_empty;
  output                        cmd_fifo_rd;
  input   [71:0]                cmd_fifo_data_out;
  input                         cmd_fifo_empty;
   
  reg     [7:0]                 gmii_txd;
  reg                           gmii_tx_en;
  reg                           data_fifo_rd;
  reg                           cmd_fifo_rd;
  
  reg                           crc_init;
  reg                           crc_en;
  reg     [7:0]                 crc_data;
  wire    [31:0]                crc_cal_result;
  reg     [7:0]                 gmii_txd_tmp;
  reg                           gmii_tx_en_tmp;
  reg     [3:0]                 cnt_tx_sfd_st;
  reg     [13:0]                pkt_length_tmp;
  reg     [13:0]                pkt_content_cnt;
  reg     [3:0]                 cnt_tx_crc;
  reg     [31:0]                crc_cal_r_tmp;
  reg     [3:0]                 cnt_tx_wait;            //counter for wait colck cycle
  reg     [11:0]                counter_crc_tx;         //clock counter for tx_crc state
  reg                           flag_rd_cmd;
  
  
  parameter             frame_type                 = 16'h01AA;
 //this state machine is for packet transmit of GMII interface
  reg          [7:0]    tx_state;    
  parameter             tx_idle                    = 8'h01, 
                        tx_ready                   = 8'h02, // wait for start signal
                        tx_rd_cmd                  = 8'h04, // send sfd signal
                        tx_sfd_st                  = 8'h08, // send start signal
                        tx_data                    = 8'h10, // send data, judge length and contents
                        tx_crc                     = 8'h20, // send crc 
                        tx_wait                    = 8'h40, // wait some time for bandwidth ratio control
                        tx_invalid_pkt             = 8'h80; // discard invalid packet
  

  assign    gmii_tx_er        = 1'b0;


  //generate gmii_txd and gmii_tx_en
 always @ (posedge clk or posedge reset)
  begin
   if (reset == 1'b1) begin
    gmii_tx_en                          <= 1'b0;
    gmii_txd                            <= 8'h0;
    end
   else if (sgmii_clk_en == 1'b1) begin
    if (gmii_tx_en_tmp == 1'b1) begin
     gmii_tx_en                         <= 1'b1;
     gmii_txd                           <= gmii_txd_tmp;    
     end
    else if (tx_state == tx_crc) begin
    	gmii_tx_en                        <= 1'b1;
    case (cnt_tx_crc)
     4'h1 : begin
     if (counter_crc_tx == 12'h001)
      gmii_txd                          <= crc_cal_result[31:24];
     else
      gmii_txd                          <= crc_cal_r_tmp[31:24];
      end
     4'h2 : begin
     gmii_txd                           <= crc_cal_r_tmp[23:16];
      end
     4'h3 : begin
     gmii_txd                           <= crc_cal_r_tmp[15:8];
      end      
     4'h4 : begin
     gmii_txd                           <= crc_cal_r_tmp[7:0];
      end
     default : begin
     gmii_txd                           <= 8'h0;
      end                
     endcase
     end
    else begin
     gmii_tx_en                         <= 1'b0;
     gmii_txd                           <= 8'h0;
     end
    end
   end
  


 //right GMII receive state machine
 always @ (posedge clk or posedge reset)
  begin
   if (reset == 1'b1) begin
   tx_state	                            <= tx_idle;
   gmii_txd_tmp                         <= 8'h0;
   gmii_tx_en_tmp                       <= 1'b0;
   crc_init                             <= 1'b0;
   crc_en                               <= 1'b0;
   crc_data                             <= 8'h0;
   cnt_tx_sfd_st                        <= 4'h0;
   pkt_length_tmp                       <= 14'h0;
   cnt_tx_crc                           <= 4'h0;
   crc_cal_r_tmp                        <= 32'h0;
   cnt_tx_wait                          <= 4'h0;
   counter_crc_tx                       <= 12'h0;
   cmd_fifo_rd                          <= 1'b0;
   flag_rd_cmd                          <= 1'b0;
   data_fifo_rd                         <= 1'b0;
   pkt_content_cnt                      <= 14'h0;
    end
   else case (tx_state)
  tx_idle      : begin
   tx_state	                            <= tx_ready;
   gmii_txd_tmp                         <= 8'h0;
   gmii_tx_en_tmp                       <= 1'b0;
   crc_init                             <= 1'b0;
   crc_en                               <= 1'b0;
   crc_data                             <= 8'h0; 
   cnt_tx_sfd_st                        <= 4'h0;
   pkt_length_tmp                       <= 14'h0;
   cnt_tx_crc                           <= 4'h0;
   crc_cal_r_tmp                        <= 32'h0;
   cnt_tx_wait                          <= 4'h0;
   counter_crc_tx                       <= 12'h0;
   cmd_fifo_rd                          <= 1'b0;
   flag_rd_cmd                          <= 1'b0;
   data_fifo_rd                         <= 1'b0;
   pkt_content_cnt                      <= 14'h0;
   end      
  tx_ready     : begin 
   gmii_txd_tmp                         <= 8'h0;
   gmii_tx_en_tmp                       <= 1'b0;
   crc_init                             <= 1'b0;
   crc_en                               <= 1'b0;
   crc_data                             <= 8'h0;
   cnt_tx_sfd_st                        <= 4'h0;
   pkt_length_tmp                       <= 14'h0;
   cnt_tx_crc                           <= 4'h0;  
   crc_cal_r_tmp                        <= 32'h0;
   cnt_tx_wait                          <= 4'h0;
   counter_crc_tx                       <= 12'h0;
   flag_rd_cmd                          <= 1'b0;
   data_fifo_rd                         <= 1'b0;
   pkt_content_cnt                      <= 14'h0;
     
   if (cmd_fifo_empty == 1'b0) begin
   	cmd_fifo_rd                         <= 1'b1;
    tx_state                            <= tx_rd_cmd;
    end
   else begin
   	cmd_fifo_rd                         <= 1'b0;
    tx_state                            <= tx_ready;
    end
   end
  tx_rd_cmd    : begin
   cmd_fifo_rd                          <= 1'b0;
   data_fifo_rd                         <= 1'b0;
   flag_rd_cmd                          <= ~flag_rd_cmd;
   if (flag_rd_cmd == 1'b1) begin
   	pkt_length_tmp                      <= cmd_fifo_data_out[13:0];
   	pkt_content_cnt                     <= cmd_fifo_data_out[13:0];
   	if (((cmd_fifo_data_out[53]|cmd_fifo_data_out[52]) == 1'b1) || (cmd_fifo_data_out[13:0] <= 14'h003B))
   	 tx_state                           <= tx_invalid_pkt;
   	else
   	 tx_state                           <= tx_sfd_st;
    end
   end
  tx_sfd_st    : begin
    crc_en                              <= 1'b0;
    cnt_tx_crc                          <= 4'h0;
    counter_crc_tx                      <= 12'h0;
    flag_rd_cmd                         <= 1'b0;
    if (sgmii_clk_en == 1'b1) begin
     gmii_tx_en_tmp                     <= 1'b1;     	
     cnt_tx_sfd_st                      <= cnt_tx_sfd_st + 1'b1;    
     if (cnt_tx_sfd_st == 4'h7) begin     //has sent 7 sfd
      gmii_txd_tmp                      <= 8'hD5;
      tx_state                          <= tx_data;
      end
     else begin
      gmii_txd_tmp                      <= 8'h55;
      tx_state                          <= tx_sfd_st;
      end
   
     if (cnt_tx_sfd_st == 4'h4) begin
      crc_init                          <= 1'b1;
      end
     else begin
      crc_init                          <= 1'b0;
      end
     
     if ((cnt_tx_sfd_st == 4'h6) || (cnt_tx_sfd_st == 4'h7)) begin
      data_fifo_rd                      <= 1'b1;
      pkt_length_tmp                    <= pkt_length_tmp - 1'b1;
      end
     else begin
     	data_fifo_rd                      <= 1'b0;
      end
     end
    else begin
     tx_state                           <= tx_sfd_st;
     end
    end
  tx_data      : begin
   if (sgmii_clk_en == 1'b1) begin 
    gmii_tx_en_tmp                      <= 1'b1;
    crc_en                              <= 1'b1;
    gmii_txd_tmp                        <= data_fifo_data_out[7:0];
    crc_data                            <= data_fifo_data_out[7:0];
    pkt_content_cnt                     <= pkt_content_cnt - 1'b1;
    if (pkt_content_cnt == 14'h0001) begin
     tx_state                           <= tx_crc;
     end
    else begin
     tx_state                           <= tx_data;
     end
    
    if (pkt_length_tmp != 14'h0) begin
     data_fifo_rd                       <= 1'b1;
     pkt_length_tmp                     <= pkt_length_tmp - 1'b1;   	
     end
    else begin
     data_fifo_rd                       <= 1'b0;
     end
    end
   else begin
    crc_en                              <= 1'b0;
    tx_state                            <= tx_data;  	
    end	  
   end      
  tx_crc       : begin
   crc_en                               <= 1'b0;
   counter_crc_tx                       <= counter_crc_tx + 1'b1;
   cnt_tx_wait                          <= 4'h9;
  if (sgmii_clk_en == 1'b1) begin
    gmii_tx_en_tmp                      <= 1'b0;
    cnt_tx_crc                          <= cnt_tx_crc + 1'b1;
   if (cnt_tx_crc == 4'h4)         // has sent 4 crc bytes
    tx_state                            <= tx_wait;
   else
    tx_state                            <= tx_crc;
    end
  else begin
  	tx_state                            <= tx_crc;
    end 
      
  if (counter_crc_tx == 12'h001) begin  
    crc_cal_r_tmp                       <= crc_cal_result;
    end    
   end       
  tx_wait      : begin  	
   gmii_tx_en_tmp                       <= 1'b0;
   if (sgmii_clk_en == 1'b1) begin
    cnt_tx_wait                         <= cnt_tx_wait - 1'b1;
    if (cnt_tx_wait == 4'h2)               //considering 1 cycle in crc state
     tx_state                           <= tx_ready;
    else
     tx_state                           <= tx_wait;
    end
   else begin
    tx_state                            <= tx_wait;
    end
   end   
  tx_invalid_pkt : begin 
   if (sgmii_clk_en == 1'b1) begin
   	pkt_length_tmp                      <= pkt_length_tmp - 1'b1;
    if (pkt_length_tmp == 14'h0001)
     tx_state                           <= tx_ready;
    else
     tx_state                           <= tx_invalid_pkt;
    end 
   else begin
    tx_state                            <= tx_invalid_pkt;
    end
   end
  default      : begin
   tx_state	                            <= tx_idle;
   gmii_txd_tmp                         <= 8'h0;
   gmii_tx_en_tmp                       <= 1'b0;
   crc_init                             <= 1'b0;
   crc_en                               <= 1'b0;
   crc_data                             <= 8'h0;
   cnt_tx_sfd_st                        <= 4'h0;
   pkt_length_tmp                       <= 14'h0;
   cnt_tx_crc                           <= 4'h0;
   crc_cal_r_tmp                        <= 32'h0;
   cnt_tx_wait                          <= 4'h0;
   counter_crc_tx                       <= 12'h0;
   cmd_fifo_rd                          <= 1'b0;
   flag_rd_cmd                          <= 1'b0;
   end
  endcase
 end

crc32_d8 gmii_tx_crc(
  .clk                                  (clk),
  .reset                                (reset),
  .init                                 (crc_init),
  .en                                   (crc_en),
  .data                                 (crc_data),
  .crc_rlt                              (),
  .new_crc                              (crc_cal_result)
  );
  


endmodule




