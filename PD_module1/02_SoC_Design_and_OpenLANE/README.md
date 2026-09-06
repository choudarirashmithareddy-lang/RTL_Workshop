# SoC Design and OpenLANE

## Introduction

A System-on-Chip (SoC) combines multiple functional blocks on a single semiconductor die.

Modern SoCs can contain:

* Processor cores
* Memory
* Communication interfaces
* Timers
* GPIO
* Security blocks
* Accelerators
* Clock circuits
* Power-management blocks

Designing such systems requires several stages, starting from an RTL description and ending with a physical layout.

---

# 1. Components of an Open-Source Digital ASIC Design

A complete digital ASIC design environment contains several important components.

## RTL

RTL stands for **Register Transfer Level**.

It describes:

* Registers
* Combinational logic
* Data movement
* Control logic
* Clocked behavior

Common RTL languages include:

* Verilog
* SystemVerilog

Example:

```verilog
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);

assign y = a & b;

endmodule
```

---

# 2. Standard-Cell Library

A standard-cell library contains pre-designed digital cells that can be used during synthesis and physical implementation.

Examples include:

* AND gates
* OR gates
* NAND gates
* NOR gates
* Inverters
* Buffers
* Multiplexers
* Flip-flops

Each cell is characterized with information such as:

* Area
* Timing
* Power
* Input capacitance
* Output behavior

The synthesis tool selects suitable cells from the library to implement the RTL.

---

# 3. PDK

PDK stands for **Process Design Kit**.

A PDK provides the technology-related information required by EDA tools.

It can contain information such as:

* Design rules
* Device information
* Layer definitions
* Technology files
* Standard-cell libraries
* Extraction information
* Simulation models

The SKY130 ecosystem is an important open technology platform used in educational and open-source silicon projects.
<img width="1600" height="702" alt="pd2 1" src="https://github.com/user-attachments/assets/0d4ce8eb-f8ba-433d-9941-b2997918081f" />

---

# 4. EDA Tools

EDA stands for **Electronic Design Automation**.

EDA tools automate different stages of chip development.

Examples include:

| Tool           | Function                |
| -------------- | ----------------------- |
| Icarus Verilog | RTL simulation          |
| GTKWave        | Waveform viewing        |
| Yosys          | Logic synthesis         |
| OpenROAD       | Physical implementation |
| OpenSTA        | Timing analysis         |
| Magic          | Layout and DRC          |
| Netgen         | LVS/netlist comparison  |
| KLayout        | Layout analysis         |
| OpenLANE       | Automated ASIC flow     |

---

# 5. Design Constraints

Constraints describe important requirements for the design.

Examples include:

* Clock period
* Input delay
* Output delay
* Clock uncertainty
* Input capacitance
* Maximum transition
* Maximum fanout

Timing constraints are particularly important because they determine whether the circuit can operate at the required frequency.

---

# 6. Simplified RTL-to-GDSII Flow

The overall digital ASIC implementation flow is:

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
Physical Verification
 ↓
Static Timing Analysis
 ↓
GDSII
```

---
<img width="1600" height="702" alt="pd2 4" src="https://github.com/user-attachments/assets/e3eafbc5-12f8-46ac-ad28-500ee721120c" />


# 7. RTL Simulation

Simulation is used to verify the logical behavior of the RTL before synthesis.

A testbench applies inputs to the design and observes the outputs.

Typical tools include:

* Icarus Verilog
* GTKWave

Basic workflow:

```text
RTL + Testbench
       ↓
   Compilation
       ↓
    Simulation
       ↓
 Waveform Analysis
```

Simulation helps identify functional errors before physical implementation.

---

# 8. Logic Synthesis

Synthesis converts RTL into a gate-level representation.

A simplified synthesis process is:

```text
RTL
 ↓
Parsing
 ↓
Elaboration
 ↓
Logic Optimization
 ↓
Technology Mapping
 ↓
Gate-Level Netlist
```

The resulting netlist contains standard-cell instances selected from the target technology library.

---

# 9. Floorplanning

Floorplanning determines the physical organization of the design.

It includes decisions about:

* Core dimensions
* Die dimensions
* I/O placement
* Macro placement
* Power structures

A simplified view is:

```text
+-----------------------------+
|          DIE                |
|  +-----------------------+  |
|  |        CORE           |  |
|  |                       |  |
|  |   Standard Cells      |  |
|  |   + Macros            |  |
|  |                       |  |
|  +-----------------------+  |
+-----------------------------+
```

---

# 10. Placement

Placement determines the physical locations of standard cells.

The objective is to create a layout that satisfies requirements related to:

* Area
* Timing
* Congestion
* Power
* Routability

---

# 11. Clock Tree Synthesis

Clock Tree Synthesis (CTS) creates a clock distribution network.

The purpose is to distribute the clock signal to sequential elements with controlled delay and skew.

A simplified structure is:

```text
             Clock Source
                  |
             Clock Buffer
              /       \
          Buffer      Buffer
          /   \       /   \
        FF1   FF2   FF3   FF4
```

---

# 12. Routing

Routing connects the placed cells using physical metal layers.

The routing process establishes:

* Signal connections
* Clock connections
* Power connections

Routing must obey the manufacturing design rules of the selected technology.

---

# 13. Physical Verification

Physical verification checks whether the final layout is suitable for fabrication.

Important checks include:

### DRC

Design Rule Checking verifies that the layout follows manufacturing rules.

### LVS

Layout Versus Schematic or netlist checking verifies that the physical connectivity corresponds to the intended design.

### Parasitic Extraction

Parasitic information can be extracted from the physical layout for more accurate timing and power analysis.

---

# 14. Static Timing Analysis

Static Timing Analysis (STA) determines whether timing requirements are satisfied without requiring functional simulation of every possible input combination.

Important terms include:

### Clock Period

The time between successive active clock edges.

### Setup Time

The data must remain stable for a specified time before the active clock edge.

### Hold Time

The data must remain stable for a specified time after the active clock edge.

### Slack

Slack represents the difference between the required timing and the actual timing.

A simplified interpretation is:

```text
Positive Slack → Timing requirement satisfied
Zero Slack     → Boundary condition
Negative Slack → Timing violation
```

---

# 15. OpenLANE

OpenLANE is an open-source automated RTL-to-GDSII implementation flow.

It combines multiple open-source EDA tools into a structured flow.

Its purpose is to reduce the amount of manual effort required to take a digital RTL design through synthesis and physical implementation.

A simplified view is:

```text
RTL
 ↓
OpenLANE
 ↓
Synthesis
 ↓
Floorplan
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

# 16. Why OpenLANE is Useful

OpenLANE is useful for learning and experimenting with ASIC implementation because it brings several stages together under a common flow.

Advantages include:

* Open-source workflow
* Automation
* Reproducibility
* Integration of multiple EDA tools
* Suitable for educational projects
* Useful for research and experimentation
* Supports open-source silicon development

---

# 17. STRIVE and Open-Source Silicon

STRIVE-related efforts are associated with initiatives that demonstrate the use of open-source hardware and ASIC design methodologies.

Such projects help demonstrate that open-source RTL, processors, EDA tools, and technology resources can be combined to create real silicon implementations.

The broader objective is to encourage:

* Open hardware development
* Processor experimentation
* SoC research
* ASIC education
* Community-based silicon design

---

# 18. Detailed OpenLANE ASIC Design Flow

A typical implementation sequence can be understood through the following stages.

## Stage 1 — Design Preparation

The design source files and configuration information are prepared.

Typical information includes:

* RTL source files
* Top module
* Clock definition
* Technology
* Timing constraints
* Design configuration

---

## Stage 2 — Synthesis

The RTL is converted into a technology-mapped gate-level netlist.

The synthesis stage considers:

* Logic functionality
* Area
* Timing
* Available standard cells

---

## Stage 3 — Floorplanning

The physical dimensions of the design are established.

Major objects such as macros and I/O regions are organized.

---

## Stage 4 — Placement

Standard cells are assigned physical positions.

The placement engine attempts to produce a layout with acceptable:

* Timing
* Congestion
* Area
* Routability

---

## Stage 5 — Clock Tree Synthesis

The clock network is constructed and optimized.

The objective is to deliver the clock to sequential elements with controlled skew and delay.

---

## Stage 6 — Routing

The signal, clock, and power connections are physically routed.

Routing uses available metal layers while respecting technology rules.

---

## Stage 7 — Timing Analysis

The design is analyzed to determine whether timing requirements are met.

Timing reports can reveal:

* Setup violations
* Hold violations
* Critical paths
* Slack
* Clock information

---

## Stage 8 — Physical Verification

The physical layout is checked for:

* Design-rule violations
* Connectivity problems
* Layout consistency

---

## Stage 9 — GDSII Generation

GDSII is a standard format used to represent integrated-circuit layout information.

The final GDSII represents the physical geometry that can be used in the semiconductor manufacturing flow.

---

# Complete OpenLANE Flow

```text
              RTL
               ↓
        Design Preparation
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

---

# Conclusion

SoC design requires cooperation between architecture, RTL design, synthesis, physical design, timing analysis, and verification.

OpenLANE provides an integrated open-source flow that helps connect these stages.

Understanding this flow is essential for anyone learning digital ASIC design because it explains how RTL eventually becomes a physical chip layout.
