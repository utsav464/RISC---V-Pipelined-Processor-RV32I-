module cpu

(
input  [6:0] op,
input  [6:0] funct7,
input  [2:0] funct3,
output       reg_writeD,
output       result_srcD,
output       pc_addr_srcD,
output       mem_writeD,
output       branchD,
output       jumpD,
output       signD,
output [1:0] alu_srcD,
output [1:0] byteD,
output [2:0] imm_srcD,
output [4:0] alu_controlD

);

wire [2:0] alu_op;


main_decoder MAIN_DECODER(
                            .op(op),
                            .funct3(funct3),
                            .jump(jumpD),
                            .reg_write(reg_writeD),
                            .result_src(result_srcD),
                            .pc_addr_src(pc_addr_srcD),
                            .alu_src(alu_srcD),
                            .mem_write(mem_writeD),
                            .branch(branchD),
                            .alu_op(alu_op),
                            .imm_src(imm_srcD),
                            .byte(byteD),
                            .sign(signD)
                            
                          );  

 ALU_Decoder ALU_DECODER(
                            .alu_op(alu_op),
                            .funct3(funct3),
                            .funct7(funct7),
                            .alu_control(alu_controlD)
                        );     
                        
                        
endmodule