module counter #(parameter WIDTH = 5)
(
  input clk,
  input rst,
  input load,
  input enab,
  input  [WIDTH-1:0] cnt_in,
  output reg [WIDTH-1:0] cnt_out
);

reg [WIDTH-1:0] next_cnt;

always @(*) begin
  next_cnt = cnt_out;
 if (rst)
    next_cnt = {WIDTH{1'b0}};
 else if (load)
    next_cnt = cnt_in;
 else if (enab)
    next_cnt = cnt_out + 1'b1;
end

always @(posedge clk) begin
    cnt_out <= next_cnt;
end
endmodule
