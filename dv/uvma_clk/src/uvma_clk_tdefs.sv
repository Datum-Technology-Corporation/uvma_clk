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


`ifndef __UVMA_CLK_TDEFS_SV__
`define __UVMA_CLK_TDEFS_SV__


typedef enum {
   UVMA_CLK_STATE_NO_SYNC      ,
   UVMA_CLK_STATE_SYNCHRONIZING,
   UVMA_CLK_STATE_LOCKED
} uvma_clk_state_enum;


typedef enum {
   UVMA_CLK_SEQ_ITEM_ACTION_START,
   UVMA_CLK_SEQ_ITEM_ACTION_STOP ,
   UVMA_CLK_SEQ_ITEM_ACTION_PAUSE,
   UVMA_CLK_SEQ_ITEM_ACTION_CHANGE_FREQUENCY,
   UVMA_CLK_SEQ_ITEM_ACTION_CHANGE_DUTY_CYCLE
} uvma_clk_seq_item_action_enum;


typedef enum {
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_SAME  ,
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_RANDOM,
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_0     ,
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_1     ,
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_X     ,
   UVMA_CLK_SEQ_ITEM_STOP_VALUE_Z
} uvma_clk_seq_item_stop_value_enum;


typedef enum {
   UVMA_CLK_MON_TRN_EVENT_LOCKED   ,
   UVMA_CLK_MON_TRN_EVENT_LOST_LOCK
} uvma_clk_mon_trn_event_enum;


`endif // __UVMA_CLK_TDEFS_SV__
