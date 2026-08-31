# VSDBabySoC – RTL Verification and Gate-Level Analysis

##  Experiment Goal

The purpose of this experiment is to understand the working structure of **VSDBabySoC** and follow its verification process at different stages of the digital design flow.

The experiment begins with the RTL implementation and continues through **pre-synthesis simulation, synthesis, gate-level simulation, and waveform verification**. The major components of the SoC, including the **RVMYTH processor, AVSDPLL, and AVSDDAC**, are also examined.

### Areas Explored

* VSDBabySoC block-level organization
* RISC-V based RVMYTH processor
* AVSDPLL clock generation
* AVSDDAC output conversion
* RTL-level simulation
* Synthesis of RTL
* Gate-level netlist generation
* Post-synthesis Gate-Level Simulation
* VCD waveform examination
* Comparison of RTL and synthesized results

---

## Guide 

1. VSDBabySoC Overview
2. SoC Block Diagram
3. RVMYTH Processor
4. AVSDPLL Clock Module
5. AVSDDAC Output Module
6. Pre-Synthesis RTL Verification
7. Synthesis and Gate-Level Verification
8. Simulation Stage Comparison
9. Results and Observations
10. Final Remarks

---

# 1. VSDBabySoC Overview

**VSDBabySoC** is a compact SoC design that brings together digital processing and analog-oriented functional blocks.

The design contains three important modules:

| Component   | Role in the SoC                                             |
| ----------- | ----------------------------------------------------------- |
| **RVMYTH**  | Executes the digital processing operations                  |
| **AVSDPLL** | Provides the required clock signal                          |
| **AVSDDAC** | Handles conversion of digital information toward the output |

These blocks are integrated through the top-level module:

```text
vsdbabysoc
```

### Design Verification Sequence

```text
RTL Source Code
      ↓
Pre-Synthesis Simulation
      ↓
Synthesis
      ↓
Gate-Level Netlist
      ↓
Post-Synthesis Simulation
      ↓
Waveform Examination
```

This sequence makes it possible to check the design first at the RTL level and then again after synthesis.

---

# 2. SoC Block Diagram

The interaction between the major VSDBabySoC components can be represented as follows:

```text
                   ┌─────────────────┐
                   │     AVSDPLL     │
                   │  Clock Generator│
                   └────────┬────────┘
                            │
                         Clock
                            │
                            ▼
                   ┌─────────────────┐
                   │     RVMYTH      │
                   │   RISC-V Core   │
                   └────────┬────────┘
                            │
                       Digital Data
                            │
                            ▼
                   ┌─────────────────┐
                   │     AVSDDAC     │
                   │ Digital-to-     │
                   │ Analog Converter│
                   └────────┬────────┘
                            │
                            ▼
                           OUT
```

### Block-Level Operation

The **AVSDPLL** supplies the clock required by the processor. The **RVMYTH** core performs the digital computation, and its resulting data is forwarded to the **AVSDDAC**, which produces the corresponding output.

---

# 3. RVMYTH Processor

The **RVMYTH** module represents the RISC-V processing section of VSDBabySoC.

It is responsible for the digital computation performed inside the SoC. The processor operates using the clock supplied by the PLL and generates digital information that is subsequently passed to the DAC.

### RVMYTH Source Files

```text
rvmyth.v
rvmyth_gen.v
rvmyth.tlv
```

### Processor Data Flow

```text
                ┌───────────────────┐
                │      RVMYTH       │
Clock ─────────►│    RISC-V Core    │
                │                   │
                │ Digital Processing│
                └─────────┬─────────┘
                          │
                          ▼
                     Digital Data
                          │
                          ▼
                       AVSDDAC
```

Thus, RVMYTH serves as the primary digital computation unit within the SoC.

---

# 4. AVSDPLL Clock Module

The **AVSDPLL** is the clock-generation component used by the VSDBabySoC design.

Its primary function is to generate the clock required for the digital processing portion of the system. The resulting clock is connected to the RVMYTH processor.

### Design File

```text
avsdpll.v
```

### Clock Generation Path

```text
Input Clock
     │
     ▼
┌───────────────┐
│    AVSDPLL    │
│     PLL       │
└───────┬───────┘
        │
        │ Generated Clock
        ▼
      RVMYTH
```

The PLL therefore provides the timing reference needed by the processor.

---

# 5. AVSDDAC Output Module

The **AVSDDAC** is the DAC section of the VSDBabySoC.

It receives the digital information produced by RVMYTH and generates the corresponding output from that data.

### Source File

```text
avsddac.v
```

### Conversion Path

```text
Digital Information
        │
        ▼
 ┌───────────────┐
 │    AVSDDAC    │
 │      DAC      │
 └───────┬───────┘
         │
         ▼
        OUT
```

The DAC therefore forms the output interface for the digital processing section.

---

# 6. Pre-Synthesis RTL Verification

## 6.1 Purpose of RTL Simulation

Before synthesis, the original RTL description is simulated to determine whether the design behaves as intended.

This stage allows the functionality of the VSDBabySoC to be examined without converting the design into physical technology-specific cells.

### Main RTL Files

```text
testbench.v
vsdbabysoc.v
rvmyth.v
rvmyth_gen.v
rvmyth.tlv
avsdpll.v
avsddac.v
clk_gate.v
```

The required include files are also supplied during compilation.

---

## 6.2 Compiling the RTL

First, enter the directory containing the required modules:

```bash
cd ~/baby_soc/BabySoC_Simulation/src/module
```

The RTL simulation can then be compiled with **Icarus Verilog**:

```bash
iverilog -o pre_synth_sim.out \
-DPRE_SYNTH_SIM \
testbench.v \
-I ../include \
-I .
```

The generated executable is:

```text
pre_synth_sim.out
```

---

## 6.3 Executing the Simulation

Run the compiled simulation with:

```bash
vvp pre_synth_sim.out
```

The simulation produces a Value Change Dump file:

```text
pre_synth_sim.vcd
```

This VCD file contains the signal activity generated during the RTL simulation.

---

## 6.4 Inspecting the RTL Waveform

The waveform can be opened in GTKWave:

```bash
gtkwave pre_synth_sim.vcd
```

GTKWave can be used to examine important signals such as:

* Clock
* Reset
* Output
* Other relevant internal signals

The main purpose at this stage is to confirm that the RTL design is functioning correctly before synthesis.

---

# 7. Synthesis and Gate-Level Verification

## 7.1 Moving from RTL to Gates

Once the RTL behavior has been checked, the design proceeds to synthesis.

During synthesis, the RTL description is transformed into a **gate-level netlist**. The logic is mapped to cells available in the **SKY130 standard-cell library**.

```text
RTL Description
      ↓
   Synthesis
      ↓
Gate-Level Netlist
```

The resulting netlist represents the synthesized implementation of the design.

---

# 8. Post-Synthesis Gate-Level Simulation

## 8.1 Purpose of GLS

After synthesis, the generated gate-level representation is simulated again.

This is called **Gate-Level Simulation (GLS)** or **post-synthesis simulation**.

The objective is to check whether the synthesized implementation continues to exhibit the expected behavior observed at the RTL level.

---

## 8.2 Gate-Level Simulation Setup

The synthesized netlist is used along with the necessary technology-library files and simulation sources.

The gate-level design is simulated using **Icarus Verilog**.

The simulation generates a waveform file:

```text
post_synth_sim.vcd
```

---

## 8.3 Viewing the Synthesized Waveform

The post-synthesis waveform can be opened with:

```bash
gtkwave post_synth_sim.vcd
```

The resulting waveform provides visibility into the behavior of the synthesized circuit.

Important signals can be examined and compared with those obtained during RTL simulation.

---

# 9. RTL and GLS Comparison

The two simulation stages provide different views of the same design.

| Aspect            | Pre-Synthesis           | Post-Synthesis                    |
| ----------------- | ----------------------- | --------------------------------- |
| Representation    | RTL source              | Gate-level netlist                |
| Timing in flow    | Before synthesis        | After synthesis                   |
| Main purpose      | Check RTL functionality | Verify synthesized implementation |
| Technology cells  | Not mapped              | SKY130 cells used                 |
| Waveform          | `pre_synth_sim.vcd`     | `post_synth_sim.vcd`              |
| Viewer            | GTKWave                 | GTKWave                           |
| Verification type | RTL verification        | Gate-Level Simulation             |

### Complete Flow

```text
                RTL Design
                    │
                    ▼
          Pre-Synthesis Simulation
                    │
                    ▼
          pre_synth_sim.vcd
                    │
                    ▼
                Synthesis
                    │
                    ▼
          Gate-Level Netlist
                    │
                    ▼
          Post-Synthesis Simulation
                    │
                    ▼
          post_synth_sim.vcd
                    │
                    ▼
          Waveform Comparison
```

Comparing both waveforms helps determine whether the synthesized circuit retains the expected functionality of the original RTL implementation.

---

# 10. Results and Observations

| Activity Performed            | Key Observation                                                          |
| ----------------------------- | ------------------------------------------------------------------------ |
| VSDBabySoC architecture study | The main functional blocks and their connections were identified.        |
| RVMYTH study                  | The RISC-V processor was recognized as the main digital processing unit. |
| AVSDPLL analysis              | The PLL was identified as the clock-generation block.                    |
| AVSDDAC analysis              | The DAC receives digital information and generates the output.           |
| RTL simulation                | Design functionality was examined before synthesis.                      |
| VCD generation                | RTL signal activity was captured in `pre_synth_sim.vcd`.                 |
| Synthesis                     | RTL was transformed into a technology-mapped gate-level representation.  |
| GLS                           | The synthesized circuit was simulated at gate level.                     |
| Post-synthesis waveform       | Signal behavior was captured in `post_synth_sim.vcd`.                    |
| Waveform comparison           | RTL and synthesized simulation results were examined together.           |

---

# 11. Final Remarks

The experiment provided a practical understanding of how a VSDBabySoC design moves through different stages of the digital design and verification process.

The major architectural blocks—**RVMYTH, AVSDPLL, and AVSDDAC**—were studied individually as well as in their integrated configuration.

The design was first verified at the **RTL level** through pre-synthesis simulation. The generated waveform was captured in a VCD file and inspected using GTKWave.

Following synthesis, the RTL was converted into a **SKY130-based gate-level netlist**. The synthesized representation was then simulated using Gate-Level Simulation, and its generated waveform was examined.

### End-to-End Process

```text
VSDBabySoC RTL
       ↓
Pre-Synthesis Verification
       ↓
RTL Waveform
       ↓
Synthesis
       ↓
SKY130 Gate-Level Netlist
       ↓
Post-Synthesis GLS
       ↓
GLS Waveform
       ↓
RTL / GLS Comparison
       ↓
Functional Verification
```

Overall, this experiment strengthened the understanding of **SoC architecture, RISC-V integration, clock generation, DAC interfacing, RTL simulation, synthesis, Gate-Level Simulation, and waveform-based verification using GTKWave**.
