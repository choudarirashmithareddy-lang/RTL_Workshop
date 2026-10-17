
module pwm_generator (
    input  wire       clk,
    input  wire       reset,
    input  wire [7:0] duty_cycle,
    output reg        pwm_out
);

    reg [7:0] counter;

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            counter <= 8'd0;
        end
        else begin
            counter <= counter + 8'd1;
        end

    end

  
always @(*) begin
    if (duty_cycle == 8'hFF)
        pwm_out = 1'b1;
    else if (counter < duty_cycle)
        pwm_out = 1'b1;
    else
        pwm_out = 1'b0;
end

endmodule
