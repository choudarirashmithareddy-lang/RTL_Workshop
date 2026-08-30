# Assessment – Sequence Detector

## Overview

This assessment presents the design and verification of a **Verilog-based sequence detector**. The implementation is verified through RTL simulation, waveform analysis, synthesis, gate-level inspection, and Gate-Level Simulation (GLS).

The sequence detector is designed to recognize the following serial input pattern:



## Objectives

The main objectives of this assessment are:

* Design a sequence detector using Verilog RTL.
* Verify the RTL implementation using simulation.
* Observe signal behavior using GTKWave.
* Synthesize the design using Yosys.
* Examine the synthesized gate-level circuit.
* Perform Gate-Level Simulation.
* Compare the RTL and GLS results.
* Confirm that the required sequence is detected correctly.

---

## Design Description

The design is implemented as a sequence detector that monitors the serial input `din`.

The target sequence is:

```text
1111010
```

The detector uses state-based logic to keep track of the progress of the incoming sequence.

When the complete pattern is identified, the `detected` output produces a detection pulse.

The design also includes a `detection_count` signal that records the number of successful detections during the simulation.

---

## Main Signals

| Signal            | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| `clk`             | Clock input used to synchronize the sequential logic       |
| `din`             | Serial data input                                          |
| `reset`           | Reset input for initializing the detector                  |
| `state`           | Current state of the sequence detector                     |
| `next_state`      | Next FSM state calculated from the current state and input |
| `detected`        | Indicates that the target sequence has been detected       |
| `detection_count` | Keeps track of detected sequence occurrences               |

---

# 1. RTL Simulation

The sequence detector was first verified at the RTL level.

The Verilog design and its testbench were simulated, and the generated waveform was inspected using GTKWave.

## RTL Waveform

![RTL GTKWave Simulation](./images/rtl_gtkwave.png)

### Observation

The waveform displays the clock, serial input, reset, detector state, detection output, and detection count.

The `din` signal represents the incoming serial data. The state-related signals change according to the input sequence, while `detected` indicates successful recognition of the target pattern.

The detection count increases when a valid sequence is identified.

---

# 2. RTL Verification

The RTL simulation was used to confirm that the sequence detector responds correctly to the supplied input data.

The target pattern used for verification is:

```text
1111010
```

The simulation waveform provides a visual representation of the input sequence and the corresponding detection events.

The expected detection behavior was observed during the RTL simulation.

---

# 3. Synthesis Using Yosys

After verifying the RTL functionality, the design was synthesized using **Yosys**.

The synthesis process transforms the RTL description into a hardware-oriented representation and applies logic optimization before technology mapping.

## Yosys Synthesis Output

![Yosys Synthesis Result](./images/yosys_synthesis.png)

### Synthesis Information

The synthesis report provides information about the generated design, including:

* Number of wires
* Number of wire bits
* Number of public wires
* Number of ports
* Number of memories
* Number of processes
* Number of cells
* Types of cells used

The synthesis output confirms that the `sequence_detector` module was successfully processed.

---

# 4. Synthesized Gate-Level Circuit

The synthesized design was represented as a gate-level circuit using standard-cell logic.

## Gate-Level Netlist

![Synthesized Gate-Level Circuit](./images/gate_level_netlist.png)

### Circuit Observation

The synthesized circuit contains interconnected combinational and sequential elements.

The generated representation includes:

* Logic gates
* Flip-flops
* Clock connections
* Reset connections
* Input data path
* State logic
* Detection output logic

This provides a structural view of how the original RTL behavior is implemented using synthesized hardware cells.

---

# 5. Gate-Level Simulation

After synthesis, the resulting gate-level implementation was simulated to verify that the synthesized design continues to provide the intended functionality.

This process is referred to as **Gate-Level Simulation (GLS)**.

The GLS waveform was inspected using GTKWave.

## GLS Waveform

![Gate-Level Simulation](./images/gls_gtkwave.png)

### Observation

The waveform contains the main signals required for verification:

* `clk`
* `din`
* `reset`
* `detected`
* `detection_count`

The target sequence `1111010` is detected correctly during the gate-level simulation.

The detection pulses occur at the expected locations.

---

# 6. RTL and GLS Comparison

The RTL and gate-level simulations were compared to verify that synthesis did not change the intended functional behavior.

| Verification Parameter | RTL Simulation    | Gate-Level Simulation |
| ---------------------- | ----------------- | --------------------- |
| Clock operation        | Correct           | Correct               |
| Reset behavior         | Verified          | Verified              |
| Input pattern          | `1111010`         | `1111010`             |
| Sequence detection     | Correct           | Correct               |
| Detection pulse        | Observed          | Observed              |
| Detection count        | Updated correctly | Updated correctly     |
| Overall functionality  | Valid             | Preserved             |

The comparison shows that the synthesized implementation maintains the functional behavior of the original RTL design.

Small differences in signal timing or propagation can appear at the gate level because the synthesized design contains explicit logic and cell-level connections. These differences do not affect the logical detection result.

---

# 7. Verification Flow

The complete assessment follows the flow shown below:

```text
Verilog RTL
     |
     v
Testbench
     |
     v
RTL Simulation
     |
     v
GTKWave Analysis
     |
     v
Yosys Synthesis
     |
     v
Gate-Level Netlist
     |
     v
Gate-Level Simulation
     |
     v
RTL vs GLS Comparison
     |
     v
Functional Verification
```

---

# 8. Sequence Detection Result

The target sequence used in this assessment is:

```text
1111010
```

The sequence was successfully identified during simulation.

The `detected` output provides the indication of a successful match, while `detection_count` records the number of detection events.

Both RTL and GLS simulations show the expected detection behavior.

---

# 9. Synthesis Result

The synthesis stage successfully converted the RTL sequence detector into a gate-level implementation.

The generated synthesis information shows the hardware resources used by the design, while the gate-level diagram provides a structural representation of the synthesized circuit.

This confirms that the RTL description can be successfully mapped into standard-cell based logic.

---

# 10. Gate-Level Verification Result

The synthesized implementation was verified through Gate-Level Simulation.

The GLS results preserve the intended functionality of the RTL implementation, and the target sequence `1111010` is detected correctly.

The gate-level waveform may contain propagation-related timing differences compared with the RTL waveform, but the logical detection behavior remains unchanged.

---

# 11. Key Learning Outcomes

Through this assessment, the following concepts were demonstrated:

* Verilog RTL design
* FSM-based sequence detection
* Testbench-based verification
* RTL simulation
* GTKWave waveform analysis
* Yosys synthesis
* Logic-cell mapping
* Gate-level circuit inspection
* Gate-Level Simulation
* RTL and GLS comparison
* Functional verification after synthesis

---

# 12. Tools Used

| Tool / Technology            | Purpose                           |
| ---------------------------- | --------------------------------- |
| Verilog                      | RTL design                        |
| Icarus Verilog               | RTL and simulation flow           |
| GTKWave                      | Waveform visualization            |
| Yosys                        | RTL synthesis                     |
| SKY130 Standard-Cell Library | Technology mapping                |
| Linux                        | Design and simulation environment |
| Git                          | Version control                   |
| GitHub                       | Project documentation and storage |

---

# 13. Overall Result

The sequence detector was successfully designed, simulated, synthesized, and verified at gate level.

The target pattern:

```text
1111010
```

was detected correctly in both RTL and Gate-Level Simulation.

The synthesis and GLS stages confirmed that the intended functionality was preserved after converting the RTL design into a synthesized gate-level implementation.

---

# Conclusion

This assessment demonstrates a complete RTL-to-GLS verification flow for a sequence detector.

The design was first validated through RTL simulation and GTKWave analysis. It was then synthesized using Yosys, inspected as a gate-level circuit, and finally verified through Gate-Level Simulation.

The successful RTL and GLS results demonstrate that the synthesized implementation preserves the intended sequence-detection functionality.

---

## Assessment Status

**Completed Successfully**

### Final Verification

```text
Target Sequence : 1111010
RTL Simulation  : PASS
Synthesis       : PASS
Gate-Level Netlist : Generated
GLS             : PASS
Functional Verification : PASS
```

```
```
