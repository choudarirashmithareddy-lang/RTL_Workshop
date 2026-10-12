# Static Timing Analysis (STA) of RVMYTH/BabySoC Across SKY130 PVT Corners

**Design:** RVMYTH/BabySoC\
**Technology:** SKY130 HD standard-cell library\
**STA tool:** OpenSTA

## Overview

Static Timing Analysis (STA) checks whether the timing paths in a
digital design satisfy the required timing constraints without applying
simulation vectors. This assessment analyzes the synthesized
RVMYTH/BabySoC design using SKY130 HD Liberty timing libraries across 16
timing corners.

## Objectives

-   Check setup and hold timing.
-   Review Worst Negative Slack (WNS) and Total Negative Slack (TNS).
-   Compare timing behavior across process, voltage, and temperature
    (PVT) conditions.
-   Preserve timing screenshots from the assessment PDF for each listed
    corner.

## Tools Used

-   Ubuntu Linux
-   Docker
-   OpenSTA
-   SKY130 HD standard-cell Liberty (`.lib`) timing libraries
-   Synthesized Verilog netlist

## About the Timing Libraries

Liberty timing files contain standard-cell information such as cell
delay, transition/slew, setup time, hold time, pin capacitance, and
timing arcs. Different corners represent different process, voltage, and
temperature operating conditions.



## Timing Corners Listed in the Assessment

    No. Timing corner file listed in the assessment
  ----- ---------------------------------------------
      1 `sky130_fd_sc_hd__ff_100C_1v65.lib`
      2 `sky130_fd_sc_hd__ff_100C_1v95.lib`
      3 `sky130_fd_sc_hd__ff_n40C_1v56.lib`
      4 `sky130_fd_sc_hd__ff_n40C_1v65.lib`
      5 `sky130_fd_sc_hd__ff_n40C_1v76.lib`
      6 `sky130_fd_sc_hd__ff_n40C_1v95.lib`
      7 `sky130_fd_sc_hd__ss_100C_1v40.lib`
      8 `sky130_fd_sc_hd__ss_100C_1v60.lib`
      9 `sky130_fd_sc_hd__ss_n40C_1v28.lib`
     10 `sky130_fd_sc_hd__ss_n40C_1v35.lib`
     11 `sky130_fd_sc_hd__ss_n40C_1v40.lib`
     12 `sky130_fd_sc_hd__ss_n40C_1v44.lib`
     13 `sky130_fd_sc_hd__ss_n40C_1v60.lib`
     14 `sky130_fd_sc_hd__ss_n40C_1v76.lib`
     15 `sky130_fd_sc_hd__tt_025C_1v80.lib`
     16 `sky130_fd_sc_hd__tt_100C_1v80.lib`

> **Filename note:** The extracted PDF text has formatting issues in
> some corner labels. Verify exact Liberty filenames against your local
> SKY130 timing-library directory before running analysis scripts.

## Results Summary

According to the assessment:

-   The FF and TT corners analyzed show positive setup WNS and zero
    setup TNS.
-   The SS corners show negative setup WNS and negative setup TNS,
    indicating setup timing violations under those operating conditions.
-   Hold analysis shows positive WNS and zero TNS for all 16 corners.
-   Timing behavior changes with the process, voltage, and temperature
    conditions represented by the libraries.

The assessment text provides these results qualitatively. Add measured
numerical WNS/TNS values from your OpenSTA reports if a numeric
comparison table is required.

## Conclusion

The assessment reports setup and hold analysis of the synthesized
RVMYTH/BabySoC design across 16 SKY130 HD timing corners using OpenSTA.
The reported setup results indicate violations in the SS corners, while
the FF and TT corners analyzed show positive setup WNS and zero setup
TNS. Hold analysis reports positive WNS and zero TNS across all 16
corners. The extracted page screenshots are included as repository image
references above.


