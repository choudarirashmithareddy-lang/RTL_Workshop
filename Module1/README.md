## Module 1 – Verilog RTL Design, Simulation and Synthesis

The aim of this experiment was to develop a basic understanding of Register Transfer Level (RTL) design using Verilog HDL. It also covered the compilation and simulation of Verilog programs with Icarus Verilog (iverilog), followed by waveform verification using GTKWave. To gain practical experience, a 2-to-1 Multiplexer was designed and simulated as part of the RTL simulation workflow.

## Contents

1. [Understanding RTL Simulation](#1-understanding-rtl-simulation)
2. [Simulation Flow Using Icarus Verilog](#2-simulation-flow-using-icarus-verilog)
3. [Hands-on Experiment – 2-to-1 MUX](#3-hands-on-experiment--2-to-1-mux)
4. [Breaking Down the Verilog Design](#4-breaking-down-the-verilog-design)
5. [Yosys and Standard Cell Libraries](#5-yosys-and-standard-cell-libraries)
6. [RTL Synthesis Procedure](#6-rtl-synthesis-procedure)
7. [Day 1 Learning Outcomes](#7-day-1-learning-outcomes)

---

## 1. Understanding RTL Simulation

Before converting an RTL design into physical hardware, its behavior needs to be verified.

###  Simulator

A **simulator** is a software program used to execute a digital design and observe how its outputs respond to different input conditions.

Simulation helps identify functional problems before the design reaches the synthesis or hardware implementation stage.

###  RTL Design

The **RTL design** is the hardware description written using a language such as **Verilog HDL**.

It describes how signals and logic should behave inside the digital circuit.

###  Testbench

A **testbench** is a separate Verilog module used to test the RTL design.

It provides:

* Input stimulus
* Different combinations of signals
* Simulation control
* Waveform generation
* Output observation

The relationship between the design and its testbench can be represented as:

<img width="2460" height="1080" alt="simulator" src="https://github.com/user-attachments/assets/553ec5bc-e46b-4286-861b-df7d37aa1d36" />


---

## 2. Simulation Flow Using Icarus Verilog

**Icarus Verilog (`iverilog`)** is an open-source Verilog compiler and simulator.

It can be used to compile RTL source files together with their corresponding testbench and execute the resulting simulation.

A typical workflow is:

<img width="1600" height="893" alt="simulationflow" src="https://github.com/user-attachments/assets/9549e4f5-f156-4dfb-bcb3-ca613b619385" />


### 🔄 Basic Simulation Sequence

1. Create the RTL design.
2. Write a testbench for the design.
3. Compile both files using `iverilog`.
4. Execute the generated simulation file.
5. Generate a VCD waveform file.
6. Open the waveform using GTKWave.
7. Verify the circuit behavior.

The generated **`.vcd` (Value Change Dump)** file stores signal transitions during simulation.

---

## 3. Hands-on Experiment – 2-to-1 MUX

To understand the RTL simulation process, we will implement and test a **2-to-1 Multiplexer**.

A 2-to-1 MUX selects one of two input signals based on the value of a select signal.

### Step 1: Download the Workshop Files

Clone the workshop repository:

```bash
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git
```

Move into the Verilog source directory:

```bash
cd sky130RTLDesignAndSynthesisWorkshop/verilog_files
```

### Step 2: Install Simulation Tools

Install **Icarus Verilog**:

```bash
sudo apt install iverilog
```

Install **GTKWave**:

```bash
sudo apt install gtkwave
```

These tools will be used for compiling, running, and visually inspecting the simulation.

### Step 3: Compile the RTL and Testbench

Compile the multiplexer design and its testbench:

```bash
iverilog good_mux.v tb_good_mux.v
```

If compilation is successful, an executable file named `a.out` will be generated.

### Step 4: Execute the Simulation

Run the compiled simulation:

```bash
./a.out
```

The testbench generates the required input combinations and produces the waveform dump.

### Step 5: Open the Waveform

Launch GTKWave using:

```bash
gtkwave tb_good_mux.vcd
```

The waveform viewer allows you to inspect the changes in:

* `i0`
* `i1`
* `sel`
* `y`

<img width="958" height="930" alt="goodmux" src="https://github.com/user-attachments/assets/712e332b-17c6-4942-a43d-2a51582877e8" />


---

## 4. Breaking Down the Verilog Design

The RTL implementation used for the multiplexer is:

```verilog
module good_mux (
    input i0,
    input i1,
    input sel,
    output reg y
);

always @ (*)
begin
    if(sel)
        y <= i1;
    else
        y <= i0;
end

endmodule
```

### 🔍 Signal Description

| Signal | Direction | Purpose              |
| ------ | --------- | -------------------- |
| `i0`   | Input     | First data input     |
| `i1`   | Input     | Second data input    |
| `sel`  | Input     | Select control       |
| `y`    | Output    | Selected data output |

### ⚙️ MUX Operation

The select signal determines which input reaches the output:

| `sel` | Selected Input | Output   |
| ----: | -------------- | -------- |
|     0 | `i0`           | `y = i0` |
|     1 | `i1`           | `y = i1` |

Therefore:

* When `sel = 0`, the output follows `i0`.
* When `sel = 1`, the output follows `i1`.

The `always @(*)` block ensures that the output logic responds whenever one of the input signals used by the block changes.

---

## 5. Yosys and Standard Cell Libraries

### 🔹 What is Yosys?

**Yosys** is an open-source framework used for **RTL synthesis**.

While simulation checks whether the RTL behaves correctly, synthesis transforms the RTL description into a representation of actual digital hardware.

A simplified synthesis flow can be viewed as:

```text
Verilog RTL
     ↓
RTL Processing
     ↓
Logic Optimization
     ↓
Technology Mapping
     ↓
Gate-Level Netlist
```

### 🔹 Main Capabilities of Yosys

Yosys can perform several important tasks:

* Read and process Verilog RTL
* Convert RTL into an internal logic representation
* Optimize digital logic
* Perform synthesis
* Map logic to technology libraries
* Generate gate-level netlists
* Provide circuit visualization
* Support automated hardware design flows

### 📦 Understanding `.lib` Files

A **Liberty (`.lib`) file** contains information about standard cells used during technology mapping.

It can contain information such as:

* Logic function
* Timing characteristics
* Cell area
* Power information
* Input capacitance
* Output characteristics
* Different drive strengths

For example, a technology library may contain multiple implementations of the same logical function.

### ⚡ Why Multiple Cell Variants Exist

Different versions of a cell are provided because digital designs have different requirements.

| Cell Characteristic | Typical Purpose              |
| ------------------- | ---------------------------- |
| High-speed cell     | Improve critical-path timing |
| Low-power cell      | Reduce power consumption     |
| Small-area cell     | Minimize silicon area        |
| Higher-drive cell   | Drive larger loads           |
| Lower-drive cell    | Suitable for lighter loads   |

Therefore, synthesis tools can select appropriate cells according to the requirements of the design.

---

## 6. RTL Synthesis Procedure

Now we can synthesize the multiplexer RTL using Yosys.

### Step 1: Launch Yosys

Open the Yosys interactive shell:

```bash
yosys
```

### Step 2: Load the Technology Library

Load the SKY130 Liberty file:

```bash
read_liberty -lib /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

> Replace the path with the actual location of the `.lib` file on your system.

### Step 3: Import the Verilog RTL

Read the multiplexer source:

```bash
read_verilog /home/vsduser/VLSI/sky130RTLDesignAndSynthesisWorkshop/verilog_files/good_mux.v
```

If your files are stored in another directory, modify the path accordingly.

### Step 4: Perform RTL Synthesis

Specify `good_mux` as the top-level module:

```bash
synth -top good_mux
```

Yosys will process the RTL and perform logic synthesis.

### Step 5: Perform Technology Mapping

Map the synthesized logic to cells from the SKY130 library:

```bash
abc -liberty /address/to/your/sky130/file/sky130_fd_sc_hd__tt_025C_1v80.lib
```

This step converts the generic logic representation into technology-specific standard cells.

### Step 6: Display the Synthesized Circuit

To visualize the resulting logic:

```bash
show
```

A graphical representation of the synthesized circuit will be displayed.
<img width="1920" height="940" alt="goodmux1" src="https://github.com/user-attachments/assets/4c221256-b392-4396-80ab-d9f50bada0c1" />


---

## 7. Day 1 Learning Outcomes

After completing this session, you should be able to:

* Explain the purpose of a digital design simulator.
* Distinguish between RTL design and a testbench.
* Understand the basic Icarus Verilog simulation workflow.
* Compile and execute a Verilog design using `iverilog`.
* Generate and inspect VCD waveform files.
* Use GTKWave to analyze signal transitions.
* Understand the operation of a 2-to-1 multiplexer.
* Identify the role of Yosys in RTL synthesis.
* Understand the purpose of Liberty `.lib` files.
* Recognize why standard cells are available in different drive strengths and performance variants.
* Perform basic RTL synthesis and technology mapping using Yosys.

---

## 📝 Final Takeaway

Day 1 introduced the fundamental **RTL-to-simulation-to-synthesis flow**.

The practical MUX experiment demonstrated how Verilog RTL can be compiled with **Icarus Verilog**, verified through **GTKWave**, and then processed using **Yosys** to obtain a synthesized gate-level representation.

This workflow forms the foundation for the more advanced RTL design, timing, optimization, and physical-design concepts covered in the upcoming workshop sessions.
