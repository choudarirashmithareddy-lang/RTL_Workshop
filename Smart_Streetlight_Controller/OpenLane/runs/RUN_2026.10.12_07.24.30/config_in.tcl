
set ::env(DESIGN_NAME) "smart_streetlight"

set ::env(VERILOG_FILES) [list \
    /project/RTL/smart_streetlight.v \
    /project/RTL/streetlight_controller.v \
    /project/RTL/pwm_generator.v \
    /project/RTL/reset_sync.v]

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

set ::env(FP_CORE_UTIL) 30
set ::env(FP_ASPECT_RATIO) 1
set ::env(FP_IO_MODE) 1
set ::env(PL_TARGET_DENSITY) 0.35

set ::env(SYNTH_STRATEGY) "AREA 0"
set ::env(QUIT_ON_SYNTH_CHECKS) 0

set ::env(PNR_SDC_FILE) "/project/Constraints/smart_streetlight.sdc"
set ::env(SIGNOFF_SDC_FILE) "/project/Constraints/smart_streetlight.sdc"
