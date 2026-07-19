module parity_tb;

reg clk;
reg rst;
reg serial_in;
wire parity_out;

stream_parity dut (
    .clk(clk),
    .reset(rst),
    .serial_in(serial_in),
    .parity_out(parity_out)
);
  task expt;
 input exp_out;
  begin
if (parity_out !==exp_out) begin
 
 $display("test failed");
 $display(" at time %0d rst=%b parity_out=%b" ,$time ,rst, parity_out);
 $display("parity_out shuld be %b", exp_out);
 $finish;
  end
else begin 
  $display(" at time %0d rst =%b parity_out =%b ", $time ,rst ,parity_out);
    end
   end
endtask

task sen(input [7:0] d);
  integer i;
 begin
    for(i=7; i>= 0; i =i-1) begin
  @(negedge clk);
serial_in = d[i];
    end
   end
endtask

task all (input [7:0] b);
   integer i;
  reg t;
   for(i=1;i<=255;i=i+1) begin
  sen(i[7:0]); @(negedge clk);
   t=^i;
expt(t);
   end
  endtask

initial clk=0;
 always #5 clk = ~clk;

initial begin
rst=1; serial_in=0;
 @(negedge clk);
rst =0;
all(255);
  $display("test passed");
  $finish;
end
endmodule

