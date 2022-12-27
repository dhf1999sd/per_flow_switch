`timescale 1 ns / 100 ps

module dynamic_per_stream_queue_switch(

  GE_PHY_C_QSGMII0_IN_P,
  GE_PHY_C_QSGMII0_IN_N,
  GE_PHY_C_QSGMII0_OUT_P,
  GE_PHY_C_QSGMII0_OUT_N,
  GE_PHY_C_QSGMII1_IN_P,
  GE_PHY_C_QSGMII1_IN_N,
  GE_PHY_C_QSGMII1_OUT_P,
  GE_PHY_C_QSGMII1_OUT_N,
  GE_PHY_B_QSGMII0_IN_P,
  GE_PHY_B_QSGMII0_IN_N,
  GE_PHY_B_QSGMII0_OUT_P,
  GE_PHY_B_QSGMII0_OUT_N,
  GE_PHY_B_QSGMII1_IN_P,
  GE_PHY_B_QSGMII1_IN_N,
  GE_PHY_B_QSGMII1_OUT_P,
  GE_PHY_B_QSGMII1_OUT_N,
  FPGA_GTX_P0_CLK_P,
  FPGA_GTX_P0_CLK_N,
  GE_PHY_A_QSGMII1_IN_P,
  GE_PHY_A_QSGMII1_IN_N,
  GE_PHY_A_QSGMII1_OUT_P,
  GE_PHY_A_QSGMII1_OUT_N,

  GE_PHY_A_QSGMII0_IN_P,
  GE_PHY_A_QSGMII0_IN_N,
  GE_PHY_A_QSGMII0_OUT_P,
  GE_PHY_A_QSGMII0_OUT_N,

 
  CPU_ESPI2_RDY,             //CPU LED signal;
  CPU_ESPI1_MISO,           //reset signal from CPU
  CPU_ENET2_TX_CLK,
  SW_SEL_P00,
  SW_SEL_P01,
  SW_SEL_P02,
  SW_SEL_P03,
  SW_SEL_P04,
  SW_SEL_P05,
  SW_SEL_P06,
  SW_SEL_P07,
  SW_SEL_P08,
  SW_SEL_P09,
  SW_SEL_P10,
  SW_SEL_P11,
  SW_SEL_P12,
  SW_SEL_P13,
  SW_SEL_P14,
  SW_SEL_P15,
  SW_SEL_P16,
  SW_SEL_P17,
  SW_SEL_P18,
  SW_SEL_P19,
  SW_SEL_P20,
  SW_SEL_P21,
  SW_SEL_P22,
  SW_SEL_P23,
  GE_PHY_A_MDC,
  GE_PHY_B_MDC ,
  GE_PHY_C_MDC,
  FE_PHY_MDC,
  CPU_ENET2_MDC,
  CPU_ENET1_LED_LNKACT,
  CPU_ENET1_LED_SPEED,
  FPGA_SYS_ETH_LED0,
  FPGA_SYS_ETH_LED1,
  FPGA_GE_LED_P16,
  FPGA_GE_LED_P15,
  FPGA_GE_LED_P06,
  FPGA_GE_LED_P07,
  FPGA_GE_LED_P19,
  FPGA_GE_LED_P18,
  FPGA_GE_LED_P13,
  FPGA_GE_LED_P14,
  FPGA_GE_LED_P08,
  FPGA_GE_LED_P17,
  GE_PHY_B_LED_P2,
  GE_PHY_B_LED_P5,
  FPGA_GE_LED_P03,
  GE_PHY_B_LED_P4,
  GE_PHY_B_LED_P6,
  GE_PHY_B_LED_P7,
  GE_PHY_B_LED_P3,
  FPGA_GE_LED_P01,
  FPGA_GE_LED_P02,
  GE_PHY_A_LED_P2,
  FPGA_GE_LED_P09,
  FPGA_GE_LED_P05,
  FPGA_GE_LED_P11,
  FPGA_GE_LED_P04,
  FPGA_GE_LED_P12,
  FPGA_GE_LED_P23,
  FPGA_GE_LED_P22,
  GE_PHY_B_LED_P1,
  GE_PHY_C_LED_P6,
  GE_PHY_C_LED_P5,
  FPGA_GE_LED_P21,
  FPGA_GE_LED_P20,
  GE_PHY_C_LED_P3,
  GE_PHY_C_LED_P4,
  GE_PHY_C_LED_P1,
  GE_PHY_C_LED_P7,
  FPGA_GE_LED_P10,
  FPGA_GE_LED_P00,
  GE_PHY_A_LED_P3,
  GE_PHY_A_LED_P5,
  GE_PHY_A_LED_P0,
  GE_PHY_A_LED_P6,
  GE_PHY_A_LED_P4,
  GE_PHY_A_LED_P7,
  GE_PHY_A_LED_P1,
  GE_PHY_B_LED_P0,
  GE_PHY_C_LED_P0,
  GE_PHY_C_LED_P2,
  LED3,
  LED4,
  LED5,
  LED6,
  SYS_LED
 );
	
  output                      GE_PHY_C_QSGMII0_IN_P;
  output                      GE_PHY_C_QSGMII0_IN_N;
  input                       GE_PHY_C_QSGMII0_OUT_P;
  input                       GE_PHY_C_QSGMII0_OUT_N;
  output                      GE_PHY_C_QSGMII1_IN_P;
  output                      GE_PHY_C_QSGMII1_IN_N;
  input                       GE_PHY_C_QSGMII1_OUT_P;
  input                       GE_PHY_C_QSGMII1_OUT_N;
  output                      GE_PHY_B_QSGMII0_IN_P;
  output                      GE_PHY_B_QSGMII0_IN_N;
  input                       GE_PHY_B_QSGMII0_OUT_P;
  input                       GE_PHY_B_QSGMII0_OUT_N;
  output                      GE_PHY_B_QSGMII1_IN_P;
  output                      GE_PHY_B_QSGMII1_IN_N;
  input                       GE_PHY_B_QSGMII1_OUT_P;
  input                       GE_PHY_B_QSGMII1_OUT_N;
  input                       FPGA_GTX_P0_CLK_P;
  input                       FPGA_GTX_P0_CLK_N;
  output                      GE_PHY_A_QSGMII1_IN_P;           //PMD输出的数据
  output                      GE_PHY_A_QSGMII1_IN_N;
  input                       GE_PHY_A_QSGMII1_OUT_P;
  input                       GE_PHY_A_QSGMII1_OUT_N;

  output           wire       GE_PHY_A_QSGMII0_IN_P;
  output           wire       GE_PHY_A_QSGMII0_IN_N;
  input                       GE_PHY_A_QSGMII0_OUT_P;
  input                       GE_PHY_A_QSGMII0_OUT_N;     //外部数据传递给物理层的

  input                       CPU_ESPI2_RDY;
  input                       CPU_ESPI1_MISO;
  input                       CPU_ENET2_TX_CLK;  //50MHz clock input
  output                      SW_SEL_P00;
  output                      SW_SEL_P01;
  output                      SW_SEL_P02;
  output                      SW_SEL_P03;
  output                      SW_SEL_P04;
  output                      SW_SEL_P05;
  output                      SW_SEL_P06;
  output                      SW_SEL_P07;
  output                      SW_SEL_P08;
  output                      SW_SEL_P09;
  output                      SW_SEL_P10;
  output                      SW_SEL_P11;
  output                      SW_SEL_P12;
  output                      SW_SEL_P13;
  output                      SW_SEL_P14;
  output                      SW_SEL_P15;
  output                      SW_SEL_P16;
  output                      SW_SEL_P17;
  output                      SW_SEL_P18;
  output                      SW_SEL_P19;
  output                      SW_SEL_P20;
  output                      SW_SEL_P21;
  output                      SW_SEL_P22;
  output                      SW_SEL_P23;
  output                      GE_PHY_A_MDC;
  output                      GE_PHY_B_MDC;
  output                      GE_PHY_C_MDC;
  output                      FE_PHY_MDC;
  input                       CPU_ENET2_MDC;
  input                       CPU_ENET1_LED_LNKACT;
  input                       CPU_ENET1_LED_SPEED;
  output                      FPGA_SYS_ETH_LED0;
  output                      FPGA_SYS_ETH_LED1;
  output                      FPGA_GE_LED_P16;
  output                      FPGA_GE_LED_P15;
  output                      FPGA_GE_LED_P06;
  output                      FPGA_GE_LED_P07;
  output                      FPGA_GE_LED_P19;
  output                      FPGA_GE_LED_P18;
  output                      FPGA_GE_LED_P13;
  output                      FPGA_GE_LED_P14;
  output                      FPGA_GE_LED_P08;
  output                      FPGA_GE_LED_P17;
  input                       GE_PHY_B_LED_P2;
  input                       GE_PHY_B_LED_P5;
  output                      FPGA_GE_LED_P03;
  input                       GE_PHY_B_LED_P4;
  input                       GE_PHY_B_LED_P6;
  input                       GE_PHY_B_LED_P7;
  input                       GE_PHY_B_LED_P3;
  output                      FPGA_GE_LED_P01;
  output                      FPGA_GE_LED_P02;
  input                       GE_PHY_A_LED_P2;
  output                      FPGA_GE_LED_P09;
  output                      FPGA_GE_LED_P05;
  output                      FPGA_GE_LED_P11;
  output                      FPGA_GE_LED_P04;
  output                      FPGA_GE_LED_P12;
  output                      FPGA_GE_LED_P23;
  output                      FPGA_GE_LED_P22;
  input                       GE_PHY_B_LED_P1;
  input                       GE_PHY_C_LED_P6;
  input                       GE_PHY_C_LED_P5;
  output                      FPGA_GE_LED_P21;
  output                      FPGA_GE_LED_P20;
  input                       GE_PHY_C_LED_P3;
  input                       GE_PHY_C_LED_P4;
  input                       GE_PHY_C_LED_P1;
  input                       GE_PHY_C_LED_P7;
  output                      FPGA_GE_LED_P10;
  output                      FPGA_GE_LED_P00;
  input                       GE_PHY_A_LED_P3;
  input                       GE_PHY_A_LED_P5;
  input                       GE_PHY_A_LED_P0;
  input                       GE_PHY_A_LED_P6;
  input                       GE_PHY_A_LED_P4;
  input                       GE_PHY_A_LED_P7;
  input                       GE_PHY_A_LED_P1;
  input                       GE_PHY_B_LED_P0;
  input                       GE_PHY_C_LED_P0;
  input                       GE_PHY_C_LED_P2;
  output                      LED3;
  output                      LED4;
  output                      LED5;
  output                      LED6;
  output                      SYS_LED;
  
  wire                        clk_50m;         
  wire      [5:0]             configuration_vector;     
  wire      [15:0]            an_adv_config_vector;     
  wire                        an_restart_config;        
  wire                        signal_detect;            
  wire                        qs_0_speed_is_10_100_ch0; 
  wire                        qs_0_speed_is_100_ch0   ; 
  wire                        qs_0_speed_is_10_100_ch1; 
  wire                        qs_0_speed_is_100_ch1   ; 
  wire                        qs_0_speed_is_10_100_ch2; 
  wire                        qs_0_speed_is_100_ch2   ; 
  wire                        qs_0_speed_is_10_100_ch3; 
  wire                        qs_0_speed_is_100_ch3   ; 
  wire                        qs_1_speed_is_10_100_ch0; 
  wire                        qs_1_speed_is_100_ch0   ; 
  wire                        qs_1_speed_is_10_100_ch1; 
  wire                        qs_1_speed_is_100_ch1   ; 
  wire                        qs_1_speed_is_10_100_ch2; 
  wire                        qs_1_speed_is_100_ch2   ; 
  wire                        qs_1_speed_is_10_100_ch3; 
  wire                        qs_1_speed_is_100_ch3   ; 
  wire                        qs_2_speed_is_10_100_ch0; 
  wire                        qs_2_speed_is_100_ch0   ; 
  wire                        qs_2_speed_is_10_100_ch1; 
  wire                        qs_2_speed_is_100_ch1   ; 
  wire                        qs_2_speed_is_10_100_ch2; 
  wire                        qs_2_speed_is_100_ch2   ; 
  wire                        qs_2_speed_is_10_100_ch3; 
  wire                        qs_2_speed_is_100_ch3   ; 
  wire                        qs_3_speed_is_10_100_ch0; 
  wire                        qs_3_speed_is_100_ch0   ; 
  wire                        qs_3_speed_is_10_100_ch1; 
  wire                        qs_3_speed_is_100_ch1   ; 
  wire                        qs_3_speed_is_10_100_ch2; 
  wire                        qs_3_speed_is_100_ch2   ; 
  wire                        qs_3_speed_is_10_100_ch3; 
  wire                        qs_3_speed_is_100_ch3   ; 
  wire                        qs_4_speed_is_10_100_ch0; 
  wire                        qs_4_speed_is_100_ch0   ; 
  wire                        qs_4_speed_is_10_100_ch1; 
  wire                        qs_4_speed_is_100_ch1   ; 
  wire                        qs_4_speed_is_10_100_ch2; 
  wire                        qs_4_speed_is_100_ch2   ; 
  wire                        qs_4_speed_is_10_100_ch3; 
  wire                        qs_4_speed_is_100_ch3   ; 
  wire                        qs_5_speed_is_10_100_ch0; 
  wire                        qs_5_speed_is_100_ch0   ; 
  wire                        qs_5_speed_is_10_100_ch1; 
  wire                        qs_5_speed_is_100_ch1   ; 
  wire                        qs_5_speed_is_10_100_ch2; 
  wire                        qs_5_speed_is_100_ch2   ; 
  wire                        qs_5_speed_is_10_100_ch3; 
  wire                        qs_5_speed_is_100_ch3   ; 
  
  wire                        qs_0_clk125;
  wire                        qs_1_clk125; 
  wire                        qs_2_clk125; 
  wire                        qs_3_clk125; 
  wire                        qs_4_clk125; 
  wire                        qs_5_clk125;
  
  wire      [7:0]             port1_gmii_txd;
  wire                        port1_gmii_tx_en;
  wire                        port1_gmii_tx_er;
  wire      [7:0]             port1_gmii_rxd;
  wire                        port1_gmii_rx_dv;
  wire                        port1_gmii_rx_er;
  wire      [7:0]             port2_gmii_txd;
  wire                        port2_gmii_tx_en;
  wire                        port2_gmii_tx_er;
  wire      [7:0]             port2_gmii_rxd;
  wire                        port2_gmii_rx_dv;
  wire                        port2_gmii_rx_er;

  wire      [7:0]             port3_gmii_txd;
  wire                        port3_gmii_tx_en;
  wire                        port3_gmii_tx_er;
  wire      [7:0]             port3_gmii_rxd;
  wire                        port3_gmii_rx_dv;
  wire                        port3_gmii_rx_er;
  wire      [7:0]             port4_gmii_txd;
  wire                        port4_gmii_tx_en;
  wire                        port4_gmii_tx_er;
  wire      [7:0]             port4_gmii_rxd;
  wire                        port4_gmii_rx_dv;
  wire                        port4_gmii_rx_er; 
 
  wire      [7:0]             line_3_left_gmii_txd;
  wire                        line_3_left_gmii_tx_en;
  wire                        line_3_left_gmii_tx_er;
  wire      [7:0]             line_3_left_gmii_rxd;
  wire                        line_3_left_gmii_rx_dv;
  wire                        line_3_left_gmii_rx_er;
  wire      [7:0]             line_3_right_gmii_txd;
  wire                        line_3_right_gmii_tx_en;
  wire                        line_3_right_gmii_tx_er;
  wire      [7:0]             line_3_right_gmii_rxd;
  wire                        line_3_right_gmii_rx_dv;
  wire                        line_3_right_gmii_rx_er; 
 
  wire      [7:0]             port7_gmii_txd;
  wire                        port7_gmii_tx_en;
  wire                        port7_gmii_tx_er;
  wire      [7:0]             port7_gmii_rxd;
  wire                        port7_gmii_rx_dv;
  wire                        port7_gmii_rx_er;
  wire      [7:0]             port8_gmii_txd;
  wire                        port8_gmii_tx_en;
  wire                        port8_gmii_tx_er;
  wire      [7:0]             port8_gmii_rxd;
  wire                        port8_gmii_rx_dv;
  wire                        port8_gmii_rx_er; 
  
  wire      [7:0]             line_5_left_gmii_txd;
  wire                        line_5_left_gmii_tx_en;
  wire                        line_5_left_gmii_tx_er;
  wire      [7:0]             line_5_left_gmii_rxd;
  wire                        line_5_left_gmii_rx_dv;
  wire                        line_5_left_gmii_rx_er;
  wire      [7:0]             line_5_right_gmii_txd;
  wire                        line_5_right_gmii_tx_en;
  wire                        line_5_right_gmii_tx_er;
  wire      [7:0]             line_5_right_gmii_rxd;
  wire                        line_5_right_gmii_rx_dv;
  wire                        line_5_right_gmii_rx_er;  
  
  wire      [7:0]             line_6_left_gmii_txd;
  wire                        line_6_left_gmii_tx_en;
  wire                        line_6_left_gmii_tx_er;
  wire      [7:0]             line_6_left_gmii_rxd;
  wire                        line_6_left_gmii_rx_dv;
  wire                        line_6_left_gmii_rx_er;
  wire      [7:0]             line_6_right_gmii_txd;
  wire                        line_6_right_gmii_tx_en;
  wire                        line_6_right_gmii_tx_er;
  wire      [7:0]             line_6_right_gmii_rxd;
  wire                        line_6_right_gmii_rx_dv;
  wire                        line_6_right_gmii_rx_er;  
  
  wire     [7:0]              line_7_left_gmii_txd;
  wire                        line_7_left_gmii_tx_en;
  wire                        line_7_left_gmii_tx_er;
  wire     [7:0]              line_7_left_gmii_rxd;
  wire                        line_7_left_gmii_rx_dv;
  wire                        line_7_left_gmii_rx_er;
  wire     [7:0]              line_7_right_gmii_txd;
  wire                        line_7_right_gmii_tx_en;
  wire                        line_7_right_gmii_tx_er;
  wire     [7:0]              line_7_right_gmii_rxd;
  wire                        line_7_right_gmii_rx_dv;
  wire                        line_7_right_gmii_rx_er;  
  
  wire     [7:0]              line_8_left_gmii_txd;
  wire                        line_8_left_gmii_tx_en;
  wire                        line_8_left_gmii_tx_er;
  wire     [7:0]              line_8_left_gmii_rxd;
  wire                        line_8_left_gmii_rx_dv;
  wire                        line_8_left_gmii_rx_er;
  wire     [7:0]              line_8_right_gmii_txd;
  wire                        line_8_right_gmii_tx_en;
  wire                        line_8_right_gmii_tx_er;
  wire     [7:0]              line_8_right_gmii_rxd;
  wire                        line_8_right_gmii_rx_dv;
  wire                        line_8_right_gmii_rx_er;  
  
  wire     [7:0]              line_9_left_gmii_txd;
  wire                        line_9_left_gmii_tx_en;
  wire                        line_9_left_gmii_tx_er;
  wire     [7:0]              line_9_left_gmii_rxd;
  wire                        line_9_left_gmii_rx_dv;
  wire                        line_9_left_gmii_rx_er;
  wire     [7:0]              line_9_right_gmii_txd;
  wire                        line_9_right_gmii_tx_en;
  wire                        line_9_right_gmii_tx_er;
  wire     [7:0]              line_9_right_gmii_rxd;
  wire                        line_9_right_gmii_rx_dv;
  wire                        line_9_right_gmii_rx_er; 
  
  wire     [7:0]              line_10_left_gmii_txd;
  wire                        line_10_left_gmii_tx_en;
  wire                        line_10_left_gmii_tx_er;
  wire     [7:0]              line_10_left_gmii_rxd;
  wire                        line_10_left_gmii_rx_dv;
  wire                        line_10_left_gmii_rx_er;
  wire     [7:0]              line_10_right_gmii_txd;
  wire                        line_10_right_gmii_tx_en;
  wire                        line_10_right_gmii_tx_er;
  wire     [7:0]              line_10_right_gmii_rxd;
  wire                        line_10_right_gmii_rx_dv;
  wire                        line_10_right_gmii_rx_er;
  
  wire     [7:0]              line_11_left_gmii_txd;
  wire                        line_11_left_gmii_tx_en;
  wire                        line_11_left_gmii_tx_er;
  wire     [7:0]              line_11_left_gmii_rxd;
  wire                        line_11_left_gmii_rx_dv;
  wire                        line_11_left_gmii_rx_er;
  wire     [7:0]              line_11_right_gmii_txd;
  wire                        line_11_right_gmii_tx_en;
  wire                        line_11_right_gmii_tx_er;
  wire     [7:0]              line_11_right_gmii_rxd;
  wire                        line_11_right_gmii_rx_dv;
  wire                        line_11_right_gmii_rx_er;  
  
  wire     [7:0]              line_12_left_gmii_txd;
  wire                        line_12_left_gmii_tx_en;
  wire                        line_12_left_gmii_tx_er;
  wire     [7:0]              line_12_left_gmii_rxd;
  wire                        line_12_left_gmii_rx_dv;
  wire                        line_12_left_gmii_rx_er;
  wire     [7:0]              line_12_right_gmii_txd;
  wire                        line_12_right_gmii_tx_en;
  wire                        line_12_right_gmii_tx_er;
  wire     [7:0]              line_12_right_gmii_rxd;
  wire                        line_12_right_gmii_rx_dv;
  wire                        line_12_right_gmii_rx_er;  
  
  wire                        port1_sgmii_clk_en; 
  wire                        port2_sgmii_clk_en;  
  wire                        port3_sgmii_clk_en; 
  wire                        port4_sgmii_clk_en;  
  wire                        line_3_left_sgmii_clk_en; 
  wire                        line_3_right_sgmii_clk_en;  
  wire                        port7_sgmii_clk_en; 
  wire                        port8_sgmii_clk_en;  
  wire                        line_5_left_sgmii_clk_en; 
  wire                        line_5_right_sgmii_clk_en;  
  wire                        line_6_left_sgmii_clk_en; 
  wire                        line_6_right_sgmii_clk_en; 
  wire                        line_7_left_sgmii_clk_en; 
  wire                        line_7_right_sgmii_clk_en; 
  wire                        line_8_left_sgmii_clk_en; 
  wire                        line_8_right_sgmii_clk_en; 
  wire                        line_9_left_sgmii_clk_en; 
  wire                        line_9_right_sgmii_clk_en; 
  wire                        line_10_left_sgmii_clk_en; 
  wire                        line_10_right_sgmii_clk_en; 
  wire                        line_11_left_sgmii_clk_en; 
  wire                        line_11_right_sgmii_clk_en; 
  wire                        line_12_left_sgmii_clk_en; 
  wire                        line_12_right_sgmii_clk_en;  
  
  wire                        gtrefclk;
  wire                        common_qplloutclk_a;
  wire                        common_qplloutrefclk_a;
  wire                        common_qplloutclk_bc;
  wire                        common_qplloutrefclk_bc;
  wire                        mmcm_locked;
  wire                        clk_200m;
  
  reg                         reset;          //system reset
  wire                        qplllock_a;
  wire 	           					  qplllock_bc; 
  
  wire    [15:0]              qs0_status_vector_ch3;
  wire    [15:0]              qs0_status_vector_ch2;	
  wire    [15:0]              qs0_status_vector_ch1;	
  wire    [15:0]              qs0_status_vector_ch0;
  wire                        qs0_gt0_cplllock_out;
                   			
  wire    [15:0]              qs1_status_vector_ch3;	
  wire    [15:0]              qs1_status_vector_ch2;	
  wire    [15:0]              qs1_status_vector_ch1;	
  wire    [15:0]              qs1_status_vector_ch0;
  wire                        qs1_gt0_cplllock_out;	
   			
  wire    [15:0]              qs2_status_vector_ch3;	
  wire    [15:0]              qs2_status_vector_ch2;	
  wire    [15:0]              qs2_status_vector_ch1;	
  wire    [15:0]              qs2_status_vector_ch0;
  wire                        qs2_gt0_cplllock_out;	
	
  wire    [15:0]              qs3_status_vector_ch3;	
  wire    [15:0]              qs3_status_vector_ch2;	
  wire    [15:0]              qs3_status_vector_ch1;	
  wire    [15:0]              qs3_status_vector_ch0;
  wire                        qs3_gt0_cplllock_out;	
			
  wire    [15:0]              qs4_status_vector_ch3;	
  wire    [15:0]              qs4_status_vector_ch2;	
  wire    [15:0]              qs4_status_vector_ch1;	
  wire    [15:0]              qs4_status_vector_ch0;
  wire                        qs4_gt0_cplllock_out;	
 			
  wire    [15:0]              qs5_status_vector_ch3;	
  wire    [15:0]              qs5_status_vector_ch2;	
  wire    [15:0]              qs5_status_vector_ch1;	
  wire    [15:0]              qs5_status_vector_ch0;
  wire                        qs5_gt0_cplllock_out;	
  
  reg     [25:0]              cnt_led;
  reg     [23:0]              shift_mcmm_locked;
  
  wire                        FPGA_GTX_P0_CLK_P_i;
  wire                        FPGA_GTX_P0_CLK_N_i;
  
  reg                         qs_0_line_reset_1d;                          
  reg                         qs_0_line_reset_2d;
  reg                         qs_1_line_reset_1d;
  reg                         qs_1_line_reset_2d;
  reg                         qs_2_line_reset_1d;
  reg                         qs_2_line_reset_2d;
  reg                         qs_3_line_reset_1d;
  reg                         qs_3_line_reset_2d;
  reg                         qs_4_line_reset_1d;
  reg                         qs_4_line_reset_2d;
  reg                         qs_5_line_reset_1d;
  reg                         qs_5_line_reset_2d;
  reg                         CPU_ESPI2_RDY_1d;
  reg     [29:0]              counter_rst_18s;
  reg     [26:0]              counter_watchdog;
  reg                         system_led;
  
  wire                      GE_PHY_A_QSGMII0_IN_P_txp;
  wire                      GE_PHY_A_QSGMII0_IN_N_txn;
  reg                       GE_PHY_A_QSGMII0_OUT_P_initial;
  reg                       GE_PHY_A_QSGMII0_OUT_N_initial;
  wire                      tx;

















  assign   SW_SEL_P00              = 1'b0;                       // 网口1切换开关，0为连通，1为断开；
  assign   SW_SEL_P01              = 1'b0;  
  assign   SW_SEL_P02              = 1'b0;
  assign   SW_SEL_P03              = 1'b0;  
  assign   SW_SEL_P04              = 1'b1;
  assign   SW_SEL_P05              = 1'b1;  
  assign   SW_SEL_P06              = 1'b1;
  assign   SW_SEL_P07              = 1'b1;  
  assign   SW_SEL_P08              = 1'b1;
  assign   SW_SEL_P09              = 1'b1;  
  assign   SW_SEL_P10              = 1'b1;
  assign   SW_SEL_P11              = 1'b1;  
  assign   SW_SEL_P12              = 1'b1;
  assign   SW_SEL_P13              = 1'b1;  
  assign   SW_SEL_P14              = 1'b1;
  assign   SW_SEL_P15              = 1'b1;  
  assign   SW_SEL_P16              = 1'b1;
  assign   SW_SEL_P17              = 1'b1;  
  assign   SW_SEL_P18              = 1'b1;
  assign   SW_SEL_P19              = 1'b1;  
  assign   SW_SEL_P20              = 1'b1;
  assign   SW_SEL_P21              = 1'b1;   
  assign   SW_SEL_P22              = 1'b1;
  assign   SW_SEL_P23              = 1'b1; 
 
  assign   LED3                    = CPU_ESPI2_RDY;
  assign   LED4                    = cnt_led[25];
  assign   LED5                    = 1'b0;
  assign   LED6                    = 1'b1;
  assign   SYS_LED                 = ~system_led;
  
  assign   GE_PHY_A_MDC            = CPU_ENET2_MDC;
  assign   GE_PHY_B_MDC            = CPU_ENET2_MDC;
  assign   GE_PHY_C_MDC            = CPU_ENET2_MDC;
  assign   FE_PHY_MDC              = CPU_ENET2_MDC;
   
  assign   FPGA_GE_LED_P00   = clk_50m;
  assign   FPGA_GE_LED_P01   = clk_50m;
  assign   FPGA_GE_LED_P02   = 1'b0;
  assign   FPGA_GE_LED_P03   = 1'b0;
  assign   FPGA_GE_LED_P04   = 1'b1;
  assign   FPGA_GE_LED_P05   = 1'b1;
  assign   FPGA_GE_LED_P06   = 1'b1;
  assign   FPGA_GE_LED_P07   = 1'b1;
  assign   FPGA_GE_LED_P08   = 1'b1;
  assign   FPGA_GE_LED_P09   = 1'b1;
  assign   FPGA_GE_LED_P10   = 1'b1;
  assign   FPGA_GE_LED_P11   = 1'b1;
  assign   FPGA_GE_LED_P12   = 1'b1;
  assign   FPGA_GE_LED_P13   = 1'b1;
  assign   FPGA_GE_LED_P14   = 1'b1;
  assign   FPGA_GE_LED_P15   = 1'b1;
  assign   FPGA_GE_LED_P16   = 1'b1;
  assign   FPGA_GE_LED_P17   = 1'b1;
  assign   FPGA_GE_LED_P18   = 1'b1;
  assign   FPGA_GE_LED_P19   = 1'b1;
  assign   FPGA_GE_LED_P20   = 1'b1;
  assign   FPGA_GE_LED_P21   = 1'b1;
  assign   FPGA_GE_LED_P22   = 1'b1;
  assign   FPGA_GE_LED_P23   = 1'b1;
  
  assign   FPGA_SYS_ETH_LED0 = ~CPU_ENET1_LED_LNKACT;
  assign   FPGA_SYS_ETH_LED1 = ~CPU_ENET1_LED_SPEED;


  

always @ (posedge clk_50m)
  begin
   if ((mmcm_locked == 1'b0)||(CPU_ESPI1_MISO == 1'b0))
    shift_mcmm_locked           <= 24'h0;
   else if (shift_mcmm_locked[23] == 1'b0)
    shift_mcmm_locked           <= shift_mcmm_locked + 1'b1;
   end
  
 always @ (posedge clk_50m)
  begin
    reset                       <= ~(shift_mcmm_locked[23]);
   end

 always @ (posedge qs_0_clk125)
  begin
    qs_0_line_reset_1d          <= reset;
    qs_0_line_reset_2d          <= qs_0_line_reset_1d;
  end
 
 always @ (posedge qs_1_clk125)                         
  begin                                                 
    qs_1_line_reset_1d          <= reset;               
    qs_1_line_reset_2d          <= qs_1_line_reset_1d;  
  end                                                   
 
 always @ (posedge qs_2_clk125)                         
  begin                                                 
    qs_2_line_reset_1d          <= reset;               
    qs_2_line_reset_2d          <= qs_2_line_reset_1d;  
  end                                                   
 
 always @ (posedge qs_3_clk125)                        
  begin                                                
    qs_3_line_reset_1d          <= reset;              
    qs_3_line_reset_2d          <= qs_3_line_reset_1d; 
  end                                                  

 always @ (posedge qs_4_clk125)                        
  begin                                                
    qs_4_line_reset_1d          <= reset;              
    qs_4_line_reset_2d          <= qs_4_line_reset_1d; 
  end                                                  

 always @ (posedge qs_5_clk125)                        
  begin                                                
    qs_5_line_reset_1d          <= reset;              
    qs_5_line_reset_2d          <= qs_5_line_reset_1d; 
  end                                       

 always @ (posedge clk_50m or posedge reset)
  begin
   if (reset == 1'b1)
    CPU_ESPI2_RDY_1d            <= 1'b0;
   else
    CPU_ESPI2_RDY_1d            <= CPU_ESPI2_RDY;
   end  

 always @ (posedge clk_50m or posedge reset)     
  begin                                          
   if (reset == 1'b1)
    counter_rst_18s             <= 30'h0;
   else if (counter_rst_18s != 30'h36000000)
    counter_rst_18s             <= counter_rst_18s + 1'b1;
   end
       
 always @ (posedge clk_50m or posedge reset)     
  begin                                          
   if (reset == 1'b1)
    counter_watchdog            <= 27'h0;
   else if (CPU_ESPI2_RDY != CPU_ESPI2_RDY_1d)
    counter_watchdog            <= 27'h4F00000;
   else if ((|counter_watchdog) == 1'b1)
    counter_watchdog            <= counter_watchdog - 1'b1;
   end
 
 always @ (posedge clk_50m or posedge reset)     
  begin                                          
   if (reset == 1'b1)
    system_led                  <= 1'b0;    //led off
   else if (counter_rst_18s == 30'h36000000)
    system_led                  <= (|counter_watchdog);
   else
    system_led                  <= 1'b0;
   end

 //led 
 always @ (posedge clk_50m or posedge reset)
  begin
   if (reset == 1'b1)
    cnt_led                     <= 26'h0;
   else
    cnt_led                     <= cnt_led + 1'b1;
   end  
      
  
  clk_wiz_0 u_mmcm(
      .clk_out1                  (clk_50m),              // output clk_out1
      .clk_out2                  (clk_200m),             // output clk_out2
      .reset                     (~CPU_ESPI1_MISO),              // input reset
      .locked                    (mmcm_locked),            // output locked
      .clk_in1                   (CPU_ENET2_TX_CLK)       // input clk_in1
     );   

   IBUF gtrefclk_p_ibuf (
       .I    (FPGA_GTX_P0_CLK_P),
       .O    (FPGA_GTX_P0_CLK_P_i)
     );

   IBUF gtrefclk_n_ibuf (
       .I    (FPGA_GTX_P0_CLK_N),
       .O    (FPGA_GTX_P0_CLK_N_i)
     );   

   IBUFDS_GTE2 ibufds_gtrefclk(
      .I                         (FPGA_GTX_P0_CLK_P_i),
      .IB                        (FPGA_GTX_P0_CLK_N_i),
      .CEB                       (1'b0),
      .O                         (gtrefclk),
      .ODIV2                     ()
     );

  qsgmii_1218_gt_common_wrapper core_gt_common_a(
      .GT0_GTREFCLK0_COMMON_IN   (gtrefclk),
      .QPLLOUTCLK                (common_qplloutclk_a),
      .QPLLOUTREFCLK             (common_qplloutrefclk_a),
      .GT0_QPLLLOCK_OUT          (qplllock_a),
      .GT0_QPLLLOCKDETCLK_IN     (clk_200m),
      .GT0_QPLLREFCLKLOST_OUT    (),
      .GT0_QPLLRESET_IN          (reset)          // to be tested
     );

  qsgmii_1218_gt_common_wrapper core_gt_common_bc(
      .GT0_GTREFCLK0_COMMON_IN   (gtrefclk),
      .QPLLOUTCLK                (common_qplloutclk_bc),
      .QPLLOUTREFCLK             (common_qplloutrefclk_bc),
      .GT0_QPLLLOCK_OUT          (qplllock_bc),
      .GT0_QPLLLOCKDETCLK_IN     (clk_200m),
      .GT0_QPLLREFCLKLOST_OUT    (),
      .GT0_QPLLRESET_IN          (reset)     // to be tested
     );

  qsgmii_1218_support qs_0_PHY_A_0(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),            
	    .common_qplloutclk         (common_qplloutclk_a),  
	    .common_qplloutrefclk      (common_qplloutrefclk_a), 
      .gtrefclk_out              (),
      .txp                       (GE_PHY_A_QSGMII0_IN_P),
      .txn                       (GE_PHY_A_QSGMII0_IN_N),
      .rxp                       (GE_PHY_A_QSGMII0_OUT_P),
      .rxn                       (GE_PHY_A_QSGMII0_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_0_clk125),
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m),
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (port7_sgmii_clk_en ),//port7
      .gmii_txd_ch0              (port7_gmii_txd     ),
      .gmii_tx_en_ch0            (port7_gmii_tx_en   ),
      .gmii_tx_er_ch0            (port7_gmii_tx_er   ),
      .gmii_rxd_ch0              (port7_gmii_rxd     ),
      .gmii_rx_dv_ch0            (port7_gmii_rx_dv   ),
      .gmii_rx_er_ch0            (port7_gmii_rx_er   ),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_0_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_0_speed_is_100_ch0),
      .status_vector_ch0         (qs0_status_vector_ch0),
      .sgmii_clk_en_ch1          (port8_sgmii_clk_en),
      .gmii_txd_ch1              (port8_gmii_txd  ),
      .gmii_tx_en_ch1            (port8_gmii_tx_en),
      .gmii_tx_er_ch1            (port8_gmii_tx_er),
      .gmii_rxd_ch1              (port8_gmii_rxd  ),
      .gmii_rx_dv_ch1            (port8_gmii_rx_dv),
      .gmii_rx_er_ch1            (port8_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_0_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_0_speed_is_100_ch1),
      .status_vector_ch1         (qs0_status_vector_ch1),
      .sgmii_clk_en_ch2          (port1_sgmii_clk_en),
      .gmii_txd_ch2              (port1_gmii_txd  ),
      .gmii_tx_en_ch2            (port1_gmii_tx_en),
      .gmii_tx_er_ch2            (port1_gmii_tx_er),
      .gmii_rxd_ch2              (port1_gmii_rxd  ),
      .gmii_rx_dv_ch2            (port1_gmii_rx_dv),
      .gmii_rx_er_ch2            (port1_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_0_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_0_speed_is_100_ch2),
      .status_vector_ch2         (qs0_status_vector_ch2),
      .sgmii_clk_en_ch3          (port2_sgmii_clk_en),
      .gmii_txd_ch3              (port2_gmii_txd  ),
      .gmii_tx_en_ch3            (port2_gmii_tx_en),
      .gmii_tx_er_ch3            (port2_gmii_tx_er),
      .gmii_rxd_ch3              (port2_gmii_rxd  ),
      .gmii_rx_dv_ch3            (port2_gmii_rx_dv),
      .gmii_rx_er_ch3            (port2_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_0_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_0_speed_is_100_ch3),
      .status_vector_ch3         (qs0_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs0_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );

  qsgmii_1218_support qs_1_PHY_A_1(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),
	    .common_qplloutclk         (common_qplloutclk_a),
	    .common_qplloutrefclk      (common_qplloutrefclk_a),
      .gtrefclk_out              (),
      .txp                       (GE_PHY_A_QSGMII1_IN_P),
      .txn                       (GE_PHY_A_QSGMII1_IN_N),
      .rxp                       (GE_PHY_A_QSGMII1_OUT_P),
      .rxn                       (GE_PHY_A_QSGMII1_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_1_clk125),  
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m),
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (port3_sgmii_clk_en),
      .gmii_txd_ch0              (port3_gmii_txd  ),
      .gmii_tx_en_ch0            (port3_gmii_tx_en),
      .gmii_tx_er_ch0            (port3_gmii_tx_er),
      .gmii_rxd_ch0              (port3_gmii_rxd  ),
      .gmii_rx_dv_ch0            (port3_gmii_rx_dv),
      .gmii_rx_er_ch0            (port3_gmii_rx_er),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_1_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_1_speed_is_100_ch0),
      .status_vector_ch0         (qs1_status_vector_ch0),
      .sgmii_clk_en_ch1          (port4_sgmii_clk_en),
      .gmii_txd_ch1              (port4_gmii_txd  ),
      .gmii_tx_en_ch1            (port4_gmii_tx_en),
      .gmii_tx_er_ch1            (port4_gmii_tx_er),
      .gmii_rxd_ch1              (port4_gmii_rxd  ),
      .gmii_rx_dv_ch1            (port4_gmii_rx_dv),
      .gmii_rx_er_ch1            (port4_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_1_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_1_speed_is_100_ch1),
      .status_vector_ch1         (qs1_status_vector_ch1),
      .sgmii_clk_en_ch2          (line_3_left_sgmii_clk_en),
      .gmii_txd_ch2              (line_3_left_gmii_txd  ),
      .gmii_tx_en_ch2            (line_3_left_gmii_tx_en),
      .gmii_tx_er_ch2            (line_3_left_gmii_tx_er),
      .gmii_rxd_ch2              (line_3_left_gmii_rxd  ),
      .gmii_rx_dv_ch2            (line_3_left_gmii_rx_dv),
      .gmii_rx_er_ch2            (line_3_left_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_1_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_1_speed_is_100_ch2),
      .status_vector_ch2         (qs1_status_vector_ch2),
      .sgmii_clk_en_ch3          (line_3_right_sgmii_clk_en),
      .gmii_txd_ch3              (line_3_right_gmii_txd  ),
      .gmii_tx_en_ch3            (line_3_right_gmii_tx_en),
      .gmii_tx_er_ch3            (line_3_right_gmii_tx_er),
      .gmii_rxd_ch3              (line_3_right_gmii_rxd  ),
      .gmii_rx_dv_ch3            (line_3_right_gmii_rx_dv),
      .gmii_rx_er_ch3            (line_3_right_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_1_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_1_speed_is_100_ch3),
      .status_vector_ch3         (qs1_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs1_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );


  qsgmii_1218_support qs_2_PHY_B_0(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),
	    .common_qplloutclk         (common_qplloutclk_bc),
	    .common_qplloutrefclk      (common_qplloutrefclk_bc),
      .gtrefclk_out              (),
      .txp                       (GE_PHY_B_QSGMII0_IN_P),
      .txn                       (GE_PHY_B_QSGMII0_IN_N),
      .rxp                       (GE_PHY_B_QSGMII0_OUT_P),
      .rxn                       (GE_PHY_B_QSGMII0_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_2_clk125),  
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m), 
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (line_8_left_sgmii_clk_en),
      .gmii_txd_ch0              (line_8_left_gmii_txd  ),
      .gmii_tx_en_ch0            (line_8_left_gmii_tx_en),
      .gmii_tx_er_ch0            (line_8_left_gmii_tx_er),
      .gmii_rxd_ch0              (line_8_left_gmii_rxd  ),
      .gmii_rx_dv_ch0            (line_8_left_gmii_rx_dv),
      .gmii_rx_er_ch0            (line_8_left_gmii_rx_er),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_2_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_2_speed_is_100_ch0),
      .status_vector_ch0         (qs2_status_vector_ch0),
      .sgmii_clk_en_ch1          (line_8_right_sgmii_clk_en),
      .gmii_txd_ch1              (line_8_right_gmii_txd  ),
      .gmii_tx_en_ch1            (line_8_right_gmii_tx_en),
      .gmii_tx_er_ch1            (line_8_right_gmii_tx_er),
      .gmii_rxd_ch1              (line_8_right_gmii_rxd  ),
      .gmii_rx_dv_ch1            (line_8_right_gmii_rx_dv),
      .gmii_rx_er_ch1            (line_8_right_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_2_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_2_speed_is_100_ch1),
      .status_vector_ch1         (qs2_status_vector_ch1),
      .sgmii_clk_en_ch2          (line_5_left_sgmii_clk_en),
      .gmii_txd_ch2              (line_5_left_gmii_txd  ),
      .gmii_tx_en_ch2            (line_5_left_gmii_tx_en),
      .gmii_tx_er_ch2            (line_5_left_gmii_tx_er),
      .gmii_rxd_ch2              (line_5_left_gmii_rxd  ),
      .gmii_rx_dv_ch2            (line_5_left_gmii_rx_dv),
      .gmii_rx_er_ch2            (line_5_left_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_2_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_2_speed_is_100_ch2),
      .status_vector_ch2         (qs2_status_vector_ch2),
      .sgmii_clk_en_ch3          (line_5_right_sgmii_clk_en),
      .gmii_txd_ch3              (line_5_right_gmii_txd  ),
      .gmii_tx_en_ch3            (line_5_right_gmii_tx_en),
      .gmii_tx_er_ch3            (line_5_right_gmii_tx_er),
      .gmii_rxd_ch3              (line_5_right_gmii_rxd  ),
      .gmii_rx_dv_ch3            (line_5_right_gmii_rx_dv),
      .gmii_rx_er_ch3            (line_5_right_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_2_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_2_speed_is_100_ch3),
      .status_vector_ch3         (qs2_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs2_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );
      
  qsgmii_1218_support qs_3_PHY_B_1(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),
	    .common_qplloutclk         (common_qplloutclk_bc),
	    .common_qplloutrefclk      (common_qplloutrefclk_bc),
      .gtrefclk_out              (),
      .txp                       (GE_PHY_B_QSGMII1_IN_P),
      .txn                       (GE_PHY_B_QSGMII1_IN_N),
      .rxp                       (GE_PHY_B_QSGMII1_OUT_P),
      .rxn                       (GE_PHY_B_QSGMII1_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_3_clk125),   
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m), 
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (line_6_left_sgmii_clk_en),
      .gmii_txd_ch0              (line_6_left_gmii_txd  ),
      .gmii_tx_en_ch0            (line_6_left_gmii_tx_en),
      .gmii_tx_er_ch0            (line_6_left_gmii_tx_er),
      .gmii_rxd_ch0              (line_6_left_gmii_rxd  ),
      .gmii_rx_dv_ch0            (line_6_left_gmii_rx_dv),
      .gmii_rx_er_ch0            (line_6_left_gmii_rx_er),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_3_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_3_speed_is_100_ch0),
      .status_vector_ch0         (qs3_status_vector_ch0),
      .sgmii_clk_en_ch1          (line_6_right_sgmii_clk_en),
      .gmii_txd_ch1              (line_6_right_gmii_txd  ),
      .gmii_tx_en_ch1            (line_6_right_gmii_tx_en),
      .gmii_tx_er_ch1            (line_6_right_gmii_tx_er),
      .gmii_rxd_ch1              (line_6_right_gmii_rxd  ),
      .gmii_rx_dv_ch1            (line_6_right_gmii_rx_dv),
      .gmii_rx_er_ch1            (line_6_right_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_3_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_3_speed_is_100_ch1),
      .status_vector_ch1         (qs3_status_vector_ch1),
      .sgmii_clk_en_ch2          (line_7_left_sgmii_clk_en),
      .gmii_txd_ch2              (line_7_left_gmii_txd  ),
      .gmii_tx_en_ch2            (line_7_left_gmii_tx_en),
      .gmii_tx_er_ch2            (line_7_left_gmii_tx_er),
      .gmii_rxd_ch2              (line_7_left_gmii_rxd  ),
      .gmii_rx_dv_ch2            (line_7_left_gmii_rx_dv),
      .gmii_rx_er_ch2            (line_7_left_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_3_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_3_speed_is_100_ch2),
      .status_vector_ch2         (qs3_status_vector_ch2),
      .sgmii_clk_en_ch3          (line_7_right_sgmii_clk_en),
      .gmii_txd_ch3              (line_7_right_gmii_txd  ),
      .gmii_tx_en_ch3            (line_7_right_gmii_tx_en),
      .gmii_tx_er_ch3            (line_7_right_gmii_tx_er),
      .gmii_rxd_ch3              (line_7_right_gmii_rxd  ),
      .gmii_rx_dv_ch3            (line_7_right_gmii_rx_dv),
      .gmii_rx_er_ch3            (line_7_right_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_3_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_3_speed_is_100_ch3),
      .status_vector_ch3         (qs3_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs3_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );

  qsgmii_1218_support qs_4_PHY_C_0(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),
	    .common_qplloutclk         (common_qplloutclk_bc),
	    .common_qplloutrefclk      (common_qplloutrefclk_bc),
      .gtrefclk_out              (),
      .txp                       (GE_PHY_C_QSGMII0_IN_P),
      .txn                       (GE_PHY_C_QSGMII0_IN_N),
      .rxp                       (GE_PHY_C_QSGMII0_OUT_P),
      .rxn                       (GE_PHY_C_QSGMII0_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_4_clk125),   
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m), 
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (line_12_left_sgmii_clk_en),
      .gmii_txd_ch0              (line_12_left_gmii_txd  ),
      .gmii_tx_en_ch0            (line_12_left_gmii_tx_en),
      .gmii_tx_er_ch0            (line_12_left_gmii_tx_er),
      .gmii_rxd_ch0              (line_12_left_gmii_rxd  ),
      .gmii_rx_dv_ch0            (line_12_left_gmii_rx_dv),
      .gmii_rx_er_ch0            (line_12_left_gmii_rx_er),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_4_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_4_speed_is_100_ch0),
      .status_vector_ch0         (qs4_status_vector_ch0),
      .sgmii_clk_en_ch1          (line_12_right_sgmii_clk_en),
      .gmii_txd_ch1              (line_12_right_gmii_txd  ),
      .gmii_tx_en_ch1            (line_12_right_gmii_tx_en),
      .gmii_tx_er_ch1            (line_12_right_gmii_tx_er),
      .gmii_rxd_ch1              (line_12_right_gmii_rxd  ),
      .gmii_rx_dv_ch1            (line_12_right_gmii_rx_dv),
      .gmii_rx_er_ch1            (line_12_right_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_4_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_4_speed_is_100_ch1),
      .status_vector_ch1         (qs4_status_vector_ch1),
      .sgmii_clk_en_ch2          (line_9_left_sgmii_clk_en),
      .gmii_txd_ch2              (line_9_left_gmii_txd  ),
      .gmii_tx_en_ch2            (line_9_left_gmii_tx_en),
      .gmii_tx_er_ch2            (line_9_left_gmii_tx_er),
      .gmii_rxd_ch2              (line_9_left_gmii_rxd  ),
      .gmii_rx_dv_ch2            (line_9_left_gmii_rx_dv),
      .gmii_rx_er_ch2            (line_9_left_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_4_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_4_speed_is_100_ch2),
      .status_vector_ch2         (qs4_status_vector_ch2),
      .sgmii_clk_en_ch3          (line_9_right_sgmii_clk_en),
      .gmii_txd_ch3              (line_9_right_gmii_txd  ),
      .gmii_tx_en_ch3            (line_9_right_gmii_tx_en),
      .gmii_tx_er_ch3            (line_9_right_gmii_tx_er),
      .gmii_rxd_ch3              (line_9_right_gmii_rxd  ),
      .gmii_rx_dv_ch3            (line_9_right_gmii_rx_dv),
      .gmii_rx_er_ch3            (line_9_right_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_4_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_4_speed_is_100_ch3),
      .status_vector_ch3         (qs4_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs4_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );
      
  qsgmii_1218_support qs_5_PHY_C_1(
      .reset                     (reset),
	    .gtrefclk                  (gtrefclk),
	    .common_qplloutclk         (common_qplloutclk_bc),
	    .common_qplloutrefclk      (common_qplloutrefclk_bc),
      .gtrefclk_out              (),
      .txp                       (GE_PHY_C_QSGMII1_IN_P),
      .txn                       (GE_PHY_C_QSGMII1_IN_N),
      .rxp                       (GE_PHY_C_QSGMII1_OUT_P),
      .rxn                       (GE_PHY_C_QSGMII1_OUT_N),
      .userclk_out               (),
      .userclk2_out              (qs_5_clk125), 
      .rxuserclk_out             (),
      .rxuserclk2_out            (),
      .independent_clock_bufg    (clk_200m), 
      .pma_reset_out             (),
      .mmcm_locked_out           (),
      .sgmii_clk_en_ch0          (line_10_left_sgmii_clk_en),
      .gmii_txd_ch0              (line_10_left_gmii_txd  ),
      .gmii_tx_en_ch0            (line_10_left_gmii_tx_en),
      .gmii_tx_er_ch0            (line_10_left_gmii_tx_er),
      .gmii_rxd_ch0              (line_10_left_gmii_rxd  ),
      .gmii_rx_dv_ch0            (line_10_left_gmii_rx_dv),
      .gmii_rx_er_ch0            (line_10_left_gmii_rx_er),
      .configuration_vector_ch0  (configuration_vector),
      .an_interrupt_ch0          (),
      .an_adv_config_vector_ch0  (an_adv_config_vector),
      .an_restart_config_ch0     (an_restart_config),      
      .speed_is_10_100_ch0       (qs_5_speed_is_10_100_ch0),
      .speed_is_100_ch0          (qs_5_speed_is_100_ch0),
      .status_vector_ch0         (qs5_status_vector_ch0),
      .sgmii_clk_en_ch1          (line_10_right_sgmii_clk_en),
      .gmii_txd_ch1              (line_10_right_gmii_txd  ),
      .gmii_tx_en_ch1            (line_10_right_gmii_tx_en),
      .gmii_tx_er_ch1            (line_10_right_gmii_tx_er),
      .gmii_rxd_ch1              (line_10_right_gmii_rxd  ),
      .gmii_rx_dv_ch1            (line_10_right_gmii_rx_dv),
      .gmii_rx_er_ch1            (line_10_right_gmii_rx_er),
      .configuration_vector_ch1  (configuration_vector),
      .an_interrupt_ch1          (),
      .an_adv_config_vector_ch1  (an_adv_config_vector),
      .an_restart_config_ch1     (an_restart_config),      
      .speed_is_10_100_ch1       (qs_5_speed_is_10_100_ch1),
      .speed_is_100_ch1          (qs_5_speed_is_100_ch1),
      .status_vector_ch1         (qs5_status_vector_ch1),
      .sgmii_clk_en_ch2          (line_11_left_sgmii_clk_en),
      .gmii_txd_ch2              (line_11_left_gmii_txd  ),
      .gmii_tx_en_ch2            (line_11_left_gmii_tx_en),
      .gmii_tx_er_ch2            (line_11_left_gmii_tx_er),
      .gmii_rxd_ch2              (line_11_left_gmii_rxd  ),
      .gmii_rx_dv_ch2            (line_11_left_gmii_rx_dv),
      .gmii_rx_er_ch2            (line_11_left_gmii_rx_er),
      .configuration_vector_ch2  (configuration_vector),
      .an_interrupt_ch2          (),
      .an_adv_config_vector_ch2  (an_adv_config_vector),
      .an_restart_config_ch2     (an_restart_config),      
      .speed_is_10_100_ch2       (qs_5_speed_is_10_100_ch2),
      .speed_is_100_ch2          (qs_5_speed_is_100_ch2),
      .status_vector_ch2         (qs5_status_vector_ch2),
      .sgmii_clk_en_ch3          (line_11_right_sgmii_clk_en),
      .gmii_txd_ch3              (line_11_right_gmii_txd  ),
      .gmii_tx_en_ch3            (line_11_right_gmii_tx_en),
      .gmii_tx_er_ch3            (line_11_right_gmii_tx_er),
      .gmii_rxd_ch3              (line_11_right_gmii_rxd  ),
      .gmii_rx_dv_ch3            (line_11_right_gmii_rx_dv),
      .gmii_rx_er_ch3            (line_11_right_gmii_rx_er),
      .configuration_vector_ch3  (configuration_vector),
      .an_interrupt_ch3          (),
      .an_adv_config_vector_ch3  (an_adv_config_vector),
      .an_restart_config_ch3     (an_restart_config),      
      .speed_is_10_100_ch3       (qs_5_speed_is_10_100_ch3),
      .speed_is_100_ch3          (qs_5_speed_is_100_ch3),
      .status_vector_ch3         (qs5_status_vector_ch3),
      .gt0_gttxreset_in          (1'b0),
      .gt0_txpmareset_in         (1'b0),
      .gt0_txpcsreset_in         (1'b0),
      .gt0_rxchariscomma_out     (),
      .gt0_rxcharisk_out         (),
      .gt0_rxbyteisaligned_out   (),
      .gt0_rxbyterealign_out     (),
      .gt0_rxcommadet_out        (),
      .gt0_txpolarity_in         (1'b0),
      .gt0_txdiffctrl_in         (4'b1000),
      .gt0_txpostcursor_in       (5'b00000),
      .gt0_txprecursor_in        (5'b00000),
      .gt0_rxpolarity_in         (1'b0),
      .gt0_txinhibit_in          (1'b0),
      .gt0_rxdfelpmreset_in      (1'b0),
      .gt0_rxdfeagcovrden_in     (1'b0),
      .gt0_rxlpmen_in            (1'b1),
      .gt0_txprbssel_in          (3'b000),
      .gt0_txprbsforceerr_in     (1'b0),
      .gt0_rxprbscntreset_in     (1'b0),
      .gt0_rxprbserr_out         (),
      .gt0_rxprbssel_in          (3'b000),
      .gt0_loopback_in           (3'b000),
      .gt0_txresetdone_out       (),
      .gt0_rxresetdone_out       (),
      .gt0_gtrxreset_in          (1'b0),
      .gt0_rxpmareset_in         (1'b0),
      .gt0_rxpcsreset_in         (1'b0),
      .gt0_txbufstatus_out       (),
      .gt0_rxbufstatus_out       (),
      .gt0_rxbufreset_in         (1'b0),
      .gt0_cplllock_out          (qs5_gt0_cplllock_out),
      .gt0_rxpmaresetdone_out    (),
      .gt0_drpaddr_in            (9'b0),
      .gt0_drpclk_in             (clk_50m),
      .gt0_drpdi_in              (16'b0),
      .gt0_drpdo_out             (),
      .gt0_drpen_in              (1'b0),
      .gt0_drprdy_out            (),
      .gt0_drpwe_in              (1'b0),
      .gt0_rxdisperr_out         (),
      .gt0_rxnotintable_out      (),
      .gt0_eyescanreset_in       (1'b0),
      .gt0_eyescandataerror_out  (),
      .gt0_eyescantrigger_in     (1'b0),
      .gt0_rxrate_in             (3'b000),
      .gt0_rxcdrhold_in          (1'b0),
      .gt0_rxratedone_out        (),
      .gt0_dmonitorout_out       (),
      .gt0_rxmonitorout_out      (),
      .gt0_rxmonitorsel_in       (2'b00),
      .gt0_qplloutclk_out        (),
      .gt0_qplloutrefclk_out     (),
      .signal_detect             (signal_detect)
      );

  qsgmii_ip_cfg qsgmii_configure(
      .qs_0_status_speed_in_ch0    (qs0_status_vector_ch0[11:10]),
      .qs_0_status_speed_in_ch1    (qs0_status_vector_ch1[11:10]),
      .qs_0_status_speed_in_ch2    (qs0_status_vector_ch2[11:10]),
      .qs_0_status_speed_in_ch3    (qs0_status_vector_ch3[11:10]),
      .qs_1_status_speed_in_ch0    (qs1_status_vector_ch0[11:10]),
      .qs_1_status_speed_in_ch1    (qs1_status_vector_ch1[11:10]),
      .qs_1_status_speed_in_ch2    (qs1_status_vector_ch2[11:10]),
      .qs_1_status_speed_in_ch3    (qs1_status_vector_ch3[11:10]),
      .qs_2_status_speed_in_ch0    (qs2_status_vector_ch0[11:10]),
      .qs_2_status_speed_in_ch1    (qs2_status_vector_ch1[11:10]),
      .qs_2_status_speed_in_ch2    (qs2_status_vector_ch2[11:10]),
      .qs_2_status_speed_in_ch3    (qs2_status_vector_ch3[11:10]),
      .qs_3_status_speed_in_ch0    (qs3_status_vector_ch0[11:10]),  
      .qs_3_status_speed_in_ch1    (qs3_status_vector_ch1[11:10]),  
      .qs_3_status_speed_in_ch2    (qs3_status_vector_ch2[11:10]),  
      .qs_3_status_speed_in_ch3    (qs3_status_vector_ch3[11:10]),  
      .qs_4_status_speed_in_ch0    (qs4_status_vector_ch0[11:10]),  
      .qs_4_status_speed_in_ch1    (qs4_status_vector_ch1[11:10]),  
      .qs_4_status_speed_in_ch2    (qs4_status_vector_ch2[11:10]),  
      .qs_4_status_speed_in_ch3    (qs4_status_vector_ch3[11:10]),  
      .qs_5_status_speed_in_ch0    (qs5_status_vector_ch0[11:10]),  
      .qs_5_status_speed_in_ch1    (qs5_status_vector_ch1[11:10]),  
      .qs_5_status_speed_in_ch2    (qs5_status_vector_ch2[11:10]),  
      .qs_5_status_speed_in_ch3    (qs5_status_vector_ch3[11:10]),
      .configuration_vector        (configuration_vector),
      .an_adv_config_vector        (an_adv_config_vector),
      .an_restart_config           (an_restart_config),   
      .signal_detect               (signal_detect),  
      .qs_0_speed_is_10_100_ch0    (qs_0_speed_is_10_100_ch0),     
      .qs_0_speed_is_100_ch0       (qs_0_speed_is_100_ch0), 
      .qs_0_speed_is_10_100_ch1    (qs_0_speed_is_10_100_ch1),     
      .qs_0_speed_is_100_ch1       (qs_0_speed_is_100_ch1), 
      .qs_0_speed_is_10_100_ch2    (qs_0_speed_is_10_100_ch2),     
      .qs_0_speed_is_100_ch2       (qs_0_speed_is_100_ch2),   
      .qs_0_speed_is_10_100_ch3    (qs_0_speed_is_10_100_ch3),     
      .qs_0_speed_is_100_ch3       (qs_0_speed_is_100_ch3),   
      .qs_1_speed_is_10_100_ch0    (qs_1_speed_is_10_100_ch0),     
      .qs_1_speed_is_100_ch0       (qs_1_speed_is_100_ch0), 
      .qs_1_speed_is_10_100_ch1    (qs_1_speed_is_10_100_ch1),     
      .qs_1_speed_is_100_ch1       (qs_1_speed_is_100_ch1), 
      .qs_1_speed_is_10_100_ch2    (qs_1_speed_is_10_100_ch2),     
      .qs_1_speed_is_100_ch2       (qs_1_speed_is_100_ch2),   
      .qs_1_speed_is_10_100_ch3    (qs_1_speed_is_10_100_ch3),     
      .qs_1_speed_is_100_ch3       (qs_1_speed_is_100_ch3),    
      .qs_2_speed_is_10_100_ch0    (qs_2_speed_is_10_100_ch0),     
      .qs_2_speed_is_100_ch0       (qs_2_speed_is_100_ch0), 
      .qs_2_speed_is_10_100_ch1    (qs_2_speed_is_10_100_ch1),     
      .qs_2_speed_is_100_ch1       (qs_2_speed_is_100_ch1), 
      .qs_2_speed_is_10_100_ch2    (qs_2_speed_is_10_100_ch2),     
      .qs_2_speed_is_100_ch2       (qs_2_speed_is_100_ch2),   
      .qs_2_speed_is_10_100_ch3    (qs_2_speed_is_10_100_ch3),     
      .qs_2_speed_is_100_ch3       (qs_2_speed_is_100_ch3),    
      .qs_3_speed_is_10_100_ch0    (qs_3_speed_is_10_100_ch0),     
      .qs_3_speed_is_100_ch0       (qs_3_speed_is_100_ch0), 
      .qs_3_speed_is_10_100_ch1    (qs_3_speed_is_10_100_ch1),     
      .qs_3_speed_is_100_ch1       (qs_3_speed_is_100_ch1), 
      .qs_3_speed_is_10_100_ch2    (qs_3_speed_is_10_100_ch2),     
      .qs_3_speed_is_100_ch2       (qs_3_speed_is_100_ch2),   
      .qs_3_speed_is_10_100_ch3    (qs_3_speed_is_10_100_ch3),     
      .qs_3_speed_is_100_ch3       (qs_3_speed_is_100_ch3),     
      .qs_4_speed_is_10_100_ch0    (qs_4_speed_is_10_100_ch0),     
      .qs_4_speed_is_100_ch0       (qs_4_speed_is_100_ch0), 
      .qs_4_speed_is_10_100_ch1    (qs_4_speed_is_10_100_ch1),     
      .qs_4_speed_is_100_ch1       (qs_4_speed_is_100_ch1), 
      .qs_4_speed_is_10_100_ch2    (qs_4_speed_is_10_100_ch2),     
      .qs_4_speed_is_100_ch2       (qs_4_speed_is_100_ch2),   
      .qs_4_speed_is_10_100_ch3    (qs_4_speed_is_10_100_ch3),     
      .qs_4_speed_is_100_ch3       (qs_4_speed_is_100_ch3),   
      .qs_5_speed_is_10_100_ch0    (qs_5_speed_is_10_100_ch0),     
      .qs_5_speed_is_100_ch0       (qs_5_speed_is_100_ch0), 
      .qs_5_speed_is_10_100_ch1    (qs_5_speed_is_10_100_ch1),     
      .qs_5_speed_is_100_ch1       (qs_5_speed_is_100_ch1), 
      .qs_5_speed_is_10_100_ch2    (qs_5_speed_is_10_100_ch2),     
      .qs_5_speed_is_100_ch2       (qs_5_speed_is_100_ch2),   
      .qs_5_speed_is_10_100_ch3    (qs_5_speed_is_10_100_ch3),     
      .qs_5_speed_is_100_ch3       (qs_5_speed_is_100_ch3)
  );

eth_switch_core switch_mult_queue (
.  clk      (qs_0_clk125)         ,                //125MHz clock
.reset      (qs_0_line_reset_2d)        ,             
.port1_gmii_txd     (port1_gmii_txd    ) ,            //输出的数据
.port1_gmii_tx_en   (port1_gmii_tx_en  ) ,  
.port1_gmii_tx_er   (port1_gmii_tx_er  ) ,  
.port1_gmii_rxd     (port1_gmii_rxd    ) ,            //收到的数据   
.port1_gmii_rx_dv   (port1_gmii_rx_dv  ) , 
.port1_gmii_rx_er   (port1_gmii_rx_er  ) , 
.port1_sgmii_clk_en (port1_sgmii_clk_en) ,
.port2_gmii_txd     (port2_gmii_txd    ) ,    
.port2_gmii_tx_en   (port2_gmii_tx_en  ) ,  
.port2_gmii_tx_er   (port2_gmii_tx_er  ) ,  
.port2_gmii_rxd     (port2_gmii_rxd    ) ,    
.port2_gmii_rx_dv   (port2_gmii_rx_dv  ) , 
.port2_gmii_rx_er   (port2_gmii_rx_er  ) , 
.port2_sgmii_clk_en (port2_sgmii_clk_en) ,
.port3_sgmii_clk_en (port3_sgmii_clk_en) ,
.port3_gmii_txd     (port3_gmii_txd    ) ,    
.port3_gmii_tx_en   (port3_gmii_tx_en  ) ,  
.port3_gmii_tx_er   (port3_gmii_tx_er  ) ,  
.port3_gmii_rxd     (port3_gmii_rxd    ) ,    
.port3_gmii_rx_dv   (port3_gmii_rx_dv  ) , 
.port3_gmii_rx_er   (port3_gmii_rx_er  ) , 
.port4_gmii_txd     (port4_gmii_txd    ) ,    
.port4_gmii_tx_en   (port4_gmii_tx_en  ) ,  
.port4_gmii_tx_er   (port4_gmii_tx_er  ) ,  
.port4_gmii_rxd     (port4_gmii_rxd    ) ,    
.port4_gmii_rx_dv   (port4_gmii_rx_dv  ) , 
.port4_gmii_rx_er   (port4_gmii_rx_er  ) , 
.port4_sgmii_clk_en (port4_sgmii_clk_en) 


);
  

endmodule

