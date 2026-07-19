module seq_detector_overlap(
 input clk,
 input reset,
 input din,
 output reg detected
);

parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6;

reg [2:0] state,next_state;

always @(posedge clk or posedge reset)
begin
  if(reset)
      state<=S0;
  else
      state<=next_state;
end

always @(*)
begin
    detected=0;
    case(state)
    S0:
      if(din) next_state=S1;
      else next_state=S0;

    S1:
      if(din) next_state=S2;
      else next_state=S0;

    S2:
      if(din) next_state=S2;
      else next_state=S3;

    S3:
      if(din) next_state=S4;
      else next_state=S0;

    S4:
      if(din) next_state=S2;
      else next_state=S5;

    S5:
      if(din) next_state=S6;
      else next_state=S0;

    S6:
    begin
        detected=1;

      if(din)
          next_state=S2;
      else
          next_state=S3;
    end

    default:
        next_state=S0;

    endcase
  end
endmodule
