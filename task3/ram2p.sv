// Definiting a 512 x 8 bit RAM with read & write
module ram2p #(
    parameter DATA_WIDTH = 8,
              ADDR_WIDTH = 9
              
)(
    input logic clk,
    input logic wr_en,
    input logic rd_en,
    input logic [ADDR_WIDTH-1:0] wr_addr,
    input logic [ADDR_WIDTH-1:0] rd_addr,
    input logic [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDR_WIDTH-1:0];

always_ff @(posedge clk) begin
    if (wr_en == 1'b1)
        ram_array[wr_addr] <= din;
    if (rd_en == 1'b1)
        dout <= ram_array[rd_addr];
end

endmodule
