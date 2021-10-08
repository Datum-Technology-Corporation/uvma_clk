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


`ifndef __UVMT_CLK_ST_MONITORING_TEST_SV__
`define __UVMT_CLK_ST_MONITORING_TEST_SV__


/**
 * TODO Describe uvmt_clk_st_monitoring_test_c
 */
class uvmt_clk_st_monitoring_test_c extends uvmt_clk_st_base_test_c;
   
   rand uvme_clk_st_start_and_stop_vseq_c  start_and_stop_vseq;
   
   
   `uvm_component_utils(uvmt_clk_st_monitoring_test_c)
   
   
   /**
    * Describe test_cons
    */
   constraint test_cons {
      env_cfg.scoreboarding_enabled   == 1;
      env_cfg.active_cfg .mon_enabled == 0;
      env_cfg.passive_cfg.mon_enabled == 1;
   }
   
   
   /**
    * Creates start_and_stop_vseq.
    */
   extern function new(string name="uvmt_clk_st_monitoring_test", uvm_component parent=null);
   
   /**
    * Runs start_and_stop_vseq on vsequencer.
    */
   extern virtual task main_phase(uvm_phase phase);
   
endclass : uvmt_clk_st_monitoring_test_c


function uvmt_clk_st_monitoring_test_c::new(string name="uvmt_clk_st_monitoring_test", uvm_component parent=null);
   
   super.new(name, parent);
   
   start_and_stop_vseq = uvme_clk_st_start_and_stop_vseq_c::type_id::create("start_and_stop_vseq");
   
endfunction : new


task uvmt_clk_st_monitoring_test_c::main_phase(uvm_phase phase);
   
   super.main_phase(phase);
   
   phase.raise_objection(this);
   `uvm_info("TEST", $sformatf("Starting start_and_stop_vseq virtual sequence:\n%s", start_and_stop_vseq.sprint()), UVM_NONE)
   start_and_stop_vseq.start(vsequencer);
   `uvm_info("TEST", $sformatf("Finished start_and_stop_vseq virtual sequence:\n%s", start_and_stop_vseq.sprint()), UVM_NONE)
   phase.drop_objection(this);
   
endtask : main_phase


`endif // __UVMT_CLK_ST_MONITORING_TEST_SV__
