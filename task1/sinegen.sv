module sinegen #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock 
  input  logic             rst,      // reset 
  input  logic             en,       // enable
  input  logic [WIDTH-1:0] incr,
  output logic [WIDTH-1:0] dout       // count output
);

  logic  [WIDTH-1:0]       count;    // interconnect wire

counter myCounter (
  .clk (clk),
  .rst (rst),
  .en (en),
  .incr(incr),
  .count (count)
);

rom myROM (
  .clk (clk),
  .addr (count),
  .dout (dout)
);

endmodule
