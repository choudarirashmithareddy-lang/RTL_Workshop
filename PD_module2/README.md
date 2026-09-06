## Chip Floorplanning and Power Integrity

## Project Overview

This module focuses on two important areas of ASIC Physical Design: **chip floorplanning** and **power integrity**.

Floorplanning establishes the physical organization of an ASIC by determining the die and core dimensions, estimating cell area, selecting utilization and aspect ratio, and deciding where standard cells, macros, and other fixed blocks should be located.

The module also introduces the electrical effects that influence physical implementation, including **switching current, IR drop, inductive voltage drop, noise margin, supply noise, and decoupling capacitors**.

Practical implementation concepts are demonstrated using the **OpenLane RTL-to-GDSII flow**, **OpenROAD**, and the **SKY130 PDK**. The later sections examine floorplan configuration, power planning, PDN generation, standard-cell placement, placement blockages, tap cells, LEF and technology files, timing constraints, and mapping logical cells to their corresponding physical library cells.

The overall objective is to understand how a digital design moves from a logical description to an organized physical implementation:

```text
RTL / Netlist
      ↓
Floorplanning
      ↓
Power Planning
      ↓
Cell Placement
      ↓
Routing
      ↓
Physical Layout
```

---

##  Objectives

The major learning goals of this module are:

* Understand the basic principles of ASIC physical design and floorplanning.
* Interpret a synthesized netlist from a physical-design perspective.
* Convert logical standard-cell representations into physical dimensions.
* Determine the total area required by the cells in a design.
* Understand the relationship between **core area, die area, utilization, and aspect ratio**.
* Learn why macros and other pre-placed blocks require carefully selected locations.
* Understand how floorplan decisions influence routing congestion, timing, wire length, and power.
* Study switching current and its effect on the power-delivery network.
* Understand resistive **IR drop** and inductive voltage drop.
* Learn the meaning of **noise margin** in digital circuits.
* Understand the purpose of decoupling capacitors in power-integrity improvement.
* Study the structure and operation of a **Power Distribution Network (PDN)**.
* Explore floorplanning and power-planning concepts in OpenLane.
* Understand the role of the **SKY130 PDK** and standard-cell libraries.
* Examine LEF files and technology information used by physical-design tools.
* Understand standard-cell placement and placement blockages.
* Learn why tap cells are inserted into CMOS layouts.
* Study timing constraints used during physical implementation.
* Understand how logical netlist instances are associated with physical library cells.
* Observe the transition from **Netlist → Floorplan → Placement → Physical Layout**.

---

##  Tools and Technologies

| Tool / Technology           | Application                                            |
| --------------------------- | ------------------------------------------------------ |
| **OpenLane**                | Open-source automated RTL-to-GDSII implementation flow |
| **OpenROAD**                | Physical implementation and layout analysis            |
| **SKY130 PDK**              | Open-source 130 nm process design kit                  |
| **sky130_fd_sc_hd**         | SKY130 high-density standard-cell library              |
| **LEF Files**               | Physical abstracts used during placement and routing   |
| **Tcl**                     | OpenLane configuration and flow automation             |
| **Verilog**                 | Hardware description and RTL representation            |
| **SDC**                     | Timing and clock constraint specification              |
| **KLayout / Layout Viewer** | Physical-layout inspection and visualization           |
| **Linux / Ubuntu**          | ASIC design environment                                |
| **GitHub**                  | Version control and project documentation              |

---

# Table of Contents

* [1 - Define Width and Height of Core and Die](#1-define-width-and-height-of-core-and-die)
* [2 - Convert Netlist Symbols into Physical Dimensions](#2-convert-netlist-symbols-into-physical-dimensions)
* [3 - Calculate Area Occupied by the Netlist](#3-calculate-area-occupied-by-the-netlist)
* [4 - Utilization Factor and Aspect Ratio](#4-utilization-factor-and-aspect-ratio)
* [5 - Core and Die Dimension Example](#5-core-and-die-dimension-example)
* [6 - Define Locations of Pre-placed Cells](#6-define-locations-of-pre-placed-cells)
* [7 - Placement of Pre-placed Cells](#7-placement-of-pre-placed-cells)
* [8 - IP Blocks and Floorplanning](#8-ip-blocks-and-floorplanning)
* [9 - Surround Pre-placed Cells with Decoupling Capacitors](#9-surround-pre-placed-cells-with-decoupling-capacitors)
* [10 - Switching Current and Voltage Drop](#10-switching-current-and-voltage-drop)
* [11 - Noise Margin](#11-noise-margin)
* [12 - Solution: Add Decoupling Capacitors](#12-solution-add-decoupling-capacitors)
* [13 - Decoupling Capacitor Placement Around Blocks](#13-decoupling-capacitor-placement-around-blocks)
* [14 - Decoupling Capacitor Placement in the Floorplan](#14-decoupling-capacitor-placement-in-the-floorplan)
* [15 - Power Network, Driver, Load and 16-bit Bus](#15-power-network-driver-load-and-16-bit-bus)
* [16 - Floorplanning](#16-floorplanning)
* [17 - Power Planning](#17-power-planning)
* [18 - Power Distribution Network](#18-power-distribution-network)
* [19 - PicoRV32A ASIC Design Flow using OpenLane](#19-picorv32a-asic-design-flow-using-openlane)
* [20 - OpenLane Physical Design Configuration](#20-openlane-physical-design-configuration)
* [21 - SkyWater PDK LEF File Configuration](#21-skywater-pdk-lef-file-configuration)
* [22 - OpenLane Floorplanning Configuration](#22-openlane-floorplanning-configuration)
* [23 - Standard Cell Placement](#23-standard-cell-placement)
* [24 - Decoupling Capacitors](#24-decoupling-capacitors)
* [25 - Logical Cell Placement Blockage](#25-logical-cell-placement-blockage)
* [26 - Tap Cells](#26-tap-cells)
* [27 - LEF and Technology Files](#27-lef-and-technology-files)
* [28 - OpenLane Configuration](#28-openlane-configuration)
* [29 - Timing Constraints](#29-timing-constraints)
* [30 - OpenROAD / Layout View](#30-openroad--layout-view)
* [31 - Bind Netlist with Physical Library Cells](#31-bind-netlist-with-physical-library-cells)
* [32 - Placement](#32-placement)

---

# 1. Define Width and Height of Core and Die

Physical design begins by examining the synthesized netlist and determining how its logical components can be represented physically.

A netlist contains information about the components used in the design and the connections between them.

For the example considered in this module, the design contains:

* Flip-flops
* AND gate
* OR gate
* Clock connection
* Data connections

Although the netlist describes the design logically, each component eventually needs a physical representation with a defined width, height, and location.

<img width="876" height="698" alt="Screenshot 2026-09-06 223752" src="https://github.com/user-attachments/assets/e0399213-d8db-48ea-8c26-815935350d10" />

---

# 2. Convert Netlist Symbols into Physical Dimensions

Once the logical structure is understood, the cells in the netlist can be associated with physical standard-cell implementations.

The example contains components such as:

* Flip-flops
* Standard logic cells
* AND gates
* OR gates

Every physical cell occupies a finite amount of silicon area. Therefore, the dimensions of the cells must be considered before deciding the size of the core.

The total cell area provides the basis for determining how much space should be reserved for standard-cell placement.
<img width="855" height="690" alt="Screenshot 2026-09-06 223834" src="https://github.com/user-attachments/assets/a100b8e2-bc8f-4f83-b3c0-cb9e25199f8b" />


---

# 3. Calculate Area Occupied by the Netlist

For a simplified floorplanning example, every standard cell and flip-flop can be treated as a square having unit dimensions.

For one cell:

```text
Width  = 1 unit
Height = 1 unit

Area = Width × Height
     = 1 × 1
     = 1 sq. unit
```

The complete cell area is obtained by summing the area of all cells present in the netlist.

This calculated value is useful when determining the minimum core area required by the design.

<img width="1322" height="817" alt="Screenshot 2026-09-06 223905" src="https://github.com/user-attachments/assets/b7106b57-4245-4c35-8596-1dbac00f7ee9" />


---

# 4. Utilization Factor and Aspect Ratio

Two important floorplanning parameters are **core utilization** and **aspect ratio**.

### Utilization Factor

The utilization factor describes the percentage of the available core area that is occupied by design cells.

```text
Utilization Factor =
Area Occupied by Netlist
-------------------------
Total Core Area
```

A high utilization value means that cells are packed more densely. A lower value leaves additional whitespace that can be used for routing and other physical-design requirements.

<img width="1423" height="858" alt="Screenshot 2026-09-06 223940" src="https://github.com/user-attachments/assets/ab4b5f6f-69fb-44cb-9f71-0777b3661589" />


### Aspect Ratio

The aspect ratio describes the shape of the core.

```text
Aspect Ratio = Height / Width
```

For example, a core with dimensions approximately **4 units × 2 units** has a different shape from a square core.

The selected utilization and aspect ratio determine the available physical space and influence the subsequent placement and routing stages.

---

# 5. Core and Die Dimension Example

The dimensions of the core and die are selected according to the area required by the design and the desired utilization.

The available physical area must accommodate:

* Standard cells
* Routing resources
* Power-distribution structures
* Decoupling cells
* Macros and IP blocks
* Other physical-design requirements

A lower utilization value generally creates more whitespace. This can provide additional room for routing and may help reduce congestion.

However, excessively low utilization increases the overall chip area.

<img width="1036" height="463" alt="Screenshot 2026-09-06 224004" src="https://github.com/user-attachments/assets/11629c9c-3383-4d64-9afd-599c9d8faf4f" />


---

# 6. Define Locations of Pre-placed Cells

Not every physical component can be freely moved by the automated placement engine.

Large or special-purpose blocks are often assigned fixed locations before standard-cell placement.

Examples include:

* Memory macros
* Clock-related structures
* Comparators
* Multiplexers
* Large IP blocks
* Other fixed-function macros

These are commonly referred to as **pre-placed or fixed cells/blocks**.

Their locations are decided during floorplanning because their positions strongly influence routing and the placement of surrounding logic.


<img width="876" height="367" alt="Screenshot 2026-09-06 230312" src="https://github.com/user-attachments/assets/d47046fc-5a46-43d1-a548-7612eb8173a1" />



---

# 7. Placement of Pre-placed Cells

The location of fixed blocks has a direct effect on the remaining physical implementation.

When blocks are positioned, designers need to consider:

* Connectivity
* Input/output access
* Routing distance
* Congestion
* Timing
* Available whitespace

The example contains multiple logic blocks with connections between them.

Extending or organizing I/O connections appropriately makes the intended connectivity easier to implement.

A good placement can reduce:

* Wire length
* Routing congestion
* Timing delays
* Unnecessary routing detours

<img width="1600" height="702" alt="WhatsApp Image 2026-09-06 at 10 50 39 PM" src="https://github.com/user-attachments/assets/675eed3e-44e6-47c4-b829-c9cce5f3163c" />
---

# 8. IP Blocks and Floorplanning

Large ASICs often contain several reusable IP blocks and macros.

Examples include:

* Memory blocks
* Clock-related blocks
* Comparators
* Multiplexers
* Custom IP macros

The process of deciding where these major blocks should be located within the chip is called **floorplanning**.

Since these blocks can occupy significant silicon area and often have fixed dimensions, their placement must be decided before the automated placement of ordinary standard cells.

Therefore, floorplanning establishes the overall physical structure of the chip.

<img width="957" height="650" alt="Screenshot 2026-09-06 224142" src="https://github.com/user-attachments/assets/fcef3785-40ee-47a0-afd7-436a45ec57dd" />


---

# 9. Surround Pre-placed Cells with Decoupling Capacitors

Large pre-placed blocks may experience considerable switching activity.

When many circuits switch simultaneously, the instantaneous current demand can increase significantly. This can produce temporary variations in the local supply voltage.

One method of improving local power integrity is to place **decoupling capacitor cells (DECAP cells)** close to these blocks.

A typical floorplan may contain:

* Core
* Die
* Block A
* Block B
* Block C
* Decoupling capacitor regions

Decoupling capacitors store electrical charge locally and can provide that charge during short-duration current-demand events.

<img width="1600" height="702" alt="WhatsApp Image 2026-09-06 at 10 50 46 PM" src="https://github.com/user-attachments/assets/b2d85ea1-a8f4-4fcf-a413-2f5561824965" />

---

# 10. Switching Current and Voltage Drop

Digital circuits do not consume a constant amount of current. During switching events, the current demand can rise sharply.

This instantaneous demand is commonly referred to as **peak switching current**.

The power-delivery network contains parasitic resistance and inductance. Therefore, current flowing through the network can produce voltage variations.

### Resistive Voltage Drop

The voltage drop caused by resistance can be expressed as:

```text
V = I × R
```

where:

* `I` = current
* `R` = resistance

### Inductive Voltage Drop

The voltage variation caused by inductance is approximately:

```text
V = L × di/dt
```

where:

* `L` = inductance
* `di/dt` = rate of change of current

Therefore, a large and rapid current transition can produce significant supply-voltage disturbance.

<img width="1600" height="702" alt="WhatsApp Image 2026-09-06 at 11 11 21 PM" src="https://github.com/user-attachments/assets/4f52241b-2c47-46d2-b086-1e7c4ce4a679" />


---

# 11. Noise Margin

**Noise margin** indicates how much unwanted voltage disturbance a digital circuit can tolerate while still correctly interpreting a logic value.

Two important quantities are:

### Noise Margin High

```text
NMH = VOH(min) − VIH(min)
```

### Noise Margin Low

```text
NML = VIL(max) − VOL(max)
```

A noise disturbance that remains within the available noise margin generally does not cause an incorrect logic interpretation.

If the disturbance becomes larger than the available margin, the receiving circuit may interpret the signal incorrectly.

<img width="1600" height="702" alt="WhatsApp Image 2026-09-06 at 10 50 40 PM" src="https://github.com/user-attachments/assets/68db71a2-fc52-49cf-b3e2-f2f6d6b6c72c" />


---

# 12. Solution: Add Decoupling Capacitors

A common technique for reducing the impact of sudden current demand is the use of **decoupling capacitors**.

The capacitor is connected between the power and ground networks.

When switching logic suddenly requires additional current, the capacitor can temporarily supply charge locally.

The basic sequence is:

```text
Logic switches
      ↓
Current demand increases
      ↓
Decoupling capacitor provides local charge
      ↓
Power network restores capacitor charge
```

Because the capacitor is located close to the switching circuitry, it can reduce the impact of transient current demand on the local supply voltage.

<img width="1600" height="702" alt="11" src="https://github.com/user-attachments/assets/c0126a17-1fd0-45c6-9d26-205288fa8593" />


---

# 13. Decoupling Capacitor Placement Around Blocks

Decoupling cells are often positioned close to blocks that are expected to experience substantial transient current demand.

For example:

```text
+--------------------------------+
|                                |
|          DECAP1                |
|                                |
|       Block A   Block B        |
|                                |
|          DECAP2                |
|                                |
|       Block C                  |
|                                |
|          DECAP3                |
|                                |
+--------------------------------+
```

The primary objective is to minimize the electrical distance between the decoupling cell and the circuitry requiring transient current.

A shorter path can reduce the effect of parasitic resistance and inductance.

<img width="1600" height="702" alt="WhatsApp Image 2026-09-06 at 10 50 40 PM" src="https://github.com/user-attachments/assets/bb8ea56a-8909-4ade-9ce2-c196efa9d237" />


---

# 14. Decoupling Capacitor Placement in the Floorplan

The floorplan can reserve dedicated regions for decoupling cells around fixed blocks.

A simplified arrangement can be represented as:

```text
DECAP1
Block A
Block B
DECAP2
Block C
DECAP3
```

The exact arrangement depends on the current-demand characteristics, available area, routing requirements, and power-network structure.

Placing DECAP cells close to high-switching regions helps provide a local source of charge and can improve supply stability.

<img width="821" height="521" alt="Screenshot 2026-09-06 231716" src="https://github.com/user-attachments/assets/5e10a92c-985b-47ee-af92-445f2b062aa5" />

---

# 15. Power Network, Driver, Load and 16-bit Bus

The example illustrates a power network supplying several driver and load circuits.

The power network has non-ideal characteristics such as:

* Resistance
* Inductance
* Distributed capacitance

The diagram also contains a multi-bit signal path, represented by a **16-bit bus**.

When several signals transition simultaneously, the combined switching activity can produce a large current transient.

This makes power-network design particularly important for circuits containing wide buses and highly active logic.

Appropriate power planning and decoupling help maintain a stable supply voltage.

<img width="847" height="492" alt="Screenshot 2026-09-06 231745" src="https://github.com/user-attachments/assets/241e25fd-f8be-4d38-aaf5-cfce240aaac6" />


---

# 16. Floorplanning

Floorplanning is one of the first major activities in the physical-design process.

It establishes the physical boundaries and resources that will be used by later implementation stages.

Important floorplan characteristics include:

```text
Die dimensions
Core dimensions
Core utilization
Aspect ratio
Standard-cell placement area
I/O regions
Power-distribution requirements
```

### Important OpenLane Floorplan Parameters

Common configuration variables include:

```text
FP_CORE_UTIL
FP_ASPECT_RATIO
FP_SIZING
DIE_AREA
FP_IO_HMETAL
FP_IO_VMETAL
FP_IO_MODE
```

### Core Utilization

`FP_CORE_UTIL` specifies the approximate percentage of the core area intended for standard-cell utilization.

If utilization becomes too high, the placement and routing tools may have insufficient whitespace.

If utilization is too low, the design may occupy unnecessarily large silicon area.

Therefore, a suitable value must be selected based on the characteristics of the design.

<img width="675" height="446" alt="Screenshot 2026-09-06 231808" src="https://github.com/user-attachments/assets/1028f31d-28ee-4668-8349-54a8b057e917" />


---

# 17. Power Planning

Power planning establishes the structures required to distribute supply voltage and ground throughout the chip.

A typical power network contains horizontal and vertical metal structures.

The basic organization can be represented as:

```text
VDD
 │
 ├── Horizontal Power Rails
 │
 ├── Vertical Power Straps
 │
 └── Standard-Cell Power Connections

VSS
 │
 ├── Horizontal Ground Rails
 │
 ├── Vertical Ground Straps
 │
 └── Standard-Cell Ground Connections
```

The objective of the power grid is to deliver a sufficiently stable supply voltage to cells throughout the core.

A properly constructed power network helps minimize voltage drop and improves overall power integrity.

<img width="977" height="592" alt="Power planning and grid" src="https://github.com/user-attachments/assets/6c65e942-8ee9-48a6-9e1b-b0d39fb58b5b" />

---

# 18. Power Distribution Network (PDN)

The **Power Distribution Network** distributes VDD and VSS across the physical design.

A typical PDN contains:

* Horizontal power straps
* Vertical power straps
* Standard-cell power rails
* VDD connections
* VSS connections
* Power-grid intersections

The PDN must provide power to cells throughout the core while keeping voltage variations within acceptable limits.

An effective PDN helps with:

* IR-drop reduction
* Supply-voltage stability
* Power integrity
* Reliable standard-cell operation
* Improved current distribution

<img width="871" height="560" alt="Screenshot 2026-09-06 231910" src="https://github.com/user-attachments/assets/af57c318-f7f1-40ef-b18c-d0911166b321" />


---

# 19. PicoRV32A ASIC Design Flow using OpenLane

**OpenLane** is an open-source automated RTL-to-GDSII design flow.

It takes a hardware design described using RTL and processes it through several stages to produce a physical layout suitable for further verification and fabrication.

A simplified flow is:

```text
RTL
 ↓
Synthesis
 ↓
Floorplanning
 ↓
Power Planning
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
```

The **PicoRV32A** design is an optimized RISC-V processor core that can be used as a practical example for studying the flow.

The `config.tcl` file serves as an important configuration point. It specifies design information and implementation parameters such as:

* Design name
* RTL files
* Timing constraints
* Clock information
* Floorplan settings
* Placement targets
<img width="1067" height="522" alt="Screenshot 2026-09-06 232251" src="https://github.com/user-attachments/assets/dceca058-922b-4e62-a060-697c7381904a" />


---

# 20. OpenLane Physical Design Configuration

The OpenLane flow uses configuration parameters to control the different stages of ASIC implementation.

This example uses the:

```text
sky130_fd_sc_hd
```

standard-cell library.

Important parameters influence synthesis, timing, floorplanning, and placement.

### Synthesis and Timing

For example:

```text
SYNTH_MAX_FANOUT
CLOCK_PERIOD
```

`SYNTH_MAX_FANOUT` limits the number of loads that a cell output is allowed to drive.

`CLOCK_PERIOD` defines the target clock period used for timing-driven implementation.

### Floorplanning and Placement Density

Parameters such as:

```text
FP_CORE_UTIL
PL_TARGET_DENSITY
```

control the amount of available core area and the desired placement density.

The goal is to obtain a compact implementation while leaving sufficient resources for routing.

<img width="892" height="290" alt="Screenshot 2026-09-06 232309" src="https://github.com/user-attachments/assets/3ef30648-1daa-4c89-8b56-c13841f579fa" />

---

# 21. SkyWater PDK LEF File Configuration

A **LEF (Library Exchange Format)** file provides abstract physical information required by place-and-route tools.

Unlike a detailed layout database, a LEF file mainly exposes the information necessary for physical implementation, such as:

* Cell dimensions
* Pin locations
* Routing layers
* Obstructions
* Placement sites
* Physical abstracts

The `merged.lef` or equivalent merged LEF used by the flow contains technology and library information needed by the implementation tools.

### Technology Units

The LEF specifies units used to represent physical quantities such as:

* Distance
* Resistance
* Time
* Capacitance

### Manufacturing Grid

The manufacturing grid defines the smallest permitted geometric placement increment.

The example uses a grid of approximately:

```text
0.005 microns
```

### Site Definitions

Site definitions describe the templates used for standard-cell placement rows.

The library may contain different site definitions for cells such as:

```text
unithd
unithddbl
```

These correspond to different cell heights and placement requirements.

<img width="752" height="872" alt="Screenshot 2026-09-06 232638" src="https://github.com/user-attachments/assets/2564232c-151a-4ecc-9128-43cbae748ca9" />


---

# 22. OpenLane Floorplanning Configuration

OpenLane provides several variables that control the floorplanning process.

##  Die and Core Parameters

### `FP_CORE_UTIL`

Specifies the target percentage of the core area intended for standard-cell utilization.

Example:

```text
FP_CORE_UTIL = 50
```

### `FP_ASPECT_RATIO`

Controls the shape of the core.

```text
FP_ASPECT_RATIO = Height / Width
```

A value of `1` represents a square core.

### `FP_SIZING`

Specifies how the core and die dimensions are determined.

Typical strategies include:

```text
relative
absolute
```

### `DIE_AREA`

Allows explicit specification of the die boundary.

The coordinates define the rectangular die region.

---

##  I/O Pin Configuration

### `FP_IO_HMETAL`

Defines the metal layer used for horizontal I/O pin placement.

### `FP_IO_VMETAL`

Defines the metal layer used for vertical I/O pin placement.

### `FP_IO_MODE`

Controls the I/O placement strategy.

### `FP_IO_MIN_DISTANCE`

Specifies the minimum spacing between neighboring I/O pins.

---

## PDN Parameters

Important power-grid parameters include:

```text
FP_PDN_VOFFSET
FP_PDN_HOFFSET
FP_PDN_VPITCH
FP_PDN_HPITCH
FP_PDN_AUTO_ADJUST
```

Offsets determine where the initial power straps begin, while pitch values control the spacing between repeated power structures.

`FP_PDN_AUTO_ADJUST` allows the flow to adjust the PDN structure when necessary to match the floorplan.

---

## Tap and I/O Parameters

The configuration may also contain:

```text
FP_WELLTAP_CELL
FP_ENDCAP_CELL
FP_TAPCELL_DIST
FP_IO_VEXTEND
FP_IO_HEXTEND
FP_IO_VLENGTH
FP_IO_HLENGTH
FP_IO_VTHICKNESS_MULT
FP_IO_HTHICKNESS_MULT
```

These parameters control well-tap insertion, endcap cells, I/O geometry, and related physical structures.

<img width="847" height="871" alt="Screenshot 2026-09-06 232708" src="https://github.com/user-attachments/assets/1281ebe1-ffe8-4bb3-828f-9e3bda8ba008" />


---

# 23. Standard Cell Placement

After floorplanning and power planning, the standard cells in the netlist must be assigned physical locations.

The placement stage determines where cells such as the following are positioned:

* Combinational logic
* Flip-flops
* Buffers
* Inverters
* Logic gates
* Other standard cells

Standard cells are normally arranged in rows inside the core.

A good placement solution attempts to achieve:

* Shorter interconnects
* Lower routing congestion
* Better timing
* Efficient routing
* Reduced power consumption
<img width="916" height="446" alt="Screenshot 2026-09-06 232745" src="https://github.com/user-attachments/assets/018431f2-637f-436d-aacf-afb7e57e2722" />


Example command/output:

<img width="813" height="786" alt="Screenshot 2026-09-06 232807" src="https://github.com/user-attachments/assets/5b7ce9f3-c953-4040-89b2-79107b24a55a" />


Additional placement result:

<img width="857" height="435" alt="Screenshot 2026-09-06 232823" src="https://github.com/user-attachments/assets/febcb4f7-c326-4650-824f-af4c94685188" />

---

# 24. Decoupling Capacitors

Decoupling capacitor cells are physical cells used to improve local power stability.

They can provide charge during short-duration switching events and help reduce local supply fluctuations.

Important applications include:

* Reducing supply noise
* Supporting transient current requirements
* Improving local power integrity
* Supporting sensitive or high-switching regions

The physical layout examples demonstrate how these structures can be distributed within the floorplan.

---

# 25. Logical Cell Placement Blockage

A **placement blockage** prevents the placement engine from using a specified physical region for ordinary standard cells.

For example:

```text
+--------------------------------------+
|                                      |
|     Standard Cell Placement Area     |
|                                      |
|          +----------------+          |
|          |    BLOCKAGE    |          |
|          |                |          |
|          | DECAP / SPECIAL|          |
|          |     CELLS      |          |
|          +----------------+          |
|                                      |
+--------------------------------------+
```

Blockages can be introduced to:

* Reserve space for special cells
* Protect macro regions
* Control placement density
* Manage congestion
* Preserve routing resources
* Create dedicated physical regions

---

# 26. Tap Cells

**Tap cells** provide electrical connections between the wells/substrate and the appropriate supply networks.

They are important in CMOS physical implementation because they help maintain the required well and substrate biasing and reduce the risk of latch-up.

Tap cells are inserted at appropriate intervals across standard-cell rows according to the technology rules.

Therefore, tap-cell insertion is an important physical-design step before final routing and verification.

---

# 27. LEF and Technology Files

The physical-design flow uses technology and library information supplied by the **SKY130A PDK**.

Important files and information include:

```text
sky130A.tech
sky130_fd_sc_hd_*
*.lef
```

### LEF Files

LEF files provide abstract physical information such as:

* Cell width and height
* Pin locations
* Routing layers
* Obstructions
* Placement information
* Physical cell abstracts

### Technology Files

Technology files describe information required by layout and physical-design tools, including:

* Metal layers
* Layer properties
* Manufacturing rules
* Routing information
* Technology-specific physical parameters

These files allow the physical-design tools to understand how logical cells can be implemented physically.

---

# 28. OpenLane Configuration

OpenLane uses Tcl configuration files to specify the design and implementation settings.

A typical configuration for the PicoRV32A example can contain:

```tcl
set ::env(DESIGN_NAME) "picorv32a"

set ::env(VERILOG_FILES) \
    "$::env(DESIGN_DIR)/src/picorv32a.v"

set ::env(SDC_FILE) \
    "$::env(DESIGN_DIR)/src/picorv32a.sdc"

set ::env(CLOCK_PERIOD) "5.000"
set ::env(CLOCK_PORT) "clk"

set ::env(FP_CORE_UTIL) 50
set ::env(FP_ASPECT_RATIO) 1
```

These settings identify the design files and specify important implementation constraints.

The exact parameter values should always correspond to the configuration used by the actual project.

---

# 29. Timing Constraints

Timing information is provided through an **SDC (Synopsys Design Constraints)** file.

Timing constraints communicate the required operating conditions to synthesis and physical-design tools.

Important constraints can include:

* Clock period
* Clock source
* Input delay
* Output delay
* Timing uncertainty
* Clock relationships

For example:

```tcl
create_clock \
    -name clk \
    -period 5.0 \
    [get_ports clk]
```

This command creates a clock named `clk` with a period of `5.0 ns`.

Correct timing constraints are essential because the implementation tools use them when optimizing the design for performance.

---

# 30. OpenROAD / Layout View

The physical implementation can be inspected using **OpenROAD-based visualization tools**.

A physical layout view can show:

* Standard-cell rows
* Cell instances
* Core boundary
* Die boundary
* Power structures
* I/O pins
* Metal layers
* Routing regions

Layout visualization helps verify whether the physical implementation is organized correctly and provides a useful way to inspect the result before final signoff.

---

# 31. Bind Netlist with Physical Library Cells

The synthesized netlist contains logical cell instances such as:

```text
FF1
FF2
AND1
OR1
```

These logical instances must be associated with actual physical standard-cell implementations available in the technology library.

For example, a logical flip-flop can be mapped to a corresponding flip-flop cell from the:

```text
sky130_fd_sc_hd
```

library.

This process establishes the relationship between the logical representation and its physical implementation.

<img width="408" height="656" alt="Screenshot 2026-09-06 233111" src="https://github.com/user-attachments/assets/34aa6d18-8a3d-431b-a625-cf6d2b219dc5" />


<img width="867" height="420" alt="Screenshot 2026-09-06 233126" src="https://github.com/user-attachments/assets/9a2aab05-b09a-4651-b744-d337c6a25d9a" />

---

# 32. Placement

Once logical cells have been mapped to physical library cells, they can be positioned within the floorplan.

The placement engine considers several factors, including:

* Cell connectivity
* Available placement rows
* Legal placement sites
* Timing requirements
* Congestion
* Blockages
* I/O locations
* Fixed macros
* Power structures

The physical implementation can therefore be viewed as a sequence:

```text
Logical Netlist
      ↓
Library Cell Mapping
      ↓
Physical Cell Placement
      ↓
Physical Layout
```

The examples show how the same logic can be represented at different stages, progressing from the original netlist to the final physical arrangement.
<img width="765" height="467" alt="Screenshot 2026-09-06 233147" src="https://github.com/user-attachments/assets/c2fa7c27-208f-4e8c-9279-f9084d11a407" />


The floorplan example contains:

* Standard-cell rows
* Input pins such as `Din1`, `Din2`, `Din3`, and `Din4`
* Clock pins such as `Clk1` and `Clk2`
* Fixed cells such as `FF1` and `FF2`
* Special structures such as `DECAP1` and `DECAP3`
* Placement and routing regions

![Uploading Screenshot 2026-09-06 233215.png…]()


---

# Key Learnings

After completing this module, the following concepts were studied:

### Netlist and Physical Representation

* Understanding the contents of a synthesized netlist
* Relating logical cells to physical standard cells
* Estimating cell dimensions
* Calculating total cell area

### Floorplanning

* Core and die dimensions
* Core utilization
* Aspect ratio
* Pre-placed cells
* Macro and IP placement
* Floorplan organization
* Effects of placement decisions on routing

### Power Integrity

* Switching current
* Peak current
* Resistive voltage drop
* IR drop
* Inductive voltage variation
* Noise margin
* Supply-voltage disturbances
* Decoupling capacitors
* Decap placement

### Physical Implementation

* Power planning
* Power Distribution Network
* Standard-cell placement
* Placement blockages
* Tap-cell insertion
* LEF files
* Technology files
* OpenLane configuration
* SDC timing constraints
* Logical-to-physical cell mapping
* OpenROAD layout visualization

---

#  Conclusion

Floorplanning establishes the physical foundation of an ASIC and has a significant influence on the quality of the final design.

The core and die dimensions must be selected according to the total cell area, desired utilization, and aspect ratio. Large macros and pre-placed blocks must be positioned carefully so that connectivity, timing, routing, and congestion can be managed effectively.

Power integrity is another essential consideration. During simultaneous switching, the circuit may demand a large transient current. The resistance and inductance present in the power network can then produce voltage disturbances such as IR drop and inductive voltage variation.

Noise margin determines how much of this unwanted disturbance a digital circuit can tolerate. Decoupling capacitors provide a local charge reservoir that helps reduce the impact of rapid current demand.

The OpenLane and SKY130 examples demonstrate how these concepts are applied in an actual open-source ASIC implementation flow. Through floorplanning, power planning, PDN generation, standard-cell placement, blockage management, tap-cell insertion, library mapping, and layout inspection, the logical design is gradually transformed into a structured physical representation.

Overall, this module provides a foundation for understanding the relationship between **logical design, physical dimensions, power delivery, placement, and final ASIC layout**.

---



