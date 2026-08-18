# Day 1 – Exploring Verilog RTL Design Through Simulation

## Experiment Objective

The main objective of this experiment was to learn the basic concepts of Register Transfer Level (RTL) design using Verilog HDL. The experiment also involved understanding the process of compiling and simulating Verilog programs using Icarus Verilog (iverilog) and observing the simulation waveforms with GTKWave. As a practical exercise, a 2-to-1 Multiplexer was designed and simulated to understand the complete RTL simulation workflow.

---

## Contents

- [Digital Design Verification](#digital-design-verification)
- [Simulation Workflow with Icarus Verilog](#2️⃣-simulation-workflow-with-icarus-verilog)
- [Practical Exercise – Simulating a 2:1 Multiplexer](#3️⃣-practical-exercise--simulating-a-21-multiplexer)
- [Multiplexer Design Explanation](#4️⃣-multiplexer-design-explanation)
- [Introduction to Yosys](#5️⃣-introduction-to-yosys)
- [RTL Design and Synthesis](#6️⃣-rtl-design-and-synthesis)
- [Understanding the `.lib` File and Cell Flavors](#7️⃣-understanding-the-lib-file-and-cell-flavors)
- [Launching Yosys and Synthesizing the Good Mux](#8️⃣-launching-yosys-and-synthesizing-the-good-mux)
- [Synthesis Results and Gate-Level Representation](#9️⃣-synthesis-results-and-gate-level-representation)
- [Generated Gate-Level Netlist](#🔟-generated-gate-level-netlist)
- [Conclusion](#1️⃣1️⃣-conclusion)

---

# 1️⃣ Digital Design Verification

### Simulator

A simulator is a software tool used to execute and analyze a digital design without physically implementing it on hardware. In Verilog-based design, a simulator applies the specified input conditions to the circuit and shows how the outputs behave. This helps designers verify functionality and detect logical errors at an early stage.

---

### Design

The design refers to the Verilog RTL module that describes the intended digital circuit. It defines the input signals, output signals, and the logical relationship between them

---

### Testbench
A testbench is a separate Verilog module created specifically for testing a design. It provides different input combinations to the design under test and observes the corresponding outputs. A testbench is essential for checking whether the RTL implementation behaves according to the required functionality.


<img width="606" height="285" alt="testbench" src="https://github.com/user-attachments/assets/8f3425fa-8804-4b28-b919-38ae2d3fdfc4" />

---

# 2️⃣ Simulation Workflow with Icarus Verilog

Icarus Verilog (iverilog) is a free and open-source Verilog compiler and simulator. It is used to compile the RTL design along with its testbench and run the simulation. The simulation results can be stored in a Value Change Dump (.vcd) file, which can subsequently be opened and examined using GTKWave.

## Simulation Flow

```text
Design File
      +
Testbench
      ↓
Icarus Verilog (iverilog)
      ↓
Generate .vcd File
      ↓
GTKWave
```

### Simulation Flow Diagram

<img width="701" height="325" alt="simflow" src="https://github.com/user-attachments/assets/fcc78909-5229-4f89-b4c3-58c8cd441f4f" />


---

# 3️⃣ Practical Exercise – Simulating a 2:1 Multiplexer

## Step 1 – Install Required Tools

```bash
sudo apt install iverilog
sudo apt install gtkwave
```

---

## Step 2 – Compile the Design

```bash
iverilog good_mux.v tb_good_mux.v
```

This command compiles the design file and the testbench.

---

## Step 3 – Execute the Simulation

```bash
./a.out
```

Running the above command executes the simulation and generates the waveform file.

---

## Step 4 – Open the Waveform

```bash
gtkwave tb_good_mux.vcd
```

The waveform can now be analyzed using GTKWave.

### GTKWave Output

<img width="1920" height="1012" alt="waveform" src="https://github.com/user-attachments/assets/97c72225-1e60-4409-832a-bb0c5b3b51ae" />

---

# 4️⃣ Multiplexer Design Explanation

## Verilog Design

```verilog
module good_mux (
    input i0,
    input i1,
    input sel,
    output reg y
);

always @(*)
begin
    if (sel)
        y <= i1;
    else
        y <= i0;
end

endmodule
```

---

## Working Principle

### Inputs

- `i0` – First input
- `i1` – Second input
- `sel` – Selection signal

### Output

- `y` – Multiplexer output

### Operation

- When `sel = 0`, the output follows **i0**.
- When `sel = 1`, the output follows **i1**.

### Verilog Code Screenshot

<img width="1920" height="1012" alt="code" src="https://github.com/user-attachments/assets/24df9d93-00c8-4e5e-8ee0-a331dfd32adf" />

---

# 5️⃣ Introduction to Yosys

**Yosys** is an open-source tool used to synthesize Verilog RTL designs and generate a gate-level netlist.

### Yosys Synthesis Flow

The basic synthesis flow is:

1. Load the technology library using `read_liberty`.
2. Read the RTL design using `read_verilog`.
3. Set the top module using `synth -top`.
4. Perform technology mapping using `abc`.
5. Generate the netlist using `write_verilog`.

```text
RTL Design + Library
        ↓
      Yosys
        ↓
Synthesized Netlist
```

```bash
read_liberty -lib <library>.lib
read_verilog good_mux.v
synth -top good_mux
abc -liberty <library>.lib
write_verilog synthesized_mux.v
```

The synthesized netlist is then verified using the testbench and **GTKWave**.


<img width="705" height="416" alt="Screenshot 2026-08-08 222843" src="https://github.com/user-attachments/assets/c07f8c9e-fe0f-4822-881d-e827b5b9f352" />
<img width="703" height="334" alt="Screenshot 2026-08-08 222858" src="https://github.com/user-attachments/assets/3eff0420-b3f9-4bb9-a830-da05794bb501" />


---

# 6️⃣ RTL Design and Synthesis

After introducing Yosys, the next step was to understand how an **RTL design is transformed into a gate-level implementation** through synthesis.

```text
RTL Design
    ↓
  Yosys
    ↓
Gate-Level Netlist
```

### RTL vs Gate-Level Design

| RTL Design | Gate-Level Design |
|------------|-------------------|
| Describes circuit functionality using Verilog. | Represents the circuit using library cells. |
| Easier to understand and modify. | Represents the synthesized hardware structure. |
| Used for RTL simulation. | Used for further implementation and verification. |
<img width="520" height="279" alt="Screenshot 2026-08-09 013331" src="https://github.com/user-attachments/assets/493daa50-28dd-4198-8ae1-a87f09a4df55" />


---

# 7️⃣ Understanding the `.lib` File and Cell Flavors

A **`.lib` (Liberty) file** contains information about the standard cells available in a particular technology library, including their functionality, timing, power, and other characteristics.

Different versions of cells are available for different requirements.

### Faster vs Slower Cells

- **Faster cells** have lower delay and are useful for timing-critical paths.
- **Slower cells** generally have lower power or area and can be used where high speed is not required.

Using fast cells everywhere is unnecessary because not every path is timing-critical. Therefore, synthesis selects suitable cells based on factors such as **timing, power, and area**.

---

# 8️⃣ Launching Yosys and Synthesizing the Good Mux

Yosys can be launched from the terminal using:

```bash
yosys
```
<img width="1920" height="146" alt="yosys launch" src="https://github.com/user-attachments/assets/bf0a0f76-6e89-4b5a-b1b6-3212990fe666" />


The `good_mux` design was then synthesized using the following commands:

```bash
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog good_mux.v
synth -top good_mux
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr good_mux_net.v
```

### Command Meaning

| Command | Purpose |
|---------|---------|
| `read_liberty` | Loads the technology library. |
| `read_verilog` | Reads the Verilog RTL design. |
| `synth -top` | Synthesizes the specified top module. |
| `abc` | Performs technology mapping using the library. |
| `write_verilog` | Generates the synthesized Verilog netlist. |

---

# 9️⃣ Synthesis Results and Gate-Level Representation

After synthesis, Yosys provides statistics about the generated design, including information about its ports, wires, and cells.

<img width="1920" height="401" alt="sysn statistics" src="https://github.com/user-attachments/assets/58e6f167-adfc-4a03-a277-e74cef4f5ee5" />


The synthesized circuit can also be visualized using:

```bash
show
```

This displays a graphical representation of the synthesized gate-level design.

<img width="1920" height="1012" alt="goodmux logic" src="https://github.com/user-attachments/assets/6f8ff5ca-6120-4441-835c-9d92a284c6a4" />

---

# 🔟 Generated Gate-Level Netlist

The synthesized netlist was generated using:

```bash
write_verilog -noattr good_mux_net.v
```

It can be viewed using:

```bash
cat good_mux_net.v
```

The generated netlist represents the original RTL functionality using cells from the selected technology library.

<img width="1920" height="1012" alt="main netlist" src="https://github.com/user-attachments/assets/97d85548-7fb2-4188-8316-5222ead5a96d" />

---
# 1️⃣1️⃣ Conclusion

This experiment helped me understand the fundamental RTL-to-netlist design flow. I learned how to describe a digital circuit using Verilog RTL and verify its behavior through simulation using Icarus Verilog and GTKWave. I also gained an understanding of RTL synthesis using Yosys and learned how a Verilog design can be transformed into a gate-level netlist.

In addition, I learned about the role of Liberty .lib files, standard-cell libraries, and different cell flavors. The importance of balancing timing, power, and area during cell selection was also understood. Finally, the good_mux design was synthesized, its synthesis statistics and gate-level representation were examined, and the resulting synthesized Verilog netlist was generated successfully.

