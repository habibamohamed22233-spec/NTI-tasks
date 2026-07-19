module fsm_2(
   input a,
   input b,
   input clk,
   input reset,
   output reg y0,
   output reg y1
);

localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10;

reg [1:0] present_state, next_state;

// State Register
always @(posedge clk or negedge reset)
begin
    if(!reset)
        present_state <= S0;
    else
        present_state <= next_state;
end

// Next State Logic
always @(*)
  begin
    case(present_state)
    S0:
     if(!a) begin
      next_state = S0;
   end
     else if(b) begin
      next_state = S2;
   end
     else begin
      next_state = S1;
   end
     S1:
     if(!a) begin
       next_state = S1;
   end
     else begin
       next_state = S0;
   end
      S2:
       next_state = S0;
  default:
         next_state = S0;
    endcase
end

// Output y0 
always @(*)
  begin
    case(present_state)
     S0:
     y0 = a & b;
    default:
     y0 = 0;
    endcase
end

// Output y1
always @(*)
  begin
    case(present_state)
    S0, S1:
    y1 = 1;
    default:
    y1 = 0;
    endcase
  end
endmodule