module instruction_mem #(DATA_WIDTH = 32)
                        
(

input                    clk,
input                    rst,
input   [DATA_WIDTH-1:0] pc,
output  [DATA_WIDTH-1:0] RD

);


reg [7:0] mem[0:4096];

  
assign  RD = {mem[pc+3], mem[pc+2], mem[pc+1], mem[pc]};

       

        
initial 
    begin
        $readmemh("memfile.mem",mem);
    end
   
endmodule
