// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_CLK_PKG_SV__
`define __UVMA_CLK_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvma_clk_macros.svh"

// Interface(s)
`include "uvma_clk_if.sv"


/**
 * Encapsulates all the types needed for the Moore.io Clocking UVM agent.
 */
package uvma_clk_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;

   // Constants / Structs / Enums
   `include "uvma_clk_tdefs.sv"
   `include "uvma_clk_constants.sv"

   // Objects
   `include "uvma_clk_cfg.sv"
   `include "uvma_clk_cntxt.sv"

   // High-level transactions
   `include "uvma_clk_mon_trn.sv"
   `include "uvma_clk_mon_trn_logger.sv"
   `include "uvma_clk_seq_item.sv"
   `include "uvma_clk_seq_item_logger.sv"

   // Agent components
   `include "uvma_clk_cov_model.sv"
   `include "uvma_clk_drv.sv"
   `include "uvma_clk_mon.sv"
   `include "uvma_clk_sqr.sv"
   `include "uvma_clk_agent.sv"

   // Sequences
   `include "uvma_clk_base_seq.sv"

endpackage : uvma_clk_pkg


// Module(s) / Checker(s)
`ifdef UVMA_CLK_INC_IF_CHKR
`include "uvma_clk_if_chkr.sv"
`endif


`endif // __UVMA_CLK_PKG_SV__
