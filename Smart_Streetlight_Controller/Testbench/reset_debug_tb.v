`timescale 1ns/1ps

module reset_debug_tb;
    reg clk = 0;
    reg reset = 1;
    reg day_night = 0;
    reg vehicle_detect = 0;
    wire light_pwm;

    smart_streetlight dut (
        .clk(clk),
        .reset(reset),
        .day_night(day_night),
        .vehicle_detect(vehicle_detect),
        .light_pwm(light_pwm)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("time=%0t reset=%b sync_reset=%b state=%b pwm=%b",
                 $time, reset, dut.sync_reset,
                 dut.controller.state, light_pwm);

        #20 reset = 0;
        #100 $finish;
    end
endmodule
