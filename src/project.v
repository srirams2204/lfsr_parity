/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_lfsr_parity (
    input wire clk,
    input wire rst,
    input wire ena,
    output reg [7:0] lfsr_out
);

reg [6:0] lfsr;
wire feedback = lfsr[6] ^ lfsr[5];  // taps at bit 6 and 5

always @(posedge clk or posedge rst) begin
    if (rst)
        lfsr <= 7'b0000001;
    else
        lfsr <= {lfsr[5:0], feedback};
end

always @(*) begin
    lfsr_out[6:0] = lfsr;
    lfsr_out[7]   = ~(^lfsr);  // even parity
end

endmodule
