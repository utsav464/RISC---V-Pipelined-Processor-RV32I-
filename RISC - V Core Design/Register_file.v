module Register_file #(parameter DATA_WIDTH = 32,
                                 REG_WIDTH  = 5)

(

input                    clk,
input                    rst,
input                    wE3,
input   [REG_WIDTH-1:0]  A1,
input   [REG_WIDTH-1:0]  A2,
input   [REG_WIDTH-1:0]  A3,
input   [DATA_WIDTH-1:0] wD3,
output  [DATA_WIDTH-1:0] RD1,
output  [DATA_WIDTH-1:0] RD2

);

reg [DATA_WIDTH-1:0]register [0:31];

integer i;

always@(posedge clk,negedge rst)
    begin
        if(~rst)
            begin
                for(i=0; i<32; i= i+1)
                    begin
                        register[i] <= 0;
                    end    
            end
         else if(wE3 && A3 != 5'd0)
            begin
                register[A3]<= wD3;
            end
   end             
                       
 
    
    
assign RD1 = register[A1];
assign RD2 = register[A2];
 
      

initial begin
//    register[0]  <= 32'd0;
//#101;
//      register[1]  = 32'd6;
//      register[2]  = 32'd5;
//    register[3]  <= 32'd4;
   
//    register[5]  <= 32'd7;
//    register[6]  <= 32'd5;

//    register[8]  <= 32'd12;
//    register[9]  <= 32'd3;
    
//    register[11] <= 32'd7;
//    register[12] <= 32'd2;

//    register[14] <= 32'd3;
//    register[15] <= 32'd1;

//    register[17] <= 32'd16;  // 👈 important
//    register[18] <= 32'd2;

//    register[20] <= 32'd32;
//    register[21] <= 32'd1;

//    register[23] <= 32'd5;
//    register[24] <= 32'd10;

//    register[26] <= 32'd8;
//    register[27] <= 32'd4;
end


endmodule
