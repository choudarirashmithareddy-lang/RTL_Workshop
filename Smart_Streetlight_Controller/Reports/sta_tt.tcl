read_liberty /home/vsduser/VSDSquadron_FM/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog /home/vsduser/Smart_Streetlight_Controller/Synthesis/smart_streetlight_sky130.v

link_design smart_streetlight

read_sdc /home/vsduser/Smart_Streetlight_Controller/Constraints/smart_streetlight.sdc

puts "\n===== TT CORNER: SETUP TIMING ====="
report_checks -path_delay max

puts "\n===== TT CORNER: HOLD TIMING ====="
report_checks -path_delay min

puts "\n===== TT CORNER: WORST SETUP SLACK ====="
report_worst_slack -max

puts "\n===== TT CORNER: WORST HOLD SLACK ====="
report_worst_slack -min

puts "\n===== TT CORNER: TNS ====="
report_tns
