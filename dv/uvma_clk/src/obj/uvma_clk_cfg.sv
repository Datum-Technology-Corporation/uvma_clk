// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_CLK_CFG_SV__
`define __UVMA_CLK_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running all Clocking agent (uvma_clk_agent_c)
 * components.
 */
class uvma_clk_cfg_c extends uvml_cfg_c;

   // Generic options
   rand bit                      enabled          ; ///<
   rand uvm_active_passive_enum  is_active        ; ///<
   rand uvm_sequencer_arb_mode   sqr_arb_mode     ; ///<
   rand bit                      cov_model_enabled; ///<
   rand bit                      trn_log_enabled  ; ///<

   // Configuration
   rand bit           mon_enabled                    ; ///<
   rand int unsigned  mon_lock_cycle_threshold       ; ///<
   rand int unsigned  mon_sync_missed_edges_threshold; ///<
   rand int unsigned  mon_tolerance                  ; ///< Measured in percentage


   `uvm_object_utils_begin(uvma_clk_cfg_c)
      `uvm_field_int (                         enabled          , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active        , UVM_DEFAULT)
      `uvm_field_enum(uvm_sequencer_arb_mode , sqr_arb_mode     , UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled, UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled  , UVM_DEFAULT)

      `uvm_field_int(mon_enabled                    , UVM_DEFAULT          )
      `uvm_field_int(mon_lock_cycle_threshold       , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(mon_sync_missed_edges_threshold, UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(mon_tolerance                  , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end


   constraint defaults_cons {
      soft enabled           == 1;
      soft is_active         == UVM_PASSIVE;
      soft sqr_arb_mode      == UVM_SEQ_ARB_FIFO;
      soft cov_model_enabled == 0;
      soft trn_log_enabled   == 1;

           mon_enabled                     ==  0; // Not working well
      soft mon_lock_cycle_threshold        == 10;
      soft mon_sync_missed_edges_threshold ==  1;
      soft mon_tolerance                   ==  1; // 1%
   }

   constraint limits_cons {
      mon_lock_cycle_threshold > 0;
      mon_sync_missed_edges_threshold > 0;
      mon_tolerance inside {[1:99]};
   }


   /**
    * Default constructor.
    */
   extern function new(string name="uvma_clk_cfg");

endclass : uvma_clk_cfg_c


function uvma_clk_cfg_c::new(string name="uvma_clk_cfg");

   super.new(name);

endfunction : new


`endif // __UVMA_CLK_CFG_SV__
