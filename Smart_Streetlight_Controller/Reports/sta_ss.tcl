read_liberty /home/vsduser/OpenSTA/test/sky130hd/sky130_fd_sc_hd__ss_n40C_1v40.lib

read_verilog /home/vsduser/Smart_Streetlight_Controller/Synthesis/smart_streetlight_sky130.v

link_design smart_streetlight

read_sdc /home/vsduser/Smart_Streetlight_Controller/Constraints/smart_streetlight.sdc

puts "\n===== SS CORNER: SETUP TIMING ====="
report_checks -path_delay max

puts "\n===== SS CORNER: HOLD TIMING ====="
report_checks -path_delay min

puts "\n===== SS CORNER: WORST SETUP SLACK ====="
report_worst_slack -max

puts "\n===== SS CORNER: WORST HOLD SLACK ====="
report_worst_slack -min

puts "\n===== SS CORNER: TNS ====="
report_tns
