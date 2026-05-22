module mux2_1 #(parameter DATA_WIDTH = 32)

(
input                   sel,
input  [DATA_WIDTH-1:0] a,
input  [DATA_WIDTH-1:0] b,
output [DATA_WIDTH-1:0] c
);


assign c = (sel==1'b0)? a : b;

endmodule
