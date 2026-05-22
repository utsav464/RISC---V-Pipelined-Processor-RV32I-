module mux4_1 #(parameter DATA_WIDTH = 32)
  
(  
  input      [1:0]            sel,
  input      [DATA_WIDTH-1:0] a,
  input      [DATA_WIDTH-1:0] b,
  input      [DATA_WIDTH-1:0] c,
  input      [DATA_WIDTH-1:0] d,
  output reg [DATA_WIDTH-1:0] e
);
  
  
always @(*) begin
    case(sel)
        2'b00: e = a;  
        2'b01: e = b;  
        2'b10: e = c; 
        2'b11: e = d;
                                    
        default: e = a;                           
    endcase                                       
end


endmodule