module decode_cycle #(parameter DATA_WIDTH = 32,
                                REG_WIDTH = 5)

(
input                   clk,
input                   rst,
input                   flush,
input                   reg_writeW,
input [DATA_WIDTH-1:0]  instrD,
input [DATA_WIDTH-1:0]  pcD,
input [DATA_WIDTH-1:0]  pcplus4D,
input [DATA_WIDTH-1:0]  resultW,
input [REG_WIDTH-1:0]   RDW,
output                  reg_writeE,
output                  result_srcE,
output                  pc_addr_srcE,
output                  mem_writeE,
output                  branchE,
output                  signE,
output [1:0]            alu_srcE,
output [1:0]            byteE,
output [4:0]            alu_controlE,
output                  jumpE,
output [REG_WIDTH-1:0]  RDE,
output [REG_WIDTH-1:0]  RS1E,
output [REG_WIDTH-1:0]  RS2E,
output [DATA_WIDTH-1:0] RD1E,
output [DATA_WIDTH-1:0] RD2E,
output [DATA_WIDTH-1:0] pcE,
output [DATA_WIDTH-1:0] pcplus4E,
output [DATA_WIDTH-1:0] imm_extE


);



wire                  reg_writeD;
wire                  result_srcD;
wire                  pc_addr_srcD;
wire                  mem_writeD;
wire                  branchD;
wire                  signD;
wire [1:0]            alu_srcD;
wire [1:0]            byteD;
wire [4:0]            alu_controlD;
wire [DATA_WIDTH-1:0] RD1D;
wire [DATA_WIDTH-1:0] RD2D;
wire [DATA_WIDTH-1:0] imm_extD;
wire [2:0]            imm_srcD;
wire                  jumpD;




reg                  reg_writeE_reg;
reg                  result_srcE_reg;
reg                  pc_addr_srcE_reg;
reg                  mem_writeE_reg;
reg                  branchE_reg;
reg                  jumpE_reg;
reg                  signE_reg;
reg [1:0]            alu_srcE_reg;
reg [1:0]            byteE_reg;
reg [4:0]            alu_controlE_reg;
reg [DATA_WIDTH-1:0] RD1E_reg;
reg [DATA_WIDTH-1:0] RD2E_reg;
reg [DATA_WIDTH-1:0] imm_extE_reg;
reg [DATA_WIDTH-1:0] pcE_reg;
reg [DATA_WIDTH-1:0] pcplus4E_reg;
reg [REG_WIDTH-1:0]  RDE_reg;
reg [REG_WIDTH-1:0]  RS1E_reg;
reg [REG_WIDTH-1:0]  RS2E_reg;


cpu CPU (
           .op(instrD[6:0]),
           .funct7(instrD[31:25]),
           .funct3(instrD[14:12]),
           .reg_writeD(reg_writeD),
           .result_srcD(result_srcD),
           .pc_addr_srcD(pc_addr_srcD),
           .alu_srcD(alu_srcD),
           .mem_writeD(mem_writeD),
           .branchD(branchD),
           .jumpD(jumpD),
           .imm_srcD(imm_srcD),
           .alu_controlD(alu_controlD),
           .byteD(byteD),
           .signD(signD)

         );


Register_file registerfile(
                            .wD3(resultW),
                            .clk(clk),
                            .rst(rst),
                            .wE3(reg_writeW),
                            .A1(instrD[19:15]),
                            .A2(instrD[24:20]),
                            .A3(RDW),
                            .RD1(RD1D),
                            .RD2(RD2D)
                            );

sign_extended sign_extended (
                             .instrD(instrD[31:7]),
                             .imm_srcD(imm_srcD),
                             .imm_extD(imm_extD)
                             );

           
                             
always@(posedge clk,negedge rst)
    begin
        if(~rst || flush)
            begin
                alu_controlE_reg <=  5'b000000;
                reg_writeE_reg   <=  1'b0;
                RS1E_reg         <=  0;
                RS2E_reg         <=  0;
                RDE_reg          <=  {REG_WIDTH{1'B0}};
                RD1E_reg         <=  {DATA_WIDTH{1'B0}};
                RD2E_reg         <=  {DATA_WIDTH{1'B0}};
                result_srcE_reg  <=  1'b0;
                pc_addr_srcE_reg <=  0;
                imm_extE_reg     <=  0;
                alu_srcE_reg     <=  1'b0;
                mem_writeE_reg   <=  1'b0;
                pcE_reg          <=  {DATA_WIDTH{1'B0}};
                pcplus4E_reg     <=  {DATA_WIDTH{1'B0}};
                signE_reg        <= 0;
                byteE_reg        <= 0;
                branchE_reg      <= 0;
                jumpE_reg        <= 0;
            end
        
        
        else
            begin
                alu_controlE_reg <=  alu_controlD;
                reg_writeE_reg   <=  reg_writeD;
                RDE_reg          <=  instrD[11:7];
                RS1E_reg         <=  instrD[19:15];
                RS2E_reg         <=  instrD[24:20];
                RD1E_reg         <=  RD1D;
                RD2E_reg         <=  RD2D;
                result_srcE_reg  <=  result_srcD;
                pc_addr_srcE_reg <=  pc_addr_srcD;
                imm_extE_reg     <=  imm_extD;
                alu_srcE_reg     <=  alu_srcD;
                mem_writeE_reg   <=  mem_writeD;
                pcE_reg          <=  pcD;
                pcplus4E_reg     <=  pcplus4D;
                signE_reg        <=  signD;
                byteE_reg        <=  byteD;
                branchE_reg      <=  branchD;
                jumpE_reg        <=  jumpD;
                
           end
        end
     
        
assign reg_writeE   = reg_writeE_reg;
assign alu_controlE = alu_controlE_reg;
assign RS1E         = RS1E_reg;
assign RS2E         = RS2E_reg;
assign RD1E         = RD1E_reg;
assign RD2E         = RD2E_reg;
assign RDE          = RDE_reg;
assign result_srcE  = result_srcE_reg;
assign pc_addr_srcE = pc_addr_srcE_reg;
assign imm_extE     = imm_extE_reg;
assign alu_srcE     = alu_srcE_reg;
assign mem_writeE   = mem_writeE_reg;
assign pcE          = pcE_reg;
assign pcplus4E     = pcplus4E_reg;
assign jumpE        = jumpE_reg;
assign byteE        = byteE_reg;
assign signE        = signE_reg;
assign branchE      = branchE_reg;
 

endmodule
