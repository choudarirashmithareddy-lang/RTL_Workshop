# Day 2 – Timing Libraries, Synthesis Methods & Flip-Flop RTL Design

Welcome to **Day 2** of the RTL Design Workshop!

The second day focuses on important concepts that connect **RTL coding with synthesis and technology libraries**. In this session, we explore the SKY130 timing library, examine different synthesis strategies, and implement various D flip-flop configurations using Verilog.

The practical work also demonstrates how **Icarus Verilog**, **GTKWave**, and **Yosys** can be combined to simulate, analyze, synthesize, and map RTL designs.

---

## Table of Contents

1. [Introduction to Timing Libraries](#1-introduction-to-timing-libraries)

   * [SKY130 Technology Overview](#sky130-technology-overview)
   * [Interpreting the Library Filename](#interpreting-the-library-filename)
   * [Examining the Liberty File](#examining-the-liberty-file)
2. [Synthesis with and without Hierarchy](#2-synthesis-with-and-without-hierarchy)

   * [Hierarchical Approach](#hierarchical-approach)
   * [Flat Synthesis Approach](#flat-synthesis-approach)
   * [Synthesis Method Comparison](#synthesis-method-comparison)
3. [D Flip-Flop RTL Implementations](#3-d-flip-flop-rtl-implementations)

   * [D Flip-Flop with Asynchronous Reset](#d-flip-flop-with-asynchronous-reset)
   * [D Flip-Flop with Asynchronous Set](#d-flip-flop-with-asynchronous-set)
   * [D Flip-Flop with Synchronous Reset](#d-flip-flop-with-synchronous-reset)
4. [Verifying the Flip-Flop Designs](#4-verifying-the-flip-flop-designs)
5. [Synthesizing Flip-Flops with Yosys](#5-synthesizing-flip-flops-with-yosys)
6. [What Was Learned](#6-what-was-learned)
7. [Conclusion](#7-conclusion)

---

# 1. Introduction to Timing Libraries

## SKY130 Technology Overview

The **SKY130 PDK** is an open-source Process Design Kit developed around **SkyWater's 130 nm CMOS process**.

A PDK provides the technology-specific information required by electronic design automation tools. This information can include standard-cell descriptions, electrical characteristics, timing models, physical information, and process-related data.

For the experiments in this workshop, the following standard-cell timing library is used:

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

This library provides characterization data that can be used during synthesis and technology mapping.

---

## Interpreting the Library Filename

The name of the Liberty file contains useful information about the technology and operating conditions.

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

| Part       | Description                        |
| ---------- | ---------------------------------- |
| `sky130`   | 130 nm SKY technology              |
| `fd_sc_hd` | Standard-cell high-density library |
| `tt`       | Typical process corner             |
| `025C`     | Characterized at 25°C              |
| `1v80`     | 1.8 V operating voltage            |

The process, voltage, and temperature conditions are commonly referred to as **PVT conditions**.

```text
PVT = Process + Voltage + Temperature
```

Cell performance can change when these conditions vary, which is why libraries are characterized for specific operating corners.

---

## Examining the Liberty File

The **`.lib` file** is written using the Liberty format and contains detailed information about the standard cells available in a technology library.

Typical information found inside the file includes:

* Standard-cell definitions
* Input and output pins
* Logic functions
* Timing arcs
* Cell delays
* Transition characteristics
* Capacitance values
* Power information
* Cell area
* Operating conditions

### Step 1: Install Gedit

A simple way to inspect the library is to use a text editor such as Gedit.

```bash
sudo apt install gedit
```

### Step 2: Open the Library

Navigate to the directory containing the library and run:

```bash
gedit sky130_fd_sc_hd__tt_025C_1v80.lib
```

The file can then be searched to locate individual cells and examine their timing and electrical parameters.



---

# 2. Synthesis with and without Hierarchy

During synthesis, the RTL module structure can either be retained or removed.

The two commonly discussed approaches are:

* **Hierarchical synthesis**
* **Flattened synthesis**

The choice depends on the design size, optimization requirements, debugging needs, and implementation flow.

---

## Hierarchical Approach

### What Is Hierarchical Synthesis?

In hierarchical synthesis, the module organization defined in the RTL is maintained during synthesis.

For example:

```text
Top Module
│
├── Block A
├── Block B
└── Block C
```

The individual blocks remain identifiable in the synthesized representation.

### Main Characteristics

* RTL module boundaries are maintained.
* Sub-blocks can be analyzed individually.
* The overall design remains organized.
* Module-level analysis becomes easier.

### Benefits

* Simplifies debugging.
* Makes large designs easier to manage.
* Preserves the logical organization of the RTL.
* Useful when individual blocks are reused or independently developed.
* Makes design analysis more structured.

### Drawbacks

* Optimization between separate modules may be restricted.
* Some redundant logic may remain across module boundaries.
* Additional effort may be required for complete design-level analysis.

<img width="1920" height="940" alt="multiplemodules" src="https://github.com/user-attachments/assets/4b3e8aa0-98c7-409e-8284-e8ea90166af3" />

---

## Flat Synthesis Approach

### What Is Flattened Synthesis?

Flattening removes the hierarchy between modules and creates a single unified representation of the design.

For example:

```text
Top Module
│
├── Block A
├── Block B
└── Block C
```

can be transformed into:

```text
Complete Flat Netlist
```

In Yosys, the `flatten` command can be used to collapse the hierarchy.

### Benefits

* Allows optimization across module boundaries.
* Gives synthesis tools access to the complete design.
* Can remove redundant logic across different blocks.
* May improve overall optimization for suitable designs.

### Drawbacks

* Debugging becomes more difficult.
* Original module boundaries are no longer easily visible.
* Large designs may require additional memory.
* The resulting netlist can become difficult to inspect.

<img width="1920" height="940" alt="mm2" src="https://github.com/user-attachments/assets/7bacf637-6efe-405a-be71-d3df057e25ab" />



---

## Synthesis Method Comparison

| Parameter                 | Hierarchical Synthesis | Flattened Synthesis                   |
| ------------------------- | ---------------------- | ------------------------------------- |
| RTL hierarchy             | Retained               | Removed                               |
| Optimization              | Mainly within blocks   | Across the complete design            |
| Debugging                 | Relatively easier      | More challenging                      |
| Design organization       | Structured             | Unified                               |
| Cross-module optimization | Limited                | Extensive                             |
| Memory requirement        | Generally lower        | Can increase for large designs        |
| Best suited for           | Modular designs        | Designs requiring global optimization |

> **Important:** Hierarchical synthesis emphasizes modularity and easier analysis, while flattened synthesis provides a larger optimization scope by treating the design as one unified structure.

---

# 3. D Flip-Flop RTL Implementations

A **D flip-flop** is a sequential storage element that captures the value of the data input at a clock edge.

Different control mechanisms can be incorporated into a D flip-flop depending on the design requirements.

This section covers:

1. Asynchronous reset
2. Asynchronous set
3. Synchronous reset

---

## D Flip-Flop with Asynchronous Reset

An asynchronous reset can force the output to a known value immediately, without waiting for a clock transition.

```verilog
module dff_asyncres (
    input clk,
    input async_reset,
    input d,
    output reg q
);

always @(posedge clk or posedge async_reset)
begin
    if (async_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

### Working

* `async_reset = 1` forces `q` to `0`.
* When reset is inactive, `q` captures `d` at the rising edge of `clk`.

---

## D Flip-Flop with Asynchronous Set

An asynchronous set forces the stored output to logic `1` independently of the clock.

```verilog
module dff_async_set (
    input clk,
    input async_set,
    input d,
    output reg q
);

always @(posedge clk or posedge async_set)
begin
    if (async_set)
        q <= 1'b1;
    else
        q <= d;
end

endmodule
```

### Working

* `async_set = 1` immediately drives `q` to `1`.
* When the set signal is inactive, the input `d` is sampled on the rising edge of `clk`.

---

## D Flip-Flop with Synchronous Reset

A synchronous reset is evaluated only when the active clock edge occurs.

```verilog
module dff_syncres (
    input clk,
    input sync_reset,
    input d,
    output reg q
);

always @(posedge clk)
begin
    if (sync_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

### Working

* If `sync_reset = 1` during a rising clock edge, `q` becomes `0`.
* Changing the reset signal between clock edges does not immediately change the output.

---

# 4. Verifying the Flip-Flop Designs

The RTL designs can be tested using **Icarus Verilog**.

For example, the asynchronous-reset flip-flop can be compiled together with its testbench.

### Compile the Design

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
```

### Start the Simulation

```bash
./a.out
```

### Open the Waveform

```bash
gtkwave tb_dff_asyncres.vcd
```

GTKWave can be used to observe how the clock, reset, data, and output signals behave over simulation time.



---

# 5. Synthesizing Flip-Flops with Yosys
<img width="1920" height="940" alt="asynchronus" src="https://github.com/user-attachments/assets/7b56b5ab-8037-4fc7-a534-741a4a0b3140" />




The synthesized flip-flop can be mapped to an appropriate standard cell from the SKY130 library.

## Step 1: Launch Yosys

```bash
yosys
```

## Step 2: Load the Liberty File

```yosys
read_liberty -lib /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Replace the example path with the actual path on your system.

## Step 3: Read the Verilog Source

For the asynchronous-reset example:

```yosys
read_verilog /path/to/dff_asyncres.v
```

## Step 4: Select the Top Module and Synthesize

```yosys
synth -top dff_asyncres
```

Yosys processes the RTL and converts it into a synthesized representation.

## Step 5: Map the Flip-Flop

Use `dfflibmap` to identify a suitable flip-flop cell from the technology library:

```yosys
dfflibmap -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

## Step 6: Perform Technology Mapping

Use ABC to map the remaining combinational logic:

```yosys
abc -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

## Step 7: Generate the Schematic

To inspect the resulting synthesized circuit:

```yosys
show
```

<img width="1920" height="940" alt="asynchres" src="https://github.com/user-attachments/assets/98c793b8-1b1c-442b-ba0c-9e3bcf9dd2bd" />


---

# 6. What Was Learned

After completing this day's activities, the following concepts should be clear:

* Purpose of a **technology timing library**.
* Basic structure and information contained in a **Liberty `.lib` file**.
* Meaning of the process, voltage, and temperature conditions in the SKY130 library name.
* Difference between **hierarchical and flattened synthesis**.
* Advantages and limitations of preserving design hierarchy.
* Benefits of global optimization through flattening.
* RTL description of D flip-flops.
* Difference between **synchronous and asynchronous controls**.
* Simulation of sequential circuits using **Icarus Verilog**.
* Waveform inspection using **GTKWave**.
* RTL synthesis using **Yosys**.
* Flip-flop mapping using `dfflibmap`.
* Technology mapping using **ABC**.

---

# 7. Summary

Day 2 extends the basic RTL flow introduced in Day 1 by connecting RTL descriptions with **technology libraries and synthesis strategies**.

The overall process can be represented as:

```text
RTL Description
      ↓
Technology Library
      ↓
Synthesis
      ↓
Hierarchy Management
      ↓
Flip-Flop Identification
      ↓
DFF Library Mapping
      ↓
Technology Mapping
      ↓
Gate-Level Netlist
```

The session also demonstrates that RTL coding style directly influences how synthesis tools interpret and implement sequential logic.

---

## Tools and Technologies

| Tool / Technology  | Role                                           |
| ------------------ | ---------------------------------------------- |
| **Verilog HDL**    | Hardware description and RTL coding            |
| **Icarus Verilog** | Functional simulation                          |
| **GTKWave**        | Simulation waveform viewer                     |
| **Yosys**          | RTL synthesis                                  |
| **ABC**            | Logic optimization and technology mapping      |
| **SKY130 PDK**     | Open-source process technology                 |
| **Liberty `.lib`** | Standard-cell timing and characterization data |

---

## Final Takeaway

The main workflow covered in Day 2 is:

**Study the Technology → Understand the Library → Write RTL → Simulate → Synthesize → Map to Standard Cells**

These fundamentals provide a strong base for the next stages of the RTL-to-GDS flow, including **timing analysis, optimization, physical design, and implementation**.

