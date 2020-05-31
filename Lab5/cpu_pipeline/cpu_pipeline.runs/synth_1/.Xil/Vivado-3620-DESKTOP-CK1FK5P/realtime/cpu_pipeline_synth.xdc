set_property SRC_FILE_INFO {cfile:d:/VivadoProject/COD/Lab5/cpu_pipeline/cpu_pipeline.srcs/sources_1/ip/instr_mem_256x32/instr_mem_256x32/instr_mem_256x32_in_context.xdc rfile:../../../../../cpu_pipeline.srcs/sources_1/ip/instr_mem_256x32/instr_mem_256x32/instr_mem_256x32_in_context.xdc id:1 order:EARLY scoped_inst:mem_instr} [current_design]
set_property SRC_FILE_INFO {cfile:d:/VivadoProject/COD/Lab5/cpu_pipeline/cpu_pipeline.srcs/sources_1/ip/data_mem_256x32/data_mem_256x32/data_mem_256x32_in_context.xdc rfile:../../../../../cpu_pipeline.srcs/sources_1/ip/data_mem_256x32/data_mem_256x32/data_mem_256x32_in_context.xdc id:2 order:EARLY scoped_inst:data_mem} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property IS_IP_OOC_CELL true [get_cells mem_instr]
current_instance data_mem
set_property src_info {type:SCOPED_XDC file:2 line:1 export:INPUT save:INPUT read:READ} [current_design]
set_property CLOCK_PERIOD_OOC_TARGET 20 [get_ports -scoped_to_current_instance clk]
current_instance
set_property src_info {type:SCOPED_XDC file:2 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property IS_IP_OOC_CELL true [get_cells data_mem]
set_property src_info {type:TCL file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells mem_instr]
set_property src_info {type:TCL file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells data_mem]
