# PD Module 4: Timing Analysis, CTS & Post-CTS STA

## Overview

module 4 covers the timing-oriented portion of the SKY130 ASIC physical design flow. The module connects standard-cell timing information with setup and hold checks, Clock Tree Synthesis (CTS), placement, clock distribution, skew, and Static Timing Analysis (STA).

The main goal is to understand how timing is evaluated after synthesis and physical implementation, and how the physical clock network influences sequential timing paths.

## module 4 Learning Flow

```text
Standard-Cell Timing Information
            ↓
       Delay Tables
            ↓
     Setup / Hold Checks
            ↓
   Clock Tree Synthesis
            ↓
    Clock Distribution
            ↓
 Placement / Physical Design
            ↓
      Post-CTS Timing
            ↓
   Clock Skew / Glitch Checks
            ↓
   Static Timing Analysis
            ↓
       WNS / TNS
            ↓
    Timing Closure
````

---

# 1. Timing Models and Delay Tables

Timing analysis depends on accurate timing data for the standard cells used in the design. Cell libraries contain characterized information for different input transitions and output loading conditions.

Typical factors used by the timing engine include:

* Input slew
* Output load capacitance
* Standard-cell type
* Input and output transition conditions

Delay tables help the STA tool estimate the delay of a cell for a particular electrical operating condition.

### Important Timing Terms

* **Input slew** — the time taken by an input signal to transition.
* **Output load** — the capacitive load connected to a cell output.
* **Cell delay** — propagation delay through a standard cell.
* **Buffer delay** — delay added by a buffer inserted into a data or clock path.
* **Slew degradation** — deterioration of signal transition quality as the signal travels through the circuit.

### Delay Table — Buffering Level 1

<img width="1642" height="890" alt="Screenshot 2026-09-26 222321" src="https://github.com/user-attachments/assets/bcd3728e-f750-46cc-b1da-1bd8b0a3076b" />


### Delay Table — Buffering Level 2

<img width="920" height="532" alt="Screenshot 2026-09-26 222451" src="https://github.com/user-attachments/assets/540dbf87-2b1b-4903-af82-e1aeddd7269f" />

### Delay Components

<img width="892" height="528" alt="Screenshot 2026-09-26 222555" src="https://github.com/user-attachments/assets/496a64e2-9777-4f18-9794-bcbfc338d399" />

The delay of a physical path is determined by more than the logic cells. Wire resistance, wire capacitance, interconnect length, buffering, and parasitic effects all contribute to the overall path delay.

---

# 2. Setup and Hold Timing

Sequential timing analysis determines whether data reaches a receiving flip-flop within the required time window with respect to the clock.

## 2.1 Setup Timing

Setup timing checks whether the data signal becomes stable sufficiently **before the active clock edge** reaches the capture flip-flop.

```text
Launch FF ─── Combinational Logic ─── Capture FF
     │                                  │
 Launch Clock                       Capture Clock
```

If the data arrives later than the allowed setup window, the path has a **setup violation**.

### Setup Analysis with an Ideal Clock

<img width="895" height="600" alt="Screenshot 2026-09-26 222657" src="https://github.com/user-attachments/assets/797ef687-a1d5-465d-80a1-91a07e03cb2b" />

### Setup Analysis with a Real Clock

<img width="925" height="641" alt="Screenshot 2026-09-26 222715" src="https://github.com/user-attachments/assets/cbd8f997-2605-4ad5-9d13-0f1706309268" />

### Setup Time Concept

<img width="917" height="582" alt="Screenshot 2026-09-26 222819" src="https://github.com/user-attachments/assets/1d4a1e76-aea8-42e8-9bbd-72bc00d33e75" />


---

## 2.2 Hold Timing

Hold timing checks whether the data remains stable for the required period **after the active clock edge**.

If new data reaches the capture flip-flop too quickly after the clock transition, a **hold violation** may occur.

### Hold Analysis with an Ideal Clock

<img width="917" height="582" alt="Screenshot 2026-09-26 222819" src="https://github.com/user-attachments/assets/a515f543-f6c4-4de4-8bb4-8ce5631bac1a" />


### Hold Analysis with a Real Clock

<img width="942" height="573" alt="Screenshot 2026-09-26 222931" src="https://github.com/user-attachments/assets/43d0f8a7-db4e-47ed-85e3-c2b3bf124ebd" />


### Hold Time Concept

![Hold Time](https://github.com/Moursagna/VSDIAT-Chip-Design/raw/main/Day_9/images/Hold_time.png)

---

## 2.3 Ideal Clock vs Real Clock

An ideal clock assumes a simplified clock-arrival relationship and does not model the physical effects of the clock distribution network.

After CTS, the clock travels through a physical network containing elements such as:

* Clock buffers
* Interconnect
* Wire resistance
* Wire capacitance
* Different branch lengths

Consequently, real-clock timing analysis includes effects such as **clock insertion delay** and **clock skew**.

---

# 3. Clock Tree Synthesis (CTS)

Clock Tree Synthesis builds the physical distribution network that carries the clock signal from its source to the required sequential elements.

The major goals of CTS are:

* Reach all required sequential elements.
* Control clock latency.
* Minimize unwanted clock skew.
* Maintain suitable clock transition characteristics.
* Create a physically realizable clock network.

## 3.1 H-Tree Clock Distribution

An H-tree uses a symmetric branching structure to provide similar clock-path lengths to different regions of the design.

<img width="942" height="573" alt="Screenshot 2026-09-26 222931" src="https://github.com/user-attachments/assets/31c191ad-5a17-49b2-b3e3-8234ca410d74" />

## 3.2 Clock Buffers

Clock buffers are added to drive the capacitive load of the clock network and maintain acceptable signal transition characteristics.

<img width="922" height="572" alt="Screenshot 2026-09-26 222952" src="https://github.com/user-attachments/assets/616ac8f5-110a-4782-8b27-8ddcf0eb9351" />

## 3.3 Clock Net Shielding

Clock signals can be affected by coupling from nearby wires. Shielding techniques help reduce unwanted capacitive coupling and associated noise.

<img width="931" height="697" alt="Screenshot 2026-09-26 223207" src="https://github.com/user-attachments/assets/6e5c0c80-c672-445d-a147-5cb460d61217" />

## 3.4 CTS Terminal / Clock Network

The completed clock network connects the clock source to the required sequential elements through the synthesized distribution structure.

---

# 4. Physical Implementation and Placement

Physical implementation has a direct influence on timing because interconnect delay depends on the actual physical geometry of the design.

Important physical-design factors include:

* Floorplanning
* Placement
* Cell locations
* Available routing resources
* Interconnect length
* Parasitic effects

### Floorplan / Terminal View
<img width="902" height="447" alt="Screenshot 2026-09-26 223840" src="https://github.com/user-attachments/assets/92551038-da75-4759-a9dc-b91d08b21452" />

### Placement

<img width="683" height="415" alt="Screenshot 2026-09-26 223859" src="https://github.com/user-attachments/assets/76baab33-3e25-4e5f-bbbb-c496e68ace6d" />


### Placement — Additional View

<img width="790" height="403" alt="Screenshot 2026-09-26 223921" src="https://github.com/user-attachments/assets/037279b7-ee35-4ab4-9123-7c43be7b9056" />

### Expanded Placement View

<img width="621" height="397" alt="Screenshot 2026-09-26 223949" src="https://github.com/user-attachments/assets/f1d8bf2f-8fa9-4d90-9679-b326a8f12adf" />


---

# 5. Post-CTS Timing Effects

Once CTS is completed, timing analysis becomes more representative of the physical implementation because the clock network is now modeled as an actual structure.

Important post-CTS effects include:

* Clock insertion delay
* Clock skew
* Clock uncertainty
* Clock-buffer delay
* Interconnect RC delay
* Crosstalk and coupling
* Clock waveform degradation

## 5.1 Clock Skew

Clock skew is the difference between the arrival times of a clock signal at two relevant sequential elements.

For two clock paths:

```text
Skew = |Δ1 - Δ2|
```

The physical clock network, including buffers and interconnect, determines the actual clock arrival times.

<img width="922" height="586" alt="Screenshot 2026-09-26 224231" src="https://github.com/user-attachments/assets/c339b27f-2cae-4ed3-b529-ac30fe9bc07f" />


## 5.2 Glitch Analysis

Signal integrity is also important during physical implementation. Unwanted transitions or glitches can influence timing and, depending on their location, may affect circuit behavior.

<img width="592" height="435" alt="Screenshot 2026-09-26 224247" src="https://github.com/user-attachments/assets/3835c2b4-92b8-4c3c-8ac6-ccdb06231351" />

---

# 6. Static Timing Analysis (STA)

Static Timing Analysis evaluates timing paths without requiring exhaustive functional simulation for every possible input sequence.

STA checks whether the timing paths in the design satisfy the specified constraints.

### Data Arrival Time

Data arrival time is the time at which data reaches the capture point.

### Data Required Time

Data required time is the latest permitted arrival time for the data to satisfy the relevant timing requirement.

### Slack

Slack indicates the available timing margin.

For setup analysis:

```text
Slack = Data Required Time - Data Arrival Time
```

A negative setup slack means that the corresponding timing requirement is not satisfied for that path.

## STA Reports

STA reports provide information about timing paths, including cell delays, net delays, clock details, data arrival time, data required time, and slack.

---

# 7. WNS and TNS

Two important summary values used to evaluate timing quality are **Worst Negative Slack (WNS)** and **Total Negative Slack (TNS)**.

## Worst Negative Slack (WNS)

WNS represents the most negative slack value among the analyzed violating paths.

```text
WNS = Minimum Slack
```

For a timing-clean group of paths, the worst slack is non-negative.

## Total Negative Slack (TNS)

TNS represents the combined negative slack of all violating paths.

```text
TNS = Sum of Negative Slacks
```

WNS shows the most severe individual timing problem, while TNS represents the combined timing deficit across violating paths.

---

# 8. Key Engineering Relationships

The major concepts covered in this module can be viewed as one connected timing-analysis flow:

```text
Cell Characterization
        │
        ├── Input Slew
        ├── Output Load
        └── Cell Delay
                │
                ▼
         Timing Analysis
                │
          ┌─────┴─────┐
          ▼           ▼
        Setup        Hold
          │           │
          └─────┬─────┘
                ▼
               CTS
                │
        ┌───────┼────────┐
        ▼       ▼        ▼
     Buffers   Skew    Clock RC
        │       │        │
        └───────┴────────┘
                │
                ▼
          Post-CTS STA
                │
          ┌─────┴─────┐
          ▼           ▼
         WNS         TNS
```

---

# 9. Practical VLSI Significance

Day 9 connects timing concepts with practical ASIC physical implementation.

A design can be functionally correct at RTL and still fail timing after synthesis or physical implementation because:

* Logic paths have finite propagation delays.
* Different standard cells have different timing characteristics.
* Interconnect introduces resistance and capacitance.
* Clock paths introduce insertion delay.
* Clock signals may reach different sequential elements at different times.
* Both setup and hold requirements must be satisfied.

Therefore, timing closure is an iterative process involving RTL design, synthesis, cell selection, buffering, placement, CTS, routing, parasitic extraction, and STA.

---

# 10. Day 9 Key Learnings

The following concepts were covered during this module:

* Standard-cell timing characterization
* Input slew and output load
* Delay tables
* Cell delay and buffer delay
* Setup timing
* Hold timing
* Ideal-clock timing analysis
* Real-clock timing analysis
* Clock Tree Synthesis
* H-tree clock distribution
* Clock buffering
* Clock net shielding
* Placement and physical implementation
* Clock insertion delay
* Clock skew
* Glitch analysis
* Static Timing Analysis
* Data arrival time
* Data required time
* Slack
* Worst Negative Slack (WNS)
* Total Negative Slack (TNS)
* Timing violations
* Timing closure

---

# 11. Day 9 Completion Checklist

* [x] Reviewed timing-model fundamentals
* [x] Examined delay tables and buffering
* [x] Studied setup timing
* [x] Studied hold timing
* [x] Compared ideal-clock and real-clock behavior
* [x] Studied Clock Tree Synthesis
* [x] Reviewed H-tree clock distribution
* [x] Studied clock buffering
* [x] Studied clock-net shielding
* [x] Reviewed physical placement
* [x] Studied clock skew
* [x] Examined glitch behavior
* [x] Reviewed STA reports
* [x] Studied WNS and TNS
* [x] Connected timing analysis with physical implementation

---

## Conclusion

Day 9 demonstrates how **timing models, clock distribution, physical implementation, and Static Timing Analysis** are connected within the SKY130 ASIC flow.

The key takeaway is:

> **Physical implementation directly influences timing, while STA determines whether the implemented design meets its timing constraints.**

These concepts provide the foundation for understanding and improving **timing closure** in a complete ASIC design flow.

```
```
