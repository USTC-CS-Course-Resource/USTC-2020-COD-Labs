# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 2
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.cache/wt [current_project]
set_property parent.project_path D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/VivadoProject/COD/Lab3/lab3_test/ins.coe
add_files D:/VivadoProject/COD/Lab3/lab3_test/data.coe
read_verilog -library xil_defaultlib {
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/imports/new/ALU.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/new/control_unit.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/new/cpu_one_circle.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/imports/new/edge_taker.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/new/nixietube.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/new/register_file.v
  D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/new/dbu.v
}
read_ip -quiet D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/ip/dist_memory_256x32/dist_memory_256x32.xci
set_property used_in_implementation false [get_files -all d:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/ip/dist_memory_256x32/dist_memory_256x32_ooc.xdc]

read_ip -quiet D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/ip/dist_instruction_memory_256x32/dist_instruction_memory_256x32.xci
set_property used_in_implementation false [get_files -all d:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/sources_1/ip/dist_instruction_memory_256x32/dist_instruction_memory_256x32_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/constrs_1/imports/VivadoProject/Nexys-4-DDR-Master.xdc
set_property used_in_implementation false [get_files D:/VivadoProject/COD/Lab3/Single_Cycle_CPU/Single_Cycle_CPU.srcs/constrs_1/imports/VivadoProject/Nexys-4-DDR-Master.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top dbu -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef dbu.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file dbu_utilization_synth.rpt -pb dbu_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
