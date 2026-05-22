module sign_extended #(parameter DATA_WIDTH = 32)

(
input  [2:0]            imm_srcD, 
input  [DATA_WIDTH-1:7] instrD,
output [DATA_WIDTH-1:0] imm_extD

);

assign imm_extD = (imm_srcD == 3'b001) ? {{20{instrD[31]}},instrD[31:20]}              :
                  (imm_srcD == 3'b010) ? {{20{1'b0}},instrD[31:20]}                    : 
                  (imm_srcD == 3'b011) ? {{28{1'b0}},instrD[24:20]}                    : 
                  (imm_srcD == 3'b100) ? {{20{instrD[31]}},instrD[31:25],instrD[11:7]} :
                  (imm_srcD == 3'b101) ? {{11{instrD[31]}},instrD[31],instrD[19:12],instrD[20],instrD[30:21],1'b0}:
                  (imm_srcD == 3'b110) ? {{19{instrD[31]}},instrD[31],instrD[7],instrD[30:25],instrD[11:8],1'b0}  : 
                  (imm_srcD == 3'b111) ? {instrD[31:12],{12{1'b0}}}                                          : 32'd0;

endmodule

