onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label Clock /MIPS_tb/clk
add wave -noupdate -color Yellow -label Reset /MIPS_tb/reset
add wave -noupdate -color Cyan -label ProgramCounter /MIPS_tb/UUT/programCounter_Output_w
add wave -noupdate -color Violet -label Instruction /MIPS_tb/UUT/InstructionData_Memory_RD_Reg1_w
add wave -noupdate -color {Lime Green} -label Datapath /MIPS_tb/UUT/InstructionData_Memory_RD_Reg2_w
add wave -noupdate -color Yellow -label Control_Unit_State -subitemconfig {{/MIPS_tb/UUT/controlUnit_TOP/state[3]} {-color Yellow} {/MIPS_tb/UUT/controlUnit_TOP/state[2]} {-color Yellow} {/MIPS_tb/UUT/controlUnit_TOP/state[1]} {-color Yellow} {/MIPS_tb/UUT/controlUnit_TOP/state[0]} {-color Yellow}} /MIPS_tb/UUT/controlUnit_TOP/state
add wave -noupdate -color Cyan -label Instruction_Memory -subitemconfig {{/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[31]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[30]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[29]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[28]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[27]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[26]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[25]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[24]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[23]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[22]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[21]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[20]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[19]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[18]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[17]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[16]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[15]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[14]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[13]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[12]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[11]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[10]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[9]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[8]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[7]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[6]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[5]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[4]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[3]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[2]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[1]} {-color Cyan} {/MIPS_tb/UUT/InstructionData_Memory_TOP/ram[0]} {-color Cyan}} /MIPS_tb/UUT/InstructionData_Memory_TOP/ram
add wave -noupdate -color Violet -label RegisterFile -subitemconfig {{/MIPS_tb/UUT/RegisterFile_TOP/ram[31]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[30]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[29]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[28]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[27]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[26]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[25]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[24]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[23]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[22]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[21]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[20]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[19]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[18]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[17]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[16]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[15]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[14]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[13]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[12]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[11]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[10]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[9]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[8]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[7]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[6]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[5]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[4]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[3]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[2]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[1]} {-color Violet} {/MIPS_tb/UUT/RegisterFile_TOP/ram[0]} {-color Violet}} /MIPS_tb/UUT/RegisterFile_TOP/ram
add wave -noupdate /MIPS_tb/UUT/controlUnit_TOP/MemtoReg
add wave -noupdate -color Yellow /MIPS_tb/UUT/controlUnit_TOP/RegDst
add wave -noupdate -color Cyan /MIPS_tb/UUT/controlUnit_TOP/IorD
add wave -noupdate -color Violet /MIPS_tb/UUT/controlUnit_TOP/PCSrc
add wave -noupdate /MIPS_tb/UUT/controlUnit_TOP/ALUSrcB
add wave -noupdate -color Yellow /MIPS_tb/UUT/controlUnit_TOP/ALUSrcA
add wave -noupdate -color Cyan /MIPS_tb/UUT/controlUnit_TOP/IRWrite
add wave -noupdate -color Violet /MIPS_tb/UUT/controlUnit_TOP/MemWrite
add wave -noupdate /MIPS_tb/UUT/controlUnit_TOP/PCWrite
add wave -noupdate -color Yellow /MIPS_tb/UUT/controlUnit_TOP/RegWrite
add wave -noupdate -color Cyan /MIPS_tb/UUT/controlUnit_TOP/TxRegWrite
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1542 ns} 0} {{Cursor 2} {394 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 299
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1744 ns}
