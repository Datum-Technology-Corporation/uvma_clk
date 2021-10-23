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
**1. Change directory to 'sim'**

This is from where all jobs will be launched.
```
cd ./sim
```

**2. Project Setup**

Only needs to be done once, or when libraries must be updated. This will pull in dependencies from the web.
```
./setup_project.py
```

**3. Terminal Setup**

This must be done per terminal. The script included in this project is for bash:

```
export VIVADO=/path/to/vivado/bin # Set locaton of Vivado installation
source ./setup_terminal.sh
```

**4. Launch**

All jobs for simulation are performed via `dvm`.

> At any time, you can invoke its built-in documentation:

```
dvm --help
```

> To run test 'active' with seed '1' and wave capture enabled:


```
dvm all uvmt_clk_st -t active -s 1 -w
```
