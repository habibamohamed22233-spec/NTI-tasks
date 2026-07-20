module moore_edge_detector(
  input clk,
  input reset,
  input level,
  output reg tick
);

reg [1:0] state,next_state;
parameter ZERO = 2'b00,
          EDGE = 2'b01,
          ONE  = 2'b10;

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
       next_state = EDGE;
     else
       next_state = ZERO;

    EDGE:
      next_state = ONE;

    ONE:
    if(level)
      next_state = ONE;
    else
      next_state = ZERO;

    default:
        next_state = ZERO;

    endcase
end

always @(*)
begin
    case(state)
    EDGE:
      tick = 1'b1;

    default:
      tick = 1'b0;

    endcase
  end
endmodule
