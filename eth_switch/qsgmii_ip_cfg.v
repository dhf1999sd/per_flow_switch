//**********************************************************
//********bowen li******************************************
//********Wenrise*******************************************
//********Copy right, 11/19/2018****************************
//***The module is for configuration of 6 qsgmii ip core**** 

`timescale 1 ns / 100 ps

module qsgmii_ip_cfg(
 
  //AN status speed input
  qs_0_status_speed_in_ch0,
  qs_0_status_speed_in_ch1,
  qs_0_status_speed_in_ch2,
  qs_0_status_speed_in_ch3,
  qs_1_status_speed_in_ch0,
  qs_1_status_speed_in_ch1,
  qs_1_status_speed_in_ch2,
  qs_1_status_speed_in_ch3,
  qs_2_status_speed_in_ch0,
  qs_2_status_speed_in_ch1,
  qs_2_status_speed_in_ch2,
  qs_2_status_speed_in_ch3,
  qs_3_status_speed_in_ch0,  
  qs_3_status_speed_in_ch1,  
  qs_3_status_speed_in_ch2,  
  qs_3_status_speed_in_ch3,  
  qs_4_status_speed_in_ch0,  
  qs_4_status_speed_in_ch1,  
  qs_4_status_speed_in_ch2,  
  qs_4_status_speed_in_ch3,  
  qs_5_status_speed_in_ch0,  
  qs_5_status_speed_in_ch1,  
  qs_5_status_speed_in_ch2,  
  qs_5_status_speed_in_ch3,  
       
  // qsgmii ip general configuration parameters                
  configuration_vector,
  an_adv_config_vector,
  an_restart_config,   
  signal_detect,  
  
  // qsgmii ip 0 speed configuration  
  qs_0_speed_is_10_100_ch0,     
  qs_0_speed_is_100_ch0, 
  qs_0_speed_is_10_100_ch1,     
  qs_0_speed_is_100_ch1, 
  qs_0_speed_is_10_100_ch2,     
  qs_0_speed_is_100_ch2,   
  qs_0_speed_is_10_100_ch3,     
  qs_0_speed_is_100_ch3,   

  // qsgmii ip 1 speed configuration  
  qs_1_speed_is_10_100_ch0,     
  qs_1_speed_is_100_ch0, 
  qs_1_speed_is_10_100_ch1,     
  qs_1_speed_is_100_ch1, 
  qs_1_speed_is_10_100_ch2,     
  qs_1_speed_is_100_ch2,   
  qs_1_speed_is_10_100_ch3,     
  qs_1_speed_is_100_ch3,   

  // qsgmii ip 2 speed configuration  
  qs_2_speed_is_10_100_ch0,     
  qs_2_speed_is_100_ch0, 
  qs_2_speed_is_10_100_ch1,     
  qs_2_speed_is_100_ch1, 
  qs_2_speed_is_10_100_ch2,     
  qs_2_speed_is_100_ch2,   
  qs_2_speed_is_10_100_ch3,     
  qs_2_speed_is_100_ch3,   

  // qsgmii ip 3 speed configuration  
  qs_3_speed_is_10_100_ch0,     
  qs_3_speed_is_100_ch0, 
  qs_3_speed_is_10_100_ch1,     
  qs_3_speed_is_100_ch1, 
  qs_3_speed_is_10_100_ch2,     
  qs_3_speed_is_100_ch2,   
  qs_3_speed_is_10_100_ch3,     
  qs_3_speed_is_100_ch3,   

  // qsgmii ip 4 speed configuration  
  qs_4_speed_is_10_100_ch0,     
  qs_4_speed_is_100_ch0, 
  qs_4_speed_is_10_100_ch1,     
  qs_4_speed_is_100_ch1, 
  qs_4_speed_is_10_100_ch2,     
  qs_4_speed_is_100_ch2,   
  qs_4_speed_is_10_100_ch3,     
  qs_4_speed_is_100_ch3,   

  // qsgmii ip 5 speed configuration  
  qs_5_speed_is_10_100_ch0,     
  qs_5_speed_is_100_ch0, 
  qs_5_speed_is_10_100_ch1,     
  qs_5_speed_is_100_ch1, 
  qs_5_speed_is_10_100_ch2,     
  qs_5_speed_is_100_ch2,   
  qs_5_speed_is_10_100_ch3,     
  qs_5_speed_is_100_ch3
 
);


  input   [1:0]                 qs_0_status_speed_in_ch0;
  input   [1:0]                 qs_0_status_speed_in_ch1;
  input   [1:0]                 qs_0_status_speed_in_ch2;
  input   [1:0]                 qs_0_status_speed_in_ch3;
  input   [1:0]                 qs_1_status_speed_in_ch0;
  input   [1:0]                 qs_1_status_speed_in_ch1;
  input   [1:0]                 qs_1_status_speed_in_ch2;
  input   [1:0]                 qs_1_status_speed_in_ch3;
  input   [1:0]                 qs_2_status_speed_in_ch0;
  input   [1:0]                 qs_2_status_speed_in_ch1;
  input   [1:0]                 qs_2_status_speed_in_ch2;
  input   [1:0]                 qs_2_status_speed_in_ch3;
  input   [1:0]                 qs_3_status_speed_in_ch0;  
  input   [1:0]                 qs_3_status_speed_in_ch1;  
  input   [1:0]                 qs_3_status_speed_in_ch2;  
  input   [1:0]                 qs_3_status_speed_in_ch3;  
  input   [1:0]                 qs_4_status_speed_in_ch0;  
  input   [1:0]                 qs_4_status_speed_in_ch1;  
  input   [1:0]                 qs_4_status_speed_in_ch2;  
  input   [1:0]                 qs_4_status_speed_in_ch3;  
  input   [1:0]                 qs_5_status_speed_in_ch0;  
  input   [1:0]                 qs_5_status_speed_in_ch1;  
  input   [1:0]                 qs_5_status_speed_in_ch2;  
  input   [1:0]                 qs_5_status_speed_in_ch3;  
  
  output  [5:0]                 configuration_vector;
  output  [15:0]                an_adv_config_vector;
  output                        an_restart_config;   
  output                        signal_detect;  
  
  output                        qs_0_speed_is_10_100_ch0;     
  output                        qs_0_speed_is_100_ch0;
  output                        qs_0_speed_is_10_100_ch1;     
  output                        qs_0_speed_is_100_ch1;
  output                        qs_0_speed_is_10_100_ch2;     
  output                        qs_0_speed_is_100_ch2;
  output                        qs_0_speed_is_10_100_ch3;     
  output                        qs_0_speed_is_100_ch3;

  output                        qs_1_speed_is_10_100_ch0;     
  output                        qs_1_speed_is_100_ch0;
  output                        qs_1_speed_is_10_100_ch1;     
  output                        qs_1_speed_is_100_ch1;
  output                        qs_1_speed_is_10_100_ch2;     
  output                        qs_1_speed_is_100_ch2;
  output                        qs_1_speed_is_10_100_ch3;     
  output                        qs_1_speed_is_100_ch3;

  output                        qs_2_speed_is_10_100_ch0;     
  output                        qs_2_speed_is_100_ch0;
  output                        qs_2_speed_is_10_100_ch1;     
  output                        qs_2_speed_is_100_ch1;
  output                        qs_2_speed_is_10_100_ch2;     
  output                        qs_2_speed_is_100_ch2;
  output                        qs_2_speed_is_10_100_ch3;     
  output                        qs_2_speed_is_100_ch3;

  output                        qs_3_speed_is_10_100_ch0;     
  output                        qs_3_speed_is_100_ch0;
  output                        qs_3_speed_is_10_100_ch1;     
  output                        qs_3_speed_is_100_ch1;
  output                        qs_3_speed_is_10_100_ch2;     
  output                        qs_3_speed_is_100_ch2;
  output                        qs_3_speed_is_10_100_ch3;     
  output                        qs_3_speed_is_100_ch3;

  output                        qs_4_speed_is_10_100_ch0;     
  output                        qs_4_speed_is_100_ch0;
  output                        qs_4_speed_is_10_100_ch1;     
  output                        qs_4_speed_is_100_ch1;
  output                        qs_4_speed_is_10_100_ch2;     
  output                        qs_4_speed_is_100_ch2;
  output                        qs_4_speed_is_10_100_ch3;     
  output                        qs_4_speed_is_100_ch3;

  output                        qs_5_speed_is_10_100_ch0;     
  output                        qs_5_speed_is_100_ch0;
  output                        qs_5_speed_is_10_100_ch1;     
  output                        qs_5_speed_is_100_ch1;
  output                        qs_5_speed_is_10_100_ch2;     
  output                        qs_5_speed_is_100_ch2;
  output                        qs_5_speed_is_10_100_ch3;     
  output                        qs_5_speed_is_100_ch3;


  assign  configuration_vector       = 6'h30;      //eanble auto-negotiation   MDIO½Ó¿ÚÅäÖÃ
  assign  an_adv_config_vector       = 16'b0000000000100001;
  assign  an_restart_config          = 1'b0;
  assign  signal_detect              = 1'b1;
 
  assign  qs_0_speed_is_10_100_ch0      = ~qs_0_status_speed_in_ch0[1];             
  assign  qs_0_speed_is_10_100_ch1      = ~qs_0_status_speed_in_ch1[1];              
  assign  qs_0_speed_is_10_100_ch2      = ~qs_0_status_speed_in_ch2[1];             
  assign  qs_0_speed_is_10_100_ch3      = ~qs_0_status_speed_in_ch3[1];              
  assign  qs_1_speed_is_10_100_ch0      = ~qs_1_status_speed_in_ch0[1];             
  assign  qs_1_speed_is_10_100_ch1      = ~qs_1_status_speed_in_ch1[1];              
  assign  qs_1_speed_is_10_100_ch2      = ~qs_1_status_speed_in_ch2[1];             
  assign  qs_1_speed_is_10_100_ch3      = ~qs_1_status_speed_in_ch3[1];               
  assign  qs_2_speed_is_10_100_ch0      = ~qs_2_status_speed_in_ch0[1];             
  assign  qs_2_speed_is_10_100_ch1      = ~qs_2_status_speed_in_ch1[1];              
  assign  qs_2_speed_is_10_100_ch2      = ~qs_2_status_speed_in_ch2[1];             
  assign  qs_2_speed_is_10_100_ch3      = ~qs_2_status_speed_in_ch3[1];               
  assign  qs_3_speed_is_10_100_ch0      = ~qs_3_status_speed_in_ch0[1];             
  assign  qs_3_speed_is_10_100_ch1      = ~qs_3_status_speed_in_ch1[1];              
  assign  qs_3_speed_is_10_100_ch2      = ~qs_3_status_speed_in_ch2[1];             
  assign  qs_3_speed_is_10_100_ch3      = ~qs_3_status_speed_in_ch3[1];              
  assign  qs_4_speed_is_10_100_ch0      = ~qs_4_status_speed_in_ch0[1];             
  assign  qs_4_speed_is_10_100_ch1      = ~qs_4_status_speed_in_ch1[1];              
  assign  qs_4_speed_is_10_100_ch2      = ~qs_4_status_speed_in_ch2[1];             
  assign  qs_4_speed_is_10_100_ch3      = ~qs_4_status_speed_in_ch3[1];               
  assign  qs_5_speed_is_10_100_ch0      = ~qs_5_status_speed_in_ch0[1];             
  assign  qs_5_speed_is_10_100_ch1      = ~qs_5_status_speed_in_ch1[1];              
  assign  qs_5_speed_is_10_100_ch2      = ~qs_5_status_speed_in_ch2[1];             
  assign  qs_5_speed_is_10_100_ch3      = ~qs_5_status_speed_in_ch3[1];        

  assign  qs_0_speed_is_100_ch0      = qs_0_status_speed_in_ch0[0];             
  assign  qs_0_speed_is_100_ch1      = qs_0_status_speed_in_ch1[0];              
  assign  qs_0_speed_is_100_ch2      = qs_0_status_speed_in_ch2[0];             
  assign  qs_0_speed_is_100_ch3      = qs_0_status_speed_in_ch3[0];              
  assign  qs_1_speed_is_100_ch0      = qs_1_status_speed_in_ch0[0];             
  assign  qs_1_speed_is_100_ch1      = qs_1_status_speed_in_ch1[0];              
  assign  qs_1_speed_is_100_ch2      = qs_1_status_speed_in_ch2[0];             
  assign  qs_1_speed_is_100_ch3      = qs_1_status_speed_in_ch3[0];               
  assign  qs_2_speed_is_100_ch0      = qs_2_status_speed_in_ch0[0];             
  assign  qs_2_speed_is_100_ch1      = qs_2_status_speed_in_ch1[0];              
  assign  qs_2_speed_is_100_ch2      = qs_2_status_speed_in_ch2[0];             
  assign  qs_2_speed_is_100_ch3      = qs_2_status_speed_in_ch3[0];               
  assign  qs_3_speed_is_100_ch0      = qs_3_status_speed_in_ch0[0];             
  assign  qs_3_speed_is_100_ch1      = qs_3_status_speed_in_ch1[0];              
  assign  qs_3_speed_is_100_ch2      = qs_3_status_speed_in_ch2[0];             
  assign  qs_3_speed_is_100_ch3      = qs_3_status_speed_in_ch3[0];              
  assign  qs_4_speed_is_100_ch0      = qs_4_status_speed_in_ch0[0];             
  assign  qs_4_speed_is_100_ch1      = qs_4_status_speed_in_ch1[0];              
  assign  qs_4_speed_is_100_ch2      = qs_4_status_speed_in_ch2[0];             
  assign  qs_4_speed_is_100_ch3      = qs_4_status_speed_in_ch3[0];               
  assign  qs_5_speed_is_100_ch0      = qs_5_status_speed_in_ch0[0];             
  assign  qs_5_speed_is_100_ch1      = qs_5_status_speed_in_ch1[0];              
  assign  qs_5_speed_is_100_ch2      = qs_5_status_speed_in_ch2[0];             
  assign  qs_5_speed_is_100_ch3      = qs_5_status_speed_in_ch3[0];                
   
 


endmodule