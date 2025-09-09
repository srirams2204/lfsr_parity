`default_nettype none
`timescale 1ns / 1ps

/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

reg clk = 0;
reg rst = 1;
wire [7:0] lfsr_out;

lfsr_parity uut (
    .clk(clk),
    .rst(rst),
    .lfsr_out(lfsr_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("lfsr_parity.vcd");
    $dumpvars(0, lfsr_parity_tb);

    #10 rst = 0;

    // Run for 100 cycles
    repeat (100) begin
        #10;
        $display("Cycle %0d: LFSR = %b (Parity = %b)", $time/10, lfsr_out[6:0], lfsr_out[7]);
    end

    $finish;
end

endmodule
