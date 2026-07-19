module stream_parity #(parameter w =8)(
  input wire clk,
  input wire reset,
  input wire serial_in,
  output reg parity_out
);
 reg [w-1:0] shift_reg;
 wire [w:0] data;
 
assign data[0] =serial_in;
genvar i;
generate 
  for (i= 0; i <w; i =i+1) begin :chain
     register re (.clk(clk),.rst(reset),.data_in(data[i]),.data_out(data[i+1]));
  end
endgenerate

function calc_parity;
input [w-1:0] data_window;
begin
  calc_parity = ^data_window;
end
endfunction

always @(*) begin
  shift_reg = data [w:1];
  parity_out = calc_parity(shift_reg);
end
  
endmodule

module register (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

always@(posedge clk) begin
  if (rst)begin
     data_out <=0;
end
  else begin 
    data_out <= data_in;
   end
  end
endmodule
