module fsm_2 (
   input  wire a,
   input  wire b,
   input  wire clk,
   input  wire reset,
   output reg y0,
   output reg y1
);

localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10;

reg [1:0] present_state, next_state;

// State Register
always @(posedge clk or negedge reset)
    if (!reset)
        present_state <= S0;
    else
        present_state <= next_state;

// Next State & Output Logic
always @(*) begin
   next_state = S0;
   y0 = 0;
   y1 = 0;
    case (present_state)
     S0: begin
     y1 = 1;
     next_state = (!a) ? S0 : (b ? S2 : S1);
     y0 = (a && b);
     end
    S1: begin
    y1 = 1;
    next_state = (!a) ? S1 : S0;
     end

    S2: begin
    next_state = S0;
     end
  endcase
 end
endmodule