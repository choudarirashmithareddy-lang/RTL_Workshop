#  Module 4 – RTL Design, Synthesis & Gate-Level Verification

##  Overview

Module 4 focuses on understanding how an RTL design progresses from **Verilog source code to synthesized hardware and finally to Gate-Level Simulation (GLS)**.

The experiments provide practical experience with MUX design, RTL simulation, Yosys synthesis, standard-cell technology mapping, netlist generation, waveform analysis, sensitivity lists, blocking assignments, and simulation–synthesis mismatches.

###  Concepts Covered

* Ternary-operator based MUX
* RTL functional simulation
* Logic synthesis using Yosys
* SKY130 standard-cell mapping
* Gate-level netlist generation
* Gate-Level Simulation
* Sensitivity-list behavior
* Blocking assignments
* RTL versus GLS waveform comparison
* Simulation–synthesis mismatch

---

## Table of Contents

1. [RTL-to-Gate-Level Design Flow](#1-rtl-to-gate-level-design-flow)
2. [Ternary Operator MUX](#2-ternary-operator-mux)

   * [Working Principle](#21-working-principle)
   * [RTL Simulation](#22-rtl-simulation)
   * [Synthesis](#23-synthesis)
   * [Gate-Level Simulation](#24-gate-level-simulation)
3. [Bad MUX – Incomplete Sensitivity List](#3-bad-mux--incomplete-sensitivity-list)

   * [Problem Description](#31-problem-description)
   * [RTL Simulation](#32-rtl-simulation)
   * [Synthesis and Gate-Level Simulation](#33-synthesis-and-gate-level-simulation)
   * [Improved Coding Style](#34-improved-coding-style)
4. [Blocking Assignment Experiment](#4-blocking-assignment-experiment)

   * [Blocking Assignment Concept](#41-blocking-assignment-concept)
   * [RTL Simulation](#42-rtl-simulation)
   * [Synthesis](#43-synthesis)
   * [Gate-Level Simulation](#44-gate-level-simulation)
5. [Blocking vs Non-Blocking Assignments](#5-blocking-vs-non-blocking-assignments)
6. [Why `always @(*)` Matters](#6-why-always--matters)
7. [Understanding Simulation–Synthesis Mismatch](#7-understanding-simulationsynthesis-mismatch)
8. [RTL Simulation vs Gate-Level Simulation](#8-rtl-simulation-vs-gate-level-simulation)
9. [Tools Used](#9-tools-used)
10. [Key Observations](#10-key-observations)
11. [Learning Outcomes](#11-learning-outcomes)
12. [Conclusion](#12-conclusion)

---

# 1. RTL-to-Gate-Level Design Flow

The experiments in Day 4 follow the typical progression from an RTL description to a technology-mapped implementation and its post-synthesis verification.

```text
RTL Verilog Code
       |
       v
RTL Simulation
       |
       v
Yosys Synthesis
       |
       v
Technology Mapping
       |
       v
Gate-Level Netlist
       |
       v
Gate-Level Simulation
       |
       v
GTKWave
       |
       v
Waveform Analysis
```

### Flow Description

* **RTL Design:** The required circuit is described using Verilog HDL.
* **RTL Simulation:** Functional behavior is checked before synthesis.
* **Synthesis:** Yosys converts the RTL into a hardware representation.
* **Technology Mapping:** The design is mapped to cells available in the SKY130 library.
* **Netlist Generation:** A gate-level representation of the design is produced.
* **Gate-Level Simulation:** The synthesized implementation is simulated again.
* **Waveform Analysis:** RTL and gate-level results can be compared using GTKWave.

This flow helps verify both the intended RTL behavior and the behavior of the synthesized circuit.

---

# 2. Ternary Operator MUX

## 2.1 Working Principle

A **multiplexer (MUX)** is a combinational circuit that forwards one selected input to its output.

For a 2:1 MUX, there are two data inputs, one select signal, and one output.

```text
i0 --------\
             \
              >------ y
             /
i1 --------/
       |
      sel
```

The selection operation is:

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

The same functionality can be represented compactly in Verilog with the ternary operator:

```verilog
assign y = sel ? i1 : i0;
```

The conditional operator makes the selection relationship explicit and provides a concise way to describe the MUX.

---

## 2.2 RTL Simulation

Before synthesis, the MUX was verified through RTL simulation.

The primary signals examined during simulation were:

```text
i0
i1
sel
y
```

The output behavior is:

* With `sel` LOW, `y` follows `i0`.
* With `sel` HIGH, `y` follows `i1`.

### RTL Waveform

![Ternary MUX RTL Waveform](images/ternary_mux_rtl.png)

The waveform verifies the expected functional behavior of the MUX at the RTL level.

---

## 2.3 Synthesis

After confirming the RTL functionality, the design was synthesized using **Yosys**.

During this stage, the Verilog description is converted into hardware logic and mapped using cells available in the **SKY130 standard-cell library**.

The MUX was mapped to:

```text
sky130_fd_sc_hd__mux2_1
```

### Synthesized Netlist

![Ternary MUX Synthesized Netlist](images/ternary_mux_netlist.png)

The netlist illustrates how the simple RTL statement:

```verilog
assign y = sel ? i1 : i0;
```

is transformed into a technology-specific hardware implementation.

---

## 2.4 Gate-Level Simulation

The synthesized netlist was subsequently used for **Gate-Level Simulation**.

The testbench applies the required input combinations, and the resulting behavior is observed through GTKWave.

### Gate-Level Waveform

![Ternary MUX Gate-Level Waveform](images/ternary_mux_gls.png)

The RTL and gate-level waveforms can be compared to confirm that synthesis has preserved the intended MUX functionality.

### Complete MUX Flow

```text
RTL MUX
   |
   v
Ternary Operator
   |
   v
Yosys Synthesis
   |
   v
sky130_fd_sc_hd__mux2_1
   |
   v
Gate-Level Simulation
```

---

# 3. Bad MUX – Incomplete Sensitivity List

## 3.1 Problem Description

A combinational MUX can also be written using an `always` block. However, the sensitivity list must include every signal that can affect the output.

An incorrect implementation is:

```verilog
always @(sel)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

The issue here is that the sensitivity list contains only `sel`.

However, the output depends on:

```text
sel
i0
i1
```

Therefore, changes in `i0` or `i1` may not cause the procedural block to execute when `sel` remains unchanged.

---

## 3.2 RTL Simulation

The incorrectly coded MUX was simulated to demonstrate the effect of the incomplete sensitivity list.

### RTL Waveform

![Bad MUX RTL Waveform](images/bad_mux_rtl.png)

The waveform shows that changes in the data inputs may not immediately appear at the output if the select signal remains unchanged.

This occurs because an RTL simulator triggers the `always` block only when one of the signals specified in its sensitivity list changes.

---

## 3.3 Synthesis and Gate-Level Simulation

The sensitivity list primarily controls **simulation behavior**; it is not a physical hardware component.

During synthesis, the synthesis tool determines the actual logic relationship described inside the procedural block.

Consequently, an incomplete sensitivity list can create a situation where the RTL simulation does not accurately reflect the behavior expected from the synthesized hardware.

### Gate-Level Waveform

![Bad MUX Gate-Level Waveform](images/bad_mux_gls.png)

Comparing the RTL waveform with the gate-level waveform demonstrates the difference between simulation behavior caused by the incomplete sensitivity list and the synthesized hardware behavior.

This experiment highlights how an apparently small RTL coding mistake can result in a simulation–synthesis mismatch.

---

## 3.4 Improved Coding Style

For combinational logic, the recommended form is:

```verilog
always @(*)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

The `@(*)` construct automatically includes the signals referenced by the procedural block in the sensitivity list.

Therefore, instead of manually writing:

```verilog
always @(sel)
```

the safer form is:

```verilog
always @(*)
```

This reduces the possibility of accidentally leaving out an input signal.

---

# 4. Blocking Assignment Experiment

## 4.1 Blocking Assignment Concept

Verilog provides two major procedural assignment operators:

```text
Blocking assignment       =
Non-blocking assignment   <=
```

A blocking assignment updates its destination immediately as the procedural statements execute.

For example:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

Here, the first statement is evaluated before the second one. Therefore, the newly calculated value of `x` is available to the following statement.

This makes statement ordering important when blocking assignments are used.

---

## 4.2 RTL Simulation

The blocking-assignment circuit was first evaluated through RTL simulation.

The logical relationship can be visualized as:

```text
a ----\
       OR ---- x ----\
b ----/              \
                      AND ----> d
c ------------------/
```

### RTL Waveform

![Blocking Assignment RTL Waveform](images/blocking_caveat_rtl.png)

The waveform illustrates how the intermediate signal and final output change during RTL simulation.

Because the assignments are blocking, the updated value of the intermediate signal becomes available immediately to the next statement.

---

## 4.3 Synthesis

The design was synthesized using **Yosys** and mapped to cells from the **SKY130 standard-cell library**.

The relevant synthesized logic includes:

```text
sky130_fd_sc_hd__o21a_1
```

### Synthesized Netlist

![Blocking Assignment Synthesized Netlist](images/blocking_caveat_netlist.png)

The synthesized netlist represents the combinational hardware derived from the RTL description.

The procedural statements are converted into connections between technology-specific standard cells.

---

## 4.4 Gate-Level Simulation

The synthesized netlist was then subjected to Gate-Level Simulation.

### Gate-Level Waveform

![Blocking Assignment Gate-Level Waveform](images/blocking_caveat_gls.png)

The GLS waveform represents the behavior of the synthesized circuit.

Comparing RTL simulation with gate-level simulation provides a useful way to understand how procedural RTL descriptions correspond to the resulting hardware.

### Conceptual Flow

```text
Blocking Assignment
        |
        v
Sequential RTL Execution
        |
        v
Intermediate Signal Updated
        |
        v
Next Statement Uses Updated Value
```

This demonstrates why the ordering of blocking-assignment statements should be considered carefully.

---

# 5. Blocking vs Non-Blocking Assignments

## Blocking Assignment

The blocking operator is:

```text
=
```

Example:

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

The statements execute one after another, and the updated value of `x` can immediately be used by the next statement.

Blocking assignments are generally used when describing combinational procedural logic.

## Non-Blocking Assignment

The non-blocking operator is:

```text
<=
```

Example:

```verilog
always @(posedge clk)
begin
    q <= d;
end
```

A non-blocking assignment schedules the update rather than making the new value immediately available to subsequent statements in the same procedural evaluation.

They are generally preferred for sequential elements such as registers and flip-flops.

| Blocking `=`                                   | Non-Blocking `<=`                                    |
| ---------------------------------------------- | ---------------------------------------------------- |
| Assignment takes effect immediately            | Assignment update is scheduled                       |
| Statements execute in sequence                 | Updates occur after the current evaluation           |
| Commonly used for combinational logic          | Commonly used for sequential logic                   |
| Statement order can affect intermediate values | Suitable for modelling simultaneous register updates |

---

# 6. Why `always @(*)` Matters

When combinational logic is implemented inside an `always` block, all signals capable of changing the output need to be considered.

An incomplete sensitivity list such as:

```verilog
always @(sel)
```

can cause incorrect RTL simulation because changes to other input signals may not trigger the block.

Using:

```verilog
always @(*)
```

is a safer approach.

For example:

```verilog
always @(*)
begin
    if (sel)
        y = i1;
    else
        y = i0;
end
```

With `always @(*)`, changes to `sel`, `i0`, or `i1` can cause the procedural block to execute.

Therefore, using `always @(*)` helps avoid simulation problems caused by accidentally omitted signals.

---

# 7. Understanding Simulation–Synthesis Mismatch

A **simulation–synthesis mismatch** occurs when the behavior observed during RTL simulation does not correspond to the behavior expected from the synthesized hardware.

The experiments in this module demonstrate two important situations.

### Incomplete Sensitivity List

```verilog
always @(sel)
```

Although `i0` and `i1` also influence the output, only `sel` appears in the sensitivity list.

As a result, RTL simulation may fail to respond when a data input changes while the select signal remains constant.

The synthesized hardware, however, is derived from the actual logic relationship represented by the RTL.

### Blocking Assignment

```verilog
always @(*)
begin
    x = a | b;
    d = x & c;
end
```

Blocking assignments execute sequentially during RTL simulation, making statement order relevant to the values observed within the procedural block.

### General Concept

```text
RTL Coding Issue
      |
      v
Unexpected RTL Simulation
      |
      v
Synthesis
      |
      v
Hardware Implementation
      |
      v
RTL vs GLS Comparison
```

These experiments demonstrate why RTL should be written carefully so that its simulation behavior accurately represents the intended hardware.

---

# 8. RTL Simulation vs Gate-Level Simulation

| Feature         | RTL Simulation             | Gate-Level Simulation            |
| --------------- | -------------------------- | -------------------------------- |
| Input           | RTL Verilog                | Synthesized netlist              |
| Design stage    | Before synthesis           | After synthesis                  |
| Primary purpose | Functional verification    | Post-synthesis verification      |
| Representation  | Behavioral/RTL description | Standard-cell implementation     |
| Timing          | Mainly functional behavior | May include cell and gate delays |
| Simulator       | Icarus Verilog             | Icarus Verilog                   |
| Waveform viewer | GTKWave                    | GTKWave                          |

### RTL Simulation

RTL simulation checks whether the Verilog description behaves according to the intended functionality.

### Gate-Level Simulation

Gate-Level Simulation verifies the behavior of the synthesized implementation after conversion into standard-cell logic.

Comparing the two waveforms provides additional confidence that the synthesis process has maintained the intended functionality.

---

# 9. Tools Used

| Tool               | Purpose                                      |
| ------------------ | -------------------------------------------- |
| **Yosys**          | RTL synthesis and netlist generation         |
| **Icarus Verilog** | Verilog compilation and simulation           |
| **GTKWave**        | Waveform visualization and analysis          |
| **SKY130 PDK**     | Standard-cell library for technology mapping |

---

# 10. Key Observations

## Ternary Operator MUX

```text
RTL Description
      |
      v
assign y = sel ? i1 : i0;
      |
      v
Yosys Synthesis
      |
      v
sky130_fd_sc_hd__mux2_1
      |
      v
Gate-Level Simulation
```

The ternary operator offers a concise way of describing a 2:1 multiplexer.

## Bad MUX

The problematic implementation uses:

```verilog
always @(sel)
```

The data inputs are missing from the sensitivity list.

For combinational logic, the preferred form is:

```verilog
always @(*)
```

## Blocking Assignment

```verilog
x = a | b;
d = x & c;
```

The first assignment takes effect immediately, allowing the next statement to use the updated value of `x`.

## Gate-Level Verification

```text
RTL
 |
 v
Synthesis
 |
 v
Gate-Level Netlist
 |
 v
Gate-Level Simulation
 |
 v
Waveform Analysis
```

Gate-Level Simulation provides an additional verification stage after synthesis.

---

# 11. Learning Outcomes

After completing the Day 4 experiments, I developed an understanding of:

* RTL-to-Gate-Level verification flow
* Ternary-operator based MUX design
* RTL simulation
* Yosys-based synthesis
* Standard-cell technology mapping
* Gate-level netlist generation
* Gate-Level Simulation
* Waveform inspection using GTKWave
* Verilog sensitivity lists
* The purpose of `always @(*)`
* Blocking assignments
* Non-blocking assignments
* Simulation–synthesis mismatch
* Proper combinational RTL coding practices
* Differences between RTL and synthesized hardware behavior

The experiments also helped connect the theoretical concepts of RTL design with the actual waveforms and netlists generated during the implementation flow.

---

# 12. Conclusion

Day 4 provided practical experience with the progression from **RTL design to synthesized hardware and Gate-Level Simulation**.

The ternary MUX experiment demonstrated how a compact Verilog description can be synthesized into a technology-specific standard-cell implementation. The Bad MUX experiment highlighted the problems that can arise from an incomplete sensitivity list and showed how RTL simulation may differ from synthesized hardware behavior.

The blocking-assignment experiment further demonstrated that procedural statements execute in sequence and that the order of blocking assignments can influence intermediate values during simulation.

By examining RTL waveforms, synthesized netlists, and gate-level waveforms, the relationship between Verilog code and its resulting hardware became clearer. The use of **Icarus Verilog, GTKWave, Yosys, and the SKY130 PDK** provided hands-on experience with an important RTL-to-hardware verification flow.

Overall, this session strengthened my understanding of **RTL coding, synthesis, technology mapping, simulation, and post-synthesis verification**, while emphasizing the importance of writing clear and reliable Verilog designs.
