`timescale 1ns/1ps

module debouncer_tb;

reg clk;
reg reset;
reg sw;
wire db;

// DUT
debouncer DUT (
    .clk(clk),
    .reset(reset),
    .sw(sw),
    .db(db)
);

// Clock Generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    sw = 0;

    #20;
    @(posedge clk);
    reset = 0;

    #50;
    sw = 1; #15;
    sw = 0;
    #100;

    sw = 1; #7;
    sw = 0; #8;
    sw = 1; #9;
    sw = 0; #10;
    sw = 1; #7;
    sw = 0; #8;
    sw = 1;         
    #5000;

    
    sw = 0; #8;
    sw = 1; #7;
    sw = 0; #9;
    sw = 1; #8;
    sw = 0;          

    #5000;

    $stop;
 end
endmodule
