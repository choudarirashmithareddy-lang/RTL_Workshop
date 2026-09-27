# RTL Design and Physical Design Workshop

## About This Repository

This repository contains my hands-on learning work in **RTL Design, Digital Design Verification, Logic Synthesis, and Physical Design** using open-source VLSI tools.

The work begins with writing and simulating Verilog RTL and gradually moves toward synthesis, standard-cell technology mapping, timing analysis, floorplanning, placement, routing, physical verification, and the RTL-to-GDSII implementation flow.

The repository contains practical experiments, Verilog source files, testbenches, simulation waveforms, synthesis results, configuration files, screenshots, observations, and Physical Design experiments.

---

# Workshop Progress

| Section         | Module      | Main Area                                         | Status      |
| --------------- | ----------- | ------------------------------------------------- | ----------- |
| RTL             | Module 1    | RTL Design, Simulation and Synthesis              | Completed   |
| RTL             | Module 2    | Timing Libraries, Synthesis and Flip-Flops        | Completed   |
| RTL             | Module 3    | RTL and Logic Optimization                        | Completed   |
| RTL             | Module 4    | Gate-Level Simulation and RTL Coding Practices    | Completed   |
| RTL             | Module 5    | RTL Coding Styles and Loop Constructs             | Completed   |
| Physical Design | PD Module 1 | Open-Source EDA, OpenLane and SKY130              | In Progress |
| Physical Design | PD Module 2 | Floorplanning and Power Distribution              | In Progress |
| Physical Design | PD Module 3 | Standard Cell Design, Layout and Characterization | In Progress |
| Physical Design | PD Module 4 | Timing, STA and Physical Verification             | Planned     |
| Physical Design | PD Module 5 | RTL-to-GDSII Flow and SoC Implementation          | Planned     |

---

# Repository Structure

```text
RTL_Workshop/
│
├── README.md
│
├── Module1/
│   └── README.md
│
├── Module2/
│   └── README.md
│
├── Module3/
│   └── README.md
│
├── Module4/
│   └── README.md
│
├── Module5/
│   └── README.md
│
├── PD_module1/
│   └── README.md
│
├── PD_module2/
│   └── README.md
│
├── PD_module3/
│   └── README.md
│
├── PD_module4/
│   └── README.md
│
├── PD_module5/
│   └── README.md
│
├── assessment/
│
└── vsdbabysoc/
```

---

# Part 1 — RTL Design

The first part of the workshop focuses on understanding how a digital design moves from Verilog RTL code to a synthesized gate-level representation.

---

# Module 1 — RTL Design, Simulation and Synthesis

Module 1 introduces the basic RTL development environment and the relationship between Verilog code, simulation, waveform analysis and synthesis.

## Topics Covered

* Basics of RTL design
* Digital design description using Verilog
* Simulator, design and testbench concepts
* Simulation workflow
* Icarus Verilog
* Verilog compilation
* Testbench development
* 2:1 Multiplexer
* GTKWave waveform analysis
* RTL synthesis
* Introduction to Yosys
* Standard-cell libraries
* `.lib` files
* Timing information in libraries
* Faster and slower standard cells
* Technology-dependent synthesis
* Synthesis statistics

## Tools Used

* Verilog
* Icarus Verilog
* GTKWave
* Yosys
* SKY130 standard-cell library
* Ubuntu/Linux

---

# Module 2 — Timing Libraries, Synthesis and Flip-Flop RTL

Module 2 explores technology libraries and sequential RTL design. The experiments help understand how timing libraries are used during synthesis and how different flip-flop coding styles affect the resulting hardware.

## Topics Covered

* SKY130 PDK introduction
* Standard-cell timing libraries
* `.lib` file structure
* PVT conditions
* `tt_025C_1v80`
* Cell timing information
* Hierarchical synthesis
* Flattened synthesis
* Comparison of synthesis approaches
* D flip-flop RTL coding
* Asynchronous reset
* Asynchronous set
* Synchronous reset
* Icarus Verilog simulation
* Yosys synthesis
* Synthesis statistics

---

# Module 3 — RTL and Logic Optimization

Module 3 focuses on how synthesis tools transform RTL into simpler and more efficient logic while preserving the intended functionality.

## Topics Covered

* RTL optimization
* Boolean logic optimization
* Constant propagation
* Redundant logic removal
* AND logic optimization
* OR logic optimization
* Multi-input logic
* D flip-flop optimization
* Constant-output flip-flops
* Counter optimization
* Comparison of RTL before and after optimization
* Analysis of synthesized hardware

## Learning Outcome

The experiments demonstrate how apparently different RTL descriptions can produce simplified hardware after synthesis.

---

# Module 4 — RTL to Gate-Level Simulation

Module 4 introduces the transition from RTL simulation to gate-level verification.

The experiments also examine how coding style can affect simulation behavior and how an RTL description may produce unexpected results when the coding rules are not followed correctly.

## Topics Covered

* RTL simulation
* Synthesis using Yosys
* Technology mapping
* Standard-cell netlists
* Gate-level netlist generation
* Gate-level simulation
* RTL versus gate-level comparison
* Ternary-based MUX
* 2:1 MUX
* Blocking assignments
* Non-blocking assignments
* Sensitivity lists
* `always @(*)`
* Incomplete conditional logic
* Simulation-synthesis mismatch
* Waveform comparison

---

# Module 5 — RTL Coding Styles and Loop Constructs

Module 5 focuses on practical RTL coding techniques, conditional statements, latch inference and hardware generation using loops.

## Topics Covered

* RTL coding styles
* `if-else`
* `case`
* Priority logic
* Complete conditional assignments
* Incomplete conditional assignments
* Latch inference
* Incomplete `if`
* Incomplete `case`
* Complete `case`
* `casez`
* Overlapping conditions
* Boolean simplification
* Redundant logic
* Procedural `for` loops
* Generate `for` loops
* Loop-based MUX
* DEMUX implementation
* Ripple Carry Adder
* Structural hardware generation

---

# RTL Learning Outcomes

After completing the RTL section, I gained practical exposure to:

## RTL Design

* Writing Verilog modules
* Developing testbenches
* Designing combinational circuits
* Designing sequential circuits
* Using different RTL coding styles
* Understanding hardware generated from RTL

## Simulation

* Compiling Verilog designs
* Running simulations with Icarus Verilog
* Generating VCD waveform files
* Viewing waveforms using GTKWave
* Debugging RTL behavior

## Synthesis

* Running Yosys synthesis
* Reading synthesis reports
* Understanding technology mapping
* Examining cell usage
* Generating gate-level netlists

## Optimization

* Constant propagation
* Logic simplification
* Redundant logic elimination
* Flip-flop optimization
* Counter optimization

## Verification

* RTL simulation
* Gate-level simulation
* RTL versus synthesized behavior
* Identifying simulation-synthesis mismatches

---

# Part 2 — Physical Design

After RTL design and synthesis, the next stage of the repository focuses on **Physical Design**.

Physical Design converts the synthesized logical netlist into an actual physical implementation consisting of standard cells, interconnections, power networks and layout geometry.

The Physical Design section uses open-source tools and the **SKY130 PDK** to study the RTL-to-GDSII flow.

---

# PD Module 1 — Open-Source EDA, OpenLane and SKY130

This module introduces the open-source ASIC implementation ecosystem and the SKY130 process design kit.

## Topics Covered

* Open-source EDA overview
* ASIC design flow
* RTL-to-GDSII concept
* SKY130 PDK
* OpenLane
* OpenROAD
* Standard-cell libraries
* Technology files
* LEF files
* Liberty files
* GDS files
* SPICE files
* Verilog netlists
* Design configuration
* OpenLane directory structure
* RTL preparation
* Synthesis flow
* Synthesis reports
* Timing libraries
* Cell libraries
* PDK setup

## Main Flow

```text
RTL
 |
 v
RTL Preparation
 |
 v
Synthesis
 |
 v
Gate-Level Netlist
 |
 v
Floorplanning
 |
 v
Placement
 |
 v
Clock Tree Synthesis
 |
 v
Routing
 |
 v
Physical Verification
 |
 v
GDSII
```

---

# PD Module 2 — Chip Floorplanning and Power Integrity

This module focuses on converting the synthesized design into an initial physical structure.

## Topics Covered

* Die area
* Core area
* Aspect ratio
* Core utilization
* Standard-cell placement area
* Floorplan configuration
* I/O placement
* Pre-placed macros
* Placement blockages
* Tap cells
* Decap cells
* Power distribution network
* PDN generation
* Power delivery
* IR drop
* Switching current
* Inductive effects
* Power integrity
* OpenROAD floorplanning
* OpenLane configuration

## Important Configuration Parameters

```text
FP_CORE_UTIL
FP_ASPECT_RATIO
DIE_AREA
FP_IO_HMETAL
FP_IO_VMETAL
```

## Floorplanning Flow

```text
Synthesized Netlist
        |
        v
     Die Area
        |
        v
     Core Area
        |
        v
   I/O Placement
        |
        v
 Macro Placement
        |
        v
 Placement Blockages
        |
        v
 Power Distribution
        |
        v
   Initial Floorplan
```

---

# PD Module 3 — Standard Cell Design, Layout and Characterization

This module focuses on creating and studying custom standard-cell layouts using the SKY130 technology.

## Topics Covered

* Standard-cell architecture
* CMOS inverter
* PMOS and NMOS devices
* SKY130 technology
* Magic layout
* Layout-versus-schematic concepts
* Design-rule checking
* SPICE simulation
* CMOS inverter layout
* Extraction
* Parasitic-aware simulation
* SPICE deck creation
* Switching threshold
* Static behavior
* Dynamic behavior
* Rise time
* Fall time
* Propagation delay
* Cell characterization
* Timing information generation

## Main Tools

* Magic
* ngspice
* SKY130 PDK
* SPICE
* Linux/Ubuntu

## Characterization Flow

```text
Transistor-Level Design
        |
        v
     Layout
        |
        v
   DRC Checking
        |
        v
   Parasitic Extraction
        |
        v
    SPICE Deck
        |
        v
    ngspice
        |
        v
   Waveform Analysis
        |
        v
Timing Characterization
```

---

# PD Module 4 — Timing Analysis and Physical Verification

This module extends the physical-design flow toward timing analysis and verification of the implemented design.

## Topics Covered

* Static Timing Analysis
* Timing paths
* Startpoints and endpoints
* Clock definition
* Clock period
* Setup timing
* Hold timing
* Data arrival time
* Data required time
* Slack
* Critical paths
* Minimum and maximum delay
* Liberty timing data
* SPEF
* Parasitic information
* OpenSTA
* Timing reports
* DRC
* LVS
* Physical verification

## Timing Flow

```text
Gate-Level Netlist
        |
        +------> Liberty File
        |
        +------> SDC Constraints
        |
        +------> Parasitic Data
        |
        v
       STA
        |
        v
 Timing Reports
        |
        v
Setup / Hold Analysis
```

## Important Concepts

```text
Setup Slack
Hold Slack
Arrival Time
Required Time
Clock Period
Clock Skew
Cell Delay
Net Delay
```

---

# PD Module 5 — Complete RTL-to-GDSII Implementation

The final Physical Design module brings together the concepts studied throughout the earlier modules.

## Topics Covered

* RTL-to-GDSII flow
* OpenLane
* OpenROAD
* SKY130
* Synthesis
* Floorplanning
* Power planning
* Placement
* Clock Tree Synthesis
* Routing
* Parasitic extraction
* Static Timing Analysis
* DRC
* LVS
* GDSII generation
* Final layout inspection
* Physical implementation reports

## Complete ASIC Flow

```text
                 RTL
                  |
                  v
          RTL Synthesis
                  |
                  v
          Gate-Level Netlist
                  |
                  v
          Floorplanning
                  |
                  v
        Power Distribution
                  |
                  v
             Placement
                  |
                  v
      Clock Tree Synthesis
                  |
                  v
              Routing
                  |
                  v
        Parasitic Extraction
                  |
                  v
        Static Timing Analysis
                  |
                  v
       +----------+----------+
       |                     |
      DRC                   LVS
       |                     |
       +----------+----------+
                  |
                  v
               GDSII
```

---

# Physical Design Learning Outcomes

The Physical Design section provides practical exposure to the following areas:

## Open-Source EDA

* Open-source ASIC design tools
* OpenLane
* OpenROAD
* Magic
* ngspice
* OpenSTA
* SKY130 PDK

## Floorplanning

* Die and core dimensions
* Aspect ratio
* Utilization
* I/O placement
* Macro placement
* Placement blockages

## Power Planning

* Power grid concepts
* Power distribution networks
* Tap cells
* Decap cells
* IR drop
* Power integrity

## Placement and Routing

* Standard-cell placement
* Clock tree concepts
* Routing
* Metal layers
* Interconnects
* Congestion

## Timing

* Liberty files
* SDC constraints
* Static Timing Analysis
* Setup analysis
* Hold analysis
* Timing paths
* Slack
* SPEF
* Parasitics

## Physical Verification

* DRC
* LVS
* Layout inspection
* Parasitic extraction
* GDSII generation

---

# Tools and Technologies

| Category                | Tools / Technologies |
| ----------------------- | -------------------- |
| HDL                     | Verilog              |
| RTL Simulation          | Icarus Verilog       |
| Waveform Viewer         | GTKWave              |
| Synthesis               | Yosys                |
| PDK                     | SKY130               |
| ASIC Flow               | OpenLane             |
| Physical Implementation | OpenROAD             |
| Layout                  | Magic                |
| SPICE Simulation        | ngspice              |
| Timing Analysis         | OpenSTA              |
| Layout Viewer           | KLayout              |
| OS                      | Ubuntu / Linux       |
| Version Control         | Git                  |
| Repository              | GitHub               |

---

# Overall Learning Flow

The complete learning path followed in this repository can be summarized as:

```text
Digital Design Fundamentals
            |
            v
       Verilog RTL
            |
            v
         Simulation
            |
            v
         Waveforms
            |
            v
         Synthesis
            |
            v
     Logic Optimization
            |
            v
      Gate-Level Netlist
            |
            v
       SKY130 Library
            |
            v
       Physical Design
            |
            v
       Floorplanning
            |
            v
          PDN
            |
            v
        Placement
            |
            v
           CTS
            |
            v
         Routing
            |
            v
      Parasitic Extraction
            |
            v
           STA
            |
            v
        DRC / LVS
            |
            v
          GDSII
```

---

# Repository Goals

The main objectives of this repository are:

* Build practical knowledge of RTL design.
* Understand Verilog coding and simulation.
* Learn synthesis using open-source tools.
* Study standard-cell timing libraries.
* Understand RTL optimization.
* Perform gate-level verification.
* Learn the SKY130 technology ecosystem.
* Understand the Physical Design flow.
* Practice floorplanning and power planning.
* Explore standard-cell layout and characterization.
* Perform timing analysis.
* Understand physical verification.
* Gain hands-on exposure to the RTL-to-GDSII flow.

---

# Current Progress

## Completed RTL Work

* Module 1 — RTL Design, Simulation and Synthesis
* Module 2 — Timing Libraries and Flip-Flop RTL
* Module 3 — RTL and Logic Optimization
* Module 4 — RTL to Gate-Level Simulation
* Module 5 — RTL Coding Styles and Loop Constructs

## Physical Design Work

* PD Module 1 — Open-Source EDA, OpenLane and SKY130
* PD Module 2 — Floorplanning and Power Integrity
* PD Module 3 — Standard Cell Design and Characterization
* PD Module 4 — Timing and Physical Verification
* PD Module 5 — RTL-to-GDSII Implementation

---

# Conclusion

This repository documents my progression from **RTL coding to physical implementation** using open-source VLSI tools.

The RTL section develops the foundation required to write, simulate, synthesize and optimize digital hardware. The Physical Design section extends this knowledge into the implementation domain, covering the SKY130 PDK, floorplanning, power distribution, placement, routing, timing analysis, physical verification and GDSII generation.

Together, these modules provide a practical view of the digital ASIC design flow:

**RTL → Synthesis → Netlist → Floorplan → Placement → CTS → Routing → STA → DRC/LVS → GDSII**

---

# Author

**Choudari Rashmitha**

Electronics and Communication Engineering

---

## Repository

This project is maintained as a personal learning repository for RTL design and open-source VLSI implementation.
