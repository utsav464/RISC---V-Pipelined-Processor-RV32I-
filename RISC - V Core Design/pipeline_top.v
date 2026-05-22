`timescale 1ns/1ps


module pipeline_top #(DATA_WIDTH = 32,
                      REG_WIDTH  = 5)

(
input clk,
input rst

);

wire [DATA_WIDTH-1:0] instrD;
wire [DATA_WIDTH-1:0] result_extW;
wire [DATA_WIDTH-1:0] alu_resultM;
wire [DATA_WIDTH-1:0] imm_extE;
wire [DATA_WIDTH-1:0] read_dataW;
wire [DATA_WIDTH-1:0] alu_resultW;
wire [DATA_WIDTH-1:0] RD1E;
wire [DATA_WIDTH-1:0] RD2E;
wire [DATA_WIDTH-1:0] write_data;

wire [DATA_WIDTH-1:0] pc_targetE;
wire [DATA_WIDTH-1:0] pcD;
wire [DATA_WIDTH-1:0] pcplus4D;
wire [DATA_WIDTH-1:0] pcE;
wire [DATA_WIDTH-1:0] pcplus4E;
wire [DATA_WIDTH-1:0] alu_resultM1_haz;
wire [DATA_WIDTH-1:0] alu_resultM2_haz;
wire [DATA_WIDTH-1:0] RD2M;
wire [REG_WIDTH-1:0]  RS1E;
wire [REG_WIDTH-1:0]  RS2E;
wire [REG_WIDTH-1:0]  RDW;
wire [REG_WIDTH-1:0]  RDM;
wire [REG_WIDTH-1:0]  RDE;    
wire                  flush;
wire                  reg_writeW;
wire                  reg_writeE;
wire                  reg_writeM;
wire                  result_srcE;
wire                  pc_addr_srcE;
wire                  result_srcM;
wire                  result_srcW;
wire                  mem_writeE;
wire                  mem_writeM;
wire                  branchE;
wire                  signE;
wire                  signM;
wire                  signW;
wire [1:0]            alu_srcE;
wire [1:0]            forwardAE;
wire [1:0]            forwardBE;
wire [1:0]            byteM;
wire [1:0]            byteW;
wire [1:0]            byteE;
wire [4:0]            alu_controlE;
wire                  jumpE;
wire                  zeroE;
wire                  pcsrcE;


fetch_cycle fetch(
                  .rst(rst),
                  .clk(clk),
                  .flush(flush),
                  .pcsrcE(pcsrcE),
                  .pc_targetE(pc_targetE),
                  .instrD(instrD),
                  .pcD(pcD),
                  .pcplus4D(pcplus4D)
                
                   );
                   
decode_cycle DECODE_CYCLE  (
                               .clk(clk),
                               .rst(rst),
                               .flush(flush),
                               .reg_writeW(reg_writeW),
                               .instrD(instrD),
                               .pcD(pcD),
                               .pcplus4D(pcplus4D),
                               .resultW(result_extW),
                               .RDW(RDW),
                               .reg_writeE(reg_writeE),
                               .result_srcE(result_srcE),
                               .pc_addr_srcE(pc_addr_srcE),
                               .alu_srcE(alu_srcE),
                               .mem_writeE(mem_writeE),
                               .branchE(branchE),
                               .signE(signE),
                               .byteE(byteE),
                               .alu_controlE(alu_controlE),
                               .jumpE(jumpE),
                               .RS1E(RS1E),
                               .RS2E(RS2E),
                               .RDE(RDE),
                               .RD1E(RD1E),
                               .RD2E(RD2E),
                               .pcE(pcE),
                               .pcplus4E(pcplus4E),
                               .imm_extE(imm_extE)

                         );                 
  
  
execute_cycle execute (
                         .clk(clk),
                         .rst(rst),
                         .forwardAE(forwardAE),
                         .forwardBE(forwardBE),
                         .reg_writeE(reg_writeE),
                         .result_srcE(result_srcE),
                         .pc_addr_srcE(pc_addr_srcE),
                         .alu_srcE(alu_srcE),
                         .mem_writeE(mem_writeE),
                         .signE(signE),
                         .byteE(byteE),
                         .alu_controlE(alu_controlE),
                         .RDE(RDE),
                         .RD1E(RD1E),
                         .RD2E(RD2E),
                         .pcE(pcE),
                         .imm_extE(imm_extE),
                         .alu_resultM1_haz(alu_resultM1_haz),
                         .alu_resultM2_haz(alu_resultM2_haz),
                         .zeroE(zeroE),
                         .reg_writeM(reg_writeM),
                         .result_srcM(result_srcM),
                         .mem_writeM(mem_writeM),
                         .signM(signM),
                         .byteM(byteM),
                         .alu_resultM(alu_resultM),
                         .write_data(write_data),
                         .pc_targetE(pc_targetE),
                         .RDM(RDM),
                         .RD2M(RD2M)
                                 
                      );  
                         
 memory_write_cycle memory_write(
                                      .clk(clk),
                                      .rst(rst),
                                      .reg_writeM(reg_writeM),
                                      .result_srcM(result_srcM),
                                      .mem_writeM(mem_writeM),
                                      .signM(signM),
                                      .byteM(byteM),
                                      .alu_resultM(alu_resultM),
                                      .alu_resultW(alu_resultW),
                                      .RDM(RDM),
                                      .RD2M(RD2M),
                                      .reg_writeW(reg_writeW),
                                      .result_srcW(result_srcW),
                                      .signW(signW),
                                      .byteW(byteW),
                                      .read_dataW(read_dataW),
                                      .RDW(RDW)
                                 
                                  );        
                        
                        
 write_back_cycle writeback(
                                .clk(clk),
                                .rst(rst),
                                .alu_resultW(alu_resultW),
                                .read_dataW(read_dataW),
                                .result_srcW(result_srcW),
                                .signW(signW),
                                .byteW(byteW),
                                .result_extW(result_extW)  
                                
                           );                         

Hazard_unit HAZARD
                     (
                          .clk(clk),
                          .rst(rst),
                          .RDW(RDW),
                          .RDM(RDM),
                          .RS1E(RS1E),
                          .RS2E(RS2E),
                          .alu_resultW(alu_resultW),
                          .forwardAE(forwardAE),
                          .forwardBE(forwardBE),
                          .alu_resultM1_haz(alu_resultM1_haz),
                          .alu_resultM2_haz(alu_resultM2_haz)
                          
                         );  
                         
                         
                         
Control_Hazard CONTROL_HAZARD
                               (
                                   .jump(jumpE),
                                   .branch(branchE),
                                   .zero(zeroE),
                                   .flush(flush)
                               );                         



assign pcsrcE = jumpE || (branchE && zeroE) ? 1'b1 : 1'b0;

                                 
endmodule