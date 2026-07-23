module dff(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk or posedge reset)
begin
    if(reset)
        q<=0;
    else
        q<=d;
end

endmodule


module counter2(
    input clock,
    input reset,
    input up,
    output [1:0] count
);

wire d0,d1;

assign d0 = ~count[0];

assign d1 = up ?
            (count[1]^count[0]) :
            ~(count[1]^count[0]);

dff ff0(clock,reset,d0,count[0]);
dff ff1(clock,reset,d1,count[1]);

endmodule