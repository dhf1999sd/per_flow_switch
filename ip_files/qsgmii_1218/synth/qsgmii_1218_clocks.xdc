
set_disable_timing -from CLK -to O [get_cells -of [filter [all_fanout -from [get_ports rxuserclk2 ] -flat -endpoints_only] {IS_LEAF}] -filter {PRIMITIVE_GROUP==DMEM}] 
