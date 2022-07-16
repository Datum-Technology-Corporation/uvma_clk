#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
shopt -s expand_aliases
source ~/.bashrc
mio cpel    uvmt_clk_st
mio sim     uvmt_clk_st -t active -s 1 -c
mio results uvmt_clk_st results
mio cov     uvmt_clk_st
