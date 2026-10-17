read_liberty /home/vsduser/OpenSTA/test/sky130hd/sky130_fd_sc_hd__ff_n40C_1v95.lib

read_verilog /home/vsduser/Smart_Streetlight_Controller/Synthesis/smart_streetlight_sky130.v

link_design smart_streetlight

read_sdc /home/vsduser/Smart_Streetlight_Controller/Constraints/smart_streetlight.sdc

puts "\n===== FF CORNER: SETUP TIMING ====="
report_checks -path_delay max

puts "\n===== FF CORNER: HOLD TIMING ====="
report_checks -path_delay min

puts "\n===== FF CORNER: WORST SETUP SLACK ====="
report_worst_slack -max

puts "\n===== FF CORNER: WORST HOLD SLACK ====="
report_worst_slack -min

puts "\n===== FF CORNER: TNS ====="
report_tns
