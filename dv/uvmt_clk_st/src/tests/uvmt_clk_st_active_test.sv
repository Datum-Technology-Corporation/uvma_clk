// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_CLK_ST_ACTIVE_TEST_SV__
`define __UVMT_CLK_ST_ACTIVE_TEST_SV__


/**
 * TODO Describe uvmt_clk_st_active_test_c
 */
class uvmt_clk_st_active_test_c extends uvmt_clk_st_base_test_c;
   
   rand uvme_clk_st_start_and_stop_vseq_c  start_and_stop_vseq;
   
   
   `uvm_component_utils(uvmt_clk_st_active_test_c)
   
   
   /**
    * Describe test_cons
    */
   constraint test_cons {
      env_cfg.scoreboarding_enabled   == 0;
      env_cfg.active_cfg .mon_enabled == 0;
      env_cfg.passive_cfg.mon_enabled == 0;
   }
   
   
   /**
    * Creates start_and_stop_vseq.
    */
   extern function new(string name="uvmt_clk_st_active_test", uvm_component parent=null);
   
   /**
    * Runs start_and_stop_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_clk_st_active_test_c


function uvmt_clk_st_active_test_c::new(string name="uvmt_clk_st_active_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   start_and_stop_vseq = uvme_clk_st_start_and_stop_vseq_c::type_id::create("start_and_stop_vseq");
   
endfunction : new


task uvmt_clk_st_active_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting start_and_stop_vseq virtual sequence:\n%s", start_and_stop_vseq.sprint()), UVM_NONE)
   start_and_stop_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished start_and_stop_vseq virtual sequence:\n%s", start_and_stop_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_CLK_ST_ACTIVE_TEST_SV__
