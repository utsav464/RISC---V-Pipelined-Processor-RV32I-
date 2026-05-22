module pc_addr_exe #(DATA_WIDTH = 32)

(
input                   pc_addr_srcE,
input  [DATA_WIDTH-1:0] a,
input  [DATA_WIDTH-1:0] b,
input  [DATA_WIDTH-1:0] c,
output [DATA_WIDTH-1:0] d
);

assign d = (pc_addr_srcE) ? c + b : a + b;

endmodule