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


`ifndef __UVMA_CLK_SEQ_ITEM_SV__
`define __UVMA_CLK_SEQ_ITEM_SV__


/**
 * Object created by Clock agent sequences extending uvma_clk_seq_base_c.
 */
class uvma_clk_seq_item_c extends uvml_seq_item_c;
   
   rand uvma_clk_seq_item_action_enum      action;
   rand uvma_clk_seq_item_stop_value_enum  stop_value;
   rand int unsigned                       new_frequency;
   
   
   `uvm_object_utils_begin(uvma_clk_seq_item_c)
      `uvm_field_enum(uvma_clk_seq_item_action_enum    , action       , UVM_DEFAULT          )
      `uvm_field_enum(uvma_clk_seq_item_stop_value_enum, stop_value   , UVM_DEFAULT          )
      `uvm_field_int (                                   new_frequency, UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   constraint defaults_cons {
      soft action == UVMA_CLK_SEQ_ITEM_ACTION_START;
   }
   
   constraint rules_cons {
      if (action != UVMA_CLK_SEQ_ITEM_ACTION_STOP) {
         stop_value == UVMA_CLK_SEQ_ITEM_STOP_VALUE_SAME;
      }
   }
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_clk_seq_item");
   
endclass : uvma_clk_seq_item_c


function uvma_clk_seq_item_c::new(string name="uvma_clk_seq_item");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_CLK_SEQ_ITEM_SV__
