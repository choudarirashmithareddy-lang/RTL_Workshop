# Static Timing Analysis (STA) Report
## Smart Streetlight Controller

### 1. Project Overview
The Smart Streetlight Controller is a sequential digital design implemented using Verilog HDL. The design was taken through the OpenLane physical design flow using the Sky130HD standard-cell library.

### 2. Clock Constraints
- Clock period: 10 ns
- Clock frequency: 100 MHz
- Clock uncertainty: 0.2 ns
- Input delay: 1 ns for `day_night` and `vehicle_detect`
- Output delay: 1 ns for `light_pwm`

### 3. Timing Results

| Parameter | Observed result |
|---|---:|
| Worst setup slack | Approximately +4.02 ns |
| Worst hold slack | Approximately +0.12 ns |
| Setup timing violations | None reported |
| Hold timing violations | None reported |

### 4. Additional Checks
Recovery checks are present in the timing reports. The signoff checks also report an unconstrained endpoint (`_84_/D`), a missing input delay on `reset`, and two unannotated drivers. These warnings require review before claiming complete timing sign-off.

### 5. Conclusion
The available STA reports show positive setup and hold slack, with no reported setup or hold violations. However, the remaining reset-constraint and parasitic-annotation warnings must be reviewed and documented before final sign-off.
