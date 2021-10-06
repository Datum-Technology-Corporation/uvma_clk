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


`ifndef __UVMA_CLK_MON_TRN_LOGGER_SV__
`define __UVMA_CLK_MON_TRN_LOGGER_SV__


/**
 * Component writing Clock monitor transactions debug data to disk as plain text.
 */
class uvma_clk_mon_trn_logger_c extends uvml_logs_mon_trn_logger_c#(
   .T_TRN  (uvma_clk_mon_trn_c),
   .T_CFG  (uvma_clk_cfg_c    ),
   .T_CNTXT(uvma_clk_cntxt_c  )
);
   
   `uvm_component_utils(uvma_clk_mon_trn_logger_c)
   
   
   /**
    * Default constructor.
    */
   function new(string name="uvma_clk_mon_trn_logger", uvm_component parent=null);
      
      super.new(name, parent);
      
   endfunction : new
   
   /**
    * Writes contents of t to disk
    */
   virtual function void write(uvma_clk_mon_trn_c t);
      
      string event_str = "";
      
      case (t.event_type)
         UVMA_CLK_MON_TRN_EVENT_LOCKED   : event_str = $sformatf("LOCKED @ %7.2f Mhz", t.frequency);
         UVMA_CLK_MON_TRN_EVENT_LOST_LOCK: event_str = "LOST LOCK";
      endcase
      
      fwrite($sformatf(" %0t | %s ", $realtime(), event_str));
      
   endfunction : write
   
   /**
    * Writes log header to disk
    */
   virtual function void print_header();
      
      fwrite("---------------------");
      fwrite("     TIME     | EVENT");
      fwrite("---------------------");
      
   endfunction : print_header
   
endclass : uvma_clk_mon_trn_logger_c


/**
 * Component writing CLK monitor transactions debug data to disk as JavaScript Object Notation (JSON).
 */
class uvma_clk_mon_trn_logger_json_c extends uvma_clk_mon_trn_logger_c;
   
   `uvm_component_utils(uvma_clk_mon_trn_logger_json_c)
   
   
   /**
    * Set file extension to '.json'.
    */
   function new(string name="uvma_clk_mon_trn_logger_json", uvm_component parent=null);
      
      super.new(name, parent);
      fextension = "json";
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_clk_mon_trn_c t);
      
      // TODO Implement uvma_clk_mon_trn_logger_json_c::write()
      // Ex: fwrite({"{",
      //       $sformatf("\"time\":\"%0t\",", $realtime()),
      //       $sformatf("\"a\":%h,"        , t.a        ),
      //       $sformatf("\"b\":%b,"        , t.b        ),
      //       $sformatf("\"c\":%d,"        , t.c        ),
      //       $sformatf("\"d\":%h,"        , t.c        ),
      //     "},"});
      
   endfunction : write
   
   /**
    * Empty function.
    */
   virtual function void print_header();
      
      // Do nothing: JSON files do not use headers.
      
   endfunction : print_header
   
endclass : uvma_clk_mon_trn_logger_json_c


`endif // __UVMA_CLK_MON_TRN_LOGGER_SV__
