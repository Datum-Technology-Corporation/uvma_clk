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


`ifndef __UVMA_CLK_CNTXT_SV__
`define __UVMA_CLK_CNTXT_SV__


/**
 * Object encapsulating all state variables for all Clock agent (uvma_clk_agent_c) components.
 */
class uvma_clk_cntxt_c extends uvm_object;
   
   virtual uvma_clk_if  vif; ///< Handle to agent interface
   
   // Integrals
   uvma_clk_state_enum  current_state     ; ///< 
   int unsigned         drv_duty_cycle    ; ///< 
   realtime             drv_frequency     ; ///< 
   int unsigned         mon_cycle_count   ; ///< 
   int unsigned         mon_missed_edges  ; ///< 
   realtime             mon_frequency     ; ///< 
   realtime             mon_period        ; ///< 
   realtime             mon_last_pos_edge ; ///< 
   
   // Objects
   process    clk_gen_process; ///< 
   uvm_event  sample_cfg_e   ; ///< 
   uvm_event  sample_cntxt_e ; ///< 
   
   
   `uvm_object_utils_begin(uvma_clk_cntxt_c)
      `uvm_field_enum(uvma_clk_state_enum, current_state    , UVM_DEFAULT)
      `uvm_field_real(                     drv_frequency    , UVM_DEFAULT)
      `uvm_field_int (                     mon_cycle_count  , UVM_DEFAULT)
      `uvm_field_int (                     mon_missed_edges , UVM_DEFAULT)
      `uvm_field_real(                     mon_frequency    , UVM_DEFAULT)
      `uvm_field_real(                     mon_period       , UVM_DEFAULT)
      `uvm_field_real(                     mon_last_pos_edge, UVM_DEFAULT)
      
      `uvm_field_event(sample_cfg_e  , UVM_DEFAULT)
      `uvm_field_event(sample_cntxt_e, UVM_DEFAULT)
   `uvm_object_utils_end
   
   
   /**
    * Builds events.
    */
   extern function new(string name="uvma_clk_cntxt");
   
   /**
    * TODO Describe uvma_clk_cntxt_c::reset()
    */
   extern function void reset();
   
endclass : uvma_clk_cntxt_c


function uvma_clk_cntxt_c::new(string name="uvma_clk_cntxt");
   
   super.new(name);
   current_state     = UVMA_CLK_STATE_NO_SYNC;
   drv_duty_cycle    = 50;
   drv_frequency     =  0;
   mon_cycle_count   =  0;
   mon_missed_edges  =  0;
   mon_frequency     =  0;
   mon_period        =  0;
   mon_last_pos_edge =  0;
   sample_cfg_e     = new("sample_cfg_e"  );
   sample_cntxt_e   = new("sample_cntxt_e");
   
endfunction : new


function void uvma_clk_cntxt_c::reset();
   
   current_state     = UVMA_CLK_STATE_NO_SYNC;
   drv_duty_cycle    = 50;
   drv_frequency     = 0;
   mon_cycle_count   = 0;
   mon_missed_edges  = 0;
   mon_frequency     = 0;
   mon_period        = 0;
   mon_last_pos_edge = 0;
   
   clk_gen_process.kill();
   
endfunction : reset


`endif // __UVMA_CLK_CNTXT_SV__
