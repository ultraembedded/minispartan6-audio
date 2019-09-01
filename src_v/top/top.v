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
// TOP
//-----------------------------------------------------------------
module top
(
    // 50MHz clock
    input           clk,

    // SD card
    output          sd_clk,
    output          sd_cd_dat3,
    inout           sd_dat0,
    inout           sd_dat1,
    inout           sd_dat2,  
    output          sd_cmd,

    // SDRAM
    inout           udqm,
    inout           sdram_clk,
    inout           cke,
    inout           bs1,
    inout           bs0,
    inout           sdram_csn,
    inout           rasn,
    inout           casn,
    inout           wen,
    inout           ldqm,
    inout [12:0]    a,
    inout [15:0]    d,

    output          audio1,
    output          audio2,

    // FTDI
    inout           ftdi_rxf,
    inout           ftdi_txe,
    inout           ftdi_siwua,
    inout           ftdi_wr,
    inout           ftdi_rd,
    inout [7:0]     ftdi_d  // TXD, RXD
);

//-----------------------------------------------------------------
// Clocking
//-----------------------------------------------------------------
wire clk_pll;

spartan6_pll
u_pll
(
    .clkref_i(clk),
    .clkout0_o(clk_pll)
);

//-----------------------------------------------------------------
// Reset
//-----------------------------------------------------------------
reg reset       = 1'b1;
reg rst_next    = 1'b1;

always @(posedge clk_pll) 
if (rst_next == 1'b0)
    reset       <= 1'b0;
else 
    rst_next    <= 1'b0;

//-----------------------------------------------------------------
// Core
//-----------------------------------------------------------------
wire [ 15:0]        sdram_data_in_w;
wire [ 15:0]        sdram_data_out_w;
wire                sdram_data_out_en_w;

wire                spi_clk_w;
wire                spi_so_w;
wire                spi_si_w;
wire [7:0]          spi_cs_w;

fpga_top
u_top
(
     .clk_i(clk_pll)
    ,.rst_i(reset)

    ,.dbg_rxd_o(dbg_txd_w)
    ,.dbg_txd_i(ftdi_d[0])

    ,.uart_tx_o(uart_txd_w)
    ,.uart_rx_i(ftdi_d[0])

    ,.spi_clk_o(spi_clk_w)
    ,.spi_mosi_o(spi_si_w)
    ,.spi_miso_i(spi_so_w)
    ,.spi_cs_o(spi_cs_w)

    ,.gpio_input_i(32'b0)
    ,.gpio_output_o()
    ,.gpio_output_enable_o()

    ,.audio_l_o(audio1)
    ,.audio_r_o(audio2)

    // SDRAM Interface
    ,.sdram_clk_o()
    ,.sdram_cke_o(cke)
    ,.sdram_cs_o(sdram_csn)
    ,.sdram_ras_o(rasn)
    ,.sdram_cas_o(casn)
    ,.sdram_we_o(wen)
    ,.sdram_dqm_o({udqm, ldqm})
    ,.sdram_addr_o(a)
    ,.sdram_ba_o({bs1, bs0})
    ,.sdram_data_input_i(sdram_data_in_w)
    ,.sdram_data_output_o(sdram_data_out_w)
    ,.sdram_data_out_en_o(sdram_data_out_en_w)
);

// Xilinx placement pragmas:
//synthesis attribute IOB of txd_q is "TRUE"
reg txd_q;

always @ (posedge clk_pll or posedge reset)
if (reset)
    txd_q <= 1'b1;
else
    txd_q <= dbg_txd_w & uart_txd_w;

// 'OR' two UARTs together
assign ftdi_d[1]  = txd_q;

assign ftdi_rxf   = 1'bz;
assign ftdi_txe   = 1'bz;
assign ftdi_siwua = 1'bz;
assign ftdi_wr    = 1'bz;
assign ftdi_rd    = 1'bz;
assign ftdi_d[7:2]= 6'bz;

//-----------------------------------------------------------------
// SDRAM I/O
//-----------------------------------------------------------------
// 180 degree phase delayed sdram clock output
ODDR2 
#(
    .DDR_ALIGNMENT("NONE"),
    .INIT(1'b0),
    .SRTYPE("SYNC")
)
u_clock_delay
(
    .Q(sdram_clk),
    .C0(clk_pll),
    .C1(~clk_pll),
    .CE(1'b1),
    .R(1'b0),
    .S(1'b0),
    .D0(1'b0),
    .D1(1'b1)
);

genvar i;
generate  
for (i=0; i < 16; i = i + 1) 
begin: gen_sdram_io
  IOBUF 
  #(
    .DRIVE(12),
    .IOSTANDARD("LVTTL"),
    .SLEW("FAST")
  )
  u_data_buf
  (
    .O(sdram_data_in_w[i]),
    .IO(d[i]),
    .I(sdram_data_out_w[i]),
    .T(~sdram_data_out_en_w)
  );
end  
endgenerate

//-----------------------------------------------------------------
// SD card
//-----------------------------------------------------------------
assign sd_clk     = spi_clk_w;
assign sd_cmd     = spi_si_w;
assign sd_cd_dat3 = spi_cs_w[0];
assign spi_so_w   = sd_dat0;

endmodule
