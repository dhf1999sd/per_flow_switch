// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Tue Dec 22 10:18:10 2020
// Host        : Belen running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub C:/Users/Belen/Desktop/eth_rx_tx/ip_files/fifo_9x4k/fifo_9x4k_stub.v
// Design      : fifo_9x4k
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module fifo_9x4k(clk, srst, din, wr_en, rd_en, dout, full, almost_full, 
  empty, almost_empty, prog_full)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[8:0],wr_en,rd_en,dout[8:0],full,almost_full,empty,almost_empty,prog_full" */;
  input clk;
  input srst;
  input [8:0]din;
  input wr_en;
  input rd_en;
  output [8:0]dout;
  output full;
  output almost_full;
  output empty;
  output almost_empty;
  output prog_full;
endmodule
