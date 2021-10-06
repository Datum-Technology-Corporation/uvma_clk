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


`ifndef __UVMA_CLK_IF_SV__
`define __UVMA_CLK_IF_SV__


/**
 * Encapsulates all signals and clocking of Clock interface. Used by
 * monitor (uvma_clk_mon_c) and driver (uvma_clk_drv_c).
 * 
 * Provides equivalent implementation of uvma_clk_drv_c::clock_generator() for
 * possible use in emulation, or simply as a 'lighter' clock generator.
 */
interface uvma_clk_if();
   
   // Signals
   logic/*wire*/  clk;
   
   
   /// @name Singleton Implementation (i.e. without agent)
   /// @{
   
   // State variables
   bit           clk_started    = 0;
   int unsigned  clk_frequency  = `UVMA_CLK_DEFAULT_FREQUENCY ;
   int unsigned  clk_duty_cycle = `UVMA_CLK_DEFAULT_DUTY_CYCLE;
   
   
   /**
    * Generates clk signal.
    */
   initial begin
      real  period, period_duty_cycle_on, period_duty_cycle_off;
      
      // We re-calculate each time because the frequency can change at any moment
      period = $itor(clk_frequency) / 10_000.0; // Period is in ps and frequency is in Hz so we cheat
      period_duty_cycle_on  = period * $itor(clk_duty_cycle)/100.0;
      period_duty_cycle_off = period - period_duty_cycle_on;
      
      wait (clk_started);
      clk = 0;
      fork
         forever begin
            #(period_duty_cycle_off * 1ps) clk = 1'b1;
            #(period_duty_cycle_on  * 1ps) clk = 1'b0;
         end
      join_none
   end
   
   /**
    * Sets clock parameters.
    */
   function void set_clk_period(int unsigned frequency, int unsigned duty_cycle);
      clk_frequency  = frequency;
      clk_duty_cycle = duty_cycle;
   endfunction : set_clk_period
   
   /**
    * Triggers the generation of clk.
    */
   function void start_clk();
      clk_started = 1;
   endfunction : start_clk
   
   /// @}
   
endinterface : uvma_clk_if


`endif // __UVMA_CLK_IF_SV__
