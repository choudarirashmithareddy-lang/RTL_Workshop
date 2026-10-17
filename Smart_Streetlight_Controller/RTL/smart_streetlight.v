
module smart_streetlight (
    input  wire clk,
    input  wire reset,
    input  wire day_night,
    input  wire vehicle_detect,
    output wire light_pwm
);

    wire [7:0] duty_cycle;
    wire sync_reset;

    reset_sync reset_unit (
        .clk(clk),
        .async_reset(reset),
        .sync_reset(sync_reset)
    );

    streetlight_controller controller (
        .clk(clk),
        .reset(sync_reset),
        .day_night(day_night),
        .vehicle_detect(vehicle_detect),
        .duty_cycle(duty_cycle)
    );

    pwm_generator pwm (
        .clk(clk),
        .reset(sync_reset),
        .duty_cycle(duty_cycle),
        .pwm_out(light_pwm)
    );

endmodule

