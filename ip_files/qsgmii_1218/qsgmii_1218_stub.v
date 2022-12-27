// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Dec 22 10:17:35 2020
// Host        : Belen running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Belen/Desktop/eth_rx_tx/ip_files/qsgmii_1218/qsgmii_1218_stub.v
// Design      : qsgmii_1218
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "quadsgmii_v3_4_4,Vivado 2018.2" *)
module qsgmii_1218(reset, gtrefclk, txp, txn, rxp, rxn, txoutclk, 
  rxoutclk, resetdone, userclk, userclk2, rxuserclk, rxuserclk2, independent_clock_bufg, 
  pma_reset, mmcm_locked, sgmii_clk_en_ch0, gmii_txd_ch0, gmii_tx_en_ch0, gmii_tx_er_ch0, 
  gmii_rxd_ch0, gmii_rx_dv_ch0, gmii_rx_er_ch0, configuration_vector_ch0, an_interrupt_ch0, 
  an_adv_config_vector_ch0, an_restart_config_ch0, speed_is_10_100_ch0, speed_is_100_ch0, 
  status_vector_ch0, sgmii_clk_en_ch1, gmii_txd_ch1, gmii_tx_en_ch1, gmii_tx_er_ch1, 
  gmii_rxd_ch1, gmii_rx_dv_ch1, gmii_rx_er_ch1, configuration_vector_ch1, an_interrupt_ch1, 
  an_adv_config_vector_ch1, an_restart_config_ch1, speed_is_10_100_ch1, speed_is_100_ch1, 
  status_vector_ch1, sgmii_clk_en_ch2, gmii_txd_ch2, gmii_tx_en_ch2, gmii_tx_er_ch2, 
  gmii_rxd_ch2, gmii_rx_dv_ch2, gmii_rx_er_ch2, configuration_vector_ch2, an_interrupt_ch2, 
  an_adv_config_vector_ch2, an_restart_config_ch2, speed_is_10_100_ch2, speed_is_100_ch2, 
  status_vector_ch2, sgmii_clk_en_ch3, gmii_txd_ch3, gmii_tx_en_ch3, gmii_tx_er_ch3, 
  gmii_rxd_ch3, gmii_rx_dv_ch3, gmii_rx_er_ch3, configuration_vector_ch3, an_interrupt_ch3, 
  an_adv_config_vector_ch3, an_restart_config_ch3, speed_is_10_100_ch3, speed_is_100_ch3, 
  status_vector_ch3, gt0_gttxreset_in, gt0_txpmareset_in, gt0_txpcsreset_in, 
  gt0_rxchariscomma_out, gt0_rxcharisk_out, gt0_rxbyteisaligned_out, 
  gt0_rxbyterealign_out, gt0_rxcommadet_out, gt0_txpolarity_in, gt0_txdiffctrl_in, 
  gt0_txpostcursor_in, gt0_txprecursor_in, gt0_rxpolarity_in, gt0_txinhibit_in, 
  gt0_rxdfelpmreset_in, gt0_rxdfeagcovrden_in, gt0_rxlpmen_in, gt0_txprbssel_in, 
  gt0_txprbsforceerr_in, gt0_rxprbscntreset_in, gt0_rxprbserr_out, gt0_rxprbssel_in, 
  gt0_loopback_in, gt0_txresetdone_out, gt0_rxresetdone_out, gt0_gtrxreset_in, 
  gt0_rxpmareset_in, gt0_rxpcsreset_in, gt0_txbufstatus_out, gt0_rxbufstatus_out, 
  gt0_rxbufreset_in, gt0_cplllock_out, gt0_rxpmaresetdone_out, gt0_drpaddr_in, 
  gt0_drpclk_in, gt0_drpdi_in, gt0_drpdo_out, gt0_drpen_in, gt0_drprdy_out, gt0_drpwe_in, 
  gt0_rxdisperr_out, gt0_rxnotintable_out, gt0_eyescanreset_in, gt0_eyescandataerror_out, 
  gt0_eyescantrigger_in, gt0_rxrate_in, gt0_rxcdrhold_in, gt0_rxratedone_out, 
  gt0_dmonitorout_out, gt0_rxmonitorout_out, gt0_rxmonitorsel_in, gt0_qplloutclk_in, 
  gt0_qplloutrefclk_in, signal_detect)
/* synthesis syn_black_box black_box_pad_pin="reset,gtrefclk,txp,txn,rxp,rxn,txoutclk,rxoutclk,resetdone,userclk,userclk2,rxuserclk,rxuserclk2,independent_clock_bufg,pma_reset,mmcm_locked,sgmii_clk_en_ch0,gmii_txd_ch0[7:0],gmii_tx_en_ch0,gmii_tx_er_ch0,gmii_rxd_ch0[7:0],gmii_rx_dv_ch0,gmii_rx_er_ch0,configuration_vector_ch0[5:0],an_interrupt_ch0,an_adv_config_vector_ch0[15:0],an_restart_config_ch0,speed_is_10_100_ch0,speed_is_100_ch0,status_vector_ch0[15:0],sgmii_clk_en_ch1,gmii_txd_ch1[7:0],gmii_tx_en_ch1,gmii_tx_er_ch1,gmii_rxd_ch1[7:0],gmii_rx_dv_ch1,gmii_rx_er_ch1,configuration_vector_ch1[5:0],an_interrupt_ch1,an_adv_config_vector_ch1[15:0],an_restart_config_ch1,speed_is_10_100_ch1,speed_is_100_ch1,status_vector_ch1[15:0],sgmii_clk_en_ch2,gmii_txd_ch2[7:0],gmii_tx_en_ch2,gmii_tx_er_ch2,gmii_rxd_ch2[7:0],gmii_rx_dv_ch2,gmii_rx_er_ch2,configuration_vector_ch2[5:0],an_interrupt_ch2,an_adv_config_vector_ch2[15:0],an_restart_config_ch2,speed_is_10_100_ch2,speed_is_100_ch2,status_vector_ch2[15:0],sgmii_clk_en_ch3,gmii_txd_ch3[7:0],gmii_tx_en_ch3,gmii_tx_er_ch3,gmii_rxd_ch3[7:0],gmii_rx_dv_ch3,gmii_rx_er_ch3,configuration_vector_ch3[5:0],an_interrupt_ch3,an_adv_config_vector_ch3[15:0],an_restart_config_ch3,speed_is_10_100_ch3,speed_is_100_ch3,status_vector_ch3[15:0],gt0_gttxreset_in,gt0_txpmareset_in,gt0_txpcsreset_in,gt0_rxchariscomma_out[3:0],gt0_rxcharisk_out[3:0],gt0_rxbyteisaligned_out,gt0_rxbyterealign_out,gt0_rxcommadet_out,gt0_txpolarity_in,gt0_txdiffctrl_in[3:0],gt0_txpostcursor_in[4:0],gt0_txprecursor_in[4:0],gt0_rxpolarity_in,gt0_txinhibit_in,gt0_rxdfelpmreset_in,gt0_rxdfeagcovrden_in,gt0_rxlpmen_in,gt0_txprbssel_in[2:0],gt0_txprbsforceerr_in,gt0_rxprbscntreset_in,gt0_rxprbserr_out,gt0_rxprbssel_in[2:0],gt0_loopback_in[2:0],gt0_txresetdone_out,gt0_rxresetdone_out,gt0_gtrxreset_in,gt0_rxpmareset_in,gt0_rxpcsreset_in,gt0_txbufstatus_out[1:0],gt0_rxbufstatus_out[2:0],gt0_rxbufreset_in,gt0_cplllock_out,gt0_rxpmaresetdone_out,gt0_drpaddr_in[8:0],gt0_drpclk_in,gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_rxdisperr_out[3:0],gt0_rxnotintable_out[3:0],gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxrate_in[2:0],gt0_rxcdrhold_in,gt0_rxratedone_out,gt0_dmonitorout_out[7:0],gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_qplloutclk_in,gt0_qplloutrefclk_in,signal_detect" */;
  input reset;
  input gtrefclk;
  output txp;
  output txn;
  input rxp;
  input rxn;
  output txoutclk;
  output rxoutclk;
  output resetdone;
  input userclk;
  input userclk2;
  input rxuserclk;
  input rxuserclk2;
  input independent_clock_bufg;
  input pma_reset;
  input mmcm_locked;
  output sgmii_clk_en_ch0;
  input [7:0]gmii_txd_ch0;
  input gmii_tx_en_ch0;
  input gmii_tx_er_ch0;
  output [7:0]gmii_rxd_ch0;
  output gmii_rx_dv_ch0;
  output gmii_rx_er_ch0;
  input [5:0]configuration_vector_ch0;
  output an_interrupt_ch0;
  input [15:0]an_adv_config_vector_ch0;
  input an_restart_config_ch0;
  input speed_is_10_100_ch0;
  input speed_is_100_ch0;
  output [15:0]status_vector_ch0;
  output sgmii_clk_en_ch1;
  input [7:0]gmii_txd_ch1;
  input gmii_tx_en_ch1;
  input gmii_tx_er_ch1;
  output [7:0]gmii_rxd_ch1;
  output gmii_rx_dv_ch1;
  output gmii_rx_er_ch1;
  input [5:0]configuration_vector_ch1;
  output an_interrupt_ch1;
  input [15:0]an_adv_config_vector_ch1;
  input an_restart_config_ch1;
  input speed_is_10_100_ch1;
  input speed_is_100_ch1;
  output [15:0]status_vector_ch1;
  output sgmii_clk_en_ch2;
  input [7:0]gmii_txd_ch2;
  input gmii_tx_en_ch2;
  input gmii_tx_er_ch2;
  output [7:0]gmii_rxd_ch2;
  output gmii_rx_dv_ch2;
  output gmii_rx_er_ch2;
  input [5:0]configuration_vector_ch2;
  output an_interrupt_ch2;
  input [15:0]an_adv_config_vector_ch2;
  input an_restart_config_ch2;
  input speed_is_10_100_ch2;
  input speed_is_100_ch2;
  output [15:0]status_vector_ch2;
  output sgmii_clk_en_ch3;
  input [7:0]gmii_txd_ch3;
  input gmii_tx_en_ch3;
  input gmii_tx_er_ch3;
  output [7:0]gmii_rxd_ch3;
  output gmii_rx_dv_ch3;
  output gmii_rx_er_ch3;
  input [5:0]configuration_vector_ch3;
  output an_interrupt_ch3;
  input [15:0]an_adv_config_vector_ch3;
  input an_restart_config_ch3;
  input speed_is_10_100_ch3;
  input speed_is_100_ch3;
  output [15:0]status_vector_ch3;
  input gt0_gttxreset_in;
  input gt0_txpmareset_in;
  input gt0_txpcsreset_in;
  output [3:0]gt0_rxchariscomma_out;
  output [3:0]gt0_rxcharisk_out;
  output gt0_rxbyteisaligned_out;
  output gt0_rxbyterealign_out;
  output gt0_rxcommadet_out;
  input gt0_txpolarity_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input gt0_rxpolarity_in;
  input gt0_txinhibit_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxdfeagcovrden_in;
  input gt0_rxlpmen_in;
  input [2:0]gt0_txprbssel_in;
  input gt0_txprbsforceerr_in;
  input gt0_rxprbscntreset_in;
  output gt0_rxprbserr_out;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_loopback_in;
  output gt0_txresetdone_out;
  output gt0_rxresetdone_out;
  input gt0_gtrxreset_in;
  input gt0_rxpmareset_in;
  input gt0_rxpcsreset_in;
  output [1:0]gt0_txbufstatus_out;
  output [2:0]gt0_rxbufstatus_out;
  input gt0_rxbufreset_in;
  output gt0_cplllock_out;
  output gt0_rxpmaresetdone_out;
  input [8:0]gt0_drpaddr_in;
  input gt0_drpclk_in;
  input [15:0]gt0_drpdi_in;
  output [15:0]gt0_drpdo_out;
  input gt0_drpen_in;
  output gt0_drprdy_out;
  input gt0_drpwe_in;
  output [3:0]gt0_rxdisperr_out;
  output [3:0]gt0_rxnotintable_out;
  input gt0_eyescanreset_in;
  output gt0_eyescandataerror_out;
  input gt0_eyescantrigger_in;
  input [2:0]gt0_rxrate_in;
  input gt0_rxcdrhold_in;
  output gt0_rxratedone_out;
  output [7:0]gt0_dmonitorout_out;
  output [6:0]gt0_rxmonitorout_out;
  input [1:0]gt0_rxmonitorsel_in;
  input gt0_qplloutclk_in;
  input gt0_qplloutrefclk_in;
  input signal_detect;
endmodule
