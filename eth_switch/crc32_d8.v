// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Dec 22 11:23:43 2020
// Host        : Belen running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub C:/Users/Belen/Desktop/crc32_d8.v
// Design      : crc32_d8
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module crc32_d8(clk, reset, init, en, data, crc_rlt, new_crc)
/* synthesis syn_black_box black_box_pad_pin="clk,reset,init,en,data[7:0],crc_rlt[31:0],new_crc[31:0]" */;
  input clk;
  input reset;
  input init;
  input en;
  input [7:0]data;
  output [31:0]crc_rlt;
  output [31:0]new_crc;
endmodule
