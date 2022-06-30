// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMA_CLK_SEQ_ITEM_LOGGER_SV__
`define __UVMA_CLK_SEQ_ITEM_LOGGER_SV__


/**
 * Component writing Clock sequence items debug data to disk as plain text.
 */
class uvma_clk_seq_item_logger_c extends uvml_logs_seq_item_logger_c#(
   .T_TRN  (uvma_clk_seq_item_c),
   .T_CFG  (uvma_clk_cfg_c     ),
   .T_CNTXT(uvma_clk_cntxt_c   )
);
   
   `uvm_component_utils(uvma_clk_seq_item_logger_c)
   
   
   /**
    * Default constructor.
    */
   function new(string name="uvma_clk_seq_item_logger", uvm_component parent=null);
      
      super.new(name, parent);
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_clk_seq_item_c t);
      
      string action_str = "";
      
      case (t.action)
         UVMA_CLK_SEQ_ITEM_ACTION_START           : action_str = $sformatf("START @ %t Mhz", t.new_frequency);
         UVMA_CLK_SEQ_ITEM_ACTION_PAUSE           : action_str = $sformatf("PAUSE");
         UVMA_CLK_SEQ_ITEM_ACTION_CHANGE_FREQUENCY: action_str = $sformatf("CHANGE %t -> %t Mhz", cntxt.mon_frequency, t.new_frequency);
         
         UVMA_CLK_SEQ_ITEM_ACTION_STOP: begin
            case (t.stop_value)
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_SAME  : action_str = "STOP";
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_RANDOM: action_str = "STOP RANDVAL";
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_0     : action_str = "STOP ->0";
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_1     : action_str = "STOP ->1";
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_Z     : action_str = "STOP ->Z";
               UVMA_CLK_SEQ_ITEM_STOP_VALUE_X     : action_str = "STOP ->X";
            endcase
         end
      endcase
      
      fwrite($sformatf(" %t | %s", $realtime(), action_str));
      
   endfunction : write
   
   /**
    * Writes log header to disk.
    */
   virtual function void print_header();
      
      fwrite("--------------");
      fwrite(" TIME | ACTION");
      fwrite("--------------");
      
   endfunction : print_header
   
endclass : uvma_clk_seq_item_logger_c


/**
 * Component writing Clock monitor transactions debug data to disk as JavaScript Object Notation (JSON).
 */
class uvma_clk_seq_item_logger_json_c extends uvma_clk_seq_item_logger_c;
   
   `uvm_component_utils(uvma_clk_seq_item_logger_json_c)
   
   
   /**
    * Set file extension to '.json'.
    */
   function new(string name="uvma_clk_seq_item_logger_json", uvm_component parent=null);
      
      super.new(name, parent);
      fextension = "json";
      
   endfunction : new
   
   /**
    * Writes contents of t to disk.
    */
   virtual function void write(uvma_clk_seq_item_c t);
      
      // TODO Implement uvma_clk_seq_item_logger_json_c::write()
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
   
endclass : uvma_clk_seq_item_logger_json_c


`endif // __UVMA_CLK_SEQ_ITEM_LOGGER_SV__
