module pc_module #(parameter DATA_WIDTH = 32)

(
input         clk,
input         rst,
input  [DATA_WIDTH-1:0] pc_next,
output [DATA_WIDTH-1:0] pc
);

reg [DATA_WIDTH-1:0] pc_internal;

always@(posedge clk,negedge rst)
    begin
        if(~rst)
                pc_internal <= {DATA_WIDTH{1'b0}};
            
         else
                pc_internal <= pc_next;
    end


assign pc = pc_internal;
       
endmodule
