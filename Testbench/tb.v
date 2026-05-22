module pipeline_tb();


    reg clk = 1'b0;
    reg rst;

    // Instantiate the single_cycle CPU
pipeline_top     DUT (
        .clk(clk),
        .rst(rst)
    );
    // Clock generation: 50ns half period → 100ns full period (10 MHz)
    always #50 clk = ~clk;

    // Reset sequence
    initial begin
        rst = 1'b0;      // Assert reset
        #100;
        rst = 1'b1;      // Deassert reset after 100ns
        
        #2000 $finish;
    end


endmodule
