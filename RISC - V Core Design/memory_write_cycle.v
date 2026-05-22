module memory_write_cycle #(parameter DATA_WIDTH = 32,
                                      REG_WIDTH  = 5)


(
input                   clk,
input                   rst,
input                   reg_writeM,
input                   result_srcM,
input                   mem_writeM,
input                   signM,
input  [1:0]            byteM,
input  [DATA_WIDTH-1:0] alu_resultM,
input  [DATA_WIDTH-1:0] RD2M,
input  [REG_WIDTH-1:0]  RDM,

output                  reg_writeW,
output                  result_srcW,
output                  signW,
output [1:0]            byteW,
output [DATA_WIDTH-1:0] alu_resultW,
output [DATA_WIDTH-1:0] read_dataW,
output [REG_WIDTH-1:0]  RDW

);

wire [DATA_WIDTH-1:0] read_dataM;




reg [DATA_WIDTH-1:0] read_dataW_reg;
reg [DATA_WIDTH-1:0] alu_resultW_reg;
reg                  reg_writeW_reg;
reg                  result_srcW_reg;
reg                  signW_reg;
reg [1:0]            byteW_reg;
reg [REG_WIDTH-1:0]  RDW_reg;



data_memeory dataaa_memory(
                          .clk(clk),
                          .rst(rst),
                          .RD2M(RD2M),
                          .alu_resultM(alu_resultM),
                          .readdataW(read_dataM), 
                          .mem_writeM(mem_writeM),
                          .byte(byteM)
                           );


always@(posedge clk or negedge rst)
    begin
        if(rst==1'b0)
            begin
                reg_writeW_reg  <= 1'b0;
                result_srcW_reg <= 1'b0;
                RDW_reg         <= {REG_WIDTH{1'b0}}; 
                alu_resultW_reg <= {DATA_WIDTH{1'b0}};     
                read_dataW_reg  <= {DATA_WIDTH{1'b0}};
                signW_reg       <= 0;
                byteW_reg       <= 0;
            end
            
        else
            begin
                read_dataW_reg  <= read_dataM;
                reg_writeW_reg  <= reg_writeM;
                RDW_reg         <= RDM;
                result_srcW_reg <= result_srcM;
                alu_resultW_reg <= alu_resultM; 
                signW_reg       <= signM;
                byteW_reg       <= byteM;
                
            end
     end
                
assign read_dataW  = read_dataW_reg;
assign reg_writeW  = reg_writeW_reg;                       
assign RDW         = RDW_reg;               
assign result_srcW = result_srcW_reg;  
assign alu_resultW = alu_resultW_reg;
assign signW       = signW_reg;
assign byteW       = byteW_reg;
             
endmodule
