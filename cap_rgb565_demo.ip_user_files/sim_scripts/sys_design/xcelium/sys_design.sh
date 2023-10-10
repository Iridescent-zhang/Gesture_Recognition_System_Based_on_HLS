#!/bin/bash -f
#*********************************************************************************************************
# Vivado (TM) v2022.2 (64-bit)
#
# Filename    : sys_design.sh
# Simulator   : Cadence Xcelium Parallel Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Sun Apr 09 14:24:21 +0800 2023
# SW Build 3671981 on Fri Oct 14 05:00:03 MDT 2022
#
# Tool Version Limit: 2022.10 
#
# usage: sys_design.sh [-help]
# usage: sys_design.sh [-lib_map_path]
# usage: sys_design.sh [-noclean_files]
# usage: sys_design.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'sys_design.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
#*********************************************************************************************************

# Directory path for design sources and include directories (if any) wrt this path
ref_dir="."

# Override directory with 'export_sim_ref_dir' env path value if set in the shell
if [[ (! -z "$export_sim_ref_dir") && ($export_sim_ref_dir != "") ]]; then
  ref_dir="$export_sim_ref_dir"
fi

# Set the compiled library directory path
ref_lib_dir="."

# Set xrun options
xrun_opts="-64bit -v93 -relax -access +rwc -namemap_mixgen "

# Design libraries
design_libs=(simprims_ver xilinx_vip xpm xil_defaultlib xlconstant_v1_1_7 lib_cdc_v1_0_2 proc_sys_reset_v5_0_13 smartconnect_v1_0 axi_infrastructure_v1_1_0 axi_register_slice_v2_1_27 axi_vip_v1_1_13 lib_pkg_v1_0_2 fifo_generator_v13_2_7 lib_fifo_v1_0_16 blk_mem_gen_v8_4_5 lib_bmg_v1_0_14 lib_srl_fifo_v1_0_2 axi_datamover_v5_1_29 axi_vdma_v6_3_15 processing_system7_vip_v1_0_15 generic_baseblocks_v2_1_0 axi_data_fifo_v2_1_26 axi_crossbar_v2_1_28 axi_lite_ipif_v3_0_4 v_tc_v6_1_13 v_vid_in_axi4s_v4_0_9 v_axi4s_vid_out_v4_0_15 v_tc_v6_2_5 v_vid_in_axi4s_v5_0_2 axi_bram_ctrl_v4_1_7 xbip_utils_v3_0_10 axi_utils_v2_0_6 xbip_pipe_v3_0_6 xbip_dsp48_wrapper_v3_0_4 xbip_dsp48_addsub_v3_0_6 xbip_dsp48_multadd_v3_0_6 xbip_bram18k_v3_0_6 mult_gen_v12_0_18 floating_point_v7_1_15 axi_protocol_converter_v2_1_27 axi_mmu_v2_1_25)

# Simulation root library directory
sim_lib_dir="xcelium_lib"

# Script info
echo -e "sys_design.sh - Script generated by export_simulation (Vivado v2022.2 (64-bit)-id)\n"

# Main steps
run()
{
  check_args $# $1
  setup $1 $2
  execute
}

# RUN_STEP: <execute>
execute()
{
  xrun $xrun_opts \
       -reflib "$ref_lib_dir/unisim:unisim" \
       -reflib "$ref_lib_dir/unisims_ver:unisims_ver" \
       -reflib "$ref_lib_dir/secureip:secureip" \
       -reflib "$ref_lib_dir/unimacro:unimacro" \
       -reflib "$ref_lib_dir/unimacro_ver:unimacro_ver" \
       -top xil_defaultlib.sys_design \
       -f run.f \
       -top glbl \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/f0b6/hdl/verilog" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/66be/hdl/verilog" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/ec67/hdl" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/415b/hdl" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/ee60/hdl" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/7504/hdl/verilog" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/b285/hdl/verilog" \
       +incdir+"$ref_dir/../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/cb3e/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/f0b6/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/66be/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/ec67/hdl" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/415b/hdl" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/ee60/hdl" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/7504/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ip/sys_design_color_analysis_0_0/drivers/color_analysis_v1_5/src" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/b285/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ip/sys_design_test_Hu_0_0/drivers/test_Hu_v1_4/src" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ipshared/cb3e/hdl/verilog" \
       +incdir+"../../../../cap_rgb565_demo.gen/sources_1/bd/sys_design/ip/sys_design_CAL_Hu_0_0/drivers/CAL_Hu_v1_3/src" \
       +incdir+"C:/Xilinx/Vivado/2022.2/data/xilinx_vip/include" \
       -input simulate.do
}

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./sys_design.sh -help\" for more information)\n"
        exit 1
      else
        ref_lib_dir=$2
      fi
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
  esac

  create_lib_dir

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Create design library directory paths
create_lib_dir()
{
  if [[ -e $sim_lib_dir ]]; then
    rm -rf $sim_lib_dir
  fi

  for (( i=0; i<${#design_libs[*]}; i++ )); do
    lib="${design_libs[i]}"
    lib_dir="$sim_lib_dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
    fi
  done
}

# Delete generated data from the previous run
reset_run()
{
  files_to_remove=(xmsim.key xrun.key xrun.log waves.shm xrun.history .simvision xcelium.d xcelium)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done

  create_lib_dir
}

# Check command line arguments
check_args()
{
  if [[ ($1 == 1 ) && ($2 != "-lib_map_path" && $2 != "-noclean_files" && $2 != "-reset_run" && $2 != "-help" && $2 != "-h") ]]; then
    echo -e "ERROR: Unknown option specified '$2' (type \"./sys_design.sh -help\" for more information)\n"
    exit 1
  fi

  if [[ ($2 == "-help" || $2 == "-h") ]]; then
    usage
  fi
}

# Script usage
usage()
{
  msg="Usage: sys_design.sh [-help]\n\
Usage: sys_design.sh [-lib_map_path]\n\
Usage: sys_design.sh [-reset_run]\n\
Usage: sys_design.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

# Launch script
run $1 $2
