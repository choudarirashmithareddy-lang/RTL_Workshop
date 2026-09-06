# Familiar Open-Source EDA Tools

## Introduction

Open-source EDA tools provide software for designing, simulating, synthesizing, analyzing, and physically implementing digital circuits.

This section introduces commonly used tools and explains how they fit into an ASIC design workflow.

---

# 1. Icarus Verilog

Icarus Verilog is an open-source Verilog simulation tool.

It can be used to:

* Compile Verilog designs
* Run simulations
* Execute testbenches
* Generate simulation output

Example:

```bash
iverilog -o simulation design.v testbench.v
vvp simulation
```

---

# 2. GTKWave

GTKWave is a waveform viewer.

It can be used to inspect signals generated during simulation.

Typical workflow:

```text
Verilog RTL
     ↓
Icarus Verilog
     ↓
Simulation
     ↓
VCD waveform
     ↓
GTKWave
```

GTKWave helps verify whether the RTL behaves as expected.

---

# 3. Yosys

Yosys is an open-source synthesis framework.

It converts RTL into a gate-level representation.

A simplified process is:

```text
Verilog RTL
    ↓
Yosys
    ↓
Logic Optimization
    ↓
Technology Mapping
    ↓
Gate-Level Netlist
```

Yosys can also provide synthesis statistics such as:

* Number of cells
* Number of flip-flops
* Number of combinational cells
* Estimated area
* Hierarchy information

---

# 4. OpenROAD

OpenROAD is an open-source toolchain for digital physical design.

It supports important implementation stages such as:

* Floorplanning
* Placement
* Clock tree synthesis
* Routing
* Optimization
* Timing-related analysis

It is an important component in automated open-source ASIC implementation flows.

---

# 5. OpenSTA

OpenSTA is an open-source Static Timing Analysis tool.

It analyzes timing paths and reports information such as:

* Arrival time
* Required time
* Slack
* Clock paths
* Setup timing
* Hold timing

The general objective is to determine whether timing constraints are satisfied.

---

# 6. Magic

Magic is an open-source VLSI layout tool.

It can be used for:

* Layout viewing
* Layout editing
* Design-rule checking
* Physical inspection

It is commonly used in educational and open-source ASIC workflows.

---

# 7. Netgen

Netgen is used for netlist comparison and LVS-related verification.

LVS means **Layout Versus Schematic**.

In a digital ASIC flow, the extracted physical connectivity can be compared against the intended netlist.

The objective is to identify connectivity differences between the logical and physical representations.

---

# 8. KLayout

KLayout is a layout viewer and analysis tool.

It supports common IC layout formats and provides features for:

* Viewing layouts
* Inspecting layers
* Measuring geometry
* Analyzing layout structures
* Working with GDSII and related formats

---

# 9. OpenLANE

OpenLANE combines several open-source tools into an automated ASIC implementation flow.

It helps automate stages such as:

```text
RTL
 ↓
Synthesis
 ↓
Floorplanning
 ↓
Placement
 ↓
CTS
 ↓
Routing
 ↓
Verification
 ↓
GDSII
```

---

# 10. Git and GitHub

Git is a distributed version-control system.

GitHub provides a platform for hosting Git repositories.

A typical workflow is:

```bash
git add .
git commit -m "Add Module 1 content"
git push
```

Version control makes it easier to:

* Track changes
* Maintain project history
* Collaborate
* Recover previous versions
* Share projects

---

# 11. OpenLANE Directory Structure

The exact directory organization can vary depending on the OpenLANE version and installation method.

A simplified conceptual structure is:

```text
openlane/
│
├── designs/
│
├── flow/
│
├── scripts/
│
├── configuration/
│
├── pdks/
│
├── runs/
│
├── Makefile
│
└── README.md
```

---

# 12. Designs Directory

The `designs` directory contains user design information.

A typical design can be organized as:

```text
designs/
└── my_design/
    │
    ├── config.tcl
    │
    └── src/
        ├── top.v
        ├── alu.v
        └── control.v
```

The exact filenames depend on the project.

---

# 13. RTL Source Files

The `src` directory contains the RTL source code.

Example:

```text
src/
├── top.v
├── alu.v
├── control.v
└── registers.v
```

The top-level RTL module connects the major blocks of the design.

---

# 14. Configuration File

A configuration file contains design-specific parameters.

Typical configuration information may include:

* Design name
* Top-level module
* Clock port
* Clock period
* RTL file locations
* Technology settings
* Synthesis options

The exact variables depend on the OpenLANE version being used.

---

# 15. Runs Directory

The `runs` directory stores information generated during a flow execution.

A conceptual structure can look like:

```text
runs/
└── RUN_YYYY.MM.DD_HH.MM.SS/
    │
    ├── logs/
    ├── reports/
    ├── results/
    └── tmp/
```

These directories can contain:

* Tool logs
* Reports
* Netlists
* Layout data
* Intermediate files
* Timing information

---

# 16. Design Preparation

Before running synthesis, the design should be prepared carefully.

## Step 1 — Create the Design Directory

Create a directory for the design inside the appropriate design location.

Example:

```text
designs/
└── my_design/
```

---

## Step 2 — Add RTL Files

Place all required Verilog/SystemVerilog source files in the source directory.

Example:

```text
src/
├── top.v
├── datapath.v
└── controller.v
```

---

## Step 3 — Select the Top Module

The top module must be correctly identified.

For example:

```verilog
module top (
    input  wire clk,
    input  wire reset,
    input  wire a,
    input  wire b,
    output wire y
);

assign y = a & b;

endmodule
```

Here, `top` is the top-level module.

---

## Step 4 — Define the Clock

If the design is sequential, the clock must be properly specified.

For example:

```text
Clock Port   : clk
Clock Period : 10 ns
```

The actual value should be selected according to the design requirement.

---

## Step 5 — Check RTL

Before starting the ASIC flow, verify:

* RTL syntax
* Module names
* Port connections
* Clock signals
* Reset signals
* No unintended multiple drivers
* No missing modules

---

# 17. Reviewing Files After Preparation

After design preparation, generated files and logs should be checked before moving forward.

Important information to review includes:

* Design name
* Top module
* Technology
* RTL files
* Clock configuration
* Constraints
* Warnings
* Errors

If preparation produces errors, they should be fixed before continuing.

---

# 18. Running Synthesis

Synthesis converts the RTL into a gate-level netlist.

Conceptually:

```text
RTL
 ↓
Elaboration
 ↓
Logic Optimization
 ↓
Technology Mapping
 ↓
Gate-Level Netlist
```

The synthesis process attempts to preserve the required functionality while optimizing the implementation.

---

# 19. What to Review After Synthesis

After synthesis, examine the generated reports and logs.

Important information includes:

### Cell Count

The number of cells used by the synthesized design.

### Combinational Cells

Cells that perform logical operations.

Examples:

* NAND
* NOR
* AND
* OR
* XOR
* Multiplexer

### Sequential Cells

Storage elements such as:

* Flip-flops
* Latches

### Area

The total area occupied by the synthesized cells.

### Timing

Timing reports provide information about critical paths and slack.

### Warnings

Warnings may indicate potential design issues that do not necessarily stop the flow.

### Errors

Errors generally indicate problems that must be corrected before the flow can continue successfully.

---

# 20. Timing Concepts

## Clock Period

The time between two consecutive active clock edges.

For example:

```text
Clock Period = 10 ns
```

The corresponding ideal frequency is:

```text
Frequency = 1 / Period
```

Therefore:

```text
Frequency = 1 / 10 ns
          = 100 MHz
```

---

## Setup Slack

Setup slack indicates whether data can reach the destination register before the required clock edge.

General interpretation:

```text
Positive Setup Slack → Requirement satisfied
Negative Setup Slack → Setup violation
```

---

## Hold Slack

Hold slack indicates whether data remains stable for the required period after the clock edge.

General interpretation:

```text
Positive Hold Slack → Requirement satisfied
Negative Hold Slack → Hold violation
```

---

# 21. Characterizing Synthesis Results

Synthesis results should be recorded systematically.

A useful table is:

| Parameter           | Result             |
| ------------------- | ------------------ |
| Design Name         | Enter actual value |
| Technology          | Enter actual value |
| Top Module          | Enter actual value |
| Clock Port          | Enter actual value |
| Clock Period        | Enter actual value |
| Total Cells         | Enter actual value |
| Combinational Cells | Enter actual value |
| Sequential Cells    | Enter actual value |
| Cell Area           | Enter actual value |
| Worst Slack         | Enter actual value |
| Timing Status       | Pass / Violation   |
| Warnings            | Enter actual value |
| Errors              | Enter actual value |

**Important:** Actual values should be taken from the synthesis reports. They should not be guessed or manually fabricated.

---

# 22. Power, Performance and Area

ASIC design is often evaluated using the PPA concept:

```text
P → Power
P → Performance
A → Area
```

A good design attempts to achieve an appropriate balance between:

* Low power
* High performance
* Small area

Improving one parameter can sometimes negatively affect another.

For example:

```text
Higher Performance
        ↕
   More Area / Power
```

Therefore, ASIC implementation involves optimization and trade-offs.

---

# 23. GitHub Project Workflow

After completing the documentation or practical work, Git can be used to maintain the project.

Typical commands are:

```bash
git status
```

Check modified files.

```bash
git add .
```

Stage the changes.

```bash
git commit -m "Add Module 1 documentation"
```

Create a commit.

```bash
git push
```

Upload the changes to GitHub.

---

# 24. Recommended Repository Organization

```text
Inception_of_Open_Source_EDA/
│
├── README.md
│
├── 01_How_to_Talk_to_Computers/
│   └── README.md
│
├── 02_SoC_Design_and_OpenLANE/
│   └── README.md
│
├── 03_Familiar_Open_Source_EDA_Tools/
│   └── README.md
│
└── images/
    └── README.md
```

If an actual OpenLANE practical run is completed, a separate practical directory can be added later:

```text
04_Practical_OpenLANE_Run/
│
├── README.md
├── config.tcl
├── src/
│   └── top.v
└── results/
```

Only include result files and measurements that were actually generated during the experiment.

---

# 25. Open-Source ASIC Flow Summary

```text
                    RTL
                     ↓
              RTL Simulation
                     ↓
                 Synthesis
                     ↓
            Gate-Level Netlist
                     ↓
              Floorplanning
                     ↓
                Placement
                     ↓
         Clock Tree Synthesis
                     ↓
                  Routing
                     ↓
        Parasitic Extraction
                     ↓
       Static Timing Analysis
                     ↓
          Physical Verification
                     ↓
                   GDSII
```
# 26. Terminal Execution and Command Evidence

The following terminal screenshots provide evidence of the commands executed during the physical design setup and OpenLane flow.

## 26.1 PDK Directory and Library Setup

<img width="902" height="910" alt="pdk directory" src="https://github.com/user-attachments/assets/3b9efad2-76a0-42e4-9531-0af925738516" />


## 26.2 Sky130 Standard Cell Library Verification

<img width="937" height="986" alt="pdk lib" src="https://github.com/user-attachments/assets/1d3a90ed-5cbf-4461-94fd-fe7618a07a72" />

## 26.3 OpenLane Environment Setup
<img width="618" height="851" alt="openlane" src="https://github.com/user-attachments/assets/2528a4d7-ed6c-4411-a7bc-945001c5e411" />

## 26.4 LEF and Library File Verification

<img width="682" height="753" alt="lef" src="https://github.com/user-attachments/assets/c0b67226-3d20-4e74-901b-49a4a7022146" />


## 26.5 OpenLane Flow Execution
<img width="805" height="570" alt="openlane execution" src="https://github.com/user-attachments/assets/afaaa208-6e26-4b1f-a160-f17ee68c641a" />

## 26.6 OpenLane Configuration
<img width="817" height="758" alt="openlane configuration" src="https://github.com/user-attachments/assets/174203f5-1408-486e-8ded-3dd338ffa0e2" />


## 26.7 Floorplan Configuration 
<img width="692" height="728" alt="floor configuration" src="https://github.com/user-attachments/assets/6783893e-cfc3-4d65-a86f-75b5cd7e54de" />

---

# Conclusion

Open-source EDA tools provide an accessible environment for learning and experimenting with digital ASIC design.

Tools such as Icarus Verilog, GTKWave, Yosys, OpenROAD, OpenSTA, Magic, Netgen, KLayout, and OpenLANE each contribute to different stages of the design process.

Learning how these tools interact is important for understanding the complete ASIC workflow.

By studying the OpenLANE directory structure, preparing RTL designs, running synthesis, examining reports, and recording PPA-related results, a learner can develop a practical understanding of how RTL is transformed into a physical implementation.
