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


`ifndef __UVME_CLK_ST_COV_MODEL_SV__
`define __UVME_CLK_ST_COV_MODEL_SV__


/**
 * Component encapsulating Clock Self-Test Environment functional
 * coverage model.
 */
class uvme_clk_st_cov_model_c extends uvm_component;
   
   // Coverage targets
   uvme_clk_st_cfg_c    cfg;
   uvme_clk_st_cntxt_c  cntxt;
   uvma_clk_seq_item_c  active_seq_item;
   uvma_clk_mon_trn_c   active_mon_trn;
   uvma_clk_mon_trn_c   passive_mon_trn;
   
   // TLM
   uvm_analysis_export  #(uvma_clk_seq_item_c)  active_seq_item_export;
   uvm_analysis_export  #(uvma_clk_mon_trn_c )  active_mon_trn_export ;
   uvm_analysis_export  #(uvma_clk_mon_trn_c )  passive_mon_trn_export ;
   uvm_tlm_analysis_fifo#(uvma_clk_seq_item_c)  active_seq_item_fifo  ;
   uvm_tlm_analysis_fifo#(uvma_clk_mon_trn_c )  active_mon_trn_fifo   ;
   uvm_tlm_analysis_fifo#(uvma_clk_mon_trn_c )  passive_mon_trn_fifo   ;
   
   
   `uvm_component_utils_begin(uvme_clk_st_cov_model_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   covergroup clk_st_cfg_cg;
      // TODO Implement clk_st_cfg_cg
      //      Ex: abc_cpt : coverpoint cfg.abc;
      //          xyz_cpt : coverpoint cfg.xyz;
   endgroup : clk_st_cfg_cg
   
   covergroup clk_st_cntxt_cg;
      // TODO Implement clk_st_cntxt_cg
      //      Ex: abc_cpt : coverpoint cntxt.abc;
      //          xyz_cpt : coverpoint cntxt.xyz;
   endgroup : clk_st_cntxt_cg
   
   covergroup clk_st_active_seq_item_cg;
      // TODO Implement clk_st_active_seq_item_cg
      //      Ex: abc_cpt : coverpoint active_seq_item.abc;
      //          xyz_cpt : coverpoint active_seq_item.xyz;
   endgroup : clk_st_active_seq_item_cg
   
   covergroup clk_st_active_mon_trn_cg;
      // TODO Implement clk_st_active_mon_trn_cg
      //      Ex: abc_cpt : coverpoint active_mon_trn.abc;
      //          xyz_cpt : coverpoint active_mon_trn.xyz;
   endgroup : clk_st_active_mon_trn_cg
   
   covergroup clk_st_passive_mon_trn_cg;
      // TODO Implement clk_st_passive_mon_trn_cg
      //      Ex: abc_cpt : coverpoint passive_mon_trn.abc;
      //          xyz_cpt : coverpoint passive_mon_trn.xyz;
   endgroup : clk_st_passive_mon_trn_cg
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_clk_st_cov_model", uvm_component parent=null);
   
   /**
    * Ensures cfg & cntxt handles are not null.
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::connect_phase()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Describe uvme_clk_st_cov_model_c::run_phase()
    */
   extern virtual task run_phase(uvm_phase phase);
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::sample_cfg()
    */
   extern function void sample_cfg();
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::sample_cntxt()
    */
   extern function void sample_cntxt();
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::sample_active_seq_item()
    */
   extern function void sample_active_seq_item();
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::sample_active_mon_trn()
    */
   extern function void sample_active_mon_trn();
   
   /**
    * TODO Describe uvme_clk_st_cov_model_c::sample_passive_mon_trn()
    */
   extern function void sample_passive_mon_trn();
   
endclass : uvme_clk_st_cov_model_c


function uvme_clk_st_cov_model_c::new(string name="uvme_clk_st_cov_model", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_clk_st_cov_model_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_clk_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   
   void'(uvm_config_db#(uvme_clk_st_cntxt_c)::get(this, "", "cntxt", cntxt));
   if (!cntxt) begin
      `uvm_fatal("CNTXT", "Context handle is null")
   end
   
   // Build TLM objects
   active_seq_item_export = new("active_seq_item_export", this);
   active_mon_trn_export  = new("active_mon_trn_export" , this);
   passive_mon_trn_export  = new("passive_mon_trn_export" , this);
   active_seq_item_fifo   = new("active_seq_item_fifo"  , this);
   active_mon_trn_fifo    = new("active_mon_trn_fifo"   , this);
   passive_mon_trn_fifo    = new("passive_mon_trn_fifo"   , this);
   
endfunction : build_phase


function void uvme_clk_st_cov_model_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   // Connect TLM objects
   active_seq_item_export.connect(active_seq_item_fifo.analysis_export);
   active_mon_trn_export .connect(active_mon_trn_fifo .analysis_export);
   passive_mon_trn_export .connect(passive_mon_trn_fifo .analysis_export);
   
endfunction : connect_phase


task uvme_clk_st_cov_model_c::run_phase(uvm_phase phase);
   
   super.run_phase(phase);
  
  fork
    // Configuration
    forever begin
      cntxt.sample_cfg_e.wait_trigger();
      sample_cfg();
    end
    
    // Context
    forever begin
      cntxt.sample_cntxt_e.wait_trigger();
      sample_cntxt();
    end
    
    // active sequence item coverage
    forever begin
       active_seq_item_fifo.get(active_seq_item);
       sample_active_seq_item();
    end
    
    // active monitored transaction coverage
    forever begin
       active_mon_trn_fifo.get(active_mon_trn);
       sample_active_mon_trn();
    end
    
    // passive monitored transaction coverage
    forever begin
       passive_mon_trn_fifo.get(passive_mon_trn);
       sample_passive_mon_trn();
    end
  join_none
   
endtask : run_phase


function void uvme_clk_st_cov_model_c::sample_cfg();
   
  clk_st_cfg_cg.sample();
   
endfunction : sample_cfg


function void uvme_clk_st_cov_model_c::sample_cntxt();
   
   clk_st_cntxt_cg.sample();
   
endfunction : sample_cntxt


function void uvme_clk_st_cov_model_c::sample_active_seq_item();
   
   clk_st_active_seq_item_cg.sample();
   
endfunction : sample_active_seq_item


function void uvme_clk_st_cov_model_c::sample_active_mon_trn();
   
   clk_st_active_mon_trn_cg.sample();
   
endfunction : sample_active_mon_trn


function void uvme_clk_st_cov_model_c::sample_passive_mon_trn();
   
   clk_st_passive_mon_trn_cg.sample();
   
endfunction : sample_passive_mon_trn


`endif // __UVME_CLK_ST_COV_MODEL_SV__
