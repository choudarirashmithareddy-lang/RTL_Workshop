
`timescale 1ns/1ps

module streetlight_tb;

    reg clk, reset, day_night, vehicle_detect;
    wire light_pwm;
    integer errors = 0;
    integer i, high_count;

    smart_streetlight dut (
        .clk(clk),
        .reset(reset),
        .day_night(day_night),
        .vehicle_detect(vehicle_detect),
        .light_pwm(light_pwm)
    );

    always #5 clk = ~clk;

    task check_mode;
        input night;
        input vehicle;
        input integer expected_duty;
        input integer expected_high;
        input [160*8-1:0] test_name;
        begin
            @(negedge clk);
            day_night = night;
            vehicle_detect = vehicle;

            repeat (3) @(posedge clk);
            #1;

            if (dut.duty_cycle !== expected_duty) begin
                $display("FAIL: %0s duty=%0d expected=%0d",
                         test_name, dut.duty_cycle, expected_duty);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s duty selection", test_name);
            end

            high_count = 0;
            for (i = 0; i < 256; i = i + 1) begin
                @(posedge clk);
                #1;
                if (light_pwm === 1'b1)
                    high_count = high_count + 1;
            end

            if (high_count != expected_high) begin
                $display("FAIL: %0s PWM high cycles=%0d expected=%0d",
                         test_name, high_count, expected_high);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s PWM high cycles=%0d",
                         test_name, high_count);
            end
        end
    endtask

    initial begin
        $dumpfile("streetlight.vcd");
        $dumpvars(0, streetlight_tb);

        clk = 0;
        reset = 1;
        day_night = 0;
        vehicle_detect = 0;

        #20;
        @(negedge clk);
        reset = 0;
        repeat (4) @(posedge clk);

        check_mode(0, 0,   0,   0, "Day, no vehicle");
        check_mode(0, 1,   0,   0, "Day, vehicle");
        check_mode(1, 0,  77,  77, "Night, no vehicle");
        check_mode(1, 1, 255, 256, "Night, vehicle");
        check_mode(1, 0,  77,  77, "Vehicle leaves");
        check_mode(0, 0,   0,   0, "Night to day");

        @(negedge clk);
        reset = 1;
        #1;
        if (dut.duty_cycle !== 8'd0) begin
            $display("FAIL: Reset did not select DAY mode");
            errors = errors + 1;
        end else begin
            $display("PASS: Reset selects DAY mode");
        end

        repeat (2) @(posedge clk);
        @(negedge clk);
        reset = 0;
        repeat (4) @(posedge clk);

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule

