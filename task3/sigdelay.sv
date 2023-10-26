module sigdelay #(
    parameter DATA_WIDTH = 8,
              ADDR_WIDTH = 9
)(
    input logic clk,
    input logic rst,
    input logic wr,
    input logic rd,
    input logic [DATA_WIDTH-1:0] mic_signal,
    input logic [DATA_WIDTH-1:0] offset,
    input logic [ADDR_WIDTH-1:0] incr,
    output logic [DATA_WIDTH-1:0] delayed_signal
);

logic [ADDR_WIDTH-1:0] addr;
logic [ADDR_WIDTH-1:0] offset_addr;
assign offset_addr = addr - offset;

counter myCounter (
    .incr (incr),
    .rst (rst),
    .en (wr),
    .clk (clk),
    .count (addr)
);

ram2p myRam (
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (addr),
    .rd_addr (offset_addr),
    .din (mic_signal),
    .clk (clk),
    .dout (delayed_signal)
);
    
endmodule
