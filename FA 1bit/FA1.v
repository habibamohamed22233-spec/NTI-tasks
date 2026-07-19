`default_nettype none
module fulladder_behave(

  input a,
  input b,
  input cin,
  output reg sum,
  output reg cout
);

always @(*) begin
  sum  = a ^ b ^ cin;
  cout = (a & b) | (cin & (a ^ b));
end
endmodule

module fulladder_gatelevel(
  input wire a,
  input wire b,
  input wire cin,
  output wire sum,
  output wire cout
);
wire x1, a1, a2;
xor (x1, a, b);
xor (sum, x1, cin);

and (a1, a, b);
and (a2, x1, cin);

or (cout, a1, a2);
endmodule

