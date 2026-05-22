module alu #(parameter DATA_WIDTH = 32,
                       REG_WIDTH  = 5) 

(
input      [DATA_WIDTH-1:0] A,
input      [DATA_WIDTH-1:0] B,
input      [4:0]            alu_control,
output reg [DATA_WIDTH-1:0] alu_result,
output reg                  zero
);

reg                  overflow;
reg [DATA_WIDTH-1:0] sub;

always@(*)
    begin   
        case(alu_control)
            5'b00000: begin
                           alu_result  = A + B;
                           zero        = 1'b0;
                      end     
                      
            5'b00001: begin 
                           alu_result  = A - B;
                           zero        = 1'b0;
                      end
                           
            5'b00010: begin
                           alu_result  = A << B;
                           zero        = 1'b0;
                      end
                      
            5'b00011:begin
                         sub      = A + (~B + 1);  
                         zero     = 1'b0;
                         overflow = (A[31] & ~B[31] & ~sub[31]) |
                                    (~A[31] & B[31] & sub[31]);
                         alu_result = overflow ^ sub[31];
                      end          
          
            5'b00100:  begin
                         zero = 1'b0;
                         if(A < B)
                             alu_result = 32'd1;
                         else
                             alu_result = {DATA_WIDTH{1'b0}};  
                      end  
                                                        
            5'b00101: begin 
                           alu_result  = A ^ B;
                           zero        = 1'b0;
                      end
                           
            5'b00110: begin 
                           alu_result  = A >> B;
                           zero        = 1'b0;
                      end   
                        
            5'b00111: begin
                           alu_result  = $signed(A) >>> $signed(B) ;
                           zero        = 1'b0;
                      end 
                          
            5'b01000: begin 
                           alu_result  = A | B;
                           zero        = 1'b0;
                      end  
                      
            5'b01001: begin
                           alu_result  = A & B;
                           zero        = 1'b0;
                      end  
                      
            5'b01010: begin 
                           alu_result  =   B + 4;
                           zero        = 1'b0;
                      end  
            
            5'b01011: begin
                         alu_result  =  32'd0;
                         zero        =  (A == B) ? 1'B1:1'B0;
                      end   
            
            5'b01100: begin
                        alu_result  =  32'd0;
                        zero        =  (A != B) ? 1'B1:1'B0;
                     end   
           
            5'b01101: begin
                        alu_result  =  32'd0;
                        zero        =  ($signed(A) < $signed(B)) ? 1'B1:1'B0;
                     end  
            
            5'b01110: begin
                        alu_result  =  32'd0;
                        zero        =  ($signed(A) >= $signed(B)) ? 1'B1:1'B0;
                      end    
                  
            5'b01111: begin
                        alu_result  =  32'd0;
                        zero        =  (A < B) ? 1'B1:1'B0;
                      end                                  

            5'b10000: begin
                        alu_result  =  32'd0;
                        zero        =  (A >= B) ? 1'B1:1'B0;
                      end          
            
            5'b10001: begin
                        alu_result = B ;
                        zero       = 1'b0;
                      end
                                                          
            default: begin 
                          alu_result = {DATA_WIDTH{1'B0}};
                          zero       = 1'b0;
                     end     
        endcase
   end         
endmodule
