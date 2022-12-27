//**********************************************************

`timescale 1 ns / 100 ps

module eth_gmii_rx (
  clk,                    //125MHz clock
  reset,                  //reset input, 1: active
   
  gmii_rxd,
  gmii_rx_dv,
  gmii_rx_er,
  sgmii_clk_en,
  
  //data fifo write interface
  data_fifo_we,
  data_fifo_data_in,
  data_fifo_alt_full,
  data_fifo_prog_full,
  
  //data fifo write interface    
  cmd_fifo_we,             
  cmd_fifo_data_in,          //[53:52]:crc_err,delete;[13:0]:packet length;
  cmd_fifo_prog_full

);
	
  input                         clk;
  input                         reset;    

  input   [7:0]                 gmii_rxd;
  input                         gmii_rx_dv;
  input                         gmii_rx_er;
  input                         sgmii_clk_en;
  
  output                        data_fifo_we;
  output  [8:0]                 data_fifo_data_in; 
  input                         data_fifo_alt_full; 
  input                         data_fifo_prog_full;

  output                        cmd_fifo_we;
  output  [71:0]                cmd_fifo_data_in;
  input                         cmd_fifo_prog_full;

  reg                           data_fifo_we;            
  reg     [8:0]                 data_fifo_data_in;                                                        
  reg                           cmd_fifo_we;             
  reg     [71:0]                cmd_fifo_data_in; 
     
  reg                           rx_crc_init;
  reg                           rx_crc_en;
  reg     [7:0]                 rx_crc_data;
  wire    [31:0]                rx_crc_chk_result;

  reg     [3:0]                 cnt_rx_eh;
  reg     [10:0]                cnt_pkt_length;
  reg                           flag_delete_pkt;          //this pkt will be deleted when reading it from fifo   

  reg                           data_fifo_we_t;
  reg     [8:0]                 data_fifo_data_in_t;  
  reg     [8:0]                 data_fifo_data_in_t_1;
  reg     [8:0]                 data_fifo_data_in_t_2;  
  reg     [8:0]                 data_fifo_data_in_t_3;  
  reg     [8:0]                 data_fifo_data_in_t_4;  
  reg     [3:0]                 cnt_data_fifo_we_t;
  reg                           gmii_rx_dv_1d;


  reg          [11:0]   rx_state;    
  parameter             rx_idle                    = 12'h001,
                        rx_ready                   = 12'h002,
                        rx_sfd                     = 12'h004,
                        rx_start                   = 12'h008,
                        rx_eh                      = 12'h010, //receive da, sa and type
                        rx_data                    = 12'h020,
                        rx_wait_crc                = 12'h040,
                        rx_crc_chk                 = 12'h080,
                        rx_err_pkt                 = 12'h100; //error packet
                        



 always @ (posedge clk or posedge reset)               
  begin                                                
   if (reset == 1'b1)                      
    gmii_rx_dv_1d                       <= 1'b0;                                   
   else   
    gmii_rx_dv_1d                       <= gmii_rx_dv;                                    
   end                                                 

 always @ (posedge clk or posedge reset)                                            
  begin                                                                             
   if (reset == 1'b1) begin                                                         
    cnt_data_fifo_we_t                  <= 4'h0;
    data_fifo_data_in_t_1               <= 9'h000;
    data_fifo_data_in_t_2               <= 9'h000;                       
    data_fifo_data_in_t_3               <= 9'h000;
    data_fifo_data_in_t_4               <= 9'h000;                                  
    end                                                                             
   else if (rx_state == rx_ready) begin
    cnt_data_fifo_we_t                  <= 4'h0;
    data_fifo_data_in_t_1               <= 9'h000;
    data_fifo_data_in_t_2               <= 9'h000;
    data_fifo_data_in_t_3               <= 9'h000;
    data_fifo_data_in_t_4               <= 9'h000;
    end                                                                             
   else if (data_fifo_we_t == 1'b1) begin                                                                       
    data_fifo_data_in_t_1               <= data_fifo_data_in_t;
    data_fifo_data_in_t_2               <= data_fifo_data_in_t_1;
    data_fifo_data_in_t_3               <= data_fifo_data_in_t_2;
    data_fifo_data_in_t_4               <= data_fifo_data_in_t_3;
    if (cnt_data_fifo_we_t != 4'h4) begin
     cnt_data_fifo_we_t                 <= cnt_data_fifo_we_t + 1'b1;
     end                            
    end                                                                             
   end

 always @ (posedge clk or posedge reset)                   
  begin                                                    
   if (reset == 1'b1) begin                                
    data_fifo_we                        <= 1'b0;
    data_fifo_data_in                   <= 9'h000; 
    end                                                    
   else if ((cnt_data_fifo_we_t == 4'h4)&&(data_fifo_we_t == 1'b1)&&(gmii_rx_dv_1d == 1'b1)) begin
    data_fifo_we                        <= 1'b1;
    data_fifo_data_in                   <= data_fifo_data_in_t_4;
    end
   else begin                                              
    data_fifo_we                        <= 1'b0;   
    data_fifo_data_in                   <= 9'h000;
    end                                                    
   end
   
 always @ (posedge clk or posedge reset)                   
  begin                                                    
   if (reset == 1'b1)          
    cnt_pkt_length                       <= 11'h0;
   else if (rx_state == rx_ready)
    cnt_pkt_length                       <= 11'h0; 
   else if ((cnt_data_fifo_we_t == 4'h4)&&(data_fifo_we_t == 1'b1)&&(gmii_rx_dv_1d == 1'b1))                          
    cnt_pkt_length                       <= cnt_pkt_length + 1'b1;                                                    
   end

 always @ (posedge clk or posedge reset)                         
  begin                                                          
   if (reset == 1'b1)                                            
    flag_delete_pkt                     <= 1'b0;            
   else if (rx_state == rx_ready)
    flag_delete_pkt                     <= 1'b0;
   else if (((rx_state==rx_start)&&(data_fifo_prog_full==1'b1)) || ((data_fifo_alt_full|cmd_fifo_prog_full)==1'b1))                                                     
    flag_delete_pkt                     <= 1'b1;    
   end                                                             
   

 //GMII receive state machine
 always @ (posedge clk or posedge reset)
  begin
   if (reset == 1'b1) begin
    rx_state                            <= rx_idle;
    rx_crc_init                         <= 1'b0;
    rx_crc_en                           <= 1'b0;
    rx_crc_data                         <= 8'h0;
    cnt_rx_eh                           <= 4'h0;
    data_fifo_we_t                      <= 1'b0;
    data_fifo_data_in_t                 <= 9'h0;
    cmd_fifo_we                         <= 1'b0;        
    cmd_fifo_data_in                    <= 72'h0;
    end
   else case (rx_state)  
  rx_idle      : begin
    rx_state                            <= rx_ready;
    rx_crc_init                         <= 1'b0;
    rx_crc_en                           <= 1'b0;
    rx_crc_data                         <= 8'h0;
    cnt_rx_eh                           <= 4'h0;
    data_fifo_we_t                      <= 1'b0;      
    data_fifo_data_in_t                 <= 9'h0;
    cmd_fifo_we                         <= 1'b0; 
    cmd_fifo_data_in                    <= 72'h0;
   end    
  rx_ready     : begin
    rx_crc_init                         <= 1'b0;
    rx_crc_en                           <= 1'b0;
    rx_crc_data                         <= 8'h0;
    cnt_rx_eh                           <= 4'h0;
    data_fifo_we_t                      <= 1'b0;      
    data_fifo_data_in_t                 <= 9'h0;
    cmd_fifo_we                         <= 1'b0; 
    cmd_fifo_data_in                    <= 72'h0;
    rx_state                            <= rx_sfd;
   end   
  rx_sfd       : begin
    rx_crc_init                         <= 1'b1;
    cnt_rx_eh                           <= 4'h0;
    data_fifo_we_t                      <= 1'b0;
    cmd_fifo_we                         <= 1'b0;
   if ((sgmii_clk_en == 1'b1) && (gmii_rx_dv == 1'b1)) begin
    if (gmii_rxd == 8'h55)
     rx_state                           <= rx_start;
    else
     rx_state                           <= rx_err_pkt;
    end
   else begin
    rx_state                            <= rx_sfd;
    end 
   end     
  rx_start     : begin
    rx_crc_init                         <= 1'b0;
   if ((gmii_rx_dv == 1'b0)||(gmii_rx_er == 1'b1)) begin
    rx_state                            <= rx_err_pkt;
    end
   else if (sgmii_clk_en == 1'b1) begin
     if (gmii_rxd == 8'hD5) begin
      rx_state                          <= rx_eh;
      end
     else if (gmii_rxd == 8'h55) begin
      rx_state                          <= rx_start;
      end
     else begin
      rx_state                          <= rx_err_pkt;
      end
    end
   else begin
    rx_state                            <= rx_start;
    end
   end   
  rx_eh        : begin
   if ((gmii_rx_dv == 1'b0)||(gmii_rx_er == 1'b1)) begin
    rx_crc_en                           <= 1'b0;
    data_fifo_we_t                      <= 1'b0;  
    rx_state                            <= rx_err_pkt;
    end
   else if (sgmii_clk_en == 1'b1) begin 
    rx_crc_en                           <= 1'b1;
    rx_crc_data                         <= gmii_rxd;
   	cnt_rx_eh                           <= cnt_rx_eh + 1'b1;
    if ((flag_delete_pkt==1'b0)&&(data_fifo_alt_full==1'b0)) begin
      data_fifo_we_t                    <= 1'b1;    
      data_fifo_data_in_t               <= {1'b0,gmii_rxd};
   	  end
   	else begin
      data_fifo_we_t                    <= 1'b0;    
      data_fifo_data_in_t               <= 9'h0;   	
   	  end

     if (cnt_rx_eh == 4'hE) begin             // has received 15 bytes, da, sa, type and one byte payload;
      rx_state                          <= rx_data;
      end
     else begin
      rx_state                          <= rx_eh;
      end
    end
   else begin
   	 rx_crc_en                          <= 1'b0;
     data_fifo_we_t                     <= 1'b0;   	 
     rx_state                           <= rx_eh;
    end
   end
  rx_data      : begin
   if (gmii_rx_dv == 1'b0) begin
    rx_crc_en                           <= 1'b0;
    data_fifo_we_t                      <= 1'b0;    
   	rx_state                            <= rx_wait_crc;
    end
   else if (gmii_rx_er == 1'b1) begin                
    rx_crc_en                           <= 1'b0;
    data_fifo_we_t                      <= 1'b0;    
    rx_state                            <= rx_err_pkt;
    end
   else if (sgmii_clk_en == 1'b1) begin 
   	rx_state                            <= rx_data;
    rx_crc_en                           <= 1'b1;
    rx_crc_data                         <= gmii_rxd; 
    if ((flag_delete_pkt==1'b0)&&(data_fifo_alt_full==1'b0)) begin
     data_fifo_we_t                     <= 1'b1;      
     data_fifo_data_in_t                <= {1'b0,gmii_rxd};
     end
    else begin
     data_fifo_we_t                     <= 1'b0;        
     data_fifo_data_in_t                <= 9'h000;
     end
    end
   else begin
   	 rx_crc_en                          <= 1'b0;
     data_fifo_we_t                     <= 1'b0;  	 
     rx_state                           <= rx_data;
    end
   end    
  rx_wait_crc  : begin
    rx_crc_en                           <= 1'b0;
    data_fifo_we_t                      <= 1'b0;  
    rx_state                            <= rx_crc_chk;
   end
  rx_crc_chk   : begin
  	rx_state                            <= rx_ready;
    cmd_fifo_we                         <= (|cnt_pkt_length);
    cmd_fifo_data_in[71:54]             <= 18'h0;
    cmd_fifo_data_in[51:11]             <= 41'h0;
    cmd_fifo_data_in[10:0]              <= cnt_pkt_length;
    if (rx_crc_chk_result == 32'hC704DD7B)
     cmd_fifo_data_in[53:52]            <= {1'b0,flag_delete_pkt};
    else
     cmd_fifo_data_in[53:52]            <= 2'b10;           //invalid packet
   end
  rx_err_pkt   : begin
   if ((gmii_rx_er == 1'b0)&&(gmii_rx_dv == 1'b0)) begin
    rx_state                            <= rx_ready;
    cmd_fifo_we                         <= (|cnt_pkt_length);
    cmd_fifo_data_in                    <= {18'h0,1'b1,42'h0,cnt_pkt_length}; 
    end
   else begin
    rx_state                            <= rx_err_pkt;     	
    end
   end
  default      : begin
    rx_crc_init                         <= 1'b0;
    rx_crc_en                           <= 1'b0;   
    rx_crc_data                         <= 8'h0;
    cnt_rx_eh                           <= 4'h0;
    data_fifo_we_t                      <= 1'b0;        
    data_fifo_data_in_t                 <= 9'h0;
    cmd_fifo_we                         <= 1'b0; 
    cmd_fifo_data_in                    <= 72'h0;
   end
  endcase
 end


 crc32_d8 gmii_rx_crc(
    .clk                                (clk),
    .reset                              (reset),
    .init                               (rx_crc_init),
    .en                                 (rx_crc_en),
    .data                               (rx_crc_data),
    .crc_rlt                            (rx_crc_chk_result),
    .new_crc                            () // new crc, not necessary for receive module
 );




endmodule


