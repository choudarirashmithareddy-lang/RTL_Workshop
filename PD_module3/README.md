# Sky130 Module 3 – Design Library Cell Using Magic Layout and ngspice Characterization

##  Contents

1. [Introduction](#introduction)
2. [CMOS Inverter ngspice Simulation Labs](#cmos-inverter-ngspice-simulation-labs)

   * [IO Placer Revision](#io-placer-revision)
   * [Creating the SPICE Deck](#creating-the-spice-deck)
   * [CMOS Inverter SPICE Simulation](#cmos-inverter-spice-simulation)
   * [Switching Threshold Voltage (Vm)](#switching-threshold-voltage-vm)
   * [Static and Dynamic Simulation](#static-and-dynamic-simulation)
3. [Getting the vsdstdcelldesign Repository](#getting-the-vsdstdcelldesign-repository)
4. [Beginning the Layout Design](#beginning-the-layout-design)
5. [CMOS Fabrication Process](#cmos-fabrication-process)

   * [N-Well and P-Well Formation](#1-n-well-and-p-well-formation)
   * [Gate Terminal Formation](#2-gate-terminal-formation)
   * [Lightly Doped Drain (LDD) Formation](#3-lightly-doped-drain-ldd-formation)
   * [Source and Drain Formation](#4-source-and-drain-formation)
   * [Local Interconnect Formation](#5-local-interconnect-formation)
   * [Higher-Level Metal Formation](#6-higher-level-metal-formation)
6. [Tools Used](#tools-used)
7. [Conclusion](#conclusion)

---

# Introduction

This module focuses on the design, layout, simulation, and characterization of a CMOS standard cell using the **Sky130 technology**.

The main objective is to understand the complete transition from a transistor-level circuit to its physical layout and finally verify its electrical behavior using **ngspice**.

The module covers:

* CMOS inverter circuit simulation
* SPICE deck preparation
* IO placement concepts
* Static and transient analysis
* Switching threshold measurement
* Magic layout design
* Standard-cell repository setup
* CMOS fabrication sequence
* Understanding the relationship between layout and transistor operation

---

# CMOS Inverter ngspice Simulation Labs

## 1. IO Placer Revision

IO placement determines the physical locations of input and output pins around a standard-cell layout.

For a CMOS inverter, the important terminals are:

* **VDD** – Positive supply
* **VSS** – Ground
* **A** – Input
* **Y** – Output

A suitable pin arrangement makes the cell easier to connect with neighboring standard cells.

### Important Points

* Input and output pins should be placed according to the cell architecture.
* Power connections should be available through the appropriate supply rails.
* Metal layers used for pins must follow the technology rules.
* Pin locations should support proper routing during physical design.

---

# 2. Creating the SPICE Deck

A SPICE deck contains the information required by **ngspice** to simulate an electronic circuit.

For a CMOS inverter, the deck normally contains:

1. MOS transistor models
2. PMOS transistor
3. NMOS transistor
4. Supply voltage
5. Input signal
6. Circuit connections
7. Simulation commands
8. Measurement or plotting commands

### Basic CMOS Inverter Structure

```text
             VDD
              |
             PMOS
              |
Input ────────┤
              |
            Output
              |
             NMOS
              |
             VSS
```

The PMOS pulls the output toward VDD when the input is LOW, while the NMOS pulls the output toward ground when the input is HIGH.

---

# 3. CMOS Inverter SPICE Simulation

The inverter can be simulated using **ngspice** to observe its voltage-transfer characteristics and time-domain response.

### General Simulation Flow

```text
Create SPICE Deck
       ↓
Load Sky130 Models
       ↓
Define CMOS Inverter
       ↓
Apply Input Signal
       ↓
Run ngspice
       ↓
Observe Output
       ↓
Analyze Voltage and Timing
```

### DC Analysis

DC analysis is used to study the relationship between input voltage and output voltage.

The input voltage is gradually varied from:

```text
0 V → VDD
```

The corresponding output voltage is observed.

This produces the **Voltage Transfer Characteristic (VTC)** of the CMOS inverter.

---

# 4. Switching Threshold Voltage (Vm)

The switching threshold voltage, commonly represented by **Vm**, is the input voltage at which the CMOS inverter changes its logic state.

At approximately this point:

```text
Vin ≈ Vout
```

For a CMOS inverter, Vm lies within the transition region of the voltage-transfer curve.

### VTC Regions

```text
Vout
 ^
 |───────────────
 |              \
 |               \
 |                \
 |                 ─────────
 |
 +--------------------------> Vin
              Vm
```

### Significance of Vm

The switching threshold helps in understanding:

* Logic transition behavior
* Noise margins
* Inverter symmetry
* Relative strength of NMOS and PMOS
* Digital switching characteristics

The exact value depends on factors such as transistor dimensions, process parameters, supply voltage, and transistor characteristics.

---

# 5. Static and Dynamic Simulation

## Static Simulation

Static analysis examines the steady-state behavior of the inverter.

The major output states are:

### Input LOW

```text
Vin = 0
```

* PMOS → ON
* NMOS → OFF
* Output → HIGH

Therefore:

```text
Vin = 0  →  Vout ≈ VDD
```

### Input HIGH

```text
Vin = VDD
```

* PMOS → OFF
* NMOS → ON
* Output → LOW

Therefore:

```text
Vin = VDD  →  Vout ≈ 0
```

---

## Dynamic Simulation

Dynamic simulation studies the inverter while the input changes with time.

A pulse waveform can be applied to the input:

```text
LOW → HIGH → LOW → HIGH
```

The resulting output waveform demonstrates the inversion operation.

### Important Parameters

Dynamic analysis can be used to examine:

* Rise time
* Fall time
* Propagation delay
* Output transition
* Switching behavior
* Dynamic power-related behavior

### Basic Operation

```text
Input :  __|‾‾‾|__|‾‾‾|__
Output: ‾‾|___|‾‾|___|‾‾
```

The output changes in the opposite direction to the input.

---

# Getting the vsdstdcelldesign Repository

The standard-cell layout work can be performed using the **vsdstdcelldesign** repository.

### Clone the Repository

Open the terminal and use:

```bash
git clone https://github.com/nickson-jose/vsdstdcelldesign.git
```

Move into the repository:

```bash
cd vsdstdcelldesign
```

Check the downloaded files:

```bash
ls
```

The repository provides the required files and supporting material for working with the standard-cell layout.

---

# Beginning the Layout Design

**Magic** is used to create and inspect the physical layout of the standard cell.

The layout represents the physical implementation of:

* PMOS
* NMOS
* Poly
* Diffusion
* Contacts
* Metal
* Well regions
* Power and ground connections

### Typical Layout Flow

```text
CMOS Schematic
      ↓
Transistor-Level Netlist
      ↓
Physical Layout
      ↓
Design Rule Checking
      ↓
SPICE Extraction
      ↓
Extracted Netlist
      ↓
ngspice Simulation
```

The extracted layout can be converted into a SPICE representation and compared with the expected transistor-level behavior.

---

# CMOS Fabrication Process

CMOS fabrication involves several processing stages that create the transistor structures and metal connections on a silicon wafer.

The major stages discussed in this module are:

1. N-well and P-well formation
2. Gate terminal formation
3. LDD formation
4. Source-drain formation
5. Local interconnect formation
6. Higher-level metal formation

---

# 1. N-Well and P-Well Formation

The wells provide the required regions for constructing PMOS and NMOS transistors.

### N-Well

An N-well is created inside the silicon substrate to provide the region where the **PMOS transistor** is formed.

### P-Well

A P-well provides the region required for forming the **NMOS transistor**.

The well structure allows both transistor types to be integrated on the same chip.

### Simplified Structure

```text
        N-Well
   ┌───────────────┐
   │     PMOS      │
───┴───────────────┴───
       Silicon
   ┌───────────────┐
   │     NMOS      │
   └───────────────┘
```

---

# 2. Gate Terminal Formation

The gate controls the flow of current through the MOS transistor.

A thin gate dielectric is formed over the silicon surface, followed by deposition and patterning of the gate material.

The gate is positioned between the source and drain regions.

### Basic Structure

```text
             Gate
              │
          ─────────
             Oxide
          ─────────
Source ─── Silicon ─── Drain
```

The gate voltage controls the formation of the conducting channel between source and drain.

---

# 3. Lightly Doped Drain (LDD) Formation

Lightly Doped Drain structures are introduced near the source and drain regions.

The purpose of LDD structures includes:

* Reducing electric-field concentration
* Improving device reliability
* Reducing hot-carrier effects
* Providing a gradual transition between heavily doped regions and the channel

A typical process uses a lighter doping step before the final heavily doped source/drain implantation.

---

# 4. Source and Drain Formation

The source and drain regions are formed using controlled doping or implantation.

For an NMOS transistor, heavily doped **N-type** regions are formed.

For a PMOS transistor, heavily doped **P-type** regions are formed.

### Simplified NMOS

```text
       Gate
        │
     ┌──────┐
     │      │
─────┴──────┴─────
  N+            N+
Source         Drain
      P-type body
```

These regions provide low-resistance connections to the transistor channel.

---

# 5. Local Interconnect Formation

After transistor formation, the individual device terminals need to be electrically connected.

Local interconnect structures provide short-range connections between:

* Source
* Drain
* Gate
* Contacts
* Nearby circuit elements

Contacts connect the transistor regions to the appropriate interconnect layers.

This stage helps transform individual transistors into functional circuit structures.

---

# 6. Higher-Level Metal Formation

Multiple metal layers are formed above the transistor structures to create longer electrical connections.

These metal layers are connected using **vias**.

### Simplified Interconnect Structure

```text
       Metal 2
────────────────────
          │
         Via
          │
       Metal 1
────────────────────
          │
       Contact
          │
     Transistor
────────────────────
        Silicon
```

Higher metal layers are useful for:

* Power distribution
* Clock networks
* Signal routing
* Long-distance connections
* Connections between standard cells and larger blocks

---

# Tools Used

| Tool                                    | Purpose                                          |
| --------------------------------------- | ------------------------------------------------ |
| **Magic**                               | Physical layout creation and inspection          |
| **ngspice**                             | Circuit and extracted-netlist simulation         |
| **Git**                                 | Repository management                            |
| **Sky130 PDK**                          | Process design rules and device information      |
| **Linux/Ubuntu**                        | Development environment                          |
| **VSD Standard Cell Design Repository** | Standard-cell layout learning and implementation |

---

# Overall Module Flow

```text
        SKY130 PDK
            │
            ↓
     CMOS Inverter
            │
            ↓
      SPICE Deck
            │
            ↓
       ngspice
            │
     ┌──────┴──────┐
     ↓             ↓
   Static       Dynamic
  Analysis      Analysis
     │             │
     └──────┬──────┘
            ↓
       Switching Vm
            │
            ↓
     Standard Cell
            │
            ↓
      Magic Layout
            │
            ↓
     Layout Extraction
            │
            ↓
      ngspice Check
            │
            ↓
      Cell Characterization
```

# Conclusion

This module introduces the practical design flow for a **Sky130 CMOS standard cell**, beginning with CMOS inverter simulation and continuing toward physical layout and characterization.

The ngspice experiments help analyze the inverter's static and dynamic behavior, including its switching threshold. Magic provides the environment for implementing the physical layout, while the CMOS fabrication sequence explains how the transistor and interconnect structures represented in the layout are physically formed.

The complete flow connects **circuit design, SPICE simulation, physical layout, fabrication concepts, extraction, and characterization** into a single standard-cell design workflow.
