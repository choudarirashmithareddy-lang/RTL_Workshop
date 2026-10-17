module reset_sync (
    input  wire clk,
    input  wire async_reset,
    output wire sync_reset
);

    reg [1:0] reset_ff;

    always @(negedge clk or posedge async_reset) begin
        if (async_reset)
            reset_ff <= 2'b11;
        else
            reset_ff <= {reset_ff[0], 1'b0};
    end

    assign sync_reset = reset_ff[1];

endmodule
