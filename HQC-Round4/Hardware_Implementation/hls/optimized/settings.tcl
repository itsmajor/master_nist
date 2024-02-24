############################################################
## TCL script file for vivado HLS
## Project : HQC-FPGA
############################################################


# Settings for HQC HLS synthesis

##############################################
# List of settings
#
#   version:       - PERF/COMPACT
#   prj:      	   - keypair/encaps/decaps/all_functions
#   csim:      	   - yes/no
#   csynth:        - yes/no
#   cosim:         - yes/no
#   implem:        - yes/no
#   reset:         - yes/no
##############################################

#   prj:      	    - keypair: implement keypair project
#                   - encaps: implement encapsulate project
#              	    - decaps: implement decapsulate project
#              	    - all_functions: implement all_functions project
set prj keypair

#   version:        - PERF: target for performance: large multiplication, loop pipelining... 
#                   - COMPACT: target for size: small multiplication, no pipeline...
set version COMPACT

#   coding:        - 128: HQC-128
#                  - 192: HQC-192
#                  - 256: HQC-256 
set coding 128

#   verb:          - yes: verbose 
#              	   - no: not verbose
set verb no

#   csim:      	   - yes: perform C simulation
#              	   - no: no C simulation
set csim no 

#   csynth:        - yes: perform C to VHDL synthesis
#              	   - no: no synthesis
set csynth yes

#   cosim:         - yes: perform co-simulation C/VHDL
#              	   - no: no co-simulation
#                    Remark: Co-simulation can be done only if VHDL synthesis has been performed
set cosim yes

#   implem:        - yes: perfom VHDL synthesis and place/route
#              	   - no: no place/route
#                      Remark: Implemenation can be done only if VHDL synthesis has been performed   
set implem yes 

#   reset:         - yes: reset same previous HLS project: delete all generated files: VHDL, reports...
#              	   - no: use previous project, if it exists, without resetting, keep all files
set reset no 

##############################################
# Paths to source files
##############################################

# Path to source directory
set sourcedir ../../src
# Path to testbench directory
set tbdir ../../tests/kem/src
# Path to generic testbench directory
set genericdir ../../tests/tb_generic/src
# Path to data reference files
set datadir ../../ref_value/data

##############################################
# Hardware specifications
##############################################

# design language
set language vhdl
# FPGA family
set family artix7
# FPGA device
set device xc7a100t
# Device package
set package ftg256
# Device speed
set speed -1
# Clock name
set ap_clock clk




