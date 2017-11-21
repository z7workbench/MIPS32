onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/mips0/clk
add wave -noupdate /testbench/mips0/current
add wave -noupdate /testbench/mips0/next
add wave -noupdate /testbench/mips0/decdOp
add wave -noupdate /testbench/mips0/rs
add wave -noupdate /testbench/mips0/rt
add wave -noupdate /testbench/mips0/rdID
add wave -noupdate /testbench/mips0/rdNew
add wave -noupdate /testbench/mips0/rdEX
add wave -noupdate /testbench/mips0/rdMEM
add wave -noupdate /testbench/mips0/rdWB
add wave -noupdate /testbench/mips0/ALUOpID
add wave -noupdate /testbench/mips0/ALUOpEX
add wave -noupdate -expand /testbench/mips0/u_gpr/reg_files
add wave -noupdate -expand /testbench/mips0/u_dm/dm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1082 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {516 ns} {1516 ns}
