module controller(
  input [2:0] opcode,
  input [2:0] phase,
  input  zero,
  output reg sel,
  output reg rd,
  output reg ld_ir,
  output reg inc_pc,
  output reg halt,
  output reg ld_pc,
  output reg data_e,
  output reg ld_ac,
  output reg wr
);

localparam 
  HLT = 3'b000,
  SKZ = 3'b001,
  ADD = 3'b010,
  AND = 3'b011,
  XOR = 3'b100,
  LDA = 3'b101,
  STO = 3'b110,
  JMP = 3'b111;

reg ALUOP;
reg HALT;
reg STORE;
reg JUMP;
reg SKIP;

always @(*) begin

 ALUOP = (opcode==ADD) || (opcode==AND) || (opcode==XOR) || (opcode==LDA);
 HALT  = (opcode==HLT);
 STORE = (opcode==STO);
 JUMP  = (opcode==JMP);
 SKIP  = (opcode==SKZ) && zero;
end
// Default outputs
  sel    = 0;
  rd     = 0;
  ld_ir  = 0;
  inc_pc = 0;
  halt   = 0;
  ld_pc  = 0;
  data_e = 0;
  ld_ac  = 0;
  wr     = 0;

 case (phase)
3'd0: begin
   sel = 1;
 end
3'd1: begin
    sel = 1;
    rd = 1;
end
3'd2: begin
    sel   = 1;
    rd    = 1;
    ld_ir = 1;
end
3'd3: begin
     sel   = 1;
     rd    = 1;
     ld_ir = 1;
end
3'd4: begin
      inc_pc = 1;
      halt   = HALT;
end
3'd5: begin
    if(ALUOP)
      rd = 1;
end
3'd6: begin
   if(ALUOP)
     rd = 1;
   if(STORE)
     data_e = 1;
   if(JUMP)
      ld_pc = 1;
   if(SKIP)
       inc_pc = 1;
 end
3'd7: begin
    if(ALUOP) 
      rd    = 1;
      ld_ac = 1;
 end
    if(STORE) begin
      data_e = 1;
      wr     = 1;
end
    if(JUMP) begin
      ld_pc = 1;
end
      default: begin
  sel    = 0;
  rd     = 0;
  ld_ir  = 0;
  inc_pc = 0;
  halt   = 0;
  ld_pc  = 0;
  data_e = 0;
  ld_ac  = 0;
  wr     = 0;
end
endcase
end
endmodule
