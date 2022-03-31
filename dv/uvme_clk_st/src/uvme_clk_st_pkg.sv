// Copyright 2021 Datum Technology Corporation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
// Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
// with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
//                                        https://solderpad.org/licenses/SHL-2.1/
// Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_CLK_ST_PKG_SV__
`define __UVME_CLK_ST_PKG_SV__


// Pre-processor macros
`include "uvm_macros.svh"
`include "uvml_macros.svh"
`include "uvml_logs_macros.svh"
`include "uvml_sb_macros.svh"
`include "uvma_clk_macros.svh"
`include "uvme_clk_st_macros.svh"

// Interface(s)


 /**
 * Encapsulates all the types needed for the Moore.io UVM environment capable of self-testing the Moore.io Clocking
 * UVM Agent.
 */
package uvme_clk_st_pkg;

   import uvm_pkg      ::*;
   import uvml_pkg     ::*;
   import uvml_logs_pkg::*;
   import uvml_sb_pkg  ::*;
   import uvma_clk_pkg ::*;

   // Constants / Structs / Enums
   `include "uvme_clk_st_tdefs.sv"
   `include "uvme_clk_st_constants.sv"

   // Objects
   `include "uvme_clk_st_cfg.sv"
   `include "uvme_clk_st_cntxt.sv"

   // Environment components
   `include "uvme_clk_st_cov_model.sv"
   `include "uvme_clk_st_prd.sv"
   `include "uvme_clk_st_vsqr.sv"
   `include "uvme_clk_st_env.sv"

   // Sequences
   `include "uvme_clk_st_base_vseq.sv"
   `include "uvme_clk_st_start_and_stop_vseq.sv"

endpackage : uvme_clk_st_pkg


// Module(s) / Checker(s)
`ifdef UVME_CLK_ST_INC_CHKR
`include "uvme_clk_st_chkr.sv"
`endif


`endif // __UVME_CLK_ST_PKG_SV__
