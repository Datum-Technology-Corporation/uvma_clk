// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_CLK_ST_CFG_SV__
`define __UVME_CLK_ST_CFG_SV__


/**
 * Object encapsulating all parameters for creating, connecting and running the Clocking Agent Self-Testing Environment
 * (uvme_clk_st_env_c) components.
 */
class uvme_clk_st_cfg_c extends uvml_cfg_c;
   
   // Integrals
   rand bit                      enabled              ; ///< 
   rand uvm_active_passive_enum  is_active            ; ///< 
   rand bit                      scoreboarding_enabled; ///< 
   rand bit                      cov_model_enabled    ; ///< 
   rand bit                      trn_log_enabled      ; ///< 
   
   // Objects
   rand uvma_clk_cfg_c         active_cfg ; ///< 
   rand uvma_clk_cfg_c         passive_cfg; ///< 
   rand uvml_sb_simplex_cfg_c  sb_cfg     ; ///< 
   
   
   `uvm_object_utils_begin(uvme_clk_st_cfg_c)
      `uvm_field_int (                         enabled              , UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active            , UVM_DEFAULT)
      `uvm_field_int (                         scoreboarding_enabled, UVM_DEFAULT)
      `uvm_field_int (                         cov_model_enabled    , UVM_DEFAULT)
      `uvm_field_int (                         trn_log_enabled      , UVM_DEFAULT)
      
      `uvm_field_object(active_cfg , UVM_DEFAULT)
      `uvm_field_object(passive_cfg, UVM_DEFAULT)
      `uvm_field_object(sb_cfg     , UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft enabled                == 0;
      soft is_active              == UVM_PASSIVE;
      soft scoreboarding_enabled  == 1;
      soft cov_model_enabled      == 0;
      soft trn_log_enabled        == 1;
   }
   
   constraint agent_cfg_cons {
      if (enabled) {
         active_cfg .enabled == 1;
         passive_cfg.enabled == 1;
      }
      else {
         active_cfg .enabled == 0;
         passive_cfg.enabled == 0;
      }
      
      if (is_active == UVM_ACTIVE) {
         active_cfg .is_active == UVM_ACTIVE ;
         passive_cfg.is_active == UVM_PASSIVE;
      }
      else {
         active_cfg .is_active == UVM_PASSIVE;
         passive_cfg.is_active == UVM_PASSIVE;
      }
      
      if (trn_log_enabled) {
         /*soft*/ active_cfg .trn_log_enabled == 1;
         /*soft*/ passive_cfg.trn_log_enabled == 1;
      }
   }
   
   constraint sb_cfg_cons {
      if (scoreboarding_enabled) {
         /*soft*/ sb_cfg.enabled == 1;
      }
      else {
         sb_cfg.enabled == 0;
      }
   }
   
   constraint sync_agent_cfg_cons {
      active_cfg.mon_lock_cycle_threshold        == passive_cfg.mon_lock_cycle_threshold       ;
      active_cfg.mon_sync_missed_edges_threshold == passive_cfg.mon_sync_missed_edges_threshold;
      active_cfg.mon_tolerance                   == passive_cfg.mon_tolerance                  ;
   }
   
   
   /**
    * Creates sub-configuration objects.
    */
   extern function new(string name="uvme_clk_st_cfg");
   
endclass : uvme_clk_st_cfg_c


function uvme_clk_st_cfg_c::new(string name="uvme_clk_st_cfg");
   
   super.new(name);
   
   active_cfg  = uvma_clk_cfg_c        ::type_id::create("active_cfg" );
   passive_cfg = uvma_clk_cfg_c        ::type_id::create("passive_cfg");
   sb_cfg      = uvml_sb_simplex_cfg_c ::type_id::create("sb_cfg"     );
   
endfunction : new


`endif // __UVME_CLK_ST_CFG_SV__
