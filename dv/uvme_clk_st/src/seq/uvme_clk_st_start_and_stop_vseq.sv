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


`ifndef __UVME_CLK_ST_START_AND_STOP_VSEQ_SV__
`define __UVME_CLK_ST_START_AND_STOP_VSEQ_SV__


/**
 * TODO Describe uvme_clk_st_start_and_stop_vseq_c
 */
class uvme_clk_st_start_and_stop_vseq_c extends uvme_clk_st_base_vseq_c;
   
   rand int unsigned  clk_frequency;
   rand int unsigned  clock_gen_duration;
   
   
   `uvm_object_utils_begin(uvme_clk_st_start_and_stop_vseq_c)
      `uvm_field_int(clk_frequency     , UVM_DEFAULT + UVM_DEC)
      `uvm_field_int(clock_gen_duration, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft clk_frequency      == 100_000_000; // 100 Mhz
      soft clock_gen_duration ==   3_000_000; // 3 us
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_clk_st_start_and_stop_vseq");
   
   /**
    * TODO Describe uvme_clk_st_start_and_stop_vseq_c::body()
    */
   extern virtual task body();
   
endclass : uvme_clk_st_start_and_stop_vseq_c


function uvme_clk_st_start_and_stop_vseq_c::new(string name="uvme_clk_st_start_and_stop_vseq");
   
   super.new(name);
   
endfunction : new


task uvme_clk_st_start_and_stop_vseq_c::body();
   
   uvma_clk_seq_item_c  start_clk;
   uvma_clk_seq_item_c  stop_clk ;
   
   fork
       begin
         `uvm_info("VSEQ", $sformatf("Starting clock with frequency of %0d MHz", clk_frequency/1_000_000), UVM_LOW)
         `uvm_create_on(start_clk, p_sequencer.active_sequencer)
         `uvm_rand_send_with (start_clk, {
            action        == UVMA_CLK_SEQ_ITEM_ACTION_START;
            new_frequency == clk_frequency;
         })
      end
      
      begin
         if (cfg.passive_cfg.mon_enabled) begin
            wait (cntxt.passive_cntxt.current_state == UVMA_CLK_STATE_LOCKED);
         end
      end
   join
   
   if (cfg.passive_cfg.mon_enabled) begin
      `uvm_info("VSEQ", $sformatf("Passive clk agent is now locked, waiting %t before stopping clock", (clock_gen_duration * 1ps)), UVM_LOW)
   end
   #(clock_gen_duration * 1ps);
   
   `uvm_info("VSEQ", "Stopping clock", UVM_LOW)
   `uvm_create_on(stop_clk, p_sequencer.active_sequencer)
   `uvm_rand_send_with(stop_clk, {
      action == UVMA_CLK_SEQ_ITEM_ACTION_STOP;
   })
   
endtask : body


`endif // __UVME_CLK_ST_START_AND_STOP_VSEQ_SV__
