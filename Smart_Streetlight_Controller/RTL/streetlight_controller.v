module streetlight_controller (
    input  wire       clk,
    input  wire       reset,
    input  wire       day_night,
    input  wire       vehicle_detect,
    output reg [7:0]  duty_cycle
);

    localparam DAY          = 2'b00;
    localparam NIGHT_IDLE   = 2'b01;
    localparam NIGHT_ACTIVE = 2'b10;

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= DAY;
        end
        else begin
            case (state)

                DAY: begin
                    if (day_night)
                        state <= NIGHT_IDLE;
                    else
                        state <= DAY;
                end

                NIGHT_IDLE: begin
                    if (!day_night)
                        state <= DAY;
                    else if (vehicle_detect)
                        state <= NIGHT_ACTIVE;
                    else
                        state <= NIGHT_IDLE;
                end

                NIGHT_ACTIVE: begin
                    if (!day_night)
                        state <= DAY;
                    else if (!vehicle_detect)
                        state <= NIGHT_IDLE;
                    else
                        state <= NIGHT_ACTIVE;
                end

                default:
                    state <= DAY;

            endcase
        end
    end

    always @(*) begin

        case (state)

            DAY:
                duty_cycle = 8'd0;

            NIGHT_IDLE:
                duty_cycle = 8'd77;

            NIGHT_ACTIVE:
                duty_cycle = 8'd255;

            default:
                duty_cycle = 8'd0;

        endcase

    end

endmodule