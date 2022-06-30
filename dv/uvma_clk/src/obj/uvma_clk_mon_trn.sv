// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_CLK_MON_TRN_SV__
`define __UVMA_CLK_MON_TRN_SV__


/**
 * Object rebuilt from the Clock monitor Analog of uvma_clk_seq_item_c.
 */
class uvma_clk_mon_trn_c extends uvml_mon_trn_c;
   
   // Data
   real  frequency;
   
   // Metadata
   uvma_clk_mon_trn_event_enum  event_type;
   
   
   `uvm_object_utils_begin(uvma_clk_mon_trn_c)
      `uvm_field_enum(uvma_clk_mon_trn_event_enum, event_type, UVM_DEFAULT          )
      `uvm_field_real(                             frequency , UVM_DEFAULT + UVM_DEC)
   `uvm_object_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvma_clk_mon_trn");
   
endclass : uvma_clk_mon_trn_c


function uvma_clk_mon_trn_c::new(string name="uvma_clk_mon_trn");
   
   super.new(name);
   
endfunction : new


`endif // __UVMA_CLK_MON_TRN_SV__
