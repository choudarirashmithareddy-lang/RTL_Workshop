# Post-Route Multi-Corner Static Timing Analysis of VSDBabySoC Using OpenROAD and SKY130HD

## Abstract

Static Timing Analysis (STA) checks whether signal propagation delays satisfy a design's timing constraints without requiring functional input test vectors. This project performs post-route multi-corner STA on the VSDBabySoC design using OpenROAD and SKY130HD standard-cell timing libraries.

The analysis covers 16 process, voltage, and temperature (PVT) timing views, including fast-fast (FF), slow-slow (SS), and typical-typical (TT) corners. Setup and hold timing reports were generated, and WNS, TNS, and worst hold slack were collected for comparison.

The worst setup result reported in the source report is at `ss_n40C_1v28`, with setup WNS of **−31.8218 ns** and setup TNS of **−14651.1211 ns**. The report states that worst hold slack is positive across all 16 corners.

## Objectives

- Perform post-route STA on VSDBabySoC.
- Analyze the design across 16 SKY130HD timing views.
- Evaluate setup and hold timing at each corner.
- Collect setup WNS/TNS and hold-related metrics.
- Identify corners with the most severe setup violations.
- Generate per-corner setup and hold reports and visual comparisons.
- Organize reports and evidence for project documentation.

## Tools and Design Inputs

| Tool / component | Purpose |
|---|---|
| OpenROAD | Post-route STA and timing-report generation |
| VS Code Codespaces | Development environment and terminal |
| SKY130HD timing libraries | Standard-cell timing models for PVT views |
| VSDBabySoC | Design under analysis |
| Routed ODB database | Physical-design information used by STA |
| SDC file | Clock and timing constraints |

## Key Timing Terms

- **WNS (Worst Negative Slack):** The worst slack reported for the selected timing check. A negative setup WNS indicates a setup timing violation.
- **TNS (Total Negative Slack):** The accumulated negative slack from failing paths. A nonzero negative setup TNS indicates setup violations across one or more paths.
- **Setup timing:** Checks whether data arrives early enough before the capture clock edge.
- **Hold timing:** Checks whether data remains stable for the required time after the capture clock edge.
- **PVT corner:** A timing-library view representing process, voltage, and temperature conditions.


**Additional values recorded in the report:** clock period = 11 ns; data arrival time = 47.1052 ns; data required time = 15.2834 ns; setup slack = −31.8218 ns at the worst setup corner.

**Hold-metric note:** The source report explains that hold WNS and hold TNS are the values from OpenROAD's `report_wns -min` and `report_tns -min`. The separate “hold worst slack” column records the actual worst slack and is positive for all listed corners. Do not treat the zero hold WNS column as the same quantity as the positive hold worst-slack column.

## Main Observations

1. The most severe setup timing result is at `ss_n40C_1v28`.
2. Other slow-process corners also show setup timing violations, including `ss_n40C_1v35`, `ss_n40C_1v40`, `ss_n40C_1v44`, `ss_100C_1v40`, and `ss_n40C_1v60`.
3. The listed FF and TT corners have zero setup WNS/TNS in the summary table.
4. The source report lists positive hold worst slack at all 16 corners.
5. Before signoff, timing constraints, macro timing models, and parasitic-extraction assumptions should be validated, followed by further timing optimization and signoff-oriented analysis.

## Conclusion

Post-route multi-corner STA was performed on VSDBabySoC using OpenROAD and 16 SKY130HD timing-library views. Setup and hold reports were generated, and the timing metrics were consolidated into a summary. The worst setup corner reported was `ss_n40C_1v28`, with WNS of −31.8218 ns and TNS of −14651.1211 ns. The reported worst hold slack remained positive across all 16 corners.

The results show that the slow-process timing views require further setup-timing investigation and optimization. Final signoff should follow validation of constraints, timing models, and parasitic assumptions.
3. Upload the extracted `images` folder beside `README.md`.
4. Commit the changes. GitHub will display the Markdown and the embedded images automatically.
