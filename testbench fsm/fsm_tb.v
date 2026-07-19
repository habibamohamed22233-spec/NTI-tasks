`timescale 1ns/1ps

module fsm_tb;

 reg clk;
 reg reset;
 reg a;
 reg b;
 wire y0;
 wire y1;

// DUT
fsm_2 dut (
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .y0(y0),
    .y1(y1)
);

// Clock Generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 0;
    a = 0;
    b = 0;

    // Reset
    #10;
    reset = 1;

    // Test Case 1
    #10;
    a = 1;
    b = 0;

    // Test Case 2
    #10;
    a = 1;
    b = 1;

    // Test Case 3
    #10;
    a = 0;
    b = 1;

    // Test Case 4
    #10;
    a = 0;
    b = 0;

    #20;
    $stop;
end
endmodule