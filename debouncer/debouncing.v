module debouncer(
   input clk,
   input reset,
   input sw,
   output reg db
);

localparam
    zero    = 3'b000,
    wait1_1 = 3'b001,
    wait1_2 = 3'b010,
    wait1_3 = 3'b011,
    one     = 3'b100,
    wait0_1 = 3'b101,
    wait0_2 = 3'b110,
    wait0_3 = 3'b111;

reg [2:0] present_state, next_state;
reg [9:0] tick_counter;
wire m_tick;

// State Register + Timer
always @(posedge clk or posedge reset)
begin
   if(reset)
    begin
      present_state <= zero;
      tick_counter <= 10'd0;
    end
  else
    begin
       present_state <= next_state;

     if(tick_counter == 10'd999)
         tick_counter <= 10'd0;
   
  else
      tick_counter <= tick_counter + 1'b1;
    end
end
assign m_tick = (tick_counter == 10'd999);

// Next State Logic
always @(*)
begin
    next_state = present_state;
  case(present_state)

        zero:
          if(sw)
            next_state = wait1_1;

        wait1_1:
          if(!sw)
             next_state = zero;
          else if(m_tick)
             next_state = wait1_2;

        wait1_2:
          if(!sw)
             next_state = zero;
          else if(m_tick)
             next_state = wait1_3;

        wait1_3:
          if(!sw)
             next_state = zero;
          else if(m_tick)
             next_state = one;

        one:
          if(!sw)
             next_state = wait0_1;

        wait0_1:
          if(sw)
             next_state = one;
          else if(m_tick)
             next_state = wait0_2;

        wait0_2:
           if(sw)
              next_state = one;
          else if(m_tick)
              next_state = wait0_3;

        wait0_3:
          if(sw)
              next_state = one;
          else if(m_tick)
              next_state = zero;

        default:
            next_state = zero;

    endcase
end

// Output Logic (Moore FSM)
always @(*)
begin
    case(present_state)

        zero,
        wait1_1,
        wait1_2,
        wait1_3:
        db = 1'b0;

        one,
        wait0_1,
        wait0_2,
        wait0_3:
        db = 1'b1;

        default:
         db = 1'b0;

    endcase
  end
endmodule
