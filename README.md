# About
## [Home Page](https://datum-technology-corporation.github.io/uvma_clk/)
The Moore.io UVM Clocking Agent is a simple and vital element to any UVM test bench.  Both for driving and monitoring purposes.  This project consists of the agent (`uvma_clk_pkg`), the self-testing UVM environment (`uvme_clk_st_pkg`) and the test bench (`uvmt_clk_st_pkg`) to verify the agent against itself.

## IP
* DV
> * uvma_clk
> * uvme_clk_st
> * uvmt_clk_st
* RTL
* Tools


# Simulation
```
export VIVADO=/path/to/vivado/install
cd ./sim
cat ./README.md
./setup_project.py
source ./setup_terminal.sh
dvm --help
clear && dvm all uvmt_clk_st -t sanity -s 1 -w
```
