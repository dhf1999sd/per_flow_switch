module reg_asyn_fifo (
           wrclk,
           wr_rst,
           wr_soft_rst,
           wrreq,
           wrusedw,
           wrempty,
           wrfull,
           data,
           rdclk,
           rd_rst,
           rd_soft_rst,
           rdreq,
           rdusedw,
           rdempty,
           rdfull,
           q
           );

parameter DW = 32;
parameter AW = 9;
//parameter DP = 16;

input  wrclk ,wr_rst ,wrreq, wr_soft_rst;
input  [DW-1:0]data;
output [AW:0]wrusedw;
output wrempty ,wrfull;
input  rdclk ,rd_rst ,rdreq, rd_soft_rst;
output [DW-1:0]q;
output [AW:0]rdusedw;
output rdempty ,rdfull;

reg  [AW:0]wr_addr_bin;
reg  [AW:0]syn_rdaddr_gary2;
reg  [AW:0]syn_rdaddr_gary1;
reg  [AW:0]syn_rdaddr_gary0;
wire [AW:0]wr_nextaddr_bin;
wire [AW:0]wr_addr_gary;
reg  [AW:0]rd_addr_bin;
reg  [AW:0]syn_wraddr_gary2;
reg  [AW:0]syn_wraddr_gary1;
reg  [AW:0]syn_wraddr_gary0;
wire [AW:0]rd_nextaddr_bin;
wire [AW:0]rd_addr_gary;
reg  [DW-1:0]q;
reg  [DW-1:0]fifo_mem_arry [2**AW-1:0];
wire [AW-1:0]wraddr;
wire [AW-1:0]rdaddr;

wire [AW:0]syn_rdaddr_bin;
wire [AW:0]syn_wraddr_bin;

function [AW-1:0]gray_to_int;
  input [AW-1:0]gray_value;
  reg   [AW-1:0] temp1;
  reg   [AW-1:0] temp2;
  reg   [AW-1:0] temp3;
  reg   [AW-1:0] temp4;
  reg   [AW-1:0] temp5;
  begin
    temp1 = (gray_value >> 16) ^ gray_value;
    temp2 = (temp1 >> 8) ^ temp1;
    temp3 = (temp2 >> 4) ^ temp2;
    temp4 = (temp3 >> 2) ^ temp3;
    temp5 = (temp4 >> 1) ^ temp4;
    gray_to_int = temp5;
  end
endfunction


assign wrfull = (syn_rdaddr_gary0[AW] ^ wr_addr_gary[AW]) & (syn_rdaddr_gary0[AW-1:0] == wr_addr_gary[AW-1:0]);
assign wrempty = (syn_rdaddr_gary0 == wr_addr_gary)? 1'b1 : 1'b0;
assign wrusedw = wr_addr_bin - syn_rdaddr_bin;

always @(posedge wrclk ,negedge wr_rst)
  if (!wr_rst)
    wr_addr_bin <= {AW{1'b0}}; 
  else if (!wr_soft_rst)
    wr_addr_bin <= {AW{1'b0}};   
  else if (wrreq &(!wrfull))
    wr_addr_bin <= wr_nextaddr_bin;

assign wr_nextaddr_bin = wr_addr_bin + 1'b1;  
assign wr_addr_gary = {wr_addr_bin[AW] ,({1'b0 ,wr_addr_bin[AW-1:1]} ^ wr_addr_bin[AW-1:0])};

always @(posedge wrclk ,negedge wr_rst)
  if (!wr_rst) 
    syn_rdaddr_gary2 <= {AW{1'b0}}; 
  else if (!wr_soft_rst)
    syn_rdaddr_gary2 <= {AW{1'b0}};   
  else
    syn_rdaddr_gary2 <= rd_addr_gary;

always @(posedge wrclk ,negedge wr_rst)
  if (!wr_rst)
    syn_rdaddr_gary1 <= {AW{1'b0}};  
  else if (!wr_soft_rst)
    syn_rdaddr_gary1 <= {AW{1'b0}};  
  else
    syn_rdaddr_gary1 <= syn_rdaddr_gary2;

always @(posedge wrclk ,negedge wr_rst)
  if (!wr_rst) 
    syn_rdaddr_gary0 <= {AW{1'b0}};  
  else if (!wr_soft_rst)
    syn_rdaddr_gary0 <= {AW{1'b0}};   
  else
    syn_rdaddr_gary0 <= syn_rdaddr_gary1;

assign syn_rdaddr_bin = gray_to_int(syn_rdaddr_gary0[AW-1:0]);

assign rdempty = (syn_wraddr_gary0 == rd_addr_gary)? 1'b1 : 1'b0;
assign rdfull = (syn_wraddr_gary0[AW] ^ rd_addr_gary[AW])& (syn_wraddr_gary0[AW-1:0] == rd_addr_gary[AW-1:0]);

always @(posedge rdclk ,negedge rd_rst)
  if (!rd_rst)
    rd_addr_bin <= {AW{1'b0}}; 
  else if (!rd_soft_rst)
    rd_addr_bin <= {AW{1'b0}};  
  else if (rdreq &(!rdempty))
    rd_addr_bin <= rd_nextaddr_bin;

assign rd_nextaddr_bin = rd_addr_bin + 1'b1;  
assign rd_addr_gary = {rd_addr_bin[AW] ,({1'b0 ,rd_addr_bin[AW-1:1]} ^ rd_addr_bin[AW-1:0])};
assign rdusedw = syn_wraddr_bin - rd_addr_bin;

always @(posedge rdclk ,negedge rd_rst)
  if (!rd_rst) 
    syn_wraddr_gary2 <= {AW{1'b0}};  
  else if (!rd_soft_rst)
    syn_wraddr_gary2 <= {AW{1'b0}};   
  else
    syn_wraddr_gary2 <= wr_addr_gary;

always @(posedge rdclk ,negedge rd_rst)
  if (!rd_rst) 
    syn_wraddr_gary1 <= {AW{1'b0}}; 
  else if (!rd_soft_rst)
    syn_wraddr_gary1 <= {AW{1'b0}};    
  else
    syn_wraddr_gary1 <= syn_wraddr_gary2;

always @(posedge rdclk ,negedge rd_rst)
  if (!rd_rst) 
    syn_wraddr_gary0 <= {AW{1'b0}};  
  else if (!rd_soft_rst)
    syn_wraddr_gary0 <= {AW{1'b0}};   
  else
    syn_wraddr_gary0 <= syn_wraddr_gary1;

assign syn_wraddr_bin = gray_to_int(syn_wraddr_gary0[AW-1:0]);

assign wraddr = wr_addr_gary[AW-1:0];
assign rdaddr = rd_addr_gary[AW-1:0];

integer j;

always @(posedge wrclk,negedge wr_rst)
  if (!wr_rst)
  begin
    for (j=0;j<2**AW;j=j+1)
      fifo_mem_arry[j] <= {DW{1'b0}};
  end
  else if (!wr_soft_rst)
  begin
    for (j=0;j<2**AW;j=j+1)
      fifo_mem_arry[j] <= {DW{1'b0}};
  end
  else if (wrreq &(!wrfull)) 
      fifo_mem_arry[wraddr] <= data;


always @(posedge rdclk ,negedge rd_rst)
  if (!rd_rst)
    q <= {DW{1'b0}};
  else if (!rd_soft_rst)
    q <= {DW{1'b0}};  
  else
    q <= fifo_mem_arry[rdaddr];

    
endmodule









