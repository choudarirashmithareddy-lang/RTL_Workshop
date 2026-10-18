`timescale 1ns/1ps

module post_synth_tb;

    reg clk = 0;
    reg reset = 1;
    reg day_night = 0;
    reg vehicle_detect = 0;
    wire light_pwm;

    integer errors = 0;
    integer high_count;
    integer i;

    smart_streetlight dut (
        .clk(clk),
        .reset(reset),
        .day_night(day_night),
        .vehicle_detect(vehicle_detect),
        .light_pwm(light_pwm)
    );

    always #5 clk = ~clk;

    task check_pwm;
        input night;
        input vehicle;
        input integer expected_high;
        input [8*40-1:0] test_name;
        begin
            @(negedge clk);
            day_night = night;
            vehicle_detect = vehicle;

            repeat (4) @(posedge clk);
            #1;

            high_count = 0;

            for (i = 0; i < 256; i = i + 1) begin
                @(negedge clk);
                if (light_pwm === 1'b1)
                    high_count = high_count + 1;
                else if (light_pwm !== 1'b0) begin
                    $display("FAIL: %0s output is X/Z", test_name);
                    errors = errors + 1;
                end
            end

            if (high_count == expected_high)
                $display("PASS: %0s, high cycles=%0d",
                         test_name, high_count);
            else begin
                $display("FAIL: %0s, high cycles=%0d expected=%0d",
                         test_name, high_count, expected_high);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("post_synth.vcd");
        $dumpvars(0, post_synth_tb);

        #20;
        @(negedge clk);
        reset = 0;

        repeat (5) @(posedge clk);

        check_pwm(0, 0,   0, "Day, no vehicle");
        check_pwm(1, 0,  77, "Night, no vehicle");
        check_pwm(1, 1, 256, "Night, vehicle");
        check_pwm(1, 0,  77, "Vehicle leaves");
        check_pwm(0, 0,   0, "Night to day");

        if (errors == 0)
            $display("ALL POST-SYNTHESIS TESTS PASSED");
        else
            $display("POST-SYNTHESIS TESTS FAILED: %0d errors",
                     errors);

        $finish;
    end

endmodule
