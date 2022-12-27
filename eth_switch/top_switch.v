`timescale 1ns / 1ps
module top_switch(
//share interface
input              sys_clk,
//mac0 interface
input    [3:0]     MII_RXD_0,
input              MII_RX_DV_0,
input              MII_RX_CLK_0,
input              MII_RX_ER_0,
output   [3:0]     MII_TXD_0,
output             MII_TX_EN_0,
input              MII_TX_CLK_0,
output             MII_TX_ER_0,
output             phy_rstn_0,
//mac1 interface
input    [3:0]     MII_RXD_1,
input              MII_RX_DV_1,
input              MII_RX_CLK_1,
input              MII_RX_ER_1,
output   [3:0]     MII_TXD_1,
output             MII_TX_EN_1,
input              MII_TX_CLK_1,
output             MII_TX_ER_1,
output             phy_rstn_1,
//mac2 interface
input    [3:0]     MII_RXD_2,
input              MII_RX_DV_2,
input              MII_RX_CLK_2,
input              MII_RX_ER_2,
output   [3:0]     MII_TXD_2,
output             MII_TX_EN_2,
input              MII_TX_CLK_2,
output             MII_TX_ER_2,
output             phy_rstn_2,
//mac3 interface
input    [3:0]     MII_RXD_3,
input              MII_RX_DV_3,
input              MII_RX_CLK_3,
input              MII_RX_ER_3,
output   [3:0]     MII_TXD_3,
output             MII_TX_EN_3,
input              MII_TX_CLK_3,
output             MII_TX_ER_3,
output             phy_rstn_3
);
//interface of interface mux and  switch_pos
wire	    	     emac0_tx_data_fifo_rd;
wire    [7:0]        emac0_tx_data_fifo_dout;
wire                 emac0_tx_ptr_fifo_rd;
wire    [15:0]       emac0_tx_ptr_fifo_dout;
wire                 emac0_tx_ptr_fifo_empty;
                     
wire                 emac0_rx_data_fifo_rd;
wire    [7:0]        emac0_rx_data_fifo_dout;
wire                 emac0_rx_ptr_fifo_rd;
wire    [15:0]       emac0_rx_ptr_fifo_dout;
wire                 emac0_rx_ptr_fifo_empty;

wire	    	     emac1_tx_data_fifo_rd;
wire    [7:0]        emac1_tx_data_fifo_dout;
wire                 emac1_tx_ptr_fifo_rd;
wire    [15:0]       emac1_tx_ptr_fifo_dout;
wire                 emac1_tx_ptr_fifo_empty;
                     
wire                 emac1_rx_data_fifo_rd;
wire    [7:0]        emac1_rx_data_fifo_dout;
wire                 emac1_rx_ptr_fifo_rd;
wire    [15:0]       emac1_rx_ptr_fifo_dout;
wire                 emac1_rx_ptr_fifo_empty;

wire	    	     emac2_tx_data_fifo_rd;
wire    [7:0]        emac2_tx_data_fifo_dout;
wire                 emac2_tx_ptr_fifo_rd;
wire    [15:0]       emac2_tx_ptr_fifo_dout;
wire                 emac2_tx_ptr_fifo_empty;
                     
wire                 emac2_rx_data_fifo_rd;
wire    [7:0]        emac2_rx_data_fifo_dout;
wire                 emac2_rx_ptr_fifo_rd;
wire    [15:0]       emac2_rx_ptr_fifo_dout;
wire                 emac2_rx_ptr_fifo_empty;

wire	    	     emac3_tx_data_fifo_rd;
wire    [7:0]        emac3_tx_data_fifo_dout;
wire                 emac3_tx_ptr_fifo_rd;
wire    [15:0]       emac3_tx_ptr_fifo_dout;
wire                 emac3_tx_ptr_fifo_empty;
                     
wire                 emac3_rx_data_fifo_rd;
wire    [7:0]        emac3_rx_data_fifo_dout;
wire                 emac3_rx_ptr_fifo_rd;
wire    [15:0]       emac3_rx_ptr_fifo_dout;
wire                 emac3_rx_ptr_fifo_empty;
wire                 rstn;
wire                 clk;
mac_top u_mac_top_0(
    .clk(clk),
    .rstn(rstn),
    .MII_RXD(MII_RXD_0),
    .MII_RX_DV(MII_RX_DV_0),
    .MII_RX_CLK(MII_RX_CLK_0),
    .MII_RX_ER(MII_RX_ER_0),
    .MII_TXD(MII_TXD_0),
    .MII_TX_CLK(MII_TX_CLK_0),
    .MII_TX_EN(MII_TX_EN_0),
    .MII_TX_ER(MII_TX_ER_0),
                     
    .rx_data_fifo_rd(emac0_rx_data_fifo_rd),
    .rx_data_fifo_dout(emac0_rx_data_fifo_dout),
    .rx_ptr_fifo_rd(emac0_rx_ptr_fifo_rd),
    .rx_ptr_fifo_dout(emac0_rx_ptr_fifo_dout),
    .rx_ptr_fifo_empty(emac0_rx_ptr_fifo_empty),
                     
    .tx_data_fifo_rd(emac0_tx_data_fifo_rd),
    .tx_data_fifo_dout(emac0_tx_data_fifo_dout),
    .tx_ptr_fifo_rd(emac0_tx_ptr_fifo_rd),
    .tx_ptr_fifo_dout(emac0_tx_ptr_fifo_dout),
    .tx_ptr_fifo_empty(emac0_tx_ptr_fifo_empty)
    );
mac_top u_mac_top_1(
    .clk(clk),
    .rstn(rstn),
    .MII_RXD(MII_RXD_1),
    .MII_RX_DV(MII_RX_DV_1),
    .MII_RX_CLK(MII_RX_CLK_1),
    .MII_RX_ER(MII_RX_ER_1),
    .MII_TX_CLK(MII_TX_CLK_1),
    .MII_TXD(MII_TXD_1),
    .MII_TX_EN(MII_TX_EN_1),
    .MII_TX_ER(MII_TX_ER_1),
                                            
    .rx_data_fifo_rd(emac1_rx_data_fifo_rd),
    .rx_data_fifo_dout(emac1_rx_data_fifo_dout),
    .rx_ptr_fifo_rd(emac1_rx_ptr_fifo_rd),
    .rx_ptr_fifo_dout(emac1_rx_ptr_fifo_dout),
    .rx_ptr_fifo_empty(emac1_rx_ptr_fifo_empty),
                                            
    .tx_data_fifo_rd(emac1_tx_data_fifo_rd),
    .tx_data_fifo_dout(emac1_tx_data_fifo_dout),
    .tx_ptr_fifo_rd(emac1_tx_ptr_fifo_rd),
    .tx_ptr_fifo_dout(emac1_tx_ptr_fifo_dout),
    .tx_ptr_fifo_empty(emac1_tx_ptr_fifo_empty)
    );
mac_top u_mac_top_2(
    .clk(clk),
    .rstn(rstn),
    .MII_RXD(MII_RXD_2),
    .MII_RX_DV(MII_RX_DV_2),
    .MII_RX_CLK(MII_RX_CLK_2),
    .MII_RX_ER(MII_RX_ER_2),
    .MII_TX_CLK(MII_TX_CLK_2),
    .MII_TXD(MII_TXD_2),
    .MII_TX_EN(MII_TX_EN_2),
    .MII_TX_ER(MII_TX_ER_2),
                                                                   
    .rx_data_fifo_rd(emac2_rx_data_fifo_rd),
    .rx_data_fifo_dout(emac2_rx_data_fifo_dout),
    .rx_ptr_fifo_rd(emac2_rx_ptr_fifo_rd),
    .rx_ptr_fifo_dout(emac2_rx_ptr_fifo_dout),
    .rx_ptr_fifo_empty(emac2_rx_ptr_fifo_empty),
                                                                   
    .tx_data_fifo_rd(emac2_tx_data_fifo_rd),
    .tx_data_fifo_dout(emac2_tx_data_fifo_dout),
    .tx_ptr_fifo_rd(emac2_tx_ptr_fifo_rd),
    .tx_ptr_fifo_dout(emac2_tx_ptr_fifo_dout),
    .tx_ptr_fifo_empty(emac2_tx_ptr_fifo_empty)
    );       
mac_top u_mac_top_3(
    .clk(clk),
    .rstn(rstn),
    .MII_RXD(MII_RXD_3),
    .MII_RX_DV(MII_RX_DV_3),
    .MII_RX_CLK(MII_RX_CLK_3),
    .MII_RX_ER(MII_RX_ER_3),
    .MII_TX_CLK(MII_TX_CLK_3),
    .MII_TXD(MII_TXD_3),
    .MII_TX_EN(MII_TX_EN_3),
    .MII_TX_ER(MII_TX_ER_3),
                                         
    .rx_data_fifo_rd(emac3_rx_data_fifo_rd),
    .rx_data_fifo_dout(emac3_rx_data_fifo_dout),
    .rx_ptr_fifo_rd(emac3_rx_ptr_fifo_rd),
    .rx_ptr_fifo_dout(emac3_rx_ptr_fifo_dout),
    .rx_ptr_fifo_empty(emac3_rx_ptr_fifo_empty),
                                         
    .tx_data_fifo_rd(emac3_tx_data_fifo_rd),
    .tx_data_fifo_dout(emac3_tx_data_fifo_dout),
    .tx_ptr_fifo_rd(emac3_tx_ptr_fifo_rd),
    .tx_ptr_fifo_dout(emac3_tx_ptr_fifo_dout),
    .tx_ptr_fifo_empty(emac3_tx_ptr_fifo_empty)
    );    

wire               sfifo_rd;
wire     [7:0]     sfifo_dout;
wire               ptr_sfifo_rd;
wire     [15:0]    ptr_sfifo_dout;
wire               ptr_sfifo_empty;
interface_mux u_interface_mux(
    .clk(clk),
	.rstn(rstn),
    .rx_data_fifo_dout0(emac0_rx_data_fifo_dout),
	.rx_data_fifo_rd0(emac0_rx_data_fifo_rd),
	.rx_ptr_fifo_dout0(emac0_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd0(emac0_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty0(emac0_rx_ptr_fifo_empty),
										 
	.rx_data_fifo_dout1(emac1_rx_data_fifo_dout),
	.rx_data_fifo_rd1(emac1_rx_data_fifo_rd),
	.rx_ptr_fifo_dout1(emac1_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd1(emac1_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty1(emac1_rx_ptr_fifo_empty),
										 
	.rx_data_fifo_dout2(emac2_rx_data_fifo_dout),
	.rx_data_fifo_rd2(emac2_rx_data_fifo_rd),
	.rx_ptr_fifo_dout2(emac2_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd2(emac2_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty2(emac2_rx_ptr_fifo_empty),
										 
	.rx_data_fifo_dout3(emac3_rx_data_fifo_dout),
	.rx_data_fifo_rd3(emac3_rx_data_fifo_rd),
	.rx_ptr_fifo_dout3(emac3_rx_ptr_fifo_dout),
	.rx_ptr_fifo_rd3(emac3_rx_ptr_fifo_rd),
	.rx_ptr_fifo_empty3(emac3_rx_ptr_fifo_empty),
										 
	.sfifo_rd(sfifo_rd),
	.sfifo_dout(sfifo_dout),
	.ptr_sfifo_rd(ptr_sfifo_rd),
	.ptr_sfifo_dout(ptr_sfifo_dout),
	.ptr_sfifo_empty(ptr_sfifo_empty)
    );
                               
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
wire  		 bp1;
wire		 bp2;
wire         bp3;

frame_process u_frame_process(
    .clk(clk),
	.rstn(rstn),
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
	.rstn(rstn),
	.se_req(se_req),
	.se_ack(se_ack),
	.se_hash(se_hash),
	.se_portmap(source_portmap),
	.se_source(se_source),
	.se_result(se_result),
	.se_nak(se_nak),
	.se_mac(se_mac),
	.aging_req(),
	.aging_ack()
    );

switch_top switch(
	.clk(clk),
	.rstn(rstn),
	
	.sof(sof),
	.dv(dv),
	.din(data),
	
	.ptr_fifo_rd0(emac0_tx_ptr_fifo_rd),
	.ptr_fifo_rd1(emac1_tx_ptr_fifo_rd),
	.ptr_fifo_rd2(emac2_tx_ptr_fifo_rd),
	.ptr_fifo_rd3(emac3_tx_ptr_fifo_rd),
	.data_fifo_rd0(emac0_tx_data_fifo_rd),
	.data_fifo_rd1(emac1_tx_data_fifo_rd),
	.data_fifo_rd2(emac2_tx_data_fifo_rd),
	.data_fifo_rd3(emac3_tx_data_fifo_rd),
	.data_fifo_dout0(emac0_tx_data_fifo_dout),
	.data_fifo_dout1(emac1_tx_data_fifo_dout),
	.data_fifo_dout2(emac2_tx_data_fifo_dout),
	.data_fifo_dout3(emac3_tx_data_fifo_dout),
	.ptr_fifo_dout0(emac0_tx_ptr_fifo_dout),
	.ptr_fifo_dout1(emac1_tx_ptr_fifo_dout),
	.ptr_fifo_dout2(emac2_tx_ptr_fifo_dout),
	.ptr_fifo_dout3(emac3_tx_ptr_fifo_dout),
	.ptr_fifo_empty0(emac0_tx_ptr_fifo_empty),
	.ptr_fifo_empty1(emac1_tx_ptr_fifo_empty),
	.ptr_fifo_empty2(emac2_tx_ptr_fifo_empty),
	.ptr_fifo_empty3(emac3_tx_ptr_fifo_empty)
	);

pll_100M U_pll(
    .CLK_IN1(sys_clk),
	.RESET(1'b0),
	.CLK_OUT1(clk),
    .LOCKED(rstn)
    );

assign  phy_rstn_0=1'b1;
assign  phy_rstn_1=1'b1;
assign  phy_rstn_2=1'b1;
assign  phy_rstn_3=1'b1;
endmodule
