# Inception of Open-Source EDA, OpenLANE and SKY130 PDK

## Module Overview

This module introduces the fundamentals of open-source Electronic Design Automation (EDA), System-on-Chip (SoC) design, OpenLANE, and the SKY130 technology ecosystem.

The main objective is to understand how a hardware idea moves from a high-level RTL description to a physical chip layout. The module also explains the relationship between software, processors, digital hardware, standard cells, intellectual property (IP), and physical design.

The learning path begins with basic semiconductor packaging concepts and progresses toward the automated RTL-to-GDSII flow used in digital ASIC design.

---

## Learning Objectives

After completing this module, the following concepts should be understood:

* Basic semiconductor packaging terminology
* Difference between a chip, die, core, and pad
* QFN-48 package and its purpose
* Concept of Intellectual Property (IP) blocks
* Introduction to RISC-V architecture
* Relationship between software instructions and hardware
* Components of an open-source digital ASIC design flow
* RTL-to-GDSII implementation flow
* Purpose of the SKY130 technology ecosystem
* Role of OpenLANE in ASIC implementation
* Introduction to STRIVE-based open-source silicon efforts
* Open-source EDA tools used in ASIC design
* OpenLANE project structure
* Design preparation and synthesis
* Reviewing synthesis reports
* Basic synthesis result characterization

---

## Module Contents

### 1. How to Talk to Computers

This section covers:

* QFN-48 package
* Chip and die
* Pads
* Core
* Intellectual Property (IP)
* RISC-V
* Software-to-hardware translation
* Processor and hardware relationship

### 2. SoC Design and OpenLANE

This section covers:

* Components of an open-source digital ASIC design flow
* RTL
* Standard-cell libraries
* PDK
* EDA tools
* RTL-to-GDSII flow
* OpenLANE
* STRIVE-related open-source silicon efforts
* Detailed ASIC implementation stages

### 3. Familiar Open-Source EDA Tools

This section covers:

* Icarus Verilog
* GTKWave
* Yosys
* OpenROAD
* OpenSTA
* Magic
* Netgen
* KLayout
* OpenLANE
* Git and GitHub
* OpenLANE directory structure
* Design preparation
* Synthesis
* Report analysis
* Synthesis characterization

---

## Simplified RTL-to-GDSII Flow

A digital ASIC can be represented by the following sequence:

```text
RTL
  ↓
RTL Simulation
  ↓
Logic Synthesis
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

Each stage transforms the design into a more physical representation.

---

## Major Tools Used

| Tool           | Main Purpose                               |
| -------------- | ------------------------------------------ |
| Icarus Verilog | RTL simulation                             |
| GTKWave        | Waveform visualization                     |
| Yosys          | RTL synthesis                              |
| OpenROAD       | Physical design implementation             |
| OpenSTA        | Static timing analysis                     |
| Magic          | Layout and design-rule checking            |
| Netgen         | Layout-versus-schematic/netlist comparison |
| KLayout        | Layout viewing and analysis                |
| OpenLANE       | Automated RTL-to-GDSII flow                |
| Git            | Version control                            |
| GitHub         | Source-code hosting and collaboration      |

---

## Overall Learning Flow

```text
Computer Software
       ↓
Processor Instructions
       ↓
RISC-V Architecture
       ↓
RTL Design
       ↓
Simulation
       ↓
Synthesis
       ↓
Standard Cells
       ↓
Floorplanning
       ↓
Placement
       ↓
CTS
       ↓
Routing
       ↓
Physical Verification
       ↓
GDSII
       ↓
Fabrication
```

---

## Expected Outcome

By the end of this module, the learner should be able to explain the basic stages involved in digital ASIC implementation and understand how open-source tools can be combined to create a complete RTL-to-GDSII design flow.

The module also provides the foundation required for later practical work involving RTL design, synthesis, timing analysis, physical design, and chip layout.

---

## Repository Structure

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

---

## Conclusion

Open-source EDA has made it possible for students, researchers, and hardware developers to study ASIC design using publicly available tools and technology resources.

Understanding the complete path from software instructions and RTL to a physical GDSII layout provides a strong foundation for digital VLSI and SoC design.

This module establishes that foundation by connecting computer architecture, RTL design, synthesis, physical implementation, timing analysis, and layout verification into one complete ASIC design flow.
