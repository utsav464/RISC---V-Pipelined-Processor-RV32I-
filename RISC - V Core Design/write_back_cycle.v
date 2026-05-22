module write_back_cycle #(DATA_WIDTH = 32)

(
input                   clk,
input                   rst,
input [DATA_WIDTH-1:0]  alu_resultW,
input [DATA_WIDTH-1:0]  read_dataW,
input                   result_srcW,
input                   signW,
input  [1:0]            byteW,
output [DATA_WIDTH-1:0] result_extW
);

wire [DATA_WIDTH-1:0] resultW;
//assign resultW = (result_srcW) ? read_dataW : alu_resultW;




mux2_1  mux2_1_MW  (
                     .sel(result_srcW),
                     .a(alu_resultW),
                     .b(read_dataW),
                     .c(resultW)
                    );


result_extend  RESULT_EXTEND(
                               .sign(signW), 
                               .byte(byteW),  
                               .resultW(resultW),
                               .result_extW(result_extW)
                            );
endmodule
