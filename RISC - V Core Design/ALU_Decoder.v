module ALU_Decoder

(

input      [2:0] alu_op,
input      [2:0] funct3,
input      [6:0] funct7,
output reg [4:0] alu_control
);



always@(*)
    begin
       case(alu_op)
          3'b001    : begin
                         case({funct7[5],funct3})
                             4'b0000      :    alu_control = 5'b00000;
                             4'b1000      :    alu_control = 5'b00001;
                             4'b0001      :    alu_control = 5'b00010;
                             4'b0010      :    alu_control = 5'b00011;
                             4'b0011      :    alu_control = 5'b00100;
                             4'b0100      :    alu_control = 5'b00101;
                             4'b0101      :    alu_control = 5'b00110;
                             4'b1101      :    alu_control = 5'b00111;
                             4'b0110      :    alu_control = 5'b01000;
                             4'b0111      :    alu_control = 5'b01001;
                             
                                 default     alu_control = 5'b01111;
                          endcase
                     end
                     
          3'b010   : begin
                        case(funct3)
                            3'b000   :  alu_control = 5'b00000;
                            3'b001   :  alu_control = 5'b00010;
                            3'b010   :  alu_control = 5'b00011; 
                            3'b011   :  alu_control = 5'b00100; 
                            3'b100   :  alu_control = 5'b00101; 
                            3'b101   : begin
                                           case(funct7[5])
                                                1'b0   :  alu_control = 5'b00110;
                                                1'b1   :  alu_control = 5'b00111;
                                           endcase
                                       end         
                            3'b110   :  alu_control = 5'b01000; 
                            3'b111   :  alu_control = 5'b01001; 
                            
                            default :  alu_control = 5'b01111;
                        endcase
                   end
                   
           3'b011  : alu_control = 5'b00000;  
           3'b100  : alu_control = 5'b01010;  
           3'b101  : alu_control = 5'b00000;
          
           3'b110  : begin
                        case(funct3)
                            3'b000   :  alu_control = 5'b01011;
                            3'b001   :  alu_control = 5'b01100;
                            3'b100   :  alu_control = 5'b01101;
                            3'b101   :  alu_control = 5'b01110;
                            3'b110   :  alu_control = 5'b01111;
                            3'b111   :  alu_control = 5'b10000;
                            
                            default : alu_control = 5'b01111;
                        endcase
                    end        
           
           3'b111 : begin
                        alu_control = 5'b10001;
                    end 
                             
               default : alu_control = 5'b11111;    
      endcase
  end
                            
                                 
                                               
                         
endmodule
