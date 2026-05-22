module execute_cycle #(parameter DATA_WIDTH = 32,
                                 REG_WIDTH  = 5)

(
input                   clk,
input                   rst,

input                   reg_writeE,
input                   result_srcE,
input                   pc_addr_srcE,
input                   mem_writeE,
input                   signE,
input  [1:0]            alu_srcE,
input  [1:0]            forwardAE,
input  [1:0]            forwardBE,
input  [1:0]            byteE,
input  [4:0]            alu_controlE,
input  [REG_WIDTH-1:0]  RDE,
input  [DATA_WIDTH-1:0] RD1E,
input  [DATA_WIDTH-1:0] RD2E,
input  [DATA_WIDTH-1:0] pcE,
input  [DATA_WIDTH-1:0] imm_extE,
input  [DATA_WIDTH-1:0] alu_resultM1_haz,
input  [DATA_WIDTH-1:0] alu_resultM2_haz,


output                  zeroE,
output                  reg_writeM,
output                  result_srcM,
output                  mem_writeM,
output                  signM,
output [1:0]            byteM,
output [DATA_WIDTH-1:0] alu_resultM,
output [DATA_WIDTH-1:0] write_data,             
output [DATA_WIDTH-1:0] pc_targetE,
output [DATA_WIDTH-1:0]  RD2M,
output [REG_WIDTH-1:0]  RDM


);


wire [DATA_WIDTH-1:0] alu_resultE;
wire [DATA_WIDTH-1:0] haz_BE;
wire [DATA_WIDTH-1:0] srcBE;
wire [DATA_WIDTH-1:0] srcAE;


reg [DATA_WIDTH-1:0] alu_resultM_reg;
reg [DATA_WIDTH-1:0] RD2M_reg;
reg [DATA_WIDTH-1:0] write_data_reg;
reg [REG_WIDTH-1:0]  RDM_reg;

reg [1:0]            byteM_reg; 
reg                  signM_reg;
reg                  reg_writeM_reg;
reg                  result_srcM_reg;
reg                  mem_writeM_reg;



 alu ALU (
                 .A(srcAE),
                 .B(srcBE),
                 .alu_control(alu_controlE),
                 .alu_result(alu_resultE),
                 .zero(zeroE)
          );
         

mux4_1    mux_alu(
                     .sel(alu_srcE),
                     .a(haz_BE),
                     .b(imm_extE),
                     .c(pcE),
                     .d(pc_targetE),
                     .e(srcBE)
                 );
              
              
mux3_1 mux_haz1 (  
                  .sel(forwardAE),
                  .a(RD1E),
                  .b(alu_resultM),
                  .c(alu_resultM1_haz),
                  .e(srcAE)
                );


mux3_1 mux_haz2 (  
                  .sel(forwardBE),
                  .a(RD2E),
                  .b(alu_resultM),
                  .c(alu_resultM2_haz),
                  .e(haz_BE)
                );


pc_addr_exe  PC_ADDR_EXE (
                        .pc_addr_srcE(pc_addr_srcE),
                        .a(srcAE),
                        .b(imm_extE),
                        .c(pcE),
                        .d(pc_targetE)
                    );
        
        

always@(posedge clk,negedge rst)
    begin
        if(rst==1'b0)
            begin
               reg_writeM_reg    <=  1'b0;
               result_srcM_reg   <=  1'b0;
               mem_writeM_reg    <=  1'b0;
               alu_resultM_reg   <=  {DATA_WIDTH{1'B0}};   
               RDM_reg           <=  {REG_WIDTH{1'B0}};   
               write_data_reg    <=  {DATA_WIDTH{1'B0}};
               byteM_reg         <= 0;
               signM_reg         <= 0;
               RD2M_reg          <= 0;
             
            end
            
        else
            begin
                 alu_resultM_reg  <=  alu_resultE;
                 RDM_reg          <=  RDE;               
                 reg_writeM_reg   <=  reg_writeE;  
                 result_srcM_reg  <=  result_srcE;
                 mem_writeM_reg   <=  mem_writeE;
                 write_data_reg   <=  RD2E;
                 byteM_reg        <=  byteE;
                 signM_reg        <=  signE;
                 RD2M_reg         <=  haz_BE;
                 
            end
                
    end
    
assign alu_resultM   =  alu_resultM_reg;
assign RDM           =  RDM_reg;
assign reg_writeM    =  reg_writeM_reg;
assign result_srcM   =  result_srcM_reg;
assign mem_writeM    =  mem_writeM_reg;  
assign write_data    =  write_data_reg; 
assign byteM         =  byteM_reg;
assign signM         =  signM_reg;
assign RD2M          =  RD2M_reg;


endmodule
