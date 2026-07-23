`timescale 1ns/1ps

module counter_tb;

reg clock;
reg reset;
reg up;

wire [1:0] count;

counter2 uut(
    .clock(clock),
    .reset(reset),
    .up(up),
    .count(count)
);

always #5 clock = ~clock;

// Task
task show;
begin
    $display("Time=%0t Up=%b Count=%b",$time,up,count);
end
endtask

initial
begin

clock=0;
reset=1;
up=1;

#10;
reset=0;

// Count Up

repeat(6)
begin
    @(posedge clock);
    #1;
    show();
end

// Count Down

up=0;

repeat(6)
begin
    @(posedge clock);
    #1;
    show();
end

// Reset

reset=1;
#10;
reset=0;

repeat(4)
begin
    @(posedge clock);
    #1;
    show();
end

$finish;

end

endmodule