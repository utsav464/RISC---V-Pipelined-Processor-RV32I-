module data_memeory #(parameter DATA_WIDTH = 32,
                                REG_WIDTH  = 5)


(
input                   clk,
input                   rst,
input                   mem_writeM,
input  [1:0]            byte,
input  [DATA_WIDTH-1:0] RD2M,
input  [DATA_WIDTH-1:0] alu_resultM,
output [DATA_WIDTH-1:0] readdataW

);

reg [7:0] mem [0:4096];
integer i;


wire [31:0] addr = alu_resultM[31:0];


assign readdataW = (byte == 2'b11)?{mem[addr + 3],mem[addr + 2],mem[addr + 1],mem[addr]}:
                   (byte == 2'b01)?{24'd0,mem[addr]}:
                   (byte == 2'b10)?{16'd0,mem[addr + 1],mem[addr]}: 32'd0;


always@(posedge clk,negedge rst)
    begin 
        if(~rst)
            begin
                for(i = 0; i < 1024; i= i+1)
                    begin
                        mem[i] <= 0;
                    end    
            end    
        else if(mem_writeM)
            begin
                case(byte)
                    2'b11  : begin
                                  mem[addr]     <= RD2M[7:0];
                                  mem[addr + 1] <= RD2M[15:8];
                                  mem[addr + 2] <= RD2M[23:16];
                                  mem[addr + 3] <= RD2M[31:24];
                             end
                             
                    2'b01  : begin     
                                  mem[addr] <= RD2M[7:0];
                             end  
                  
                    2'b10  : begin
                                  mem[addr]     <= RD2M[7:0]; 
                                  mem[addr + 1] <= RD2M[15:8];             
                             end
                            
               endcase                         
            end    
    end
    
              
        
// initial begin
//  #100;
//    mem[4]  = 8'hAA;
//    mem[5]  = 8'hBB;
//    mem[6]  = 8'hCC;
//    mem[7]  = 8'hDD;
//    mem[8]  = 8'hEE;
//    mem[9]  = 8'hcc;
//    mem[10] = 8'h11;
//    mem[11] = 8'h22;
//    mem[12] = 8'h33;
//    mem[13] = 8'h44;
//    mem[14] = 8'h55;
//    mem[15] = 8'h66;
//    mem[16] = 8'h77;
//    mem[17] = 8'h88;
//    mem[18] = 8'h99;
//    mem[19] = 8'hAA;
//    mem[20] = 8'hBB;
//    mem[21] = 8'hCC;
//    mem[22] = 8'hDD;
//    mem[23] = 8'hEE;
//    mem[24] = 8'hFF;
//end

endmodule

