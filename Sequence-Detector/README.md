# Assessment – Sequence Detector

## 1. Overview

This assessment implements and verifies a **serial sequence detector** using Verilog HDL.

The detector is designed to recognize the following target sequence:

```text
1111010
````

The design was evaluated through RTL simulation, waveform analysis, logic synthesis, gate-level inspection, and Gate-Level Simulation (GLS).

The assessment demonstrates the complete flow from an RTL description to a synthesized implementation and its functional verification.

---

## 2. Objectives

The main objectives of this assessment are:

* Implement a sequence detector using Verilog.
* Design an FSM to recognize the target sequence.
* Create a testbench to provide serial input data.
* Verify the RTL using Icarus Verilog.
* Analyze simulation waveforms using GTKWave.
* Synthesize the design using Yosys.
* Inspect the synthesized gate-level structure.
* Perform Gate-Level Simulation.
* Compare RTL and GLS behavior.
* Confirm correct detection of the target sequence.

---

## 3. Target Sequence

The sequence detector monitors the serial input `din` and searches for:

```text
1111010
```

The detector progresses through a series of states as individual bits are received.

When the final `0` of the sequence is received after the preceding `111101`, the `detected` output becomes active for the corresponding clock cycle.

---

## 4. Design Structure

The sequence detector contains:

* Clock input
* Reset input
* Serial data input
* FSM state register
* Next-state combinational logic
* Detection output

### Block-Level Flow

```text
                +----------------------+
                |   Sequence Detector  |
                |                      |
din ---------->|                      |
reset -------->|       FSM Logic      |-----> detected
clk ---------->|                      |
                +----------------------+
```

---

## 5. FSM State Description

Seven states are used to track the progress of the target sequence.

| State | Meaning                   |
| ----- | ------------------------- |
| `0`   | No matching prefix        |
| `1`   | First `1` received        |
| `2`   | First two `1`s received   |
| `3`   | First three `1`s received |
| `4`   | `1111` received           |
| `5`   | `11110` received          |
| `6`   | `111101` received         |

When the design is in **State 6** and receives `0`, the complete sequence `1111010` has been detected.

The detector then asserts `detected` and returns to the initial state.

---

# 6. RTL Design Code

The following is the RTL implementation used for this assessment.

### `sequence_detector.v`

```verilog
`timescale 1ns/1ps

module sequence_detector (
    input  wire clk,
    input  wire reset,
    input  wire din,
    output reg  detected
);

    localparam integer STATE_W = 3;
    localparam integer NUM_STATES = 7;
    // Target sequence: 1111010

    reg [STATE_W-1:0] state;
    reg [STATE_W-1:0] next_state;
    reg next_detected;

    always @(*) begin
        next_state = 'd0;
        next_detected = 1'b0;

        case (state)
            0: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b0;
                end else begin
                    next_state = 1;
                    next_detected = 1'b0;
                end
            end

            1: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b0;
                end else begin
                    next_state = 2;
                    next_detected = 1'b0;
                end
            end

            2: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b0;
                end else begin
                    next_state = 3;
                    next_detected = 1'b0;
                end
            end

            3: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b0;
                end else begin
                    next_state = 4;
                    next_detected = 1'b0;
                end
            end

            4: begin
                if (din == 1'b0) begin
                    next_state = 5;
                    next_detected = 1'b0;
                end else begin
                    next_state = 4;
                    next_detected = 1'b0;
                end
            end

            5: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b0;
                end else begin
                    next_state = 6;
                    next_detected = 1'b0;
                end
            end

            6: begin
                if (din == 1'b0) begin
                    next_state = 0;
                    next_detected = 1'b1;
                end else begin
                    next_state = 2;
                    next_detected = 1'b0;
                end
            end

            default: begin
                next_state = 'd0;
                next_detected = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= 'd0;
            detected <= 1'b0;
        end else begin
            state <= next_state;
            detected <= next_detected;
        end
    end

endmodule
```

---

# 7. RTL Code Explanation

The design is divided into two main parts.

### Combinational Logic

The first `always @(*)` block determines:

* `next_state`
* `next_detected`

The `case` statement evaluates the current FSM state and the incoming `din` bit.

For each state, the next state depends on whether the received bit is `0` or `1`.

### Sequential Logic

The second `always @(posedge clk)` block stores the state and detection result.

```verilog
always @(posedge clk)
```

At every positive edge of the clock:

* Reset initializes the FSM.
* Otherwise, `state` receives `next_state`.
* `detected` receives `next_detected`.

Non-blocking assignments are used for the clocked signals.

---

# 8. Testbench

The testbench instantiates the sequence detector and provides a long serial input stream containing different bit patterns.

It also generates the clock, controls reset, creates the VCD waveform, and counts detection events.

### `sequence_detector_tb.v`

```verilog
`timescale 1ns/1ps

module tb;

    reg clk = 1'b0;
    reg reset = 1'b1;
    reg din = 1'b0;
    wire detected;

    sequence_detector dut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .detected(detected)
    );

    always #6 clk = ~clk;

    // Assessment instance: 24eg104b49

    task drive_bit(input reg b);
        begin
            @(negedge clk);
            din = b;
            @(posedge clk);
            #1;
            $display("TIME=%0t NS DIN=%b DETECTED=%b", $time, din, detected);
        end
    endtask

    integer detection_count = 0;

    always @(negedge clk) begin
        if (!reset && detected)
            detection_count = detection_count + 1;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Initial reset.
        reset = 1'b1;
        repeat (3) @(posedge clk);
        @(negedge clk);
        reset = 1'b0;

        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);

        // Final reset.
        @(negedge clk);
        reset = 1'b1;
        repeat (2) @(posedge clk);

        #1;
        $display("FINAL_DETECTION_COUNT=%0d", detection_count);
        $finish;
    end

endmodule
```

---

# 9. Testbench Explanation

The testbench performs several important tasks.

### Clock Generation

The clock is generated using:

```verilog
always #6 clk = ~clk;
```

Therefore, the clock changes state every 6 ns.

This produces a clock period of 12 ns.

### Reset

The design starts in reset:

```verilog
reset = 1'b1;
```

After three positive clock edges, reset is released.

A final reset is applied at the end of the test sequence.

### Input Application

The `drive_bit` task is used to apply one serial input bit at a time.

```verilog
task drive_bit(input reg b);
```

Each bit is assigned around the clock edges so that the sequence detector receives synchronized serial data.

### Waveform Generation

The following statements create a VCD file:

```verilog
$dumpfile("dump.vcd");
$dumpvars(0, tb);
```

The generated `dump.vcd` file can be opened in GTKWave.

### Detection Counting

The testbench maintains:

```verilog
integer detection_count = 0;
```

Whenever `detected` is active while reset is inactive, the counter is incremented.

At the end of simulation:

```verilog
$display("FINAL_DETECTION_COUNT=%0d", detection_count);
```

prints the final number of detected sequences.

---

# 10. RTL Simulation Commands

The design can be compiled using Icarus Verilog.

From the `Assessment` directory:

```bash
iverilog -o sequence_sim sequence_detector.v sequence_detector_tb.v
```

Run the simulation:

```bash
vvp sequence_sim
```

A VCD waveform file named `dump.vcd` will be generated.

Open the waveform using:

```bash
gtkwave dump.vcd
```

---

# 11. RTL Simulation Result

The RTL waveform was examined using GTKWave.

<img width="1920" height="940" alt="assesment2 (1)" src="https://github.com/user-attachments/assets/dc53c5dd-c37b-4f85-8233-d94f45d30e12" />


The waveform demonstrates the interaction between the serial input, clock, reset, FSM behavior, and detection output.

The target sequence is successfully recognized during RTL simulation.

---

# 12. Synthesis Using Yosys

The RTL design was synthesized using Yosys.

A simplified synthesis flow is:

```bash
yosys
```

Inside Yosys, the design can be processed using commands such as:

```text
read_verilog sequence_detector.v
hierarchy -top sequence_detector
proc
opt
check
stat
```

Technology mapping can then be performed using the selected standard-cell library.

---

# 13. Yosys Synthesis Result

The synthesis report generated by Yosys was inspected to understand the hardware produced from the RTL description.

<img width="1920" height="940" alt="assessment2 1" src="https://github.com/user-attachments/assets/e110e026-fce4-4e03-b2f5-3d3691b840f9" />


The synthesis output provides information about the structure and cells used in the resulting implementation.

---

# 14. Gate-Level Representation

After synthesis, the design can be represented as a gate-level circuit.

<img width="1366" height="768" alt="GLS" src="https://github.com/user-attachments/assets/a2374039-2e93-4d22-888e-106a27aacf8a" />


The gate-level representation shows how the sequence detector is constructed from interconnected logic and sequential elements.

The structural view differs from the original behavioral RTL because synthesis has converted the design into implementation-oriented logic.

---

# 15. Gate-Level Simulation

The synthesized implementation was used for Gate-Level Simulation (GLS).

The purpose of GLS is to verify that the synthesized circuit continues to produce the expected logical behavior.

<img width="1920" height="940" alt="assessment2 1" src="https://github.com/user-attachments/assets/0d1fb704-034e-49ae-93f0-09d39b23fa81" />


The GLS waveform demonstrates the behavior of the synthesized design when driven by the testbench.

The target sequence `1111010` is detected correctly, and detection pulses occur at the expected locations.

---

# 16. RTL vs GLS Verification

| Parameter           | RTL       | GLS       |
| ------------------- | --------- | --------- |
| Clock               | Verified  | Verified  |
| Reset               | Verified  | Verified  |
| Input sequence      | `1111010` | `1111010` |
| Sequence detection  | Correct   | Correct   |
| Detection pulse     | Expected  | Expected  |
| Functional behavior | Valid     | Preserved |

The RTL and GLS simulations show consistent logical behavior.

Gate-level simulation can introduce small propagation-related timing differences because the synthesized design contains explicit gate and cell delays. These differences do not change the expected sequence-detection functionality.

---

# 17. Verification Flow

```text
             Verilog RTL
                  |
                  v
              Testbench
                  |
                  v
           RTL Simulation
                  |
                  v
            GTKWave
                  |
                  v
           Yosys Synthesis
                  |
                  v
        Gate-Level Netlist
                  |
                  v
        Gate-Level Simulation
                  |
                  v
          GTKWave Analysis
                  |
                  v
        RTL vs GLS Comparison
```

---

# 18. Results Summary

| Stage                     | Result    |
| ------------------------- | --------- |
| RTL Design                | Completed |
| Testbench                 | Completed |
| RTL Simulation            | Passed    |
| GTKWave Analysis          | Verified  |
| Yosys Synthesis           | Completed |
| Gate-Level Netlist        | Generated |
| Gate-Level Simulation     | Passed    |
| Target Sequence Detection | Verified  |

### Target Pattern

```text
1111010
```

The target sequence was correctly detected in the verification flow.

---

# 19. Key Learnings

This assessment provided practical understanding of:

* FSM-based sequence detection
* Serial data processing
* Verilog RTL coding
* Combinational next-state logic
* Sequential state storage
* Testbench development
* Clock and reset handling
* VCD waveform generation
* GTKWave analysis
* Yosys synthesis
* Gate-level circuit representation
* Gate-Level Simulation
* RTL-to-GLS verification

---

# 20. Tools and Technologies

| Tool / Technology | Application              |
| ----------------- | ------------------------ |
| Verilog HDL       | RTL implementation       |
| Icarus Verilog    | Simulation               |
| GTKWave           | Waveform analysis        |
| Yosys             | Logic synthesis          |
| SKY130            | Standard-cell technology |
| Linux / Ubuntu    | Development environment  |
| Git               | Version control          |
| GitHub            | Project repository       |

---

# 21. Final Conclusion

The sequence detector was successfully implemented using Verilog and verified through a complete RTL-to-gate-level flow.

The target pattern `1111010` was detected correctly during RTL simulation as well as Gate-Level Simulation.

The synthesis stage produced a gate-level representation of the design, and subsequent GLS verification confirmed that the intended logical behavior was maintained after synthesis.

This assessment demonstrates the practical connection between **RTL coding, simulation, synthesis, gate-level implementation, and post-synthesis verification**.

---

## Assessment Status

**Completed Successfully**

```text
Target Sequence       : 1111010
RTL Simulation         : PASS
Waveform Verification  : PASS
Yosys Synthesis        : PASS
Gate-Level Netlist     : GENERATED
Gate-Level Simulation  : PASS
Functional Verification: PASS
```
