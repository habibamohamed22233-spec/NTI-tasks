module counter2(
    input clock,
    input reset,
    input up,
    output reg [1:0] count
);

wire q0,q1;
wire nq0,nq1;
wire d0,d1;

assign q0 = count[0];
assign q1 = count[1];

not(nq0,q0);
not(nq1,q1);

// D0 = ~Q0
buf(d0,nq0);

// D1
wire a,b,c,d,e,f;

and(a,up,q1,nq0);
and(b,up,nq1,q0);

and(c,~up,q1,q0);
and(d,~up,nq1,nq0);

or(d1,a,b,c,d);

always @(posedge clock or posedge reset)
begin
    if(reset)
        count<=2'b00;
    else
        count<={d1,d0};
end

endmodule