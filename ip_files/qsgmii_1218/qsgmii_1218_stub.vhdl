-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Tue Dec 22 10:17:35 2020
-- Host        : Belen running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/Belen/Desktop/eth_rx_tx/ip_files/qsgmii_1218/qsgmii_1218_stub.vhdl
-- Design      : qsgmii_1218
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity qsgmii_1218 is
  Port ( 
    reset : in STD_LOGIC;
    gtrefclk : in STD_LOGIC;
    txp : out STD_LOGIC;
    txn : out STD_LOGIC;
    rxp : in STD_LOGIC;
    rxn : in STD_LOGIC;
    txoutclk : out STD_LOGIC;
    rxoutclk : out STD_LOGIC;
    resetdone : out STD_LOGIC;
    userclk : in STD_LOGIC;
    userclk2 : in STD_LOGIC;
    rxuserclk : in STD_LOGIC;
    rxuserclk2 : in STD_LOGIC;
    independent_clock_bufg : in STD_LOGIC;
    pma_reset : in STD_LOGIC;
    mmcm_locked : in STD_LOGIC;
    sgmii_clk_en_ch0 : out STD_LOGIC;
    gmii_txd_ch0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en_ch0 : in STD_LOGIC;
    gmii_tx_er_ch0 : in STD_LOGIC;
    gmii_rxd_ch0 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv_ch0 : out STD_LOGIC;
    gmii_rx_er_ch0 : out STD_LOGIC;
    configuration_vector_ch0 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    an_interrupt_ch0 : out STD_LOGIC;
    an_adv_config_vector_ch0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config_ch0 : in STD_LOGIC;
    speed_is_10_100_ch0 : in STD_LOGIC;
    speed_is_100_ch0 : in STD_LOGIC;
    status_vector_ch0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sgmii_clk_en_ch1 : out STD_LOGIC;
    gmii_txd_ch1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en_ch1 : in STD_LOGIC;
    gmii_tx_er_ch1 : in STD_LOGIC;
    gmii_rxd_ch1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv_ch1 : out STD_LOGIC;
    gmii_rx_er_ch1 : out STD_LOGIC;
    configuration_vector_ch1 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    an_interrupt_ch1 : out STD_LOGIC;
    an_adv_config_vector_ch1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config_ch1 : in STD_LOGIC;
    speed_is_10_100_ch1 : in STD_LOGIC;
    speed_is_100_ch1 : in STD_LOGIC;
    status_vector_ch1 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sgmii_clk_en_ch2 : out STD_LOGIC;
    gmii_txd_ch2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en_ch2 : in STD_LOGIC;
    gmii_tx_er_ch2 : in STD_LOGIC;
    gmii_rxd_ch2 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv_ch2 : out STD_LOGIC;
    gmii_rx_er_ch2 : out STD_LOGIC;
    configuration_vector_ch2 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    an_interrupt_ch2 : out STD_LOGIC;
    an_adv_config_vector_ch2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config_ch2 : in STD_LOGIC;
    speed_is_10_100_ch2 : in STD_LOGIC;
    speed_is_100_ch2 : in STD_LOGIC;
    status_vector_ch2 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sgmii_clk_en_ch3 : out STD_LOGIC;
    gmii_txd_ch3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_tx_en_ch3 : in STD_LOGIC;
    gmii_tx_er_ch3 : in STD_LOGIC;
    gmii_rxd_ch3 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gmii_rx_dv_ch3 : out STD_LOGIC;
    gmii_rx_er_ch3 : out STD_LOGIC;
    configuration_vector_ch3 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    an_interrupt_ch3 : out STD_LOGIC;
    an_adv_config_vector_ch3 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    an_restart_config_ch3 : in STD_LOGIC;
    speed_is_10_100_ch3 : in STD_LOGIC;
    speed_is_100_ch3 : in STD_LOGIC;
    status_vector_ch3 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_gttxreset_in : in STD_LOGIC;
    gt0_txpmareset_in : in STD_LOGIC;
    gt0_txpcsreset_in : in STD_LOGIC;
    gt0_rxchariscomma_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxcharisk_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxbyteisaligned_out : out STD_LOGIC;
    gt0_rxbyterealign_out : out STD_LOGIC;
    gt0_rxcommadet_out : out STD_LOGIC;
    gt0_txpolarity_in : in STD_LOGIC;
    gt0_txdiffctrl_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_txpostcursor_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_txprecursor_in : in STD_LOGIC_VECTOR ( 4 downto 0 );
    gt0_rxpolarity_in : in STD_LOGIC;
    gt0_txinhibit_in : in STD_LOGIC;
    gt0_rxdfelpmreset_in : in STD_LOGIC;
    gt0_rxdfeagcovrden_in : in STD_LOGIC;
    gt0_rxlpmen_in : in STD_LOGIC;
    gt0_txprbssel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txprbsforceerr_in : in STD_LOGIC;
    gt0_rxprbscntreset_in : in STD_LOGIC;
    gt0_rxprbserr_out : out STD_LOGIC;
    gt0_rxprbssel_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_loopback_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txresetdone_out : out STD_LOGIC;
    gt0_rxresetdone_out : out STD_LOGIC;
    gt0_gtrxreset_in : in STD_LOGIC;
    gt0_rxpmareset_in : in STD_LOGIC;
    gt0_rxpcsreset_in : in STD_LOGIC;
    gt0_txbufstatus_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxbufstatus_out : out STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_rxbufreset_in : in STD_LOGIC;
    gt0_cplllock_out : out STD_LOGIC;
    gt0_rxpmaresetdone_out : out STD_LOGIC;
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpclk_in : in STD_LOGIC;
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_rxdisperr_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxnotintable_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_rxrate_in : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_rxcdrhold_in : in STD_LOGIC;
    gt0_rxratedone_out : out STD_LOGIC;
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_qplloutclk_in : in STD_LOGIC;
    gt0_qplloutrefclk_in : in STD_LOGIC;
    signal_detect : in STD_LOGIC
  );

end qsgmii_1218;

architecture stub of qsgmii_1218 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "reset,gtrefclk,txp,txn,rxp,rxn,txoutclk,rxoutclk,resetdone,userclk,userclk2,rxuserclk,rxuserclk2,independent_clock_bufg,pma_reset,mmcm_locked,sgmii_clk_en_ch0,gmii_txd_ch0[7:0],gmii_tx_en_ch0,gmii_tx_er_ch0,gmii_rxd_ch0[7:0],gmii_rx_dv_ch0,gmii_rx_er_ch0,configuration_vector_ch0[5:0],an_interrupt_ch0,an_adv_config_vector_ch0[15:0],an_restart_config_ch0,speed_is_10_100_ch0,speed_is_100_ch0,status_vector_ch0[15:0],sgmii_clk_en_ch1,gmii_txd_ch1[7:0],gmii_tx_en_ch1,gmii_tx_er_ch1,gmii_rxd_ch1[7:0],gmii_rx_dv_ch1,gmii_rx_er_ch1,configuration_vector_ch1[5:0],an_interrupt_ch1,an_adv_config_vector_ch1[15:0],an_restart_config_ch1,speed_is_10_100_ch1,speed_is_100_ch1,status_vector_ch1[15:0],sgmii_clk_en_ch2,gmii_txd_ch2[7:0],gmii_tx_en_ch2,gmii_tx_er_ch2,gmii_rxd_ch2[7:0],gmii_rx_dv_ch2,gmii_rx_er_ch2,configuration_vector_ch2[5:0],an_interrupt_ch2,an_adv_config_vector_ch2[15:0],an_restart_config_ch2,speed_is_10_100_ch2,speed_is_100_ch2,status_vector_ch2[15:0],sgmii_clk_en_ch3,gmii_txd_ch3[7:0],gmii_tx_en_ch3,gmii_tx_er_ch3,gmii_rxd_ch3[7:0],gmii_rx_dv_ch3,gmii_rx_er_ch3,configuration_vector_ch3[5:0],an_interrupt_ch3,an_adv_config_vector_ch3[15:0],an_restart_config_ch3,speed_is_10_100_ch3,speed_is_100_ch3,status_vector_ch3[15:0],gt0_gttxreset_in,gt0_txpmareset_in,gt0_txpcsreset_in,gt0_rxchariscomma_out[3:0],gt0_rxcharisk_out[3:0],gt0_rxbyteisaligned_out,gt0_rxbyterealign_out,gt0_rxcommadet_out,gt0_txpolarity_in,gt0_txdiffctrl_in[3:0],gt0_txpostcursor_in[4:0],gt0_txprecursor_in[4:0],gt0_rxpolarity_in,gt0_txinhibit_in,gt0_rxdfelpmreset_in,gt0_rxdfeagcovrden_in,gt0_rxlpmen_in,gt0_txprbssel_in[2:0],gt0_txprbsforceerr_in,gt0_rxprbscntreset_in,gt0_rxprbserr_out,gt0_rxprbssel_in[2:0],gt0_loopback_in[2:0],gt0_txresetdone_out,gt0_rxresetdone_out,gt0_gtrxreset_in,gt0_rxpmareset_in,gt0_rxpcsreset_in,gt0_txbufstatus_out[1:0],gt0_rxbufstatus_out[2:0],gt0_rxbufreset_in,gt0_cplllock_out,gt0_rxpmaresetdone_out,gt0_drpaddr_in[8:0],gt0_drpclk_in,gt0_drpdi_in[15:0],gt0_drpdo_out[15:0],gt0_drpen_in,gt0_drprdy_out,gt0_drpwe_in,gt0_rxdisperr_out[3:0],gt0_rxnotintable_out[3:0],gt0_eyescanreset_in,gt0_eyescandataerror_out,gt0_eyescantrigger_in,gt0_rxrate_in[2:0],gt0_rxcdrhold_in,gt0_rxratedone_out,gt0_dmonitorout_out[7:0],gt0_rxmonitorout_out[6:0],gt0_rxmonitorsel_in[1:0],gt0_qplloutclk_in,gt0_qplloutrefclk_in,signal_detect";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "quadsgmii_v3_4_4,Vivado 2018.2";
begin
end;
