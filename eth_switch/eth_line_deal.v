//**********************************************************

`timescale 1 ns / 100 ps

module eth_switch_core(
  clk,                //125MHz clock
  reset,              //reset input, 1: active

port1_gmii_txd      ,    
port1_gmii_tx_en    ,  
port1_gmii_tx_er    ,  
port1_gmii_rxd      ,    
port1_gmii_rx_dv    , 
port1_gmii_rx_er    , 
port1_sgmii_clk_en  ,

port2_gmii_txd      ,    
port2_gmii_tx_en    ,  
port2_gmii_tx_er    ,  
port2_gmii_rxd      ,    
port2_gmii_rx_dv    , 
port2_gmii_rx_er    , 
port2_sgmii_clk_en  ,

port3_sgmii_clk_en  ,
port3_gmii_txd      ,    
port3_gmii_tx_en    ,  
port3_gmii_tx_er    ,  
port3_gmii_rxd      ,    
port3_gmii_rx_dv    , 
port3_gmii_rx_er    , 

port4_gmii_txd      ,    
port4_gmii_tx_en    ,  
port4_gmii_tx_er    ,  
port4_gmii_rxd      ,    
port4_gmii_rx_dv    , 
port4_gmii_rx_er    , 
port4_sgmii_clk_en  
  
  
 );
	
  input                         clk;
  input                         reset;
    
  output  [7:0]                 port1_gmii_txd;
  output                        port1_gmii_tx_en;
  output                        port1_gmii_tx_er;
  input   [7:0]                 port1_gmii_rxd;
  input                         port1_gmii_rx_dv;
  input                         port1_gmii_rx_er; 
  input                         port1_sgmii_clk_en;

  output  [7:0]                 port2_gmii_txd;
  output                        port2_gmii_tx_en;
  output                        port2_gmii_tx_er;
  input   [7:0]                 port2_gmii_rxd;
  input                         port2_gmii_rx_dv;
  input                         port2_gmii_rx_er;
  input                         port2_sgmii_clk_en;
  
    output  [7:0]                 port3_gmii_txd;
    output                        port3_gmii_tx_en;
    output                        port3_gmii_tx_er;
    input   [7:0]                 port3_gmii_rxd;
    input                         port3_gmii_rx_dv;
    input                         port3_gmii_rx_er; 
    input                         port3_sgmii_clk_en;
  
    output  [7:0]                 port4_gmii_txd;
    output                        port4_gmii_tx_en;
    output                        port4_gmii_tx_er;
    input   [7:0]                 port4_gmii_rxd;
    input                         port4_gmii_rx_dv;
    input                         port4_gmii_rx_er;
    input                         port4_sgmii_clk_en;

//signal of eth_rx1234

wire                        clk;                    
wire                        reset;  

      //rxfifo signal                                                                                                                                       
wire                        rx_data_fifo1_we;           
wire  [8:0]                 rx_data_fifo1_data_in9b;    
wire  [7:0]                 rx_data_fifo1_dout8b;  
wire                        rx_data_fifo1_alt_full ;     
wire                        rx_data_fifo1_prog_full;                                                    
wire                        rx_cmd_fifo1_we        ;            
wire  [71:0]                rx_cmd_fifo1_data_in   ;       
wire                        rx_cmd_fifo1_prog_full  ;   

wire                        rx_data_fifo2_we;           
wire  [8:0]                 rx_data_fifo2_data_in9b;    
wire  [7:0]                 rx_data_fifo2_dout8b;  
wire                        rx_data_fifo2_alt_full;     
wire                        rx_data_fifo2_prog_full;                                                    
wire                        rx_cmd_fifo2_we;            
wire  [71:0]                rx_cmd_fifo2_data_in;       
wire                        rx_cmd_fifo2_prog_full; 

wire                        rx_data_fifo3_we;           
wire  [8:0]                 rx_data_fifo3_data_in9b;    
wire  [7:0]                 rx_data_fifo3_dout8b;  
wire                        rx_data_fifo3_alt_full;     
wire                        rx_data_fifo3_prog_full;                                                    
wire                        rx_cmd_fifo3_we;            
wire  [71:0]                rx_cmd_fifo3_data_in;       
wire                        rx_cmd_fifo3_prog_full;  

wire                        rx_data_fifo4_we;           
wire  [8:0]                 rx_data_fifo4_data_in9b;    
wire  [7:0]                 rx_data_fifo4_dout8b;  
wire                        rx_data_fifo4_alt_full;     
wire                        rx_data_fifo4_prog_full;                                                    
wire                        rx_cmd_fifo4_we;            
wire  [71:0]                rx_cmd_fifo4_data_in;       
wire                        rx_cmd_fifo4_prog_full;  
  //eth_rx
  wire      [7:0]              port1_gmii_txd;        
  wire                         port1_gmii_tx_en;      
  wire                         port1_gmii_tx_er;      
  wire      [7:0]              port1_gmii_rxd;        
  wire                         port1_gmii_rx_dv;      
  wire                         port1_gmii_rx_er;      
  wire                         port1_sgmii_clk_en;    
                                           
  wire      [7:0]              port2_gmii_txd;        
  wire                         port2_gmii_tx_en;      
  wire                         port2_gmii_tx_er;      
  wire      [7:0]              port2_gmii_rxd;        
  wire                         port2_gmii_rx_dv;      
  wire                         port2_gmii_rx_er;      
  wire                         port2_sgmii_clk_en;    
                                             
  wire          [7:0]            port3_gmii_txd;      
  wire                           port3_gmii_tx_en;    
  wire                           port3_gmii_tx_er;    
  wire          [7:0]            port3_gmii_rxd;      
  wire                           port3_gmii_rx_dv;    
  wire                           port3_gmii_rx_er;    
  wire                           port3_sgmii_clk_en;  
                                                
  wire          [7:0]            port4_gmii_txd;      
  wire                           port4_gmii_tx_en;    
  wire                           port4_gmii_tx_er;    
  wire          [7:0]            port4_gmii_rxd;      
  wire                           port4_gmii_rx_dv;    
  wire                           port4_gmii_rx_er;    
  wire                           port4_sgmii_clk_en;  
  
  // rx data_fifo and cmd_fifo
    
    
    wire rx_data_fifo1_rd;
    wire rx_data_fifo1_empty;
    wire [8:0]rx_data_fifo1_dout;
    wire rx_data_fifo2_rd;
    wire rx_data_fifo2_empty;
    wire [8:0]rx_data_fifo2_dout;
    wire rx_data_fifo3_rd;
    wire rx_data_fifo3_empty;
    wire [8:0]rx_data_fifo3_dout;
    wire rx_data_fifo4_rd;
    wire rx_data_fifo4_empty;
    wire [8:0]rx_data_fifo4_dout;
  
  assign rx_data_fifo1_dout8b = rx_data_fifo1_dout; 
  assign rx_data_fifo2_dout8b = rx_data_fifo2_dout; 
  assign rx_data_fifo3_dout8b = rx_data_fifo3_dout; 
  assign rx_data_fifo4_dout8b = rx_data_fifo4_dout; 
  
  //eth_rx_ model
  
 eth_gmii_rx eth_rx1(
   .clk(clk),                    
   .reset(reset),                 
   .gmii_rxd(port1_gmii_rxd),
   .gmii_rx_dv(port1_gmii_rx_dv),
   .gmii_rx_er(port1_gmii_rx_er),
   .sgmii_clk_en(port1_sgmii_clk_en),
   .data_fifo_we(rx_data_fifo1_we),
   .data_fifo_data_in(rx_data_fifo1_data_in9b),
   .data_fifo_alt_full  (rx_data_fifo1_alt_full ),
   .data_fifo_prog_full (rx_data_fifo1_prog_full),
   .cmd_fifo_we         ( rx_cmd_fifo1_we       ),             
   .cmd_fifo_data_in    ( rx_cmd_fifo1_data_in  ),        
   .cmd_fifo_prog_full  ( rx_cmd_fifo1_prog_full)
 ); 
  
  eth_gmii_rx eth_rx2(
    .clk(clk),                    
    .reset(reset),                 
    .gmii_rxd(port2_gmii_rxd),
    .gmii_rx_dv(port2_gmii_rx_dv),
    .gmii_rx_er(port2_gmii_rx_er),
    .sgmii_clk_en(port2_sgmii_clk_en),
    .data_fifo_we(rx_data_fifo2_we),
    .data_fifo_data_in(rx_data_fifo2_data_in9b),
    .data_fifo_alt_full  (rx_data_fifo2_alt_full ),
    .data_fifo_prog_full (rx_data_fifo2_prog_full),
    .cmd_fifo_we         ( rx_cmd_fifo2_we       ),             
    .cmd_fifo_data_in    ( rx_cmd_fifo2_data_in  ),        
    .cmd_fifo_prog_full  ( rx_cmd_fifo2_prog_full)
  ); 
   
  eth_gmii_rx eth_rx3(
     .clk(clk),                    
     .reset(reset),                 
     .gmii_rxd(port3_gmii_rxd),
     .gmii_rx_dv(port3_gmii_rx_dv),
     .gmii_rx_er(port3_gmii_rx_er),
     .sgmii_clk_en(port3_sgmii_clk_en),
     .data_fifo_we(rx_data_fifo3_we),
     .data_fifo_data_in(rx_data_fifo3_data_in9b),
     .data_fifo_alt_full  (rx_data_fifo3_alt_full ),
     .data_fifo_prog_full (rx_data_fifo3_prog_full),
     .cmd_fifo_we         ( rx_cmd_fifo3_we       ),             
     .cmd_fifo_data_in    ( rx_cmd_fifo3_data_in  ),        
     .cmd_fifo_prog_full  ( rx_cmd_fifo3_prog_full)
   ); 
    
  
  eth_gmii_rx eth_rx4(
      .clk(clk),                    
      .reset(reset),                 
      .gmii_rxd(port4_gmii_rxd),
      .gmii_rx_dv(port4_gmii_rx_dv),
      .gmii_rx_er(port4_gmii_rx_er),
      .sgmii_clk_en(port4_sgmii_clk_en),
      .data_fifo_we(rx_data_fifo4_we),
      .data_fifo_data_in(rx_data_fifo4_data_in9b),
      .data_fifo_alt_full  (rx_data_fifo4_alt_full ),
      .data_fifo_prog_full (rx_data_fifo4_prog_full),
      .cmd_fifo_we         ( rx_cmd_fifo4_we       ),             
      .cmd_fifo_data_in    ( rx_cmd_fifo4_data_in  ),        
      .cmd_fifo_prog_full  ( rx_cmd_fifo4_prog_full)
    ); 
     
  
 

  
 
 
 fifo_9x4k rxdata_fifo1(
      .clk                              (clk),  
      .srst                             (reset),
      .din                              (rx_data_fifo1_data_in9b),
      .wr_en                            (rx_data_fifo1_we),
      .rd_en                            (rx_data_fifo1_rd),
      .dout                             (rx_data_fifo1_dout),
      .full                             (),    //don't use
      .almost_full                      (rx_data_fifo1_alt_full),
      .empty                            (rx_data_fifo1_empty   ), 
      .almost_empty                     (),    //don't use
      .prog_full                        (rx_data_fifo1_prog_full)
    );

  fifo_9x4k rxdata_fifo2(
      .clk                              (clk),  
      .srst                             (reset),
      .din                              (rx_data_fifo2_data_in9b),
      .wr_en                            (rx_data_fifo2_we),
      .rd_en                            (rx_data_fifo2_rd),
      .dout                             (rx_data_fifo2_dout),
      .full                             (),    //don't use
      .almost_full                      (rx_data_fifo2_alt_full),
      .empty                            (rx_data_fifo2_empty   ), 
      .almost_empty                     (),    //don't use
      .prog_full                        (rx_data_fifo2_prog_full)
    );
  
  fifo_9x4k rxdata_fifo3(
          .clk                              (clk),  
          .srst                             (reset),
          .din                              (rx_data_fifo3_data_in9b),
          .wr_en                            (rx_data_fifo3_we),
          .rd_en                            (rx_data_fifo3_rd),
          .dout                             (rx_data_fifo3_dout),
          .full                             (),    //don't use
          .almost_full                      (rx_data_fifo3_alt_full),
          .empty                            (rx_data_fifo3_empty   ), 
          .almost_empty                     (),    //don't use
          .prog_full                        (rx_data_fifo3_prog_full)
        );
  
 fifo_9x4k rxdata_fifo4(
              .clk                              (clk),  
              .srst                             (reset),
              .din                              (rx_data_fifo4_data_in9b),
              .wr_en                            (rx_data_fifo4_we),
              .rd_en                            (rx_data_fifo4_rd),
              .dout                             (rx_data_fifo4_dout),
              .full                             (),    //don't use
              .almost_full                      (rx_data_fifo4_alt_full),
              .empty                            (rx_data_fifo4_empty   ), 
              .almost_empty                     (),    //don't use
              .prog_full                        (rx_data_fifo4_prog_full)
            ); 
  wire rx_ptr_fifo1_rd   ;
  wire [71:0] rx_ptr_fifo1_dout  ; 
  wire [15:0] rx_ptr_fifo1_dout16b  ;
  wire rx_ptr_fifo1_empty  ;
  wire rx_ptr_fifo2_rd   ;
  wire [71:0] rx_ptr_fifo2_dout  ;
  wire [15:0] rx_ptr_fifo2_dout16b  ; 
  wire rx_ptr_fifo2_empty  ;
  wire rx_ptr_fifo3_rd   ;
  wire [71:0] rx_ptr_fifo3_dout  ;
  wire [15:0] rx_ptr_fifo3_dout16b  ; 
  wire rx_ptr_fifo3_empty  ;
  wire rx_ptr_fifo4_rd   ;
  wire [71:0] rx_ptr_fifo4_dout  ; 
  wire [15:0] rx_ptr_fifo4_dout16b  ;
  wire rx_ptr_fifo4_empty  ;
  
assign rx_ptr_fifo1_dout16b= {rx_ptr_fifo1_dout[52],rx_ptr_fifo1_dout[53],rx_ptr_fifo1_dout[13:0]};
assign rx_ptr_fifo2_dout16b= {rx_ptr_fifo2_dout[52],rx_ptr_fifo2_dout[53],rx_ptr_fifo2_dout[13:0]};
assign rx_ptr_fifo3_dout16b= {rx_ptr_fifo3_dout[52],rx_ptr_fifo3_dout[53],rx_ptr_fifo3_dout[13:0]};
assign rx_ptr_fifo4_dout16b= {rx_ptr_fifo4_dout[52],rx_ptr_fifo4_dout[53],rx_ptr_fifo4_dout[13:0]};
  
 fifo_72x512 rxcmd_fifo1(
              .clk                              (clk),  
              .srst                             (reset),
              .din                              (rx_cmd_fifo1_data_in ),
              .wr_en                            (rx_cmd_fifo1_we), 
              .rd_en                            (rx_ptr_fifo1_rd),
              .dout                             (rx_ptr_fifo1_dout),
              .full                             (),   //don't use
              .empty                            (rx_ptr_fifo1_empty), 
              .prog_full                        (rx_cmd_fifo1_prog_full )
           );
           
           
 fifo_72x512 rxcmd_fifo2(
                         .clk                              (clk),  
                         .srst                             (reset),
                         .din                              (rx_cmd_fifo2_data_in ),
                         .wr_en                            (rx_cmd_fifo2_we), 
                         .rd_en                            (rx_ptr_fifo2_rd),
                         .dout                             (rx_ptr_fifo2_dout),
                         .full                             (),   //don't use
                         .empty                            (rx_ptr_fifo2_empty), 
                         .prog_full                        (rx_cmd_fifo2_prog_full )
                      );          
  
fifo_72x512 rxcmd_fifo3(
                         .clk                              (clk),  
                         .srst                             (reset),
                         .din                              (rx_cmd_fifo3_data_in ),
                         .wr_en                            (rx_cmd_fifo3_we), 
                         .rd_en                            (rx_ptr_fifo3_rd),
                         .dout                             (rx_ptr_fifo3_dout),
                         .full                             (),   //don't use
                         .empty                            (rx_ptr_fifo3_empty), 
                         .prog_full                        (rx_cmd_fifo3_prog_full )
                                 );
  
  
  fifo_72x512 rxcmd_fifo4(
                            .clk                              (clk),  
                            .srst                             (reset),
                            .din                              (rx_cmd_fifo4_data_in ),
                            .wr_en                            (rx_cmd_fifo4_we), 
                            .rd_en                            (rx_ptr_fifo4_rd),
                            .dout                             (rx_ptr_fifo4_dout),
                            .full                             (),   //don't use
                            .empty                            (rx_ptr_fifo4_empty), 
                            .prog_full                        (rx_cmd_fifo4_prog_full )
                                            );
                                            
   wire               sfifo_rd;
   wire     [7:0]     sfifo_dout;
   wire               ptr_sfifo_rd;
   wire     [15:0]    ptr_sfifo_dout;
   wire               ptr_sfifo_empty;                             
                                            
                                            
                                            
  //  interface_mux
   interface_mux mux(                          
      .clk                        (clk),
      .rstn                       (reset),
      .rx_data_fifo_rd0           (rx_data_fifo1_rd),
      .rx_data_fifo_dout0       (rx_data_fifo1_dout8b),
      .rx_ptr_fifo_rd0              (rx_ptr_fifo1_rd),
      .rx_ptr_fifo_dout0          (rx_ptr_fifo1_dout16b),
      .rx_ptr_fifo_empty0         ( rx_ptr_fifo1_empty),
      .rx_data_fifo_rd1           (rx_data_fifo2_rd),   
      .rx_data_fifo_dout1         (rx_data_fifo2_dout8b), 
      .rx_ptr_fifo_rd1            ( rx_ptr_fifo2_rd),   
      .rx_ptr_fifo_dout1          ( rx_ptr_fifo2_dout16b), 
      .rx_ptr_fifo_empty1         ( rx_ptr_fifo2_empty),
   
      .rx_data_fifo_rd2           (rx_data_fifo3_rd),   
      .rx_data_fifo_dout2         (rx_data_fifo3_dout8b), 
      .rx_ptr_fifo_rd2            ( rx_ptr_fifo3_rd),   
      .rx_ptr_fifo_dout2          ( rx_ptr_fifo3_dout16b), 
      .rx_ptr_fifo_empty2         ( rx_ptr_fifo3_empty),
      
      .rx_data_fifo_rd3           (rx_data_fifo4_rd),   
      .rx_data_fifo_dout3         (rx_data_fifo4_dout8b), 
      .rx_ptr_fifo_rd3            ( rx_ptr_fifo4_rd),   
      .rx_ptr_fifo_dout3          ( rx_ptr_fifo4_dout16b), 
      .rx_ptr_fifo_empty3         ( rx_ptr_fifo4_empty),
      .sfifo_rd                   (sfifo_rd        ),
      .sfifo_dout                 (sfifo_dout      ),
      .ptr_sfifo_rd               (ptr_sfifo_rd    ),
      .ptr_sfifo_dout             (ptr_sfifo_dout  ),
      .ptr_sfifo_empty            (ptr_sfifo_empty )
           ) ;                              
  
  

  wire         sof;
  wire         dv;
  wire  [7:0]  data;
  wire         se_source;
  wire  [47:0] se_mac;
  wire  [15:0] source_portmap;
  wire         se_req;
  wire         se_ack;
  wire  [15:0] se_result;   
  wire  [9:0]  se_hash;
  wire         se_nak;
  wire         aging_req;
  wire         aging_ack;
  
  wire         bp0;
  wire         bp1;
  wire         bp2;
  wire         bp3;

  
  
 frame_process u_frame_process(
      .clk(clk),
      .rstn(reset),
      .sfifo_dout(sfifo_dout),
      .sfifo_rd(sfifo_rd),
      .ptr_sfifo_rd(ptr_sfifo_rd),
      .ptr_sfifo_empty(ptr_sfifo_empty),
      .ptr_sfifo_dout(ptr_sfifo_dout),
                                           
      .sof(sof),
      .dv(dv),
      .data(data),
                                           
      .se_mac(se_mac),
      .se_req(se_req),
      .se_ack(se_ack),
      .source_portmap(source_portmap),
      .se_result(se_result),
      .se_nak(se_nak),
      .se_source(se_source),
      .se_hash(se_hash),
                                           
      .bp0(bp0),
      .bp1(bp1),
      .bp2(bp2),
      .bp3(bp3)                                                            
      );
  hash_2_bucket u_hash(
      .clk(clk),
      .rstn(reset),
      .se_req(se_req),
      .se_ack(se_ack),
      .se_hash(se_hash),
      .se_portmap(source_portmap),
      .se_source(se_source),
      .se_result(se_result),
      .se_nak(se_nak),
      .se_mac(se_mac),
      .aging_req(1'b0),
      .aging_ack()
      );
  
  
  
  
  //tx signal
  
wire          tx_data_fifo1_rd     ;
wire [7:0]    tx_data_fifo1_dout8b   ;
wire [8:0]    tx_data_fifo1_dout9b   ;
wire           tx_ptr_fifo1_rd      ;
wire [15:0]    tx_ptr_fifo1_dout16b   ;
wire [71:0]    tx_ptr_fifo1_dout72b   ;
wire           tx_ptr_fifo1_empty   ;
wire          tx_data_fifo2_rd     ;
wire [7:0]    tx_data_fifo2_dout8b   ;
wire [8:0]    tx_data_fifo2_dout9b   ;
wire           tx_ptr_fifo2_rd      ;
wire [15:0]    tx_ptr_fifo2_dout16b    ;
wire [71:0]    tx_ptr_fifo2_dout72b   ;
wire           tx_ptr_fifo2_empty   ;
wire          tx_data_fifo3_rd     ;
wire [7:0]    tx_data_fifo3_dout8b   ;
wire [8:0]    tx_data_fifo3_dout9b   ;
wire           tx_ptr_fifo3_rd      ;
wire [15:0]    tx_ptr_fifo3_dout16b    ;
wire [71:0]    tx_ptr_fifo3_dout72b   ;
wire           tx_ptr_fifo3_empty   ;
wire          tx_data_fifo4_rd     ;
wire [7:0]    tx_data_fifo4_dout8b   ;
wire [8:0]    tx_data_fifo4_dout9b   ;
wire           tx_ptr_fifo4_rd      ;
wire [15:0]    tx_ptr_fifo4_dout16b    ;
wire [71:0]    tx_ptr_fifo4_dout72b   ;
wire           tx_ptr_fifo4_empty   ;

assign tx_data_fifo1_dout9b  =  {1'b0,tx_data_fifo1_dout8b[7:0]};
assign tx_data_fifo2_dout9b  =  {1'b0,tx_data_fifo2_dout8b[7:0]};
assign tx_data_fifo3_dout9b  =  {1'b0,tx_data_fifo3_dout8b[7:0]};
assign tx_data_fifo4_dout9b  =  {1'b0,tx_data_fifo4_dout8b[7:0]};
assign tx_ptr_fifo1_dout72b  =  {61'h0,tx_ptr_fifo1_dout16b[10:0]};
assign tx_ptr_fifo2_dout72b  =  {61'h0,tx_ptr_fifo2_dout16b[10:0]};
assign tx_ptr_fifo3_dout72b  =  {61'h0,tx_ptr_fifo3_dout16b[10:0]};
assign tx_ptr_fifo4_dout72b  =  {61'h0,tx_ptr_fifo4_dout16b[10:0]};


switch_top switch(
	.clk(clk),
	.rstn(reset),
	
	.sof(sof),
	.dv(dv),
	.din(data),
	
	.ptr_fifo_rd0(tx_ptr_fifo1_rd),
	.ptr_fifo_rd1(tx_ptr_fifo2_rd),
	.ptr_fifo_rd2(tx_ptr_fifo3_rd),
	.ptr_fifo_rd3(tx_ptr_fifo4_rd),
	.data_fifo_rd0(tx_data_fifo1_rd),
	.data_fifo_rd1(tx_data_fifo2_rd),
	.data_fifo_rd2(tx_data_fifo3_rd),
	.data_fifo_rd3(tx_data_fifo4_rd),
	.data_fifo_dout0(tx_data_fifo1_dout9b),
	.data_fifo_dout1(tx_data_fifo2_dout9b),
	.data_fifo_dout2(tx_data_fifo3_dout9b),
	.data_fifo_dout3(tx_data_fifo4_dout9b),
	.ptr_fifo_dout0(tx_ptr_fifo1_dout16b),
	.ptr_fifo_dout1(tx_ptr_fifo2_dout16b),
	.ptr_fifo_dout2(tx_ptr_fifo3_dout16b),
	.ptr_fifo_dout3(tx_ptr_fifo4_dout16b),
	.ptr_fifo_empty0(tx_ptr_fifo1_empty),
	.ptr_fifo_empty1(tx_ptr_fifo2_empty),
	.ptr_fifo_empty2(tx_ptr_fifo3_empty),
	.ptr_fifo_empty3(tx_ptr_fifo4_empty)
	);  

 //eth_tx
 eth_gmii_tx eth_tx1(
 .clk                    (clk),
 .reset                  (reset),
 .gmii_txd               (port1_gmii_txd),
 .gmii_tx_en             (port1_gmii_tx_en),
 .gmii_tx_er             (port1_gmii_tx_er),
 .sgmii_clk_en           (port1_sgmii_clk_en),
 .data_fifo_rd           (tx_data_fifo1_rd),
 .data_fifo_data_out     (tx_data_fifo1_dout9b),
 .data_fifo_empty         (tx_ptr_fifo1_empty),
 .cmd_fifo_rd             (tx_ptr_fifo1_rd),
 .cmd_fifo_data_out       (tx_ptr_fifo1_dout72b),
 .cmd_fifo_empty          (tx_ptr_fifo1_empty)
);



 eth_gmii_tx eth_tx2(
.clk                    (clk),
.reset                  (reset),
.gmii_txd               (port2_gmii_txd),
.gmii_tx_en             (port2_gmii_tx_en),
.gmii_tx_er             (port2_gmii_tx_er),
.sgmii_clk_en           (port2_sgmii_clk_en),
.data_fifo_rd           (tx_data_fifo2_rd),
.data_fifo_data_out     (tx_data_fifo2_dout9b),
.data_fifo_empty         (tx_ptr_fifo2_empty),
.cmd_fifo_rd             (tx_ptr_fifo2_rd),
.cmd_fifo_data_out       (tx_ptr_fifo2_dout72b),
.cmd_fifo_empty          (tx_ptr_fifo2_empty)
);

 eth_gmii_tx eth_tx3(
 .clk                    (clk),
 .reset                  (reset),
 .gmii_txd               (port3_gmii_txd),
 .gmii_tx_en             (port3_gmii_tx_en),
 .gmii_tx_er             (port3_gmii_tx_er),
 .sgmii_clk_en           (port3_sgmii_clk_en),
 .data_fifo_rd           (tx_data_fifo3_rd),
 .data_fifo_data_out     (tx_data_fifo3_dout9b),
 .data_fifo_empty         (tx_ptr_fifo3_empty),
 .cmd_fifo_rd             (tx_ptr_fifo3_rd),
 .cmd_fifo_data_out       (tx_ptr_fifo3_dout72b),
 .cmd_fifo_empty          (tx_ptr_fifo3_empty)
);

 eth_gmii_tx eth_tx4(
 .clk                    (clk),
 .reset                  (reset),
 .gmii_txd               (port4_gmii_txd),
 .gmii_tx_en             (port4_gmii_tx_en),
 .gmii_tx_er             (port4_gmii_tx_er),
 .sgmii_clk_en           (port4_sgmii_clk_en),
 .data_fifo_rd           (tx_data_fifo4_rd),
 .data_fifo_data_out     (tx_data_fifo4_dout9b),
 .data_fifo_empty         (tx_ptr_fifo4_empty),
 .cmd_fifo_rd             (tx_ptr_fifo4_rd),
 .cmd_fifo_data_out       (tx_ptr_fifo4_dout72b),
 .cmd_fifo_empty          (tx_ptr_fifo4_empty)
);

endmodule


