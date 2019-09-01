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

module spartan6_pll
(
    // Inputs
     input           clkref_i

    // Outputs
    ,output          clkout0_o
);





wire clkref_buffered_w;
wire clkfbout_w;
wire pll_clkout0_w;
wire pll_clkout0_buffered_w;

// Input buffering
IBUFG IBUFG_IN
(
    .I (clkref_i),
    .O (clkref_buffered_w)
);

// Clocking primitive
PLL_BASE
#(
    .BANDWIDTH          ("OPTIMIZED"),
    .CLK_FEEDBACK       ("CLKFBOUT"),
    .COMPENSATION       ("INTERNAL"),
    .DIVCLK_DIVIDE      (1),
    .CLKFBOUT_MULT      (10), // VCO=500MHz
    .CLKFBOUT_PHASE     (0.000),
    .CLKOUT0_DIVIDE     (10), // CLK0=50MHz
    .CLKOUT0_PHASE      (0.0),
    .CLKOUT0_DUTY_CYCLE (0.500),
    .CLKIN_PERIOD       (20.0),
    .REF_JITTER         (0.010)
)
pll_base_inst
(
    .CLKFBOUT(clkfbout_w),
    .CLKOUT0(pll_clkout0_w),
    .CLKOUT1(),
    .CLKOUT2(),
    .CLKOUT3(),
    .CLKOUT4(),
    .CLKOUT5(),
    .RST(1'b0),
    .CLKFBIN(clkfbout_w),
    .CLKIN(clkref_buffered_w)
);

//-----------------------------------------------------------------
// CLK_OUT0
//-----------------------------------------------------------------
BUFG clkout0_buf
(
    .I(pll_clkout0_w),
    .O(pll_clkout0_buffered_w)
);

assign clkout0_o = pll_clkout0_buffered_w;




endmodule
