module mealy_edge_detector(
  input clk,
  input reset,
  input level,
  output reg tick
);

reg state,next_state;
parameter ZERO = 1'b0,
          ONE  = 1'b1;

always @(posedge clk or posedge reset)
begin
   if(reset)
      state <= ZERO;
   else
      state <= next_state;
end

always @(*)
begin
    case(state)

    ZERO:
      if(level)
          next_state = ONE;
      else
          next_state = ZERO;

    ONE:
      if(level)
          next_state = ONE;
      else
          next_state = ZERO;

    endcase
end

always @(*)
begin
    tick = (state==ZERO && level==1);
 end
endmodule
