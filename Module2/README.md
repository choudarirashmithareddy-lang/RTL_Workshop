# Module 2 – Exploring Timing Libraries, Synthesis & Flip-Flop RTL

## 🎯 Experiment Objective

The main purpose of Day 2 was to gain a better understanding of **technology libraries and cell timing information** used during digital synthesis. The experiment also focused on learning the difference between **hierarchical and flattened synthesis** and implementing different types of **flip-flops with reset and set operations** using Verilog RTL.

---

## 📑 Contents

* [Technology Libraries](#1️⃣-technology-libraries)
* [Hierarchical and Flattened Synthesis](#2️⃣-hierarchical-and-flattened-synthesis)
* [Flip-Flop RTL Coding](#3️⃣-flip-flop-rtl-coding)
* [Simulation and Synthesis](#4️⃣-simulation-and-synthesis)
* [Conclusion](#5️⃣-conclusion)

---

# 1️⃣ Technology Libraries

A **technology library** contains descriptions of the standard cells that are available for implementing a digital design. It provides important information about each cell, including its **logic function, timing characteristics, power consumption, and operating conditions**.

The SKY130 technology library used during this experiment was:

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

The different sections of the filename indicate the operating conditions represented by the library:

| Part   | Description                   |
| ------ | ----------------------------- |
| `tt`   | Typical process corner        |
| `025C` | Operating temperature of 25°C |
| `1v80` | Supply voltage of 1.8 V       |

The Liberty file can be opened from the terminal using:

```bash
gedit sky130_fd_sc_hd__tt_025C_1v80.lib
```

Opening the file makes it possible to examine the available standard cells and their associated timing information.

### 📷 SKY130 `.lib` File

<img width="1920" height="1012" alt="VirtualBox_vsdworkshop_09_08_2026_02_10_05" src="https://github.com/user-attachments/assets/7bf75f62-4888-4244-90fb-07d948804610" />

---

# 2️⃣ Hierarchical and Flattened Synthesis

During synthesis, the original module structure of an RTL design can either be retained or removed. These two approaches are known as **hierarchical synthesis** and **flattened synthesis**.

### Hierarchical Synthesis

In **hierarchical synthesis**, the relationships between different modules are retained. The top-level module continues to contain its lower-level submodules.

```text
          Top Module
          /        \
     Module A    Module B
```

Maintaining hierarchy helps organize a large design into separate functional blocks. It can also make individual modules easier to locate and analyze during debugging.

### Flattened Synthesis

In **flattened synthesis**, the boundaries between the individual modules are removed. The logic from different modules is combined into a common representation.

```text
Module A ──┐
           ├──► Flattened Design
Module B ──┘
```

Flattening allows the synthesis tool to perform optimization across module boundaries, which can potentially improve the overall implementation.

### Comparison

| Feature          | Hierarchical Synthesis | Flattened Synthesis      |
| ---------------- | ---------------------- | ------------------------ |
| Module structure | Retained               | Removed                  |
| Optimization     | Mainly within modules  | Across module boundaries |
| Debugging        | Relatively easier      | Relatively harder        |
| Representation   | Organized and modular  | Combined and unified     |

### 📷 Hierarchical / Flattened Synthesis

<img width="1920" height="1012" alt="hier netlist" src="https://github.com/user-attachments/assets/46b3f459-8efa-4149-8ac2-36d6915c6fe4" />

<img width="1920" height="1012" alt="flatten" src="https://github.com/user-attachments/assets/83b31d8b-c046-4b55-8d50-74a3b9e85dab" />

---

# 3️⃣ Flip-Flop RTL Coding

A **flip-flop** is a sequential digital circuit used for storing a single bit of information. Its output normally changes in response to a clock edge. Additional control inputs, such as **reset** and **set**, can also be included to control the stored value.

## Asynchronous Reset

An **asynchronous reset** changes the flip-flop output as soon as the reset signal becomes active, without requiring a clock edge.

```verilog
module dff_asyncres (
    input clk,
    input async_reset,
    input d,
    output reg q
);

always @(posedge clk, posedge async_reset)
begin
    if (async_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

When `async_reset` is asserted, the output `q` is immediately forced to `0`, regardless of the clock.

---

## Asynchronous Set

An **asynchronous set** forces the flip-flop output to logic `1` immediately when the set signal is asserted, independent of the clock.

```verilog
module dff_async_set (
    input clk,
    input async_set,
    input d,
    output reg q
);

always @(posedge clk, posedge async_set)
begin
    if (async_set)
        q <= 1'b1;
    else
        q <= d;
end

endmodule
```

When `async_set` becomes active, the output `q` is set to `1` without waiting for a clock transition.

---

## Synchronous Reset

Unlike an asynchronous reset, a **synchronous reset** is evaluated only when the active clock edge occurs.

```verilog
module dff_syncres (
    input clk,
    input sync_reset,
    input d,
    output reg q
);

always @(posedge clk)
begin
    if (sync_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

Here, the reset signal affects the output only at the positive edge of the clock.

### Reset Behavior Comparison

```text
Asynchronous Reset
Reset asserted ───────► Output changes immediately


Synchronous Reset
Reset asserted ──► Next active Clock Edge ──► Output changes
```

---

# 4️⃣ Simulation and Synthesis

The flip-flop RTL implementations were first tested through simulation to verify their functional behavior. After simulation, the designs were synthesized using **Yosys** and mapped to cells from the selected technology library.

## Icarus Verilog Simulation

The RTL design and its testbench were compiled using:

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
```

The generated simulation executable was then run with:

```bash
./a.out
```

The resulting waveform file was opened using:

```bash
gtkwave tb_dff_asyncres.vcd
```

GTKWave was used to observe the clock, reset, input, and output signal transitions.

### 📷 Simulation Result

<img width="1920" height="1012" alt="asyncres waveform" src="https://github.com/user-attachments/assets/e971737d-85bb-4b78-983a-27dd0c5a2af4" />

---

## Yosys Synthesis

The Yosys synthesis environment was started using:

```bash
yosys
```

The required standard-cell library was then loaded:

```bash
read_liberty -lib /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Next, the Verilog RTL source was imported:

```bash
read_verilog /path/to/dff_asyncres.v
```

The design was synthesized by specifying the top-level module:

```bash
synth -top dff_asyncres
```

The flip-flop was mapped to an appropriate cell from the technology library using:

```bash
dfflibmap -liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Technology mapping was then performed with:

```bash
abc -liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
```

Finally, the synthesized circuit was displayed using:

```bash
show
```

### Command Summary

| Command        | Function                                             |
| -------------- | ---------------------------------------------------- |
| `read_liberty` | Imports the standard-cell technology library         |
| `read_verilog` | Loads the Verilog RTL source                         |
| `synth -top`   | Performs RTL synthesis for the selected top module   |
| `dfflibmap`    | Maps flip-flop logic to available library cells      |
| `abc`          | Performs technology mapping and optimization         |
| `show`         | Generates a graphical view of the synthesized design |

### 📷 Gate-Level Representation

<img width="1920" height="1012" alt="async_reset_gate png" src="https://github.com/user-attachments/assets/b6aefb1f-9c47-4dcb-8233-5bf461664823" />

---

# 5️⃣ Conclusion

Day 2 provided a deeper understanding of the role of **technology libraries and timing information** in the synthesis process. I learned how Liberty files describe standard-cell characteristics and explored the differences between **hierarchical and flattened synthesis**.

Different flip-flop configurations, including **asynchronous reset, asynchronous set, and synchronous reset**, were implemented using Verilog RTL. The designs were functionally verified using **Icarus Verilog and GTKWave** and subsequently synthesized with **Yosys**. This experiment helped connect RTL-level sequential logic with its corresponding synthesized gate-level implementation.
