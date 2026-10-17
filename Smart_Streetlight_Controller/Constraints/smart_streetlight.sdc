# Clock: 10 ns period (100 MHz)
create_clock -name clk -period 10.000 [get_ports clk]

# Clock uncertainty
set_clock_uncertainty 0.200 [get_clocks clk]

# Synchronous input delays
set_input_delay 1.000 -clock clk [get_ports {day_night vehicle_detect}]

# Output delay
set_output_delay 1.000 -clock clk [get_ports light_pwm]

# Input transitions
set_input_transition 0.100 [get_ports {day_night vehicle_detect reset}]
