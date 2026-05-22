module Hazard_unit #(parameter REG_WIDTH  = 5,
                               DATA_WIDTH = 32)
(
input                 clk,
input                 rst,
input [REG_WIDTH-1:0] RDW,
input [REG_WIDTH-1:0] RDM,
input [REG_WIDTH-1:0] RS1E,
input [REG_WIDTH-1:0] RS2E,

input [DATA_WIDTH-1:0] alu_resultW,

output [1:0]  forwardAE,
output [1:0]  forwardBE,
output [31:0] alu_resultM1_haz,
output [31:0] alu_resultM2_haz


    );
    
reg [4:0] RD1W_internal;
reg [4:0] RD2W_internal;

reg [DATA_WIDTH-1:0] alu_resultW_internal1;
reg [DATA_WIDTH-1:0] alu_resultW_internal2;
  
assign  forwardAE = (RDM == RS1E && RDM != 5'D0)                  ? 2'b01 : 
                    (RS1E == RDW  && RDW != 5'D0)                 ? 2'b10 : 
                    (RS1E == RD1W_internal && RD1W_internal != 0) ? 2'b10 : 2'b00;
                    
assign  forwardBE = (RDM == RS2E && RDM != 5'D0)                  ? 2'b01 :
                    (RS2E == RDW && RDW != 5'd0)                  ? 2'b10 : 
                    (RS2E == RD2W_internal && RD2W_internal != 0) ? 2'B10 :2'b00;

always@(posedge clk,negedge rst)
    begin
        if(~rst)
            begin
                RD1W_internal         <= 0;
                alu_resultW_internal1 <= 0;
            end    
        else if(RS1E == RDW)
            begin
                RD1W_internal         <= RDW; 
                alu_resultW_internal1 <= alu_resultW;
            end    
        else    
            begin
                RD1W_internal         <= 0; 
                alu_resultW_internal1 <= alu_resultW_internal1;
            end    
                             
    end          


always@(posedge clk,negedge rst)
    begin
        if(~rst)
            begin
                RD2W_internal         <= 0;
                alu_resultW_internal2 <= 0;
            end    
        else if(RS2E == RDW)
            begin
                RD2W_internal         <= RDW; 
                alu_resultW_internal2 <= alu_resultW;
            end  
        else
            
            begin
                RD2W_internal         <= 0;
                alu_resultW_internal2 <= alu_resultW_internal2;
            end                   
    end        
    
 assign alu_resultM1_haz = (RS1E == RD1W_internal)? alu_resultW_internal1 : alu_resultW;
 assign alu_resultM2_haz = (RS2E == RD2W_internal)? alu_resultW_internal2 : alu_resultW;
   
endmodule
