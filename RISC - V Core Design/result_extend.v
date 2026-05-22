module result_extend #(parameter DATA_WIDTH = 32)

(
input                       sign, 
input [1:0]                 byte,  
input      [DATA_WIDTH-1:0] resultW,
output reg [DATA_WIDTH-1:0] result_extW
   
);
    
always@(*)
    begin   
        case({sign,byte})
            3'b101: result_extW = {{24{resultW[7]}},resultW[7:0]};
            3'b110: result_extW = {{16{resultW[7]}},resultW[15:0]};
            3'b111: result_extW =  resultW;
            3'b001: result_extW = {{24{1'b0}},resultW[7:0]};
            3'b010: result_extW = {{16{1'b0}},resultW[15:0]};
            3'b100: result_extW =  resultW;
            
            default : result_extW = 32'd0;
        endcase
    end        
          
    
endmodule
