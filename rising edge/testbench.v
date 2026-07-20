`timescale 1ns/1ps

module edge_detector_tb;
 reg clk;
 reg reset;
 reg level;
 wire tick;

// Moore
moore_edge_detector dut(
    .clk(clk),
    .reset(reset),
    .level(level),
    .tick(tick)
);

/*
mealy_edge_detector dut(
    .clk(clk),
    .reset(reset),
    .level(level),
    .tick(tick)
);
*/

always #5 clk = ~clk;
initial
begin
    clk = 0;
    reset = 1;
    level = 0;

    #10;
    reset = 0;
    #10 level = 1;
    #20 level = 1;
    #20 level = 0;
    #20 level = 1;
    #20 level = 0;
    #20 $stop;
  end
endmodule
