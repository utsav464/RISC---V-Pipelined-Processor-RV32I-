module main_decoder

(
input     [6:0]  op,
input     [2:0]  funct3,
output reg       jump,
output reg       reg_write,
output reg       result_src,
output reg       pc_addr_src,
output reg       mem_write,
output reg       branch,
output reg       sign,
output reg [2:0] alu_op,
output reg [1:0] byte,
output reg [1:0] alu_src,
output reg [2:0] imm_src

  );
    
 

always@(*)
    begin
        case(op)
            7'b0000011  : begin
                             result_src  = 1'b1;
                             reg_write   = 1'b1;
                             alu_src     = 2'b01;
                             jump        = 1'b0;
                             branch      = 1'b0;
                             pc_addr_src = 1'b0;
                             mem_write   = 1'b0;
                             alu_op      = 3'b011;
                              
                              case(funct3)
                                3'b000  : begin
                                              byte    = 2'b01;
                                              sign    = 1'b1;
                                              imm_src = 3'b001;
                                          end    
                                
                                3'b001  : begin
                                              byte    = 2'b10;
                                              sign    = 1'b1;
                                              imm_src = 3'b001;
                                          end  
                                
                                3'b010  : begin
                                              byte    = 2'b11;
                                              sign    = 1'b1;
                                              imm_src = 3'b001;
                                          end   
                                
                                3'b100  : begin
                                              byte    = 2'b01;
                                              sign    = 1'b0;
                                              imm_src = 3'b001;
                                          end     
                                
                                3'b101  : begin 
                                              byte    = 2'b10;
                                              sign    = 1'b0;
                                              imm_src = 3'b001;
                                          end     
                                
                                default : begin 
                                              byte      = 2'b00;
                                              sign      = 1'b1;
                                              imm_src   = 3'b001;
                                          end   
                             
                              endcase
                          end
                              
            7'b0010011  : begin
                            reg_write   = 1'b1;
                            alu_src     = 2'b01;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b0;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            alu_op      = 3'b010;
                           
                            case(funct3)
                                3'b000 : imm_src = 3'b001;
                                3'b010 : imm_src = 3'b001;
                                3'b100 : imm_src = 3'b001;
                                3'b110 : imm_src = 3'b001;
                                3'b111 : imm_src = 3'b001;
                                3'b011 : imm_src = 3'b010;
                                3'b001 : imm_src = 3'b011;
                                3'b101 : imm_src = 3'b011;
                               default : imm_src = 3'b001;
                            endcase
                            
                          end
                          
           7'b1100111  : begin  
                             imm_src     = 3'b001;
                             jump        = 1'b1;
                             branch      = 1'b0;
                             reg_write   = 1'b1;
                             alu_src     = 2'b10;
                             byte        = 2'b00;
                             sign        = 1'b1;
                             pc_addr_src = 1'b0;
                             mem_write   = 1'b0;
                             result_src  = 1'b0;
                             alu_op      = 3'b100;
                             
                         end   
                                         
           7'b0100011  : begin
                            mem_write   = 1'b1;
                            alu_src     = 2'b01;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b0;
                            alu_op      = 3'b101;
                             
                              case(funct3)
                              3'b000  : begin
                                            byte    = 2'b01;
                                            imm_src = 3'b100;
                                        end
                                        
                              3'b001  : begin  
                                            byte    = 2'b10;
                                            imm_src = 3'b100;
                                        end
                              
                              3'b010  : begin
                                            byte    = 2'b11;  
                                            imm_src = 3'b100;    
                                        end
                              default : begin
                                            byte    = 2'b00;
                                            imm_src = 2'b001;
                                        end              
                             endcase
                             
                         end
           
            7'b1101111 : begin
                             imm_src     = 3'b101;
                             byte        = 2'b00;
                             sign        = 1'b1;
                             jump        = 1'b1;
                             branch      = 1'b0;
                             pc_addr_src = 1'b1;
                             mem_write   = 1'b0;
                             result_src  = 1'b0;
                             reg_write   = 1'b1;
                             alu_src     = 2'b10;
                             alu_op      = 3'b100;
                         end 
                          
           7'b0110011 : begin
                            imm_src     = 3'b000;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b0;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b1;
                            alu_src     = 2'b00;
                            alu_op      = 3'b001;
                        end           
           

              
          7'b1100011 : begin 
                            imm_src     = 3'b110;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b1;
                            pc_addr_src = 1'b1;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b0;
                            alu_src     = 2'b00;
                            alu_op      = 3'b110;    
                      end      
       
         7'b0110111 : begin 
                            imm_src     = 3'b111;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b0;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b1;
                            alu_src     = 2'b01;
                            alu_op      = 3'b111;    
                      end   
                      
         7'b0010111 : begin 
                            imm_src     = 3'b111;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b1;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b1;
                            alu_src     = 2'b11;
                            alu_op      = 3'b111;    
                      end                     
              default : begin 
                            imm_src     = 3'b000;
                            byte        = 2'b00;
                            sign        = 1'b1;
                            jump        = 1'b0;
                            branch      = 1'b0;
                            pc_addr_src = 1'b0;
                            mem_write   = 1'b0;
                            result_src  = 1'b0;
                            reg_write   = 1'b0;
                            alu_src     = 2'b00;
                            alu_op      = 3'b000;
                        end    
           endcase
    end
  
  
    
                             

endmodule
