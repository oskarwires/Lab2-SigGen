module sinegen #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock 
  input  logic             rst,      // reset 
  input  logic             en,       // enable
  input  logic [WIDTH-1:0] phase_shift, // phase shift amount
  input  logic [WIDTH-1:0] incr,     // counter increment
  output logic [WIDTH-1:0] dout1, // first sinusoid
  output logic [WIDTH-1:0] dout2  // phase shifted sinusoid
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
  .addr1 (count),
  .dout1 (dout1),
  .addr2 (count+phase_shift),
  .dout2 (dout2)
);

endmodule
