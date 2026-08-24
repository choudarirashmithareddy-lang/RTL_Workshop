# Module 3: Combinational & Sequential Circuit Optimization

Welcome to **Module 3** of the workshop! This session focuses on optimizing combinational and sequential digital circuits. The objective is to understand practical techniques that can reduce hardware complexity, improve timing, and make designs more efficient.

---

## Table of Contents

* [1. Constant Propagation](#1-constant-propagation)
* [2. State Optimization](#2-state-optimization)
* [3. Cloning](#3-cloning)
* [4. Retiming](#4-retiming)
* [5. Optimization Labs](#5-optimization-labs)

  * [Lab 1](#lab-1)
  * [Lab 2](#lab-2)
  * [Lab 3](#lab-3)
  * [Lab 4](#lab-4)
  * [Lab 5](#lab-5)
  * [Lab 6](#lab-6)

---

## 1. Constant Propagation

**Constant propagation** is a synthesis and optimization technique in which signals or variables known to have fixed values are replaced by those values. This allows synthesis tools to remove unnecessary logic and generate a simpler hardware implementation.

### How It Works

The synthesis tool examines the RTL design and identifies signals whose values remain constant. These constants are then propagated through the logic, enabling redundant gates and connections to be eliminated.

### Advantages

* **Lower Hardware Complexity:** Removes unnecessary logic elements.
* **Improved Timing:** Simplified logic can reduce propagation delays.
* **Reduced Resources:** May decrease the number of gates, cells, or flip-flops required.
* **Better Power Efficiency:** Less switching activity can reduce dynamic power consumption.

---

## 2. State Optimization

**State optimization** is used to simplify finite state machines (FSMs) by reducing unnecessary states and improving their implementation.

### Common Techniques

* **State Reduction:** Equivalent states can be identified and merged.
* **State Encoding:** States are assigned suitable binary encodings to simplify the resulting logic.
* **Logic Simplification:** Boolean expressions can be minimized to reduce hardware.
* **Power Optimization:** Techniques such as clock gating can help reduce unnecessary switching activity.

The overall goal is to implement the FSM using fewer resources while maintaining the same required behavior.

---

## 3. Cloning

**Cloning** involves creating multiple copies of a logic cell or module when doing so can improve timing, reduce excessive fanout, or balance the load on critical signals.

### General Procedure

1. Identify timing-critical paths using synthesis or timing-analysis tools.
2. Locate cells or modules experiencing excessive fanout or load.
3. Create additional copies of the required logic.
4. Distribute the affected connections among the cloned instances.
5. Perform placement and routing.
6. Compare timing and power results before and after optimization.

---

## 4. Retiming

**Retiming** is a sequential optimization method that changes the locations of registers within a circuit while preserving the circuit's overall functionality.

The main purpose is to balance delays between sequential stages and improve the achievable clock frequency.

### Retiming Process

1. **Create a Circuit Representation:** Represent the design as a directed graph containing combinational logic and registers.
2. **Analyze Register Locations:** Examine the delays between sequential elements.
3. **Move Registers:** Reposition registers to distribute logic delays more evenly.
4. **Check Constraints:** Ensure that functionality and required timing constraints are maintained.
5. **Evaluate the Result:** Verify whether the new arrangement improves timing and overall implementation efficiency.

---

## 5. Optimization Labs

The following experiments demonstrate optimization concepts using **Verilog RTL** and synthesis tools.

### Lab 1

### Verilog Code

```verilog
module opt_check (input a, input b, output y);
    assign y = a ? b : 0;
endmodule
```

### Explanation

The ternary operator implements the following behavior:

* When `a = 1`, the output `y` follows `b`.
* When `a = 0`, the output `y` becomes `0`.

During synthesis, this type of logic can be examined for possible simplification.

Follow the procedure described in the [Module1 Synthesis Lab]


Add the following command between `abc -liberty` and `synth -top`:

```shell
opt_clean -purge
```

<img width="1920" height="940" alt="optcheck" src="https://github.com/user-attachments/assets/b11f5063-58fc-4e3a-ac12-e045f35a08f8" />

---

### Lab 2

### Verilog Code

```verilog
module opt_check2 (input a, input b, output y);
    assign y = a ? 1 : b;
endmodule
```

### Explanation

This circuit can be viewed as a 2-to-1 multiplexer:

* When `a = 1`, `y = 1`.
* When `a = 0`, `y = b`.

The example demonstrates how constant values can appear as one of the inputs to combinational logic.


<img width="958" height="930" alt="optcheck2" src="https://github.com/user-attachments/assets/7fcfc1c0-0e08-466c-87c7-ca70476c49c5" />

---

### Lab 3

### Verilog Code

```verilog
module opt_check2 (input a, input b, output y);
    assign y = a ? 1 : b;
endmodule
```

### Function

The module represents a **2-to-1 multiplexer**.

* `a = 1` → `y = 1`
* `a = 0` → `y = b`

This experiment further demonstrates the behavior of constant-driven combinational logic.


<img width="958" height="930" alt="optcheck3" src="https://github.com/user-attachments/assets/369648e8-a032-40e3-92ab-0bffcd6a0ec4" />

---

### Lab 4

### Verilog Code

```verilog
module opt_check4 (input a, input b, input c, output y);
    assign y = a ? (b ? (a & c) : c) : (!c);
endmodule
```

### Explanation

The module contains three inputs (`a`, `b`, and `c`) and one output (`y`). It uses nested conditional operators to determine the output.

The important behavior is:

* When `a = 1`, the expression ultimately produces `c`.
* When `a = 0`, the output becomes `!c`.

Therefore, the logic can be simplified to:

```text
y = a ? c : !c
```

This experiment demonstrates how synthesis optimization can identify redundant conditions and simplify combinational logic.

<img width="958" height="930" alt="optcheck4" src="https://github.com/user-attachments/assets/e905cc9a-fc1a-43bf-9566-6b7815d68fc1" />


---

### Lab 5

### Verilog Code

```verilog
module dff_const1(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b0;
    else
        q <= 1'b1;
end
endmodule
```

### Explanation

This design describes a D flip-flop with an asynchronous reset.

* When `reset = 1`, `q` is immediately set to `0`.
* When a positive clock edge occurs while reset is inactive, `q` is loaded with `1`.

Thus, the flip-flop produces a constant `1` during normal operation while retaining an asynchronous reset to `0`.


<img width="1080" height="571" alt="gtkdff1" src="https://github.com/user-attachments/assets/8d17ebea-ee04-4751-b3d9-8c74ae31bf2d" />
<img width="1080" height="560" alt="cnst1" src="https://github.com/user-attachments/assets/0d7931dd-8493-45fd-9875-5727d59ec07e" />


---

### Lab 6

### Verilog Code

```verilog
module dff_const2(input clk, input reset, output reg q);
always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b1;
    else
        q <= 1'b1;
end
endmodule
```

### Explanation

In this design, both branches assign the same value to `q`.

* When `reset = 1`, `q` becomes `1`.
* On every positive clock edge, `q` also becomes `1`.

Therefore, regardless of whether the event is caused by reset or the clock, the output is assigned the constant value `1`. A synthesis tool may recognize this redundant sequential behavior during optimization.


<img width="1080" height="569" alt="gtkdff2" src="https://github.com/user-attachments/assets/ff43e90d-f119-4aa4-af45-556c086e0b51" />
<img width="1080" height="564" alt="cnst2" src="https://github.com/user-attachments/assets/5a9558cc-14fe-4d1a-9d4f-771615add2f3" />

---

## Summary

Module 3 focused on techniques used to optimize both combinational and sequential digital circuits.

### Key Concepts

1. **Constant Propagation**
   Identifies fixed values and uses them to eliminate unnecessary logic.

2. **State Optimization**
   Simplifies FSM implementations by reducing equivalent states and improving state encoding.

3. **Cloning**
   Replicates logic when required to reduce fanout, balance loads, or improve timing.

4. **Retiming**
   Repositions registers to balance combinational delays and improve clock performance while maintaining functionality.

### Practical Work

Six Verilog-based experiments were performed to understand how synthesis tools optimize different types of RTL logic. The labs include combinational optimization examples, constant-driven logic, nested conditional expressions, and sequential circuits using D flip-flops.

---
