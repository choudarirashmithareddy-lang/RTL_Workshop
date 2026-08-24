# RTL_Workshop
This repository contains my work and learning activities from the RTL Design Workshop. It covers RTL coding using Verilog, digital-circuit simulation, waveform verification, synthesis, timing libraries, and sequential-circuit design. The repository includes practical work, commands, simulation outputs, synthesis results, screenshots, and observations.
# Workshop Progress
|Modules  |  Topics                                                         | Status      |
| ----- | --------------------------------------------------------------- | ----------- |
| Module 1 | Introduction to Verilog RTL design and Synthesis      |  Completed |
| Module 2 | Timing libs, hierarchical vs flat synthesis and efficient flop coding styles |  Completed |
| Module 3 | Combinational and sequential optmizations    |  Completed |
| Module 4 | GLS, blocking vs non-blocking and Synthesis-Simulation mismatch |  Completed |
| Module 5 | Optimization in synthesis    |  Completed |


# Module 1 – RTL Design, Simulation & Synthesis

Module 1 concentrated on learning the fundamentals of the RTL design flow, beginning with Verilog simulation and then moving towards the synthesis process using Yosys

### Topics Covered
- what is Simulator,Design,TestBench ?
- How simulator works?
- iverilog based Simulation Flow
- 2:1 Multiplexer implementation
- GTKWave waveform analysis
- RTL Design and Synthesis
- Introduction to Yosys 
- Understanding `.lib` files
- Faster and slower cell flavors
- Cell selection based on design requirements
- Synthesis lab with yosys
---

## Module 1 Documentation

The complete Module 1 experiment, including commands, explanations, screenshots, synthesis results, and observations:
 [Module1 – RTL Design, Simulation & Synthesis](./Module1/README.md)
 
---
# Module 2 – Timing Libraries, Synthesis & Flip-Flop RTL

Module 2 concentrated on exploring technology libraries, timing characteristics, hierarchical and flattened synthesis approaches, and various flip-flop RTL coding techniques.
### Topics Covered
- Timing Libraries
- SKY130 PDK Overview
- Decoding tt_025C_1v80 in the SKY130 PDK
- Opening and Exploring the .lib File
- Hierarchical vs. Flattened Synthesis
- Flip-Flop Coding Styles
- Asynchronous Reset D Flip-Flop
- Asynchronous Set D Flip-Flop
- Synchronous Reset D Flip-Flop
- Icarus Verilog Simulation
- Synthesis with Yosys
---

## Module 2 Documentation

The complete Module 2 experiment, including commands, explanations, screenshots, simulation results, synthesis results, and observations:

 [Module 2 – Timing Libraries, Synthesis & Flip-Flop RTL](./Module2/README.md)
 
---
# Module 3 – RTL & Logic Optimization

Module 3 focused on how synthesis tools can simplify RTL and logic while maintaining the required functionality.

The experiments explored constant propagation, redundant logic removal, D flip-flop optimization, and counter optimization.

### Topics Covered

- RTL optimization
- Logic optimization
- AND logic optimization
- OR logic optimization
- Three-input AND logic
- Constant propagation
- D flip-flop optimization
- DFF with constant output
- DFF constant propagation
- Counter optimization
- Redundant logic removal
- Comparison of optimized and unoptimized implementations
- Optimization observations

Optimization Flow
      
RTL Description
      ↓
Logic Analysis
      ↓
Constant Propagation
      ↓
Redundant Logic Removal
      ↓
Logic Optimization
      ↓
Optimized Hardware

---
## Module 3 Documentation

"Module 3 – RTL & Logic Optimization"

---

# Module 4 – RTL to Gate-Level Simulation

Module 4 explored the transition from RTL simulation to synthesized gate-level verification.

The experiments also demonstrated how Verilog coding practices can affect simulation results and potentially create differences between RTL simulation and synthesized hardware.

### Topics Covered

- RTL-to-Gate-Level Simulation flow
- Ternary-operator based MUX
- 2:1 MUX operation
- RTL simulation
- Yosys synthesis
- Standard-cell technology mapping
- Gate-level netlist generation
- Gate-Level Simulation
- Incomplete sensitivity lists
- Incorrect MUX implementation
- "always @(*)"
- Blocking assignments
- Non-blocking assignments
- Blocking vs non-blocking assignments
- Simulation–synthesis mismatch
- RTL versus gate-level waveform comparison

Simulation & Verification Flow

RTL Design
    ↓
RTL Simulation
    ↓
Synthesis
    ↓
Technology Mapping
    ↓
Gate-Level Netlist
    ↓
Gate-Level Simulation
    ↓
Waveform Comparison

---

## Module 4 Documentation

"Module 4 – RTL to Gate-Level Simulation" (./Module4/README.md)

---

# Module 5 – RTL Coding Styles & Looping Constructs

Module 5 concentrated on conditional RTL coding, latch inference, synthesis optimization, and looping constructs.

The practical work included incomplete and complete "if-else" and "case" implementations, wildcard "casez" behavior, MUX and DEMUX designs, and a Ripple Carry Adder using a generate loop.

### Topics Covered

- RTL coding styles
- "if-else" statements
- "case" statements
- Priority-based logic
- Incomplete conditional assignments
- Inferred latches
- Incomplete "if" statements
- Incomplete "case" statements
- Complete "case" statements
- Partial output assignments
- Overlapping "casez" conditions
- Redundancy optimization
- Boolean logic simplification
- Procedural "for" loops
- Generate "for" loops
- Loop-based MUX
- CASE-based DEMUX
- Loop-based DEMUX
- Ripple Carry Adder
- Structural hardware generation

Hardware Design Flow

RTL Coding
     ↓
Functional Simulation
     ↓
Logic Analysis
     ↓
Synthesis
     ↓
Hardware Inference
     ↓
Netlist Generation
     ↓
Waveform & Hardware Analysis

---
## Module 5 Documentation

"Module 5 – RTL Coding Styles & Looping Constructs" (./Module5/README.md)

---
##  Tools Used

- Verilog
- Icarus Verilog (iverilog)
- GTKWave
- Yosys
- SKY130 Standard Cell Library
- Linux / Ubuntu
- Git & GitHub
---

Overall Learning Outcomes

After completing the five-Modules workshop, I gained practical exposure to the following areas:

RTL Design

- Writing Verilog RTL descriptions
- Creating testbenches
- Designing combinational and sequential circuits
- Understanding different RTL coding styles

Simulation

- Compiling Verilog designs with Icarus Verilog
- Running RTL simulations
- Generating simulation waveforms
- Inspecting signal behavior using GTKWave

Synthesis

- Working with Yosys
- Understanding the RTL synthesis process
- Examining synthesis statistics
- Generating gate-level netlists
- Performing technology mapping

Timing & Libraries

- Understanding ".lib" files
- Exploring timing information
- Understanding PVT conditions
- Working with SKY130 standard cells
- Comparing different cell implementations

Optimization

- RTL optimization
- Logic optimization
- Constant propagation
- Redundant logic elimination
- D flip-flop optimization
- Counter optimization

Gate-Level Verification

- Understanding the RTL-to-gate-level flow
- Performing Gate-Level Simulation
- Comparing RTL and synthesized behavior
- Analysing synthesized netlists

RTL Coding Practices

- Using "if-else" correctly
- Writing complete "case" statements
- Understanding latch inference
- Handling wildcard "casez" conditions
- Understanding blocking assignments
- Understanding non-blocking assignments
- Using "always @(*)" for combinational logic
- Identifying potential simulation–synthesis mismatches

Hardware Structures

- Multiplexer design
- Demultiplexer design
- D flip-flops
- Ripple Carry Adder
- Procedural loops
- Generate loops
- Repeated structural hardware

---
Workshop Documentation

Day| Documentation
Day 1| "RTL Design, Simulation & Synthesis" (Module1/README.md)
Day 2| "Timing Libraries, Synthesis & Flip-Flop RTL" (Module2/README.md)
Day 3| "RTL & Logic Optimization" (Module3/README.md)
Day 4| "RTL to Gate-Level Simulation" (Module4/README.md)
Day 5| "RTL Coding Styles & Looping Constructs" (Module5/README.md)

---

 Final Takeaway

The five-day workshop provided a practical understanding of the journey from RTL code to synthesized digital hardware.

Starting with basic Verilog design and simulation, the workshop progressed through timing libraries, synthesis, optimization, technology mapping, gate-level verification, and advanced RTL coding constructs.

The hands-on experiments helped connect theoretical concepts with actual simulation waveforms, synthesized netlists, standard-cell implementations, and verification results.

Overall, this repository represents my practical learning and experimentation with the RTL design and digital hardware implementation flow.


---
## Author

* choudari rashmitha

