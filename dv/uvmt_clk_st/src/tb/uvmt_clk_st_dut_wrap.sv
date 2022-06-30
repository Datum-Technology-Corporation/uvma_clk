// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_CLK_ST_DUT_WRAP_SV__
`define __UVMT_CLK_ST_DUT_WRAP_SV__


/**
 * Module wrapper for Clock RTL DUT. All ports are SV interfaces.
 */
module uvmt_clk_st_dut_wrap(
   uvma_clk_if  active_if,
   uvma_clk_if  passive_if
);
   
   assign passive_if.clk = active_if.clk;
   
endmodule : uvmt_clk_st_dut_wrap


`endif // __UVMT_CLK_ST_DUT_WRAP_SV__
