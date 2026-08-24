# Module 5  – IF-ELSE, CASE & Looping Constructs

Module 5 explores important **Verilog RTL coding constructs** used for implementing conditional and repetitive hardware. The experiments focus on priority-based `if-else`, `case` and `casez` statements, latch inference due to incomplete assignments, synthesis optimization, procedural loops, and generate loops.

The practical exercises include the implementation of **MUX, DEMUX, and Ripple Carry Adder (RCA)** circuits. RTL simulation waveforms and synthesized netlists are used throughout the experiments to understand how different coding styles are interpreted by synthesis tools.

---

##  Table of Contents

* [RTL Coding Styles](#rtl-coding-styles)
* [IF-ELSE Statements](#if-else-statements)
* [CASE Statements](#case-statements)
* [IF-ELSE vs CASE](#if-else-vs-case)
* [Latch Inference](#latch-inference)
* [Labs 1–2: Incomplete IF Statements](#labs-1-2-Incomplete-if-statements)
* [Labs 3–5: CASE Statements](#labs-3-5-CASE-Statements)
* [Lab 6: Overlapping CASEZ](#lab-6-overlapping-casez)
* [Synthesis Optimization](#synthesis-optimization)
* [Looping Constructs](#looping-constructs)

  * [Procedural FOR Loop](#procedural-for-loop)
  * [Generate FOR Loop](#generate-for-loop)
* [Labs 7–10: MUX, DEMUX & RCA](#labs-7-10-mux-demux--rca)
* [Overall Summary](#overall-summary)
* [Conclusion](#conclusion)

---

## RTL Coding Styles

RTL, or **Register Transfer Level**, describes the behavior and structure of digital hardware before synthesis converts the description into a gate-level implementation.

Conditional statements are commonly used in RTL to represent decision-making, data selection, control signals, and other forms of combinational logic.

## IF-ELSE Statements

An `if-else` structure evaluates conditions in sequence. When more than one condition could be true, the first condition that evaluates to true determines the output.

```verilog
always @(*) begin
    if (condition_1)
        y = value_1;
    else if (condition_2)
        y = value_2;
    else
        y = value_3;
end
```

The priority order is:

| Statement | Priority     |
| --------- | ------------ |
| `if`      | Highest      |
| `else if` | Intermediate |
| `else`    | Lowest       |

Because the conditions are evaluated in order, `if-else` is useful when one condition must have precedence over another.

### Typical Applications

* Priority encoders
* Control circuits
* Conditional data selection
* Decision-making logic

---

## CASE Statements

A `case` statement compares an expression, usually a selector, against several possible values and executes the matching branch.

```verilog
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        default: y = d;
    endcase
end
```

Unlike an ordered `if-else` chain, `case` provides a convenient way to describe multiple selection possibilities.

### Common Uses

* Multiplexers
* Decoders
* Finite State Machines
* Control circuits
* Data-selection logic

---

## IF-ELSE vs CASE

| Feature                 | IF-ELSE                                  | CASE                                  |
| ----------------------- | ---------------------------------------- | ------------------------------------- |
| Primary use             | Priority-based decisions                 | Multiple selection conditions         |
| Evaluation              | Sequential condition checking            | Selector-to-item comparison           |
| Suitable for            | Priority logic and control               | MUX, decoder, FSM                     |
| Important consideration | Correct ordering and complete assignment | Complete coverage and pattern overlap |

---

## Latch Inference

A **latch** is a level-sensitive storage element that maintains its previous output when a new value is not supplied.

When writing combinational RTL, an unintended latch can be created if an output is not assigned under every possible condition.

Consider the following example:

```verilog
always @(*) begin
    if (enable)
        y = data;
end
```

When `enable = 1`, the output receives `data`.

However, when `enable = 0`, no new value is assigned to `y`. Therefore, the hardware must retain the previous value of `y`, which can result in latch inference during synthesis.

### Complete Implementation

One way to avoid this is to explicitly define the remaining condition:

```verilog
always @(*) begin
    if (enable)
        y = data;
    else
        y = 1'b0;
end
```

A default assignment can also be used:

```verilog
always @(*) begin
    y = 1'b0;

    if (enable)
        y = data;
end
```

Providing an assignment for every possible execution path ensures that the intended combinational behavior is clearly described.

---

## Latch vs Flip-Flop

Unintended latch inference should not be confused with intentional sequential storage.

For example:

```verilog
always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 0;
    else if (enable)
        count <= count + 1;
end
```

Here, `count` is implemented using flip-flops because the procedural block responds to a clock edge.

When `enable` is low, the flip-flop retaining its previous value is expected sequential behavior, not latch inference.

---

# Labs 1–2: Incomplete IF Statements

## Lab 1 – Incomplete IF Statement

**File:** `incomp_if.v`

This experiment demonstrates how an incomplete combinational `if` statement can cause storage behavior to be inferred.

```verilog
always @(*) begin
    if (i0)
        y = i1;
end
```

Only the `i0 = 1` condition has an assignment.

| `i0` | Output Behavior                |
| ---- | ------------------------------ |
| `1`  | `y = i1`                       |
| `0`  | `y` retains its previous value |

When `i0 = 0`, the output is not updated. Consequently, the synthesized circuit may require storage to preserve the previous value.

### Waveform
<img width="1080" height="560" alt="if1" src="https://github.com/user-attachments/assets/44170b2a-f0c4-4ca8-97ab-369717dd01b0" />



### Synthesized Netlist

<img width="1080" height="558" alt="if2" src="https://github.com/user-attachments/assets/4de5fb0b-1141-4c32-ae89-6dfe3c68f2bf" />


### Learning Outcome

A combinational output should receive a defined value for every required input condition. Incomplete assignments can lead to unintended latch inference.

---

## Lab 2 – Incomplete IF-ELSE Statement

**File:** `incomp_if2.v`

The second experiment adds an `else if` condition but still leaves one possible condition uncovered.

```verilog
always @(*) begin
    if (i0)
        y = i1;
    else if (i2)
        y = i3;
end
```

The resulting behavior is:

| `i0` | `i2` | Output        |
| ---- | ---- | ------------- |
| `1`  | X    | `y = i1`      |
| `0`  | `1`  | `y = i3`      |
| `0`  | `0`  | No assignment |

The final condition has no assignment, so the output can retain its previous value and storage may be inferred.

### Synthesized Netlist

<img width="1080" height="472" alt="if3" src="https://github.com/user-attachments/assets/fa11627c-f4d6-41e4-94af-6160aa427a44" />

### Complete Version

The missing condition can be handled by adding a final `else`:

```verilog
always @(*) begin
    if (i0)
        y = i1;
    else if (i2)
        y = i3;
    else
        y = 1'b0;
end
```

The final branch guarantees a defined output for the remaining condition.

### Learning Outcome

Adding an `else if` does not automatically make combinational logic complete. Every possible execution path should assign an appropriate output.

---

## Labs 3–5: CASE Statements

## Lab 3 – Incomplete CASE Statement

**File:** `incomp_case.v`

This experiment demonstrates incomplete coverage in a `case` statement.

```verilog
always @(*) begin
    case (sel)
        2'b00: y = i0;
        2'b01: y = i1;
    endcase
end
```

Since `sel` is two bits wide, four combinations are possible. However, only two of them are explicitly handled.

| `sel`   | Output        |
| ------- | ------------- |
| `2'b00` | `y = i0`      |
| `2'b01` | `y = i1`      |
| `2'b10` | No assignment |
| `2'b11` | No assignment |

The uncovered selector values can cause the output to retain its previous value, potentially leading to storage inference.

### Waveform
<img width="1080" height="566" alt="cif1" src="https://github.com/user-attachments/assets/317b147c-8514-4794-b2c1-133a3b28a614" />


### Synthesized Netlist

<img width="1080" height="489" alt="cf2" src="https://github.com/user-attachments/assets/8b07f976-3a38-4635-816d-8ab993b84796" />


### Learning Outcome

When using `case` for combinational logic, all relevant selector conditions should be covered or an appropriate `default` branch should be provided.

---

## Lab 4 – Complete CASE Statement

**File:** `comp_case.v`

An incomplete `case` statement can be completed by adding a `default` branch.

```verilog
always @(*) begin
    case (sel)
        2'b00: y = i0;
        2'b01: y = i1;
        default: y = i2;
    endcase
end
```

The output behavior becomes:

| `sel`   | Output   |
| ------- | -------- |
| `2'b00` | `y = i0` |
| `2'b01` | `y = i1` |
| `2'b10` | `y = i2` |
| `2'b11` | `y = i2` |

### Waveform

<img width="1080" height="564" alt="ccp" src="https://github.com/user-attachments/assets/4bb93ad9-6ebd-498b-95a9-373fca856237" />


### Synthesized Netlist
<img width="1080" height="528" alt="cmp2" src="https://github.com/user-attachments/assets/569072b9-2d94-4e78-8f4e-b2010c21feea" />


### Learning Outcome

The `default` branch ensures that selector values not explicitly listed still receive a defined output.

---

## Lab 5 – Partial Output Assignment

**File:** `partial_case_assign.v`

This experiment shows that latch inference can affect an individual output when that output is not assigned in every branch.

```verilog
always @(*) begin
    case (sel)

        2'b00: begin
            y = i0;
            x = i2;
        end

        2'b01: begin
            y = i1;
        end

        default: begin
            y = i3;
            x = i4;
        end

    endcase
end
```

Here, `y` receives an assignment in every branch, but `x` does not receive a new value when `sel = 2'b01`.

| `sel`   | `y`  | `x`            |
| ------- | ---- | -------------- |
| `2'b00` | `i0` | `i2`           |
| `2'b01` | `i1` | Previous value |
| Default | `i3` | `i4`           |

Therefore, storage may be inferred for `x` because its assignment is incomplete.

### Synthesized Netlist

<img width="1080" height="540" alt="l5" src="https://github.com/user-attachments/assets/d9f3117e-3244-40bf-926e-90e7b2cf696d" />


### Learning Outcome

Each output driven by combinational logic must be assigned appropriately along every possible execution path.

---

## Lab 6: Overlapping CASEZ

**File:** `bad_case.v`

This experiment demonstrates overlapping wildcard patterns using `casez`.

```verilog
always @(*) begin
    casez (sel)
        2'b00: y = i0;
        2'b01: y = i1;
        2'b10: y = i2;
        2'b1?: y = i3;
    endcase
end
```

In `casez`, the `?` character can represent a don't-care bit.

The pattern:

```text
2'b1?
```

can therefore match:

```text
2'b10
2'b11
```

As a result, the selector `2'b10` matches both `2'b10` and `2'b1?`.

| `sel`   | Matching Patterns |
| ------- | ----------------- |
| `2'b00` | `2'b00`           |
| `2'b01` | `2'b01`           |
| `2'b10` | `2'b10`, `2'b1?`  |
| `2'b11` | `2'b1?`           |

This is an **overlapping condition problem**, rather than an incomplete-assignment problem. Wildcard patterns should therefore be selected carefully to ensure that the intended behavior is clear.

### Waveform

<img width="1080" height="531" alt="l6" src="https://github.com/user-attachments/assets/931970c3-6ecd-413b-8314-961fe1c98519" />

### Learning Outcome

Overlapping wildcard patterns can result in more than one matching condition. Careful pattern design is important when using `casez` to avoid unintended behavior.

---

## Synthesis Optimization

Synthesis tools perform several optimization steps before producing the final technology-mapped netlist.

One important operation is the removal of **redundant logic** while maintaining the original Boolean functionality.

For example:

```text
F = A + A'B
```

can be reduced to:

```text
F = A + B
```

The simplified expression requires less redundant logic.

### Benefits of Logic Optimization

Synthesis optimization can potentially provide:

* Lower gate count
* Reduced silicon area
* Simplified logic
* Improved timing
* Lower switching activity
* Potential reduction in power consumption

### General Optimization Flow

```text
RTL Description
      ↓
Logic Analysis
      ↓
Boolean Optimization
      ↓
Technology Mapping
      ↓
Gate-Level Netlist
```

Because of these optimizations, the structure of the synthesized circuit may look very different from the original RTL while still implementing the same logical function.

---

## Looping Constructs

Loops allow repetitive hardware behavior to be described without manually duplicating similar RTL statements.

Two important loop mechanisms used in Verilog RTL are:

* **Procedural `for` loop**
* **Generate `for` loop**

Although their syntax is similar, their purposes are different.

---

## Procedural FOR Loop

A procedural `for` loop is placed inside an `always` block. It repeats procedural operations during RTL execution.

Example:

```verilog
integer i;

always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        y[i] = a[i];
    end
end
```

### Applications

Procedural loops are useful for describing:

* MUX logic
* DEMUX logic
* Bit-level operations
* Array processing
* Repeated combinational operations

---

## Generate FOR Loop

A generate loop is used outside procedural blocks to replicate structural hardware during elaboration.

```verilog
genvar i;

generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        // Repeated hardware instance
    end
endgenerate
```

Generate loops are particularly useful when multiple instances of a hardware module or structure need to be created.

### Applications

* Ripple Carry Adders
* Full Adder arrays
* Register arrays
* Repeated module instantiations
* Parameterized hardware designs

---

## Procedural FOR vs Generate FOR

| Feature           | Procedural `for`           | Generate `for`                    |
| ----------------- | -------------------------- | --------------------------------- |
| Location          | Inside an `always` block   | Outside procedural blocks         |
| Main purpose      | Repeat RTL operations      | Replicate hardware structures     |
| Typical use       | MUX, DEMUX, bit operations | RCA and repeated module instances |
| Processing stage  | Procedural execution       | Elaboration                       |
| Description style | Behavioral                 | Structural                        |

---

## Labs 7–10: MUX, DEMUX & RCA

## Lab 7 – MUX Using Procedural FOR Loop

**File:** `mux_generate.v`

A multiplexer selects one signal from several available inputs according to a select signal.

Using a loop provides a compact way of describing repetitive selection logic and makes the RTL easier to scale.

### Functional Concept

```text
Multiple Inputs
      ↓
 Select Signal
      ↓
     MUX
      ↓
 Single Output
```

### Waveform

<img width="1006" height="521" alt="lseven" src="https://github.com/user-attachments/assets/58ee2e29-fd1d-4874-8cb7-8b5ae4d444fa" />


### Observation

The waveform confirms that the output follows the input selected by the control signal.

### Learning Outcome

A procedural loop can reduce repetitive RTL statements while allowing synthesis tools to construct the required combinational hardware.

---

## Lab 8 – DEMUX Using CASE

**File:** `demux_case.v`

A demultiplexer takes one input and routes it to one of several output lines according to the select signal.

For a four-output DEMUX:

```text
sel = 2'b00 → Output 0
sel = 2'b01 → Output 1
sel = 2'b10 → Output 2
sel = 2'b11 → Output 3
```

A `case` statement provides a straightforward way to describe these selection conditions.

Only the output corresponding to the selected value receives the input, while the other outputs remain inactive.

### Waveform

<img width="1080" height="578" alt="leight" src="https://github.com/user-attachments/assets/1bc1dd1f-ba8b-4763-af93-8a635a9d3888" />


### Learning Outcome

For smaller DEMUX designs, `case` statements provide a clear and readable way to express output selection.

---

## Lab 9 – DEMUX Using Procedural FOR Loop

**File:** `demux_generate.v`

The same DEMUX functionality can also be implemented using a procedural loop.

### General Operation

```text
Initialize Outputs
       ↓
Read Select Signal
       ↓
Iterate Through Outputs
       ↓
Find Selected Index
       ↓
Enable Selected Output
```

This approach avoids writing separate conditional branches for each output line.

### CASE vs Procedural LOOP

| Feature        | CASE                   | Procedural `for`   |
| -------------- | ---------------------- | ------------------ |
| Coding method  | Explicit branches      | Repeated operation |
| Small circuits | Easy to understand     | Easy to implement  |
| Scalability    | Requires more branches | More convenient    |
| Repeated code  | Higher                 | Lower              |

### Waveform

<img width="1080" height="576" alt="lnine" src="https://github.com/user-attachments/assets/4db94ce5-0118-4d2e-aac2-63ef1a79400a" />


### Learning Outcome

A procedural loop offers a concise and scalable approach for describing repetitive DEMUX behavior.

---

# Lab 10 – Ripple Carry Adder Using Generate FOR Loop

**File:** `rca.v`

A **Ripple Carry Adder (RCA)** is constructed by connecting multiple Full Adder stages in sequence.

Each Full Adder receives:

* One bit from operand `A`
* One bit from operand `B`
* Carry input from the preceding stage

and generates:

* One sum bit
* Carry output for the following stage

The carry propagates from the least significant bit toward the most significant bit.

### RCA Structure

```text
A0 ──┐
B0 ──┤
Cin ─┤
     ↓
  Full Adder
     │
     ├── Sum0
     │
     └── Carry1
             ↓
          Full Adder
             │
             ├── Sum1
             │
             └── Carry2
                    ↓
                   ...
```

A generate loop can be used to automatically create one Full Adder instance for each bit.

```verilog
genvar i;

generate
    for (i = 0; i < WIDTH; i = i + 1) begin

        full_adder FA (
            .a(a[i]),
            .b(b[i]),
            .cin(carry[i]),
            .sum(sum[i]),
            .cout(carry[i+1])
        );

    end
endgenerate
```

The use of a parameterized width makes the design easier to scale. Increasing the width results in additional Full Adder instances being generated automatically.

### RTL Simulation Waveform

<img width="1080" height="575" alt="lten" src="https://github.com/user-attachments/assets/238795e4-43c7-4b95-b601-cdb87d2d99e5" />


The RTL waveform verifies the addition operation and shows the generated sum and carry signals.

### Synthesized Netlist

The synthesized netlist represents the hardware produced from the RCA RTL description.

### Gate-Level Verification

The synthesized implementation can be compared with the RTL simulation to confirm that synthesis has preserved the intended functionality.

### Learning Outcome

The RCA experiment demonstrates how generate loops can be used to construct repeated structural hardware. The same technique can be applied to larger arithmetic circuits, register structures, and other parameterized designs.

---

## Overall Summary

The Module 5 experiments demonstrate how different Verilog coding constructs influence the interpretation and synthesis of digital hardware.

| Topic                      | Key Learning                                           |
| -------------------------- | ------------------------------------------------------ |
| **IF-ELSE**                | Represents ordered or priority-based conditions        |
| **CASE**                   | Provides multi-way selection                           |
| **Incomplete IF**          | May result in unintended latch inference               |
| **Incomplete CASE**        | Can cause storage inference when coverage is missing   |
| **Partial Assignment**     | May create storage for an incompletely assigned output |
| **Overlapping CASEZ**      | Can produce multiple matching patterns                 |
| **Synthesis Optimization** | Removes redundant logic while preserving functionality |
| **Procedural `for`**       | Describes repeated RTL operations                      |
| **Generate `for`**         | Replicates structural hardware                         |
| **MUX**                    | Selects one input based on a control signal            |
| **DEMUX**                  | Routes one input to a selected output                  |
| **RCA**                    | Performs binary addition using cascaded Full Adders    |

---

## Conclusion

Module 5 extends RTL design concepts by introducing conditional statements and looping mechanisms used to describe digital hardware.

The incomplete `if-else` and `case` experiments demonstrate the importance of assigning outputs completely when designing combinational logic. The `casez` experiment further shows why wildcard patterns must be chosen carefully when multiple conditions can overlap.

The synthesis optimization section demonstrates that synthesis tools can simplify redundant Boolean logic while maintaining the required functionality.

The final experiments introduce procedural and generate loops. Procedural loops provide an efficient way to describe repeated combinational operations such as MUX and DEMUX logic, whereas generate loops are well suited for structural repetition, as demonstrated by the Ripple Carry Adder.

Overall, the experiments provide practical experience in developing **clear, complete, scalable, and synthesis-friendly Verilog RTL**, followed by verification through simulation and synthesis.
