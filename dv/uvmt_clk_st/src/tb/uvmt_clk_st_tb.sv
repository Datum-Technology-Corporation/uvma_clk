// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_CLK_ST_TB_SV__
`define __UVMT_CLK_ST_TB_SV__


/**
 * Module encapsulating the Clock VIP Self-Test DUT wrapper, agents and clock generating interfaces.  The clock and
 * reset interface only feeds into the Clock VIP interfaces.
 */
module uvmt_clk_st_tb;

   import uvm_pkg        ::*;
   import uvmt_clk_st_pkg::*;

   // Agent interfaces
   uvma_clk_if  active_if ();
   uvma_clk_if  passive_if();

   // DUT instance
   uvmt_clk_st_dut_wrap  dut_wrap(.*);


   /**
    * Test bench entry point.
    */
   initial begin
      // Specify time format for simulation (units_number, precision_number, suffix_string, minimum_field_width)
      $timeformat(-9, 3, " ns", 18);

      // Add interfaces to uvm_config_db
      uvm_config_db#(virtual uvma_clk_if)::set(null, "*.env.active_agent" , "vif", active_if );
      uvm_config_db#(virtual uvma_clk_if)::set(null, "*.env.passive_agent", "vif", passive_if);

      // Run test
      uvm_top.enable_print_topology = 1;
      uvm_top.finish_on_completion  = 1;
      uvm_top.run_test();
   end

endmodule : uvmt_clk_st_tb


`endif // __UVMT_CLK_ST_TB_SV__
