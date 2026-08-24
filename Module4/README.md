#  Module 4 – Blocking vs Non-Blocking Assignments & Synthesis–Simulation Mismatch

##  Introduction

This module explores the behavior and application of **blocking (`=`)** and **non-blocking (`<=`) assignments** in Verilog HDL. These operators play an important role in defining how statements are evaluated inside procedural blocks and are essential for creating predictable RTL designs.

The experiments cover **2×1 multiplexer design, RTL simulation, blocking assignment behavior, incorrectly coded combinational logic, synthesis–simulation mismatch, and technology mapping**. The designs are simulated with **Icarus Verilog**, their waveforms are examined using **GTKWave**, and synthesis is performed using **Yosys** with mapping to the **SKY130 standard-cell library**.

---

#  Objectives

The main goals of this module are:

* Understand the functional difference between blocking (`=`) and non-blocking (`<=`) assignments.
* Explore how improper RTL coding can result in synthesis–simulation differences.
* Implement and simulate multiplexer circuits using Verilog HDL.
* Study the execution order of blocking assignments.
* Perform RTL simulation using **Icarus Verilog**.
* Inspect simulation results through **GTKWave**.
* Synthesize Verilog designs using **Yosys**.
* Map synthesized logic to the **SKY130 standard-cell library**.
* Compare simulated RTL behavior with the resulting synthesized hardware.

---

# 🛠️ Tools & Technologies

| Tool / Technology                | Application                         |
| -------------------------------- | ----------------------------------- |
| **Verilog HDL**                  | RTL hardware description            |
| **Icarus Verilog**               | Compilation and simulation          |
| **GTKWave**                      | Waveform visualization              |
| **Yosys**                        | RTL synthesis                       |
| **SKY130 Standard Cell Library** | Technology mapping                  |
| **Linux Terminal**               | Executing design-flow commands      |
| **gVim**                         | Verilog file editing and inspection |

---

#  Table of Contents

1. [RTL Simulation of a 2×1 Multiplexer](#1️⃣-rtl-simulation-of-a-2×1-multiplexer)
2. [Technology Mapping of the Multiplexer](#2️⃣-technology-mapping-of-the-multiplexer)
3. [Functional Verification Using Waveforms](#3️⃣-functional-verification-using-waveforms)
4. [Incorrect Multiplexer Analysis](#4️⃣-incorrect-multiplexer-analysis)
5. [Verification of Incorrect Multiplexer](#5️⃣-verification-of-incorrect-multiplexer)
6. [Blocking Assignment Simulation](#6️⃣-blocking-assignment-simulation)
7. [Synthesis of Blocking Assignment Circuit](#7️⃣-synthesis-of-blocking-assignment-circuit)
8. [Blocking Assignment and Previous Values](#8️⃣-blocking-assignment-and-previous-values)
9. [Overall Result](#9️⃣-overall-result)
10. [Conclusion](#🔟-conclusion)

---

# 1️⃣ RTL Simulation of a 2×1 Multiplexer

##  Overview

The first experiment implements a **2×1 multiplexer** using the Verilog ternary operator. The RTL design is compiled and simulated with **Icarus Verilog**, after which the generated waveform is inspected using **GTKWave**.

The purpose of this experiment is to verify the basic combinational behavior of the multiplexer and observe how the selected input determines the output.

###  Simulation Commands

```bash
iverilog -o mux ternary_operator_mux.v tb_ternary_operator_mux.v

gtkwave ternary_operator_mux.vcd
```

###  Output Waveform

<img width="958" height="930" alt="2x1 multiplexer simulation waveform" src="https://github.com/user-attachments/assets/a4ddaf60-f4fc-4c1f-b23d-b1f25bbe9fba" />

###  Observation

The simulation waveform shows that the multiplexer operates as expected, with the output responding to the applied select signal and input values.

---

# 2️⃣ Technology Mapping of the Multiplexer

## 📖 Overview

After RTL simulation, the multiplexer design is passed through the synthesis flow using **Yosys**. The synthesized logic is then technology-mapped against the **SKY130 standard-cell library**.

This step demonstrates how an RTL description is transformed into a gate-level representation using cells available in the selected technology library.

###  Synthesis Commands

```bash
yosys

read_verilog mux_generate.v

synth -top mux_generate

abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

show
```

###  Synthesized Circuit

<img width="958" height="930" alt="technology mapped multiplexer circuit" src="https://github.com/user-attachments/assets/ab5e482f-c11c-4cc5-9bf7-3a2e49f7025e" />

###  Observation

The RTL multiplexer was successfully synthesized and mapped using the SKY130 standard-cell library.

---

# 3️⃣ Functional Verification Using Waveforms

## 📖 Overview

The next experiment verifies the functional operation of the multiplexer by applying different combinations of inputs and select signals.

The resulting simulation waveform is examined to ensure that the output corresponds to the input selected by the control signal.

###  Simulation Commands

```bash
iverilog -o mux mux_generate.v tb_mux_generate.v

gtkwave mux_generate.vcd
```

### 📷 Output Waveform

<img width="958" height="930" alt="multiplexer functional verification waveform" src="https://github.com/user-attachments/assets/b3df3f5c-d5f3-4b77-94a4-4a4f93c43933" />

###  Observation

The waveform confirms the expected 2×1 multiplexer behavior for the applied input combinations.

---

# 4️⃣ Incorrect Multiplexer Analysis

##  Overview

This experiment investigates a multiplexer described using an improper RTL coding style. Incomplete assignments within a combinational `always` block can cause unintended storage elements, such as latches, to be inferred during synthesis.

Such coding issues can cause the behavior observed at RTL to differ from the expected synthesized implementation.

###  Simulation Commands

```bash
iverilog -o bad_mux bad_mux.v tb_bad_mux.v

gtkwave bad_mux.vcd
```

###  Output

<img width="958" height="930" alt="incorrect multiplexer output" src="https://github.com/user-attachments/assets/8bbf014c-9a57-41c5-90ba-aebf14aadb27" />

### ✅ Observation

The simulation exposes the unexpected behavior produced by the incomplete multiplexer description.

---

# 5️⃣ Verification of Incorrect Multiplexer

## 📖 Overview

The waveform from the previous experiment provides a clearer representation of the incorrect multiplexer behavior.

When an output is not assigned for a particular condition, its previous value may be retained. This can lead to latch inference and demonstrates why complete assignments are important when describing combinational circuits.

###  Simulation Commands

```bash
iverilog -o bad_mux bad_mux.v tb_bad_mux.v

gtkwave bad_mux.vcd
```

###  Output Waveform

<img width="958" height="930" alt="incorrect multiplexer waveform" src="https://github.com/user-attachments/assets/858948b8-86c5-4915-b4de-6b1564d53740" />

###  Observation

The waveform demonstrates the effect of incomplete RTL coding and highlights a possible source of synthesis–simulation mismatch.

---

# 6️⃣ Blocking Assignment Simulation

## 📖 Overview

A **blocking assignment (`=`)** updates a variable immediately when the statement executes. Consequently, statements within the same procedural block are evaluated in sequence.

This experiment is designed to visualize that behavior during RTL simulation. It also demonstrates why blocking assignments are commonly used when describing combinational logic and why their use in sequential descriptions requires care.

###  Simulation Commands

```bash
iverilog -o blocking blocking_caveat.v tb_blocking_caveat.v

gtkwave blocking_caveat.vcd
```

###  Output Waveform

<img width="958" height="930" alt="blocking assignment simulation waveform" src="https://github.com/user-attachments/assets/ebc6762c-0679-49f4-9346-b01a3aa67573" />

###  Observation

The waveform illustrates the immediate and sequential evaluation of blocking assignments within the procedural block.

---

# 7️⃣ Synthesis of Blocking Assignment Circuit

## 📖 Overview

The blocking-assignment design is synthesized using **Yosys** to examine how the RTL description is converted into hardware.

The resulting logic is technology-mapped to the SKY130 library, providing a gate-level representation of the synthesized circuit.

###  Synthesis Commands

```bash
yosys

read_verilog blocking_caveat.v

synth -top blocking_caveat

abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

show
```

###  Technology-Mapped Circuit

<img width="958" height="930" alt="technology mapped blocking assignment circuit" src="https://github.com/user-attachments/assets/ba29e4c8-a690-4fc4-b0d9-2dd8e1efc9a8" />

###  Observation

The synthesized circuit represents the hardware structure derived from the blocking-assignment RTL description.

---

# Blocking Assignment and Previous Values

## 📖 Overview

This experiment takes a closer look at how blocking assignments (`=`) behave when multiple statements are executed within the same procedural block.

Since a blocking assignment updates the destination immediately, a later statement can use the newly assigned value. As a result, the **order of statements** can directly influence the simulation result.

This behavior is especially important when deciding whether blocking or non-blocking assignments should be used in a particular type of RTL description.

###  Simulation Commands

```bash
iverilog -o blocking_past blocking_caveat.v tb_blocking_caveat.v

gtkwave blocking_caveat.vcd
```

### 🖼️ Output

<img width="958" height="930" alt="blocking assignment previous value waveform" src="https://github.com/user-attachments/assets/a44b2749-ce64-4ec0-b89d-d9136ed310e7" />

###  Result

The waveform demonstrates that blocking assignments take effect immediately during procedural execution. It also shows how the ordering of statements can influence the values observed later in the same block.

For sequential logic, non-blocking assignments (`<=`) are generally preferred because they model simultaneous register updates more appropriately.

---

#  Overall Result

The experiments provided practical experience with:

* 2×1 multiplexer implementation.
* RTL simulation and waveform analysis.
* Blocking assignment behavior.
* Incorrect combinational RTL coding.
* Latch-related behavior.
* Synthesis–simulation mismatch scenarios.
* RTL synthesis using Yosys.
* Technology mapping using the SKY130 standard-cell library.

The complete set of experiments demonstrates the importance of writing RTL that accurately represents the intended hardware behavior.

---

#  Conclusion

Module 4 provided hands-on exposure to **blocking and non-blocking assignments, multiplexer design, RTL simulation, synthesis, and technology mapping**.

The experiments show how the choice of assignment operator and the completeness of combinational logic descriptions can influence simulation and synthesized hardware. The incorrect multiplexer examples particularly emphasize the need to avoid incomplete assignments when describing combinational circuits.

The overall design flow — **Icarus Verilog for simulation, GTKWave for waveform analysis, Yosys for synthesis, and SKY130 for technology mapping** — provides a practical view of how RTL descriptions progress toward hardware implementation.

---


Vidya Jyothi Institute of Technology, Hyderabad

[RTL Workshop Repository](#)
