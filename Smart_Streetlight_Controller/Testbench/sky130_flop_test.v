`timescale 1ns/1ps

module sky130_flop_test;
    reg clk = 0;
    reg d = 0;
    reg set_b = 0;
    wire q;

    sky130_fd_sc_hd__dfstp_2 dut (
        .CLK(clk),
        .D(d),
        .Q(q),
        .SET_B(set_b)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t clk=%b set_b=%b d=%b q=%b",
                 $time, clk, set_b, d, q);

        #10 set_b = 1;
        #10 d = 1;
        #20 $finish;
    end
endmodule

