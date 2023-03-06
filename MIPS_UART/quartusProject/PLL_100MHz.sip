set_global_assignment -entity "PLL_100MHz" -library "lib_PLL_100MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLL_100MHz" -library "lib_PLL_100MHz" -name IP_TOOL_VERSION "21.1"
set_global_assignment -entity "PLL_100MHz" -library "lib_PLL_100MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLL_100MHz" -name SPD_FILE [file join $::quartus(sip_path) "PLL_100MHz.spd"]

set_global_assignment -library "lib_PLL_100MHz" -name MISC_FILE [file join $::quartus(sip_path) "PLL_100MHz_sim/PLL_100MHz.vo"]
