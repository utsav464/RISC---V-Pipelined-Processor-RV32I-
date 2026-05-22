module fetch_cycle #(DATA_WIDTH = 32)

(
input                   clk,
input                   rst,
input                   flush,
input                   pcsrcE,
input  [DATA_WIDTH-1:0] pc_targetE,
output [DATA_WIDTH-1:0] instrD,
output [DATA_WIDTH-1:0] pcD,
output [DATA_WIDTH-1:0] pcplus4D
);


wire [DATA_WIDTH-1:0] pcF_bar;
wire [DATA_WIDTH-1:0] pcF;
wire [DATA_WIDTH-1:0] pcplus4F;
wire [DATA_WIDTH-1:0] instrF;

reg [DATA_WIDTH-1:0] pcF_reg;
reg [DATA_WIDTH-1:0] pcplus4F_reg;
reg [DATA_WIDTH-1:0] instrF_reg;


pc_addr adder(
         .a(pcF),
         .b(4),
         .c(pcplus4F)
         );

        
pc_module pc(
           .clk(clk),
           .rst(rst),
           .pc_next(pcF_bar),
           .pc(pcF)
           );  
           
                 
 instruction_mem memory(
                         .pc(pcF),
                         .RD(instrF),
                         .rst(rst),
                         .clk(clk)
                       );       
 
 

mux2_1 mux_fetch(
                   .sel(pcsrcE),
                   .a(pcplus4F),
                   .b(pc_targetE),
                   .c(pcF_bar)
                );


              
      
     always@(posedge clk )
        begin
            if(rst==1'b0)
                begin
                    pcF_reg      <= 0;
                    pcplus4F_reg <= 0;
                    instrF_reg   <= 0;
                end
                
                else   
                    begin
                         pcF_reg       <= pcF;
                         pcplus4F_reg  <= pcplus4F;
                         if(~flush)
                            instrF_reg    <= instrF;
                         else 
                            instrF_reg    <= 0;   
                    end
          end
          
          
assign instrD   = instrF_reg;
assign pcplus4D = pcplus4F_reg;  
assign pcD      = pcF_reg;                
                            
              
endmodule
