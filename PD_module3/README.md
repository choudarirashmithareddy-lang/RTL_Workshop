# PD module 3 – Exploring CMOS Design from Transistor to Standard Cell

## What I Worked On

Day 8 connected the device, fabrication, layout, and simulation sides of CMOS design into one practical flow.

The concepts were studied in the following sequence:

```text
CMOS Fundamentals
        ↓
CMOS Inverter
        ↓
CMOS Robustness
        ↓
SPICE Deck
        ↓
CMOS Fabrication
        ↓
SKY130 PDK
        ↓
Magic VLSI
        ↓
Standard Cell Layout
        ↓
SPICE Extraction
        ↓
ngspice Simulation
        ↓
Transient Analysis
````

The main practical task was to create a **SKY130 CMOS inverter (`sky130_inv`)** and follow it beyond the logic level. Its layout was created in Magic, the layout was extracted into a circuit description, and the extracted design was simulated with ngspice.

---

## 1. Building the Circuit Description

A SPICE deck acts as the input description for a circuit simulator. It tells the simulator what devices exist, how they are connected, what models they use, and what analysis needs to be performed.

For a useful simulation, the deck normally provides the following information:

* Device definitions
* Model definitions
* Circuit connectivity
* Power supplies
* Input sources
* Load elements
* Simulation commands
* Control commands

For the inverter used in this exercise, the circuit description includes:

* PMOS transistor
* NMOS transistor
* Input `A`
* Output `Y`
* Supply `VPWR`
* Ground `VGND`
* Load capacitance

A simplified CMOS inverter can be represented as:

```text
             VPWR
               |
              PMOS
               |
               +------ Y
               |
              NMOS
               |
              VGND

                 A
                 |
           Gates of PMOS/NMOS
```

This representation makes it possible to study the actual transistor-level response of the inverter instead of observing only the ideal truth-table behavior.

---

## 2. CMOS Inverter Fundamentals

An inverter is one of the simplest CMOS logic structures and is useful for understanding the operation of complementary MOS devices.

The basic structure uses two complementary devices:

* PMOS transistor
* NMOS transistor

The same input drives both gates, while the complementary device states determine the output voltage.

### When the Input is LOW

When:

```text
A = 0
```

the PMOS provides the pull-up path and the NMOS is switched off.

The output becomes:

```text
Y ≈ VPWR
```

Therefore, the output is at logic HIGH.

### When the Input is HIGH

When:

```text
A = 1
```

the PMOS pull-up path is disabled and the NMOS provides the pull-down path.

The output becomes:

```text
Y ≈ VGND
```

Therefore, the output is at logic LOW.

In Boolean form, the inverter is described by:

```text
Y = ~A
```

The two logic states can be summarized as:

```text
A = 0  →  Y = 1
A = 1  →  Y = 0
```

---

## 3. Logic Levels and Noise Tolerance

A digital gate must distinguish between valid HIGH and LOW levels even when unwanted voltage variations are present. CMOS noise margins are used to describe this tolerance.

The relevant voltage limits are:

* `VOH` – minimum output voltage recognized as logic HIGH
* `VOL` – maximum output voltage recognized as logic LOW
* `VIH` – minimum input voltage recognized as logic HIGH
* `VIL` – maximum input voltage recognized as logic LOW

The noise margins are calculated as:

```text
NMH = VOH - VIH

NML = VIL - VOL
```

These margins indicate how much unwanted voltage variation can be tolerated before a logic level may be interpreted incorrectly.

So, the inverter provides:

* Logic inversion
* Noise tolerance

These characteristics become important when several CMOS gates are connected together in a digital circuit.

---

## 4. What Happens During Switching

A real inverter needs a finite amount of time to respond to an input transition. Its behavior depends on the transistors, the load, and the capacitances associated with the circuit.

The main contributors include:

* Transistor resistance
* Gate capacitance
* Diffusion capacitance
* Interconnect capacitance
* Load capacitance

These effects appear in the measured or simulated waveform as:

* Rise time
* Fall time
* Propagation delay

Understanding these delays is important when the same cells are used in timing-sensitive digital systems.

---

## 5. CMOS Manufacturing Flow

The fabrication discussion used a **16-mask CMOS process** to show how a circuit moves from a silicon wafer to a completed interconnected structure.

Each fabrication step adds or modifies a physical region of the device. Together, the steps create the wells, active areas, gates, source/drain regions, contacts, and metal connections required for CMOS operation.

The process was broken down into these major stages:

1. Silicon wafer preparation
2. Well formation
3. Isolation
4. Active-region formation
5. Gate oxide formation
6. Polysilicon gate formation
7. Source/drain implantation
8. Spacer formation
9. Additional implantation steps
10. Inter-layer dielectric formation
11. Contact formation
12. Metal formation
13. Additional interconnect layers
14. Passivation
15. Pad/opening formation
16. Final processing

The overall build-up can be viewed as:

```text
Silicon
   ↓
Wells
   ↓
Active Regions
   ↓
Gate
   ↓
Source / Drain
   ↓
Contacts
   ↓
Metal Interconnects
   ↓
Completed CMOS Circuit
```

---

## 6. Forming the CMOS Device Structure

Well formation establishes the body regions needed by the two transistor types so that complementary devices can be fabricated within the same technology.

The discussion included the following structures:

* N-well
* P-well
* Substrate
* Dopant implantation
* Active regions

These regions determine the body connections and provide the environment in which the NMOS and PMOS devices are formed.

A simplified representation is:

```text
        PMOS
         │
       N-Well
   ───────┼───────
       Substrate
         │
        NMOS
```

The detailed arrangement varies with the selected process technology.

---

## 7. Patterning the Silicon

Photolithography provides the patterning mechanism used during fabrication. A mask defines where a particular process step should affect the wafer.

Different process layers use masks for features such as:

* Wells
* Active regions
* Polysilicon
* Implant regions
* Contacts
* Metal layers

The basic idea can be represented as:

```text
Mask
  ↓
Pattern Transfer
  ↓
Etching / Implantation / Deposition
  ↓
Physical Structure
```

In this way, fabrication is a repeated pattern-transfer process combined with deposition, etching, implantation, and other material-processing operations.

Applying the sequence repeatedly allows the required three-dimensional device structure to be built layer by layer.

---

## 8. Working with the SKY130 Technology

The **SkyWater** technology ecosystem and the **SKY130 PDK** were introduced as the technology foundation for the practical layout exercise.

The PDK supplies the technology information that EDA tools need in order to work with SKY130, such as:

* Technology layers
* Design rules
* Device information
* Standard-cell libraries
* LEF information
* Liberty timing libraries
* SPICE models
* Technology files

In practice, the PDK connects the design tools with the manufacturing technology by providing the layers, rules, models, and library information required by the flow.

The inverter layout used the SKY130 technology throughout the physical-design and extraction stages.

---

## 9. Layout Work with Magic

**Magic** is a VLSI physical-layout tool that allows circuit geometries to be drawn, inspected, checked, and extracted.

For this exercise, Magic provided the environment for constructing and checking the physical inverter layout.

The tool was used for tasks including:

* Physical layout creation
* Layer inspection
* Design Rule Checking (DRC)
* Circuit extraction
* Layout visualization
* Technology-specific physical design

Unlike a schematic, a layout shows the physical shapes and technology layers that will represent the circuit on silicon.

---

## 10. Creating the Inverter Layout

Using the SKY130A technology files, the inverter was drawn as a custom physical cell in Magic.

The completed cell contains physical regions and interfaces for:

* PMOS
* NMOS
* Input `A`
* Output `Y`
* `VPWR`
* `VGND`

Once the geometry was in place, it was inspected in Magic and prepared for extraction into an electrical model.

### Custom SKY130 CMOS Inverter Layout

<img width="1920" height="940" alt="Screenshot from 2026-09-25 20-35-02" src="https://github.com/user-attachments/assets/b7b58165-d35e-414d-9577-4bc47b5c3ca5" />
<img width="1920" height="940" alt="Screenshot from 2026-09-25 20-34-50" src="https://github.com/user-attachments/assets/bbc3b170-6261-414e-9190-bd80e21ca5ca" />

---

## 11. Converting Layout into a Circuit Model

The next step was to derive an electrical representation directly from the physical layout.

The extracted model contains information related to:

* MOS transistors
* Device dimensions
* Device connectivity
* Parasitic capacitances
* Power connections
* Ground connections

The conversion from geometry to an electrical model follows this path:

```text
Physical Layout
       ↓
     Magic
       ↓
SPICE Extraction
       ↓
Extracted Circuit
       ↓
Electrical Simulation
```

Because the model comes from the layout, the simulation can include physical information that is absent from an ideal logic-level description.

### Extracted SPICE Inverter
<img width="542" height="479" alt="image" src="https://github.com/user-attachments/assets/17366602-92c7-4030-8ff4-892eb4334d49" />


---

## 12. Running the ngspice Simulation

The extracted circuit was subsequently loaded into **ngspice** for transient analysis.

The test setup used:

* `VPWR = 3.3 V`
* `VGND = 0 V`
* Pulsed input signal
* Load capacitance
* Transient analysis

A pulsed waveform was used as the input stimulus, allowing the output transition to be observed over the selected simulation interval.

The analysis was configured with:

```text
Simulation time = 20 ns
Transient step   = 1 ns
```

### ngspice Transient Simulation

<img width="891" height="491" alt="image" src="https://github.com/user-attachments/assets/f615f6fd-7939-4096-9e63-75822b28a573" />


---

## 13. Reading the Simulation Waveform

The resulting simulation data was used to plot the input `A` and output `Y` waveforms.

The plotted signals show the expected complementary relationship:

```text
A = LOW   →   Y = HIGH

A = HIGH  →   Y = LOW
```

The transitions are not perfectly vertical; the output takes time to charge and discharge because the physical circuit contains resistance and capacitance.

Consequently, the waveform provides information about both:

* Logical inversion
* Electrical behavior of the physical circuit

### Transient Waveform

<img width="891" height="507" alt="image" src="https://github.com/user-attachments/assets/a6964d28-f24f-42aa-af24-74b4bdf0d922" />


---

## 14. Complete Layout-to-Simulation Flow

One of the most useful connections from this exercise is seeing how a physical layout can be taken back into the electrical domain for verification.

The complete flow can be represented as:

```text
CMOS Transistor Design
        ↓
Physical Layout
        ↓
Magic
        ↓
DRC / Physical Verification
        ↓
SPICE Extraction
        ↓
Extracted Netlist + Parasitics
        ↓
ngspice
        ↓
Transient Analysis
        ↓
Electrical Verification
```

The simulation is therefore not isolated from layout—the extracted physical information becomes part of the electrical analysis.

---

## 15. From Custom Layout to Standard Cell

The inverter can also be viewed as a small example of the cells used inside an ASIC standard-cell library.

For a cell to be usable in an ASIC flow, its physical geometry and logical interface need to follow well-defined technology and library requirements.

Important characteristics include:

* Defined cell dimensions
* Power connections
* Ground connections
* Input pins
* Output pins
* Technology-compliant geometry
* Routing compatibility
* Timing information
* Electrical characterization

This makes the custom inverter a useful bridge between transistor-level design and the standard-cell libraries used later in digital implementation.

The overall relationship can be visualized as:

```text
CMOS Transistor Design
        ↓
Custom Inverter
        ↓
Physical Layout
        ↓
DRC / Extraction
        ↓
Electrical Characterization
        ↓
Standard Cell
        ↓
ASIC Standard-Cell Library
```

---

## 16. Skills and Concepts Covered

### CMOS

* CMOS inverter operation
* PMOS/NMOS complementary behavior
* CMOS switching
* Noise margins
* CMOS robustness
* Rise and fall behavior
* Propagation delay

### Fabrication

* CMOS fabrication flow
* 16-mask process
* N-well and P-well formation
* Active-region formation
* Gate formation
* Source/drain implantation
* Contacts
* Metal interconnects
* Photolithography and masking

### SPICE

* SPICE deck structure
* Device models
* Circuit connectivity
* Power supplies
* Input stimulus
* Load capacitance
* Transient simulation
* Extracted circuit representation

### SKY130

* SkyWater technology
* SKY130 PDK
* Technology layers
* Standard-cell libraries
* Technology-specific design information

### Magic

* VLSI layout
* SKY130 technology setup
* Physical layer inspection
* DRC
* SPICE extraction
* Standard-cell layout

### Simulation

* ngspice
* Transient analysis
* Input/output waveform interpretation
* Electrical verification
* Parasitic effects

---

## 17. Connecting the Different Design Levels

The work on this day also showed that ASIC design is not limited to a single representation of a circuit. The same logic can be described at several levels.

```text
Transistor
    ↓
Logic Gate
    ↓
Standard Cell
    ↓
RTL
    ↓
Synthesized Netlist
    ↓
Physical Layout
    ↓
Extracted Circuit
    ↓
Electrical Verification
```

For the inverter, the logical behavior can simply be written as:

```text
Y = ~A
```

At the physical level, however, additional characteristics become relevant, including:

* Transistor dimensions
* Drive strength
* Resistance
* Capacitance
* Propagation delay
* Rise time
* Fall time
* Power characteristics
* Physical dimensions

Therefore, changing the physical implementation can affect the electrical response of the circuit.

---

## 18. Final Takeaways

Day 8 connected the device, fabrication, layout, and simulation sides of CMOS design into one practical flow.

The inverter was followed through these stages:

```text
Device Level
     ↓
Circuit Level
     ↓
Fabrication Level
     ↓
Layout Level
     ↓
SPICE Level
     ↓
Simulation Level
```

The practical flow ended with a custom SKY130 inverter layout, its extracted SPICE model, and an ngspice transient simulation.

The simulation produced the expected inverted output and also showed that real circuit transitions have finite timing behavior.

Together, these topics provide a starting point for understanding how a transistor-level design becomes a reusable standard cell within a larger ASIC flow.

---

## 19. References Used

The following resources were used as supporting references during the training session.

### SkyWater SKY130 PDK Documentation

The SkyWater SKY130 PDK documentation was used for information related to:

* SKY130 technology
* PDK concepts
* Technology information
* Process-related information
* Design rules
* Device and library information

Reference:

[https://skywater-pdk.readthedocs.io/en/main/](https://skywater-pdk.readthedocs.io/en/main/)

### Magic VLSI

Magic VLSI documentation and project information were used for topics including:

* Magic VLSI layout
* Physical design
* Layout editing
* Design Rule Checking
* Circuit extraction
* Technology-specific layout operations

Reference:

[https://opencircuitdesign.com/magic/](https://opencircuitdesign.com/magic/)

```

**This is the raw Markdown** — copy everything inside the code block and paste it directly into your GitHub `README.md`.
```
