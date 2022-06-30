// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVMT_CLK_ST_CONSTANTS_SV__
`define __UVMT_CLK_ST_CONSTANTS_SV__


const int unsigned uvmt_clk_st_default_startup_timeout     =    200_000; //  2 us // TODO Set default Heartbeat Monitor startup timeout
const int unsigned uvmt_clk_st_default_heartbeat_period    =    200_000; //  2 us // TODO Set default Heartbeat Monitor period
const int unsigned uvmt_clk_st_default_simulation_timeout  = 10_000_000; // 10 ms // TODO Set default simulation timeout


`endif // __UVMT_CLK_ST_CONSTANTS_SV__
