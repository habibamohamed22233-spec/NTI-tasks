module stream_parity_gen(
  input wire clk,
  input wire reset,
  input wire serial_in,
  output reg parity_out
);

reg [7:0] shift_reg;
function parity_calc;
  input [7:0] data;
  begin
parity_calc = ^data_in ;
    
  end
endfunction

always @(posedge clk) begin
  if (reset)
  begin
    shift_reg  <= 8'b00000000;
    parity_out <= 1'b0;
    end
  else
   begin
   shift_reg <= {shift_reg[6:0], serial_in};
   parity_out <= parity_calc({shift_reg[6:0], serial_in});
  end
end
endmodule
