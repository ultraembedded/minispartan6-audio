//-----------------------------------------------------------------
//                     Minispartan6+ Audio
//                           V0.1
//                     Ultra-Embedded.com
//                     Copyright 2019
//
//                 Email: admin@ultra-embedded.com
//
//                         License: GPL
// If you would like a version with a more permissive license for
// use in closed source commercial applications please contact me
// for details.
//-----------------------------------------------------------------
//
// This file is open source HDL; you can redistribute it and/or 
// modify it under the terms of the GNU General Public License as 
// published by the Free Software Foundation; either version 2 of 
// the License, or (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public 
// License along with this file; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
// USA
//-----------------------------------------------------------------

//-----------------------------------------------------------------
//                          Generated File
//-----------------------------------------------------------------

module fpga_top
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter CLK_FREQ         = 50000000
    ,parameter BAUDRATE         = 1000000
    ,parameter UART_SPEED       = 1000000
    ,parameter C_SCK_RATIO      = 5
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
    // Inputs
     input           clk_i
    ,input           rst_i
    ,input           dbg_txd_i
    ,input           spi_miso_i
    ,input           uart_rx_i
    ,input  [ 31:0]  gpio_input_i
    ,input  [ 15:0]  sdram_data_input_i

    // Outputs
    ,output          dbg_rxd_o
    ,output          spi_clk_o
    ,output          spi_mosi_o
    ,output [  7:0]  spi_cs_o
    ,output          uart_tx_o
    ,output [ 31:0]  gpio_output_o
    ,output [ 31:0]  gpio_output_enable_o
    ,output          sdram_clk_o
    ,output          sdram_cke_o
    ,output          sdram_cs_o
    ,output          sdram_ras_o
    ,output          sdram_cas_o
    ,output          sdram_we_o
    ,output [  1:0]  sdram_dqm_o
    ,output [ 12:0]  sdram_addr_o
    ,output [  1:0]  sdram_ba_o
    ,output [ 15:0]  sdram_data_output_o
    ,output          sdram_data_out_en_o
    ,output          audio_l_o
    ,output          audio_r_o
);

wire           ext2_cfg_awvalid_w;
wire           axi_d_awvalid_w;
wire  [  1:0]  axi_i_bresp_w;
wire  [  1:0]  axi_i_rresp_w;
wire           mem_arready_w;
wire  [ 31:0]  axi_d_araddr_w;
wire           ext2_cfg_bvalid_w;
wire  [  1:0]  mem_bresp_w;
wire           ext2_irq_w;
wire           mem_awvalid_w;
wire  [ 31:0]  axi_d_wdata_w;
wire  [ 31:0]  axi_t_araddr_w;
wire  [  3:0]  axi_d_awid_w;
wire  [  1:0]  mem_rresp_w;
wire           axi_i_rready_w;
wire           axi_t_wlast_w;
wire           axi_i_rvalid_w;
wire           axi_t_arvalid_w;
wire           ext2_cfg_rready_w;
wire  [  7:0]  axi_d_awlen_w;
wire           mem_rready_w;
wire  [  1:0]  axi_i_arburst_w;
wire           mem_bvalid_w;
wire  [ 31:0]  axi_i_rdata_w;
wire           axi_i_rlast_w;
wire           axi_d_arvalid_w;
wire           axi_t_arready_w;
wire  [  3:0]  mem_bid_w;
wire           ext2_cfg_wvalid_w;
wire           axi_d_awready_w;
wire  [  3:0]  axi_t_rid_w;
wire  [ 31:0]  mem_wdata_w;
wire           axi_i_arvalid_w;
wire           interrupt_w;
wire  [  1:0]  ext2_cfg_bresp_w;
wire           axi_cfg_wvalid_w;
wire  [ 31:0]  axi_cfg_rdata_w;
wire  [  1:0]  axi_d_bresp_w;
wire  [  3:0]  axi_cfg_wstrb_w;
wire  [  1:0]  axi_t_awburst_w;
wire  [  1:0]  ext2_cfg_rresp_w;
wire  [  3:0]  mem_arid_w;
wire  [  3:0]  axi_t_wstrb_w;
wire  [ 31:0]  ext2_cfg_awaddr_w;
wire           axi_i_wvalid_w;
wire           rst_cpu_w;
wire           axi_cfg_bready_w;
wire           ext2_cfg_rvalid_w;
wire  [ 31:0]  axi_d_awaddr_w;
wire  [ 31:0]  axi_t_wdata_w;
wire           axi_t_rlast_w;
wire           ext2_cfg_wready_w;
wire           axi_d_wvalid_w;
wire           axi_cfg_awready_w;
wire           axi_t_rready_w;
wire  [ 31:0]  axi_cfg_wdata_w;
wire           axi_d_wlast_w;
wire  [ 31:0]  axi_t_awaddr_w;
wire           axi_i_wlast_w;
wire  [  3:0]  axi_i_bid_w;
wire           axi_d_rready_w;
wire           axi_t_rvalid_w;
wire           mem_wvalid_w;
wire           axi_i_awready_w;
wire           axi_cfg_wready_w;
wire           ext2_cfg_bready_w;
wire  [ 31:0]  axi_cfg_araddr_w;
wire  [ 31:0]  axi_d_rdata_w;
wire           axi_d_wready_w;
wire  [  3:0]  ext2_cfg_wstrb_w;
wire           mem_arvalid_w;
wire  [  3:0]  axi_t_awid_w;
wire           axi_d_rvalid_w;
wire           ext2_cfg_awready_w;
wire  [  7:0]  axi_i_awlen_w;
wire  [ 31:0]  axi_i_wdata_w;
wire  [ 31:0]  axi_i_araddr_w;
wire  [  3:0]  axi_d_arid_w;
wire  [ 31:0]  ext2_cfg_araddr_w;
wire  [  1:0]  axi_t_arburst_w;
wire  [ 31:0]  ext2_cfg_wdata_w;
wire  [  1:0]  axi_t_bresp_w;
wire           axi_i_bvalid_w;
wire           ext2_cfg_arvalid_w;
wire  [ 31:0]  mem_rdata_w;
wire  [  3:0]  axi_i_awid_w;
wire  [  3:0]  axi_t_arid_w;
wire           axi_t_awready_w;
wire  [  7:0]  axi_t_arlen_w;
wire           axi_i_arready_w;
wire           axi_t_wvalid_w;
wire  [  1:0]  axi_t_rresp_w;
wire  [  1:0]  axi_i_awburst_w;
wire  [ 31:0]  ext2_cfg_rdata_w;
wire  [  1:0]  axi_d_arburst_w;
wire  [  1:0]  axi_d_rresp_w;
wire           ext2_cfg_arready_w;
wire  [  3:0]  axi_t_bid_w;
wire  [  7:0]  axi_t_awlen_w;
wire  [  3:0]  mem_awid_w;
wire  [ 31:0]  enable_w;
wire  [ 31:0]  reset_vector_w;
wire  [  3:0]  axi_d_bid_w;
wire  [  3:0]  axi_i_rid_w;
wire  [  1:0]  axi_d_awburst_w;
wire  [ 31:0]  axi_i_awaddr_w;
wire           axi_t_bready_w;
wire           axi_cfg_rvalid_w;
wire           mem_wlast_w;
wire  [  3:0]  mem_rid_w;
wire           mem_rlast_w;
wire  [  1:0]  mem_awburst_w;
wire  [  1:0]  mem_arburst_w;
wire           axi_i_awvalid_w;
wire           axi_d_rlast_w;
wire           axi_i_wready_w;
wire  [  3:0]  axi_d_rid_w;
wire           axi_cfg_bvalid_w;
wire  [  7:0]  axi_d_arlen_w;
wire  [  3:0]  axi_i_wstrb_w;
wire           axi_t_bvalid_w;
wire  [  3:0]  mem_wstrb_w;
wire  [  7:0]  mem_arlen_w;
wire           mem_bready_w;
wire  [ 31:0]  mem_awaddr_w;
wire  [ 31:0]  mem_araddr_w;
wire           axi_t_awvalid_w;
wire  [  7:0]  axi_i_arlen_w;
wire  [  3:0]  axi_d_wstrb_w;
wire           axi_cfg_arvalid_w;
wire           axi_cfg_rready_w;
wire           mem_wready_w;
wire           axi_d_bready_w;
wire           axi_cfg_awvalid_w;
wire  [ 31:0]  axi_cfg_awaddr_w;
wire           mem_awready_w;
wire  [  7:0]  mem_awlen_w;
wire           axi_i_bready_w;
wire           axi_d_bvalid_w;
wire  [  3:0]  axi_i_arid_w;
wire           mem_rvalid_w;
wire  [  1:0]  axi_cfg_rresp_w;
wire  [ 31:0]  axi_t_rdata_w;
wire           axi_d_arready_w;
wire  [  1:0]  axi_cfg_bresp_w;
wire           axi_t_wready_w;
wire           axi_cfg_arready_w;


core_soc
#(
     .CLK_FREQ(CLK_FREQ)
    ,.BAUDRATE(BAUDRATE)
    ,.C_SCK_RATIO(C_SCK_RATIO)
)
u_soc
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(axi_cfg_awvalid_w)
    ,.inport_awaddr_i(axi_cfg_awaddr_w)
    ,.inport_wvalid_i(axi_cfg_wvalid_w)
    ,.inport_wdata_i(axi_cfg_wdata_w)
    ,.inport_wstrb_i(axi_cfg_wstrb_w)
    ,.inport_bready_i(axi_cfg_bready_w)
    ,.inport_arvalid_i(axi_cfg_arvalid_w)
    ,.inport_araddr_i(axi_cfg_araddr_w)
    ,.inport_rready_i(axi_cfg_rready_w)
    ,.spi_miso_i(spi_miso_i)
    ,.uart_rx_i(uart_rx_i)
    ,.gpio_input_i(gpio_input_i)
    ,.ext1_cfg_awready_i(1'b0)
    ,.ext1_cfg_wready_i(1'b0)
    ,.ext1_cfg_bvalid_i(1'b0)
    ,.ext1_cfg_bresp_i(2'b0)
    ,.ext1_cfg_arready_i(1'b0)
    ,.ext1_cfg_rvalid_i(1'b0)
    ,.ext1_cfg_rdata_i(32'b0)
    ,.ext1_cfg_rresp_i(2'b0)
    ,.ext1_irq_i(1'b0)
    ,.ext2_cfg_awready_i(ext2_cfg_awready_w)
    ,.ext2_cfg_wready_i(ext2_cfg_wready_w)
    ,.ext2_cfg_bvalid_i(ext2_cfg_bvalid_w)
    ,.ext2_cfg_bresp_i(ext2_cfg_bresp_w)
    ,.ext2_cfg_arready_i(ext2_cfg_arready_w)
    ,.ext2_cfg_rvalid_i(ext2_cfg_rvalid_w)
    ,.ext2_cfg_rdata_i(ext2_cfg_rdata_w)
    ,.ext2_cfg_rresp_i(ext2_cfg_rresp_w)
    ,.ext2_irq_i(ext2_irq_w)
    ,.ext3_cfg_awready_i(1'b0)
    ,.ext3_cfg_wready_i(1'b0)
    ,.ext3_cfg_bvalid_i(1'b0)
    ,.ext3_cfg_bresp_i(2'b0)
    ,.ext3_cfg_arready_i(1'b0)
    ,.ext3_cfg_rvalid_i(1'b0)
    ,.ext3_cfg_rdata_i(32'b0)
    ,.ext3_cfg_rresp_i(2'b0)
    ,.ext3_irq_i(1'b0)

    // Outputs
    ,.intr_o(interrupt_w)
    ,.inport_awready_o(axi_cfg_awready_w)
    ,.inport_wready_o(axi_cfg_wready_w)
    ,.inport_bvalid_o(axi_cfg_bvalid_w)
    ,.inport_bresp_o(axi_cfg_bresp_w)
    ,.inport_arready_o(axi_cfg_arready_w)
    ,.inport_rvalid_o(axi_cfg_rvalid_w)
    ,.inport_rdata_o(axi_cfg_rdata_w)
    ,.inport_rresp_o(axi_cfg_rresp_w)
    ,.spi_clk_o(spi_clk_o)
    ,.spi_mosi_o(spi_mosi_o)
    ,.spi_cs_o(spi_cs_o)
    ,.uart_tx_o(uart_tx_o)
    ,.gpio_output_o(gpio_output_o)
    ,.gpio_output_enable_o(gpio_output_enable_o)
    ,.ext1_cfg_awvalid_o()
    ,.ext1_cfg_awaddr_o()
    ,.ext1_cfg_wvalid_o()
    ,.ext1_cfg_wdata_o()
    ,.ext1_cfg_wstrb_o()
    ,.ext1_cfg_bready_o()
    ,.ext1_cfg_arvalid_o()
    ,.ext1_cfg_araddr_o()
    ,.ext1_cfg_rready_o()
    ,.ext2_cfg_awvalid_o(ext2_cfg_awvalid_w)
    ,.ext2_cfg_awaddr_o(ext2_cfg_awaddr_w)
    ,.ext2_cfg_wvalid_o(ext2_cfg_wvalid_w)
    ,.ext2_cfg_wdata_o(ext2_cfg_wdata_w)
    ,.ext2_cfg_wstrb_o(ext2_cfg_wstrb_w)
    ,.ext2_cfg_bready_o(ext2_cfg_bready_w)
    ,.ext2_cfg_arvalid_o(ext2_cfg_arvalid_w)
    ,.ext2_cfg_araddr_o(ext2_cfg_araddr_w)
    ,.ext2_cfg_rready_o(ext2_cfg_rready_w)
    ,.ext3_cfg_awvalid_o()
    ,.ext3_cfg_awaddr_o()
    ,.ext3_cfg_wvalid_o()
    ,.ext3_cfg_wdata_o()
    ,.ext3_cfg_wstrb_o()
    ,.ext3_cfg_bready_o()
    ,.ext3_cfg_arvalid_o()
    ,.ext3_cfg_araddr_o()
    ,.ext3_cfg_rready_o()
);


dbg_bridge
#(
     .CLK_FREQ(CLK_FREQ)
    ,.UART_SPEED(UART_SPEED)
)
u_dbg
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.uart_rxd_i(dbg_txd_i)
    ,.mem_awready_i(axi_t_awready_w)
    ,.mem_wready_i(axi_t_wready_w)
    ,.mem_bvalid_i(axi_t_bvalid_w)
    ,.mem_bresp_i(axi_t_bresp_w)
    ,.mem_bid_i(axi_t_bid_w)
    ,.mem_arready_i(axi_t_arready_w)
    ,.mem_rvalid_i(axi_t_rvalid_w)
    ,.mem_rdata_i(axi_t_rdata_w)
    ,.mem_rresp_i(axi_t_rresp_w)
    ,.mem_rid_i(axi_t_rid_w)
    ,.mem_rlast_i(axi_t_rlast_w)

    // Outputs
    ,.uart_txd_o(dbg_rxd_o)
    ,.mem_awvalid_o(axi_t_awvalid_w)
    ,.mem_awaddr_o(axi_t_awaddr_w)
    ,.mem_awid_o(axi_t_awid_w)
    ,.mem_awlen_o(axi_t_awlen_w)
    ,.mem_awburst_o(axi_t_awburst_w)
    ,.mem_wvalid_o(axi_t_wvalid_w)
    ,.mem_wdata_o(axi_t_wdata_w)
    ,.mem_wstrb_o(axi_t_wstrb_w)
    ,.mem_wlast_o(axi_t_wlast_w)
    ,.mem_bready_o(axi_t_bready_w)
    ,.mem_arvalid_o(axi_t_arvalid_w)
    ,.mem_araddr_o(axi_t_araddr_w)
    ,.mem_arid_o(axi_t_arid_w)
    ,.mem_arlen_o(axi_t_arlen_w)
    ,.mem_arburst_o(axi_t_arburst_w)
    ,.mem_rready_o(axi_t_rready_w)
    ,.gpio_outputs_o(enable_w)
);


sdram_axi
u_mem
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.inport_awvalid_i(mem_awvalid_w)
    ,.inport_awaddr_i(mem_awaddr_w)
    ,.inport_awid_i(mem_awid_w)
    ,.inport_awlen_i(mem_awlen_w)
    ,.inport_awburst_i(mem_awburst_w)
    ,.inport_wvalid_i(mem_wvalid_w)
    ,.inport_wdata_i(mem_wdata_w)
    ,.inport_wstrb_i(mem_wstrb_w)
    ,.inport_wlast_i(mem_wlast_w)
    ,.inport_bready_i(mem_bready_w)
    ,.inport_arvalid_i(mem_arvalid_w)
    ,.inport_araddr_i(mem_araddr_w)
    ,.inport_arid_i(mem_arid_w)
    ,.inport_arlen_i(mem_arlen_w)
    ,.inport_arburst_i(mem_arburst_w)
    ,.inport_rready_i(mem_rready_w)
    ,.sdram_data_input_i(sdram_data_input_i)

    // Outputs
    ,.inport_awready_o(mem_awready_w)
    ,.inport_wready_o(mem_wready_w)
    ,.inport_bvalid_o(mem_bvalid_w)
    ,.inport_bresp_o(mem_bresp_w)
    ,.inport_bid_o(mem_bid_w)
    ,.inport_arready_o(mem_arready_w)
    ,.inport_rvalid_o(mem_rvalid_w)
    ,.inport_rdata_o(mem_rdata_w)
    ,.inport_rresp_o(mem_rresp_w)
    ,.inport_rid_o(mem_rid_w)
    ,.inport_rlast_o(mem_rlast_w)
    ,.sdram_clk_o(sdram_clk_o)
    ,.sdram_cke_o(sdram_cke_o)
    ,.sdram_cs_o(sdram_cs_o)
    ,.sdram_ras_o(sdram_ras_o)
    ,.sdram_cas_o(sdram_cas_o)
    ,.sdram_we_o(sdram_we_o)
    ,.sdram_dqm_o(sdram_dqm_o)
    ,.sdram_addr_o(sdram_addr_o)
    ,.sdram_ba_o(sdram_ba_o)
    ,.sdram_data_output_o(sdram_data_output_o)
    ,.sdram_data_out_en_o(sdram_data_out_en_o)
);


soc_arb
u_arb
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.debug_awvalid_i(axi_t_awvalid_w)
    ,.debug_awaddr_i(axi_t_awaddr_w)
    ,.debug_awid_i(axi_t_awid_w)
    ,.debug_awlen_i(axi_t_awlen_w)
    ,.debug_awburst_i(axi_t_awburst_w)
    ,.debug_wvalid_i(axi_t_wvalid_w)
    ,.debug_wdata_i(axi_t_wdata_w)
    ,.debug_wstrb_i(axi_t_wstrb_w)
    ,.debug_wlast_i(axi_t_wlast_w)
    ,.debug_bready_i(axi_t_bready_w)
    ,.debug_arvalid_i(axi_t_arvalid_w)
    ,.debug_araddr_i(axi_t_araddr_w)
    ,.debug_arid_i(axi_t_arid_w)
    ,.debug_arlen_i(axi_t_arlen_w)
    ,.debug_arburst_i(axi_t_arburst_w)
    ,.debug_rready_i(axi_t_rready_w)
    ,.mem_awready_i(mem_awready_w)
    ,.mem_wready_i(mem_wready_w)
    ,.mem_bvalid_i(mem_bvalid_w)
    ,.mem_bresp_i(mem_bresp_w)
    ,.mem_bid_i(mem_bid_w)
    ,.mem_arready_i(mem_arready_w)
    ,.mem_rvalid_i(mem_rvalid_w)
    ,.mem_rdata_i(mem_rdata_w)
    ,.mem_rresp_i(mem_rresp_w)
    ,.mem_rid_i(mem_rid_w)
    ,.mem_rlast_i(mem_rlast_w)
    ,.soc_awready_i(axi_cfg_awready_w)
    ,.soc_wready_i(axi_cfg_wready_w)
    ,.soc_bvalid_i(axi_cfg_bvalid_w)
    ,.soc_bresp_i(axi_cfg_bresp_w)
    ,.soc_arready_i(axi_cfg_arready_w)
    ,.soc_rvalid_i(axi_cfg_rvalid_w)
    ,.soc_rdata_i(axi_cfg_rdata_w)
    ,.soc_rresp_i(axi_cfg_rresp_w)
    ,.cpu_i_awvalid_i(axi_i_awvalid_w)
    ,.cpu_i_awaddr_i(axi_i_awaddr_w)
    ,.cpu_i_awid_i(axi_i_awid_w)
    ,.cpu_i_awlen_i(axi_i_awlen_w)
    ,.cpu_i_awburst_i(axi_i_awburst_w)
    ,.cpu_i_wvalid_i(axi_i_wvalid_w)
    ,.cpu_i_wdata_i(axi_i_wdata_w)
    ,.cpu_i_wstrb_i(axi_i_wstrb_w)
    ,.cpu_i_wlast_i(axi_i_wlast_w)
    ,.cpu_i_bready_i(axi_i_bready_w)
    ,.cpu_i_arvalid_i(axi_i_arvalid_w)
    ,.cpu_i_araddr_i(axi_i_araddr_w)
    ,.cpu_i_arid_i(axi_i_arid_w)
    ,.cpu_i_arlen_i(axi_i_arlen_w)
    ,.cpu_i_arburst_i(axi_i_arburst_w)
    ,.cpu_i_rready_i(axi_i_rready_w)
    ,.cpu_d_awvalid_i(axi_d_awvalid_w)
    ,.cpu_d_awaddr_i(axi_d_awaddr_w)
    ,.cpu_d_awid_i(axi_d_awid_w)
    ,.cpu_d_awlen_i(axi_d_awlen_w)
    ,.cpu_d_awburst_i(axi_d_awburst_w)
    ,.cpu_d_wvalid_i(axi_d_wvalid_w)
    ,.cpu_d_wdata_i(axi_d_wdata_w)
    ,.cpu_d_wstrb_i(axi_d_wstrb_w)
    ,.cpu_d_wlast_i(axi_d_wlast_w)
    ,.cpu_d_bready_i(axi_d_bready_w)
    ,.cpu_d_arvalid_i(axi_d_arvalid_w)
    ,.cpu_d_araddr_i(axi_d_araddr_w)
    ,.cpu_d_arid_i(axi_d_arid_w)
    ,.cpu_d_arlen_i(axi_d_arlen_w)
    ,.cpu_d_arburst_i(axi_d_arburst_w)
    ,.cpu_d_rready_i(axi_d_rready_w)

    // Outputs
    ,.debug_awready_o(axi_t_awready_w)
    ,.debug_wready_o(axi_t_wready_w)
    ,.debug_bvalid_o(axi_t_bvalid_w)
    ,.debug_bresp_o(axi_t_bresp_w)
    ,.debug_bid_o(axi_t_bid_w)
    ,.debug_arready_o(axi_t_arready_w)
    ,.debug_rvalid_o(axi_t_rvalid_w)
    ,.debug_rdata_o(axi_t_rdata_w)
    ,.debug_rresp_o(axi_t_rresp_w)
    ,.debug_rid_o(axi_t_rid_w)
    ,.debug_rlast_o(axi_t_rlast_w)
    ,.mem_awvalid_o(mem_awvalid_w)
    ,.mem_awaddr_o(mem_awaddr_w)
    ,.mem_awid_o(mem_awid_w)
    ,.mem_awlen_o(mem_awlen_w)
    ,.mem_awburst_o(mem_awburst_w)
    ,.mem_wvalid_o(mem_wvalid_w)
    ,.mem_wdata_o(mem_wdata_w)
    ,.mem_wstrb_o(mem_wstrb_w)
    ,.mem_wlast_o(mem_wlast_w)
    ,.mem_bready_o(mem_bready_w)
    ,.mem_arvalid_o(mem_arvalid_w)
    ,.mem_araddr_o(mem_araddr_w)
    ,.mem_arid_o(mem_arid_w)
    ,.mem_arlen_o(mem_arlen_w)
    ,.mem_arburst_o(mem_arburst_w)
    ,.mem_rready_o(mem_rready_w)
    ,.soc_awvalid_o(axi_cfg_awvalid_w)
    ,.soc_awaddr_o(axi_cfg_awaddr_w)
    ,.soc_wvalid_o(axi_cfg_wvalid_w)
    ,.soc_wdata_o(axi_cfg_wdata_w)
    ,.soc_wstrb_o(axi_cfg_wstrb_w)
    ,.soc_bready_o(axi_cfg_bready_w)
    ,.soc_arvalid_o(axi_cfg_arvalid_w)
    ,.soc_araddr_o(axi_cfg_araddr_w)
    ,.soc_rready_o(axi_cfg_rready_w)
    ,.cpu_i_awready_o(axi_i_awready_w)
    ,.cpu_i_wready_o(axi_i_wready_w)
    ,.cpu_i_bvalid_o(axi_i_bvalid_w)
    ,.cpu_i_bresp_o(axi_i_bresp_w)
    ,.cpu_i_bid_o(axi_i_bid_w)
    ,.cpu_i_arready_o(axi_i_arready_w)
    ,.cpu_i_rvalid_o(axi_i_rvalid_w)
    ,.cpu_i_rdata_o(axi_i_rdata_w)
    ,.cpu_i_rresp_o(axi_i_rresp_w)
    ,.cpu_i_rid_o(axi_i_rid_w)
    ,.cpu_i_rlast_o(axi_i_rlast_w)
    ,.cpu_d_awready_o(axi_d_awready_w)
    ,.cpu_d_wready_o(axi_d_wready_w)
    ,.cpu_d_bvalid_o(axi_d_bvalid_w)
    ,.cpu_d_bresp_o(axi_d_bresp_w)
    ,.cpu_d_bid_o(axi_d_bid_w)
    ,.cpu_d_arready_o(axi_d_arready_w)
    ,.cpu_d_rvalid_o(axi_d_rvalid_w)
    ,.cpu_d_rdata_o(axi_d_rdata_w)
    ,.cpu_d_rresp_o(axi_d_rresp_w)
    ,.cpu_d_rid_o(axi_d_rid_w)
    ,.cpu_d_rlast_o(axi_d_rlast_w)
);


audio
u_audio
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_i)
    ,.cfg_awvalid_i(ext2_cfg_awvalid_w)
    ,.cfg_awaddr_i(ext2_cfg_awaddr_w)
    ,.cfg_wvalid_i(ext2_cfg_wvalid_w)
    ,.cfg_wdata_i(ext2_cfg_wdata_w)
    ,.cfg_wstrb_i(ext2_cfg_wstrb_w)
    ,.cfg_bready_i(ext2_cfg_bready_w)
    ,.cfg_arvalid_i(ext2_cfg_arvalid_w)
    ,.cfg_araddr_i(ext2_cfg_araddr_w)
    ,.cfg_rready_i(ext2_cfg_rready_w)

    // Outputs
    ,.cfg_awready_o(ext2_cfg_awready_w)
    ,.cfg_wready_o(ext2_cfg_wready_w)
    ,.cfg_bvalid_o(ext2_cfg_bvalid_w)
    ,.cfg_bresp_o(ext2_cfg_bresp_w)
    ,.cfg_arready_o(ext2_cfg_arready_w)
    ,.cfg_rvalid_o(ext2_cfg_rvalid_w)
    ,.cfg_rdata_o(ext2_cfg_rdata_w)
    ,.cfg_rresp_o(ext2_cfg_rresp_w)
    ,.audio_l_o(audio_l_o)
    ,.audio_r_o(audio_r_o)
    ,.intr_o(ext2_irq_w)
);


riscv_top
u_cpu
(
    // Inputs
     .clk_i(clk_i)
    ,.rst_i(rst_cpu_w)
    ,.axi_i_awready_i(axi_i_awready_w)
    ,.axi_i_wready_i(axi_i_wready_w)
    ,.axi_i_bvalid_i(axi_i_bvalid_w)
    ,.axi_i_bresp_i(axi_i_bresp_w)
    ,.axi_i_bid_i(axi_i_bid_w)
    ,.axi_i_arready_i(axi_i_arready_w)
    ,.axi_i_rvalid_i(axi_i_rvalid_w)
    ,.axi_i_rdata_i(axi_i_rdata_w)
    ,.axi_i_rresp_i(axi_i_rresp_w)
    ,.axi_i_rid_i(axi_i_rid_w)
    ,.axi_i_rlast_i(axi_i_rlast_w)
    ,.axi_d_awready_i(axi_d_awready_w)
    ,.axi_d_wready_i(axi_d_wready_w)
    ,.axi_d_bvalid_i(axi_d_bvalid_w)
    ,.axi_d_bresp_i(axi_d_bresp_w)
    ,.axi_d_bid_i(axi_d_bid_w)
    ,.axi_d_arready_i(axi_d_arready_w)
    ,.axi_d_rvalid_i(axi_d_rvalid_w)
    ,.axi_d_rdata_i(axi_d_rdata_w)
    ,.axi_d_rresp_i(axi_d_rresp_w)
    ,.axi_d_rid_i(axi_d_rid_w)
    ,.axi_d_rlast_i(axi_d_rlast_w)
    ,.intr_i(interrupt_w)
    ,.reset_vector_i(reset_vector_w)

    // Outputs
    ,.axi_i_awvalid_o(axi_i_awvalid_w)
    ,.axi_i_awaddr_o(axi_i_awaddr_w)
    ,.axi_i_awid_o(axi_i_awid_w)
    ,.axi_i_awlen_o(axi_i_awlen_w)
    ,.axi_i_awburst_o(axi_i_awburst_w)
    ,.axi_i_wvalid_o(axi_i_wvalid_w)
    ,.axi_i_wdata_o(axi_i_wdata_w)
    ,.axi_i_wstrb_o(axi_i_wstrb_w)
    ,.axi_i_wlast_o(axi_i_wlast_w)
    ,.axi_i_bready_o(axi_i_bready_w)
    ,.axi_i_arvalid_o(axi_i_arvalid_w)
    ,.axi_i_araddr_o(axi_i_araddr_w)
    ,.axi_i_arid_o(axi_i_arid_w)
    ,.axi_i_arlen_o(axi_i_arlen_w)
    ,.axi_i_arburst_o(axi_i_arburst_w)
    ,.axi_i_rready_o(axi_i_rready_w)
    ,.axi_d_awvalid_o(axi_d_awvalid_w)
    ,.axi_d_awaddr_o(axi_d_awaddr_w)
    ,.axi_d_awid_o(axi_d_awid_w)
    ,.axi_d_awlen_o(axi_d_awlen_w)
    ,.axi_d_awburst_o(axi_d_awburst_w)
    ,.axi_d_wvalid_o(axi_d_wvalid_w)
    ,.axi_d_wdata_o(axi_d_wdata_w)
    ,.axi_d_wstrb_o(axi_d_wstrb_w)
    ,.axi_d_wlast_o(axi_d_wlast_w)
    ,.axi_d_bready_o(axi_d_bready_w)
    ,.axi_d_arvalid_o(axi_d_arvalid_w)
    ,.axi_d_araddr_o(axi_d_araddr_w)
    ,.axi_d_arid_o(axi_d_arid_w)
    ,.axi_d_arlen_o(axi_d_arlen_w)
    ,.axi_d_arburst_o(axi_d_arburst_w)
    ,.axi_d_rready_o(axi_d_rready_w)
);


`define DBG_BIT_RELEASE_RESET 0
`define DBG_BIT_ENABLE_DEBUG  1
`define DBG_BIT_CAPTURE_HI    2
`define DBG_BIT_CAPTURE_LO    3
`define DBG_BIT_DEBUG_WRITE   4
`define DBG_BIT_BOOTADDR      5



assign rst_cpu_w       = ~enable_w[0];

reg [31:0] reset_vector_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    reset_vector_q <= 32'h80000000;
else if (enable_w[`DBG_BIT_CAPTURE_HI] && enable_w[`DBG_BIT_BOOTADDR])
    reset_vector_q <= {enable_w[31:16], reset_vector_q[15:0]};
else if (enable_w[`DBG_BIT_CAPTURE_LO] && enable_w[`DBG_BIT_BOOTADDR])
    reset_vector_q <= {reset_vector_q[31:16], enable_w[31:16]};

assign reset_vector_w  = reset_vector_q;


endmodule
