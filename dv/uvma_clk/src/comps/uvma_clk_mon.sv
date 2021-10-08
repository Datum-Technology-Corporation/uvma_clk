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


`ifndef __UVMA_CLK_MON_SV__
`define __UVMA_CLK_MON_SV__


/**
 * Component sampling transactions from a Clock virtual interface (uvma_clk_if).
 * WARNING This code has not been tested
 */
class uvma_clk_mon_c extends uvml_mon_c;
   
   // Objects
   uvma_clk_cfg_c    cfg  ; ///< 
   uvma_clk_cntxt_c  cntxt; ///< 
   
   // TLM
   uvm_analysis_port#(uvma_clk_mon_trn_c)  ap; ///< 
   
   
   `uvm_component_utils_begin(uvma_clk_mon_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_clk_mon", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null.
    * 2. Builds ap.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * Calls monitor_vif().
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvma_clk_mon_c::monitor_clk()
    */
   extern task monitor_clk();
   
   /**
    * TODO Describe uvma_clk_mon_c::monitor_vif()
    */
   extern task monitor_vif();
   
   /**
    * TODO Describe uvma_clk_mon_c::sync_lock_fsm()
    */
   extern task sync_lock_fsm();
   
   /**
    * TODO Describe uvma_clk_mon_c::wait_for_first_cycle()
    */
   extern task wait_for_first_cycle();
   
   /**
    * TODO Describe uvma_clk_mon_c::next_cycle()
    */
   extern task next_cycle();
   
   /**
    * TODO Describe uvma_clk_mon_c::send_trn()
    */
   extern task send_trn(uvma_clk_mon_trn_c trn);
   
endclass : uvma_clk_mon_c


function uvma_clk_mon_c::new(string name="uvma_clk_mon", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvma_clk_mon_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvma_clk_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvma_clk_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   ap = new("ap", this);
  
endfunction : build_phase


task uvma_clk_mon_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
   
   if (cfg.enabled && cfg.mon_enabled) begin
      monitor_clk();
   end
   
endtask : run_phase


task uvma_clk_mon_c::monitor_clk();
   
   forever begin
      monitor_vif  ();
      sync_lock_fsm();
   end
   
endtask : monitor_clk


task uvma_clk_mon_c::monitor_vif();
   
   if (cntxt.current_state != UVMA_CLK_STATE_LOCKED) begin
      if (cntxt.mon_cycle_count == 0) begin
         wait_for_first_cycle();
      end
      else begin
         next_cycle();
      end
   end
   else begin
      next_cycle();
   end
   
endtask : monitor_vif


task uvma_clk_mon_c::sync_lock_fsm();
   
   uvma_clk_mon_trn_c  trn;
   
   forever begin
      case (cntxt.current_state)
         UVMA_CLK_STATE_NO_SYNC: begin
            if (cntxt.mon_cycle_count > 0) begin
               cntxt.current_state = UVMA_CLK_STATE_SYNCHRONIZING;
            end
         end
         
         UVMA_CLK_STATE_SYNCHRONIZING: begin
            if (cntxt.mon_cycle_count >= cfg.mon_lock_cycle_threshold) begin
               cntxt.current_state = UVMA_CLK_STATE_LOCKED;
               trn = uvma_clk_mon_trn_c::type_id::create("trn");
               trn.set_initiator(this);
               trn.event_type = UVMA_CLK_MON_TRN_EVENT_LOCKED;
               trn.frequency  = cntxt.mon_frequency;
               send_trn(trn);
            end
         end
         
         UVMA_CLK_STATE_LOCKED: begin
            if (cntxt.mon_missed_edges >= cfg.mon_sync_missed_edges_threshold) begin
               cntxt.current_state = UVMA_CLK_STATE_NO_SYNC;
               trn = uvma_clk_mon_trn_c::type_id::create("trn");
               trn.set_initiator(this);
               trn.event_type = UVMA_CLK_MON_TRN_EVENT_LOST_LOCK;
               send_trn(trn);
            end
         end
         
      endcase
   end
   
endtask : sync_lock_fsm


task uvma_clk_mon_c::wait_for_first_cycle();
   
   bit       saw_first_cycle = 0;
   realtime  first_edge;
   
   do begin
      wait (cntxt.vif.clk === 1'b0);
      wait (cntxt.vif.clk === 1'b1);
      first_edge = $realtime();
      wait (cntxt.vif.clk === 1'b0);
      wait (cntxt.vif.clk === 1'b1);
      
      saw_first_cycle = 1;
      cntxt.mon_cycle_count++;
      cntxt.mon_period    = $realtime() - first_edge;
      cntxt.mon_frequency = 1.00/cntxt.mon_period;
   end while (!saw_first_cycle);
   
endtask : wait_for_first_cycle


task uvma_clk_mon_c::next_cycle();
   
   realtime  next_pos_edge;
   
   fork
      // Timeout
      begin
         #(cntxt.mon_period * (1.00 + $itor(cfg.mon_tolerance)/100.0));
         #(0); // To avoid race condition
         cntxt.mon_missed_edges++;
         cntxt.mon_cycle_count = 0;
      end
      
      // Waits for new cycle
      begin
         wait (cntxt.vif.clk === 1'b0);
         wait (cntxt.vif.clk === 1'b1);
         
         next_pos_edge = cntxt.mon_last_pos_edge + ((1.00 - $itor(cfg.mon_tolerance)/100.0) * cntxt.mon_period);
         if ($realtime() < next_pos_edge) begin
            // Too fast!
            cntxt.mon_missed_edges++;
            cntxt.mon_cycle_count = 0;
         end
         else begin
            cntxt.mon_cycle_count++;
            cntxt.mon_missed_edges = 0;
         end
         
         cntxt.mon_last_pos_edge = $realtime();
      end
   join_any
   disable fork;
   
endtask : next_cycle


task uvma_clk_mon_c::send_trn(uvma_clk_mon_trn_c trn);
   
   ap.write(trn);
   `uvml_hrtbt()
   
endtask : send_trn


`endif // __UVMA_CLK_MON_SV__
