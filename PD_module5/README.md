#  Module 5 – RTL-to-GDSII Physical Design Implementation

This module documents the back-end physical-design stages for an **inverter** using the **SKY130A PDK** and the OpenLane-based flow.

The work covers power-network creation, routing, design-rule verification, parasitic extraction, post-route timing analysis, GDSII generation, and final layout inspection.

---

##  Contents

1. [Objective](#1--objective)
2. [Software and Technology](#2--software-and-technology)
3. [Design and Run Details](#3--design-and-run-details)
4. [Launching the OpenLane Environment](#4--launching-the-openlane-environment)
5. [Verifying the Existing Design](#5--verifying-the-existing-design)
6. [Physical Design Sequence](#6--physical-design-sequence)
7. [Power Distribution Network](#7--power-distribution-network)
8. [Detailed Routing](#8--detailed-routing)
9. [Design Rule Checking](#9--design-rule-checking)
10. [SPEF and Parasitic Extraction](#10--spef-and-parasitic-extraction)
11. [Post-Route STA](#11--post-route-sta)
12. [Understanding WNS and TNS](#12--understanding-wns-and-tns)
13. [Generating the Final GDSII](#13--generating-the-final-gdsii)
14. [Checking the Layout with KLayout](#14--checking-the-layout-with-klayout)
15. [Important Output Files](#15--important-output-files)
16. [End-to-End Flow](#16--end-to-end-flow)
17. [Verification Summary](#17--verification-summary)
18. [Learning Outcomes](#18--learning-outcomes)
19. [Conclusion](#19--conclusion)

---

# 1. Objective

The purpose of this module is to carry the inverter design through the later stages of the physical-design process and obtain the final GDSII layout.

The main activities performed are:

- Creating the Power Distribution Network (PDN)
- Performing detailed routing
- Running Design Rule Checks (DRC)
- Extracting interconnect parasitics
- Producing the SPEF file
- Performing post-route Static Timing Analysis (STA)
- Examining WNS and TNS reports
- Creating the final GDSII database
- Inspecting the final layout in KLayout

### Overall Flow

```text
RTL
 │
 ▼
Synthesis
 │
 ▼
Floorplan
 │
 ▼
Placement
 │
 ▼
Clock Tree Synthesis
 │
 ▼
PDN Generation
 │
 ▼
Routing
 │
 ▼
DRC
 │
 ▼
Parasitic Extraction
 │
 ▼
SPEF
 │
 ▼
Post-Route STA
 │
 ▼
Final GDSII
 │
 ▼
KLayout Verification
````

---

# 2.  Software and Technology

| Tool / Technology | Purpose                                       |
| ----------------- | --------------------------------------------- |
| **OpenLane**      | Executes the RTL-to-GDSII implementation flow |
| **Docker**        | Provides the OpenLane execution environment   |
| **OpenROAD**      | Handles major physical-design operations      |
| **TritonRoute**   | Performs detailed routing                     |
| **OpenSTA**       | Used for static timing analysis               |
| **Magic**         | Processes layout data and creates GDSII       |
| **KLayout**       | Displays and checks the final layout          |
| **SKY130A PDK**   | Provides the technology and process rules     |

---

# 3.  Design and Run Details

### Design

```text
inverter
```

###  Technology

```text
SKY130A
```

###  OpenLane Docker Image

```text
efabless/openlane:v0.21
```

###  Run Used

```text
26-09_15-08
```

###  OpenLane Working Directory

```text
/home/vsduser/Desktop/work/tools/openlane_working_dir/openlane
```

###  Design Directory

```text
designs/inverter
```

###  Module 5 Run Directory

```text
designs/inverter/runs/26-09_15-08
```

---

# 4.  Launching the OpenLane Environment

The physical-design work was carried out inside the OpenLane Docker environment.

### Start the Docker Container

```bash
sudo docker run -it \
-v $HOME/Desktop/work/tools/openlane_working_dir:/home/vsduser/share \
efabless/openlane:v0.21
```

After entering the container, move to the OpenLane installation:

```bash
cd /home/vsduser/share/openlane
```

Confirm the current location:

```bash
pwd
```

Expected output:

```text
/home/vsduser/share/openlane
```

---

# 5.  Verifying the Existing Design

Before continuing with the later physical-design stages, the inverter directory was inspected.

### Check the Design Directory

```bash
ls designs/inverter
```

### Display Available Runs

```bash
ls -lt designs/inverter/runs
```

The available runs were:

```text
18-09_23-24
26-09_15-08
```

The run selected for this module was:

```text
26-09_15-08
```

---

# 6. Physical Design Sequence

Module 5 continues from the existing implementation and performs the remaining back-end stages.

```text
                 Existing Placement
                        │
                        ▼
                 ┌─────────────┐
                 │     CTS     │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │     PDN     │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │   Routing   │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │     DRC     │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │    SPEF     │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │   OpenSTA   │
                 └──────┬──────┘
                        │
                        ▼
                 ┌─────────────┐
                 │  Final GDS  │
                 └──────┬──────┘
                        │
                        ▼
                     KLayout
```

The required outputs for this module were obtained from the run:

```text
26-09_15-08
```

---

# 7. Power Distribution Network

The Power Distribution Network establishes the physical paths required to deliver supply and ground connections to the standard cells.

The PDN includes:

* Power rings
* Power straps
* Standard-cell power rails
* VDD connections
* VSS connections

### Generate the PDN

The OpenLane command used for this stage is:

```tcl
gen_pdn
```

The PDN stage is positioned between the placement/CTS stages and routing:

```text
Placement / CTS
       │
       ▼
PDN Generation
       │
       ▼
Routing
```

### Key Point

The PDN forms the physical power and ground network that connects the placed cells to the required supply rails.

---

# 8. Detailed Routing

Routing establishes the physical metal connections required by the design netlist after cell placement.

### Run Routing

```tcl
run_routing
```

The routed DEF generated for the inverter is:

```text
results/routing/inverter.def
```

The corresponding routed-layout image is:

```text
results/routing/inverter.def.png
```

### Routing Representation

```text
Standard Cells
      │
      ▼
Global / Detailed Routing
      │
      ▼
Metal Interconnect
      │
      ▼
Routed DEF
```

### Key Point

The routing stage converts logical net connections into physical metal interconnects between the placed cells.

---

# 9.  Design Rule Checking

Design Rule Check (DRC) is used to determine whether the physical layout satisfies the manufacturing constraints defined by the selected technology.

### TritonRoute DRC Report

The generated report is:

```text
reports/routing/22-tritonRoute.drc
```

View the report with:

```bash
cat reports/routing/22-tritonRoute.drc
```

The command produced no output.

Therefore, the supplied run reported:

```text
No DRC violations were reported.
```

## KLayout DRC Result

The KLayout DRC report is located at:

```text
reports/routing/22-tritonRoute.klayout.xml
```

Inspect the beginning of the report:

```bash
head -50 reports/routing/22-tritonRoute.klayout.xml
```

The report contained:

```xml
<categories/>
<items/>
```

Thus, the report contained no violation items.

### Key Point

DRC is the layout-verification step used to check the implemented geometry against the technology's design rules.

---

# 10. SPEF and Parasitic Extraction

After routing, parasitic information associated with the physical interconnect is extracted for timing analysis.

The generated SPEF file is:

```text
results/routing/inverter.spef
```

**SPEF** stands for:

```text
Standard Parasitic Exchange Format
```

It stores extracted parasitic information from the routed implementation.

### SPEF Flow

```text
Routed DEF
    │
    ▼
Parasitic Extraction
    │
    ▼
SPEF
    │
    ▼
Post-Route STA
```

### Key Point

The SPEF data supplies extracted interconnect parasitics to the post-route timing-analysis stage.

---

# 11.  Post-Route STA

Static Timing Analysis was carried out using the parasitic information generated after routing.

### Main OpenSTA Report

```text
reports/synthesis/25-opensta_spef.rpt
```

Display the report:

```bash
cat reports/synthesis/25-opensta_spef.rpt
```

The supplied report showed:

```text
No paths found.
```

### WNS Report

Check the WNS result using:

```bash
cat reports/synthesis/25-opensta_spef_wns.rpt
```

Reported value:

```text
wns 0.00
```

### TNS Report

Check the TNS result using:

```bash
cat reports/synthesis/25-opensta_spef_tns.rpt
```

Reported value:

```text
tns 0.00
```

### STA Summary

| Parameter       | Reported Result   |
| --------------- | ----------------- |
| WNS             | `0.00`            |
| TNS             | `0.00`            |
| Main STA report | `No paths found.` |

The `No paths found` message is retained here exactly as reported by the supplied run.

### Key Point

Post-route STA evaluates timing using the physical implementation and extracted parasitic information.

---

# 12. Understanding WNS and TNS

Two timing quantities reported during STA are WNS and TNS.

* **WNS – Worst Negative Slack**
* **TNS – Total Negative Slack**

##  WNS

WNS represents the minimum slack value among the timing paths considered by the analysis.

```text
WNS = Minimum Slack
```

The supplied report contains:

```text
wns 0.00
```

##  TNS

TNS represents the combined negative slack reported across the analyzed timing paths.

```text
TNS = Sum of Negative Slack
```

The supplied report contains:

```text
tns 0.00
```

### Reported Values

```text
WNS = 0.00
TNS = 0.00
```

### Key Point

WNS describes the lowest reported slack, whereas TNS represents the accumulated negative slack from the timing analysis.

---

# 13.  Generating the Final GDSII

The final physical layout was written into GDSII format.

### Final GDS File

```text
results/magic/inverter.gds
```

### GDS Image

```text
results/magic/inverter.gds.png
```

The supplied file information indicates an image size of approximately:

```text
293 KB
```

### Check the GDS Image

```bash
ls -lh \
~/Desktop/work/tools/openlane_working_dir/openlane/designs/inverter/runs/26-09_15-08/results/magic/inverter.gds.png
```

### Final Layout Conversion

```text
Routed Design
      │
      ▼
    Magic
      │
      ▼
inverter.gds
      │
      ▼
   KLayout
```

### Key Point

GDSII is the final layout database representing the physical implementation of the design.

---

# 14.  Checking the Layout with KLayout

The generated GDSII file was opened in KLayout for visual inspection.

First, move to the OpenLane working directory:

```bash
cd ~/Desktop/work/tools/openlane_working_dir/openlane
```

Open the generated GDSII file:

```bash
klayout \
designs/inverter/runs/26-09_15-08/results/magic/inverter.gds
```

KLayout can then be used to inspect the physical geometry of the completed inverter layout.

---

# 15.  Important Output Files

The major files produced during the module are organized as follows:

```text
results/
│
├── routing/
│   ├── inverter.def
│   ├── inverter.def.png
│   └── inverter.spef
│
└── magic/
    ├── inverter.gds
    ├── inverter.gds.png
    ├── inverter.lef
    ├── inverter.lef.mag
    ├── inverter.mag
    └── .magicrc
```

### Verification Reports

```text
reports/
│
├── routing/
│   ├── 22-tritonRoute.drc
│   └── 22-tritonRoute.klayout.xml
│
└── synthesis/
    ├── 25-opensta_spef.rpt
    ├── 25-opensta_spef_tns.rpt
    ├── 25-opensta_spef_wns.rpt
    ├── 25-opensta_spef.min_max.rpt
    ├── 25-opensta_spef.slew.rpt
    └── 25-opensta_spef.timing.rpt
```

---

# 16.  End-to-End Physical Design Flow

The complete sequence documented in this module is:

```text
                  Inverter Design
                       │
                       ▼
                  Existing Run
                       │
                       ▼
                 PDN Generation
                       │
                       ▼
                    Routing
                       │
                       ▼
                  TritonRoute
                       │
                       ▼
                     DRC
                       │
                       ▼
                  Routed DEF
                       │
                       ▼
              Parasitic Extraction
                       │
                       ▼
                     SPEF
                       │
                       ▼
                   OpenSTA
                       │
                       ▼
                   WNS / TNS
                       │
                       ▼
                  Final GDSII
                       │
                       ▼
                    KLayout
                       │
                       ▼
                 Final Layout
```

---

# 17.  Verification Summary

| Parameter            | Result                        |
| -------------------- | ----------------------------- |
| Design               | **Inverter**                  |
| Technology           | **SKY130A**                   |
| OpenLane             | **v0.21**                     |
| Run                  | **26-09_15-08**               |
| Routing              | ✅ Completed                   |
| Routed DEF           | ✅ Generated                   |
| SPEF                 | ✅ Generated                   |
| TritonRoute DRC      | ✅ No violations reported      |
| KLayout DRC          | ✅ No violation items reported |
| Post-SPEF STA        | ✅ Report generated            |
| WNS                  | **0.00**                      |
| TNS                  | **0.00**                      |
| Final GDSII          | ✅ Generated                   |
| GDS Image            | ✅ Generated                   |
| KLayout Verification | ✅ Completed                   |

---

# 18.  Learning Outcomes

After completing this module, the following physical-design concepts are covered:

* Understanding the role of a PDN in physical implementation
* Converting placed nets into routed metal connections
* Using TritonRoute for detailed routing
* Checking layout geometry with DRC
* Understanding extracted parasitic information in SPEF
* Performing post-route timing analysis with OpenSTA
* Interpreting WNS and TNS reports
* Generating the final GDSII database using the physical-design flow
* Opening and inspecting the final layout in KLayout
* Following the sequence from routed design to final physical layout

---

# 19.  Conclusion

This module completes the later physical-design stages of the inverter implementation using the SKY130A technology and OpenLane environment.

The documented sequence is:

```text
PDN
 ↓
Routing
 ↓
DRC
 ↓
SPEF
 ↓
Post-Route STA
 ↓
GDSII
 ↓
KLayout
```

The supplied run produced the routed DEF, SPEF data, DRC reports, OpenSTA reports, and final GDSII output.

According to the provided reports, the TritonRoute DRC contained no reported violations and the KLayout DRC report contained no violation items. The reported timing values were:

```text
WNS = 0.00
TNS = 0.00
```

The final GDSII was then opened in KLayout for physical-layout inspection.

---

# Final Module 5 Result

```text
                    MODULE 5
                       │
             ┌─────────┴─────────┐
             ▼                   ▼
          Routing               DRC
             │                   │
             └─────────┬─────────┘
                       ▼
                      SPEF
                       │
                       ▼
                    OpenSTA
                       │
                 ┌─────┴─────┐
                 ▼           ▼
                WNS          TNS
               0.00         0.00
                 │
                 ▼
              Final GDS
                 │
                 ▼
               KLayout
                 │
                 ▼
          Final Inverter Layout
```

##  Module Completion

**RTL-to-GDSII physical implementation stages documented successfully for the supplied inverter run.**

```
```
