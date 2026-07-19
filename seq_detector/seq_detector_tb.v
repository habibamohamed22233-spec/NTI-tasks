`timescale 1ns/1ps

module seq_detector_tb;
 reg clk;
 reg reset;
 reg din;
 wire detected;

seq_detector_overlap DUT(
.clk(clk),
.reset(reset),
.din(din),
.detected(detected)
);

always #5 clk=~clk;

 task send;
input b;
 begin
    din=b;
    #10;
 end
endtask

 initial
 begin

clk=0;
reset=1;
din=0;

#10;
reset=0;

//110101
send(1);
send(1);
send(0);
send(1);
send(0);
send(1);

//Overlap Example
send(1);
send(0);
send(1);
send(0);
send(1);

#50;
$stop;

 end
endmodule
