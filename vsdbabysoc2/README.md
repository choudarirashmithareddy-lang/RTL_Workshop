# VSDBabySoC – Physical Design Implementation Using OpenROAD

## 1. Introduction

This project focuses on the physical implementation of VSDBabySoC using OpenROAD and the Sky130HD standard-cell platform. It builds on the RTL design and synthesis concepts by exploring how a synthesized circuit is organized and connected within a physical layout.

The implementation process includes floorplanning, power distribution, standard-cell placement, clock tree synthesis, routing, and timing evaluation. Each stage contributes to transforming the synthesized design into a physical representation.

## 2. Objectives

- Understand the physical design flow of VSDBabySoC.
- Examine the floorplan and core area.
- Generate the power distribution network.
- Study standard-cell placement.
- Understand clock tree synthesis.
- Inspect signal routing and metal interconnections.
- Evaluate timing reports and physical design results.
- Understand the final layout-generation process.

## 3. Tools and Technology

- **Design:** VSDBabySoC
- **Physical design tool:** OpenROAD
- **Flow automation:** OpenROAD-flow-scripts
- **Technology platform:** Sky130HD
- **Operating environment:** Linux
- **Layout inspection:** OpenROAD GUI

## 4. Physical Design Flow

```text
Synthesized Netlist
        |
        v
   Floorplanning
        |
        v
 Power Distribution
        |
        v
 Standard-Cell Placement
        |
        v
 Clock Tree Synthesis
        |
        v
      Routing
        |
        v
 Timing Analysis
        |
        v
 Physical Verification
        |
        v
  Layout Generation
```

## 5. Implementation Stages

### 5.1 Floorplanning

Floorplanning establishes the physical boundaries of the design and prepares the core area for cell placement.

The main aspects include:
- Die and core dimensions
- Standard-cell rows
- Placement area
- Initial physical layout

### 5.2 Power Distribution Network

The power distribution network connects the power and ground supplies to the design.

This stage establishes the configured power-grid structures and connections needed by the standard cells.

### 5.3 Standard-Cell Placement

Placement assigns physical positions to standard cells within the core area.

The placement process considers design constraints, available space, timing, and routing congestion.

### 5.4 Clock Tree Synthesis

Clock tree synthesis constructs a clock distribution network for sequential elements.

The objective is to distribute the clock while managing clock latency, skew, and transition requirements.

### 5.5 Routing

Routing creates the physical metal connections between the placed cells.

The routing stages establish signal paths using the available metal layers and vias defined by the technology platform.

### 5.6 Timing Analysis

Static Timing Analysis evaluates whether the implemented circuit satisfies its timing constraints.

Important parameters include:
- Setup slack
- Hold slack
- Worst Negative Slack (WNS)
- Total Negative Slack (TNS)
- Critical timing paths
- Results for configured process-voltage-temperature corners

### 5.7 Physical Verification and Layout Generation

Physical verification checks the layout against applicable design rules and connectivity requirements.

The final implementation may include DRC, LVS, and GDSII generation, depending on the configured flow. These stages must be confirmed using the actual reports and output files.

## 6. Results

Record the status of each stage after running the implementation.

| Stage | Status |
|---|---|
| Floorplanning |  verified |
| Power distribution |  verified |
| Placement |  verified |
| Clock tree synthesis |  verified |
| Routing |  verified |
| Timing analysis | verified |
| Physical verification |  verified |
| GDSII generation |  verified |


## 7. Conclusion

This project provides a structured study of the physical implementation of VSDBabySoC using OpenROAD and the Sky130HD platform. It covers the major stages involved in moving from a synthesized netlist toward a physical layout and introduces the role of timing analysis and physical verification in the implementation process.


