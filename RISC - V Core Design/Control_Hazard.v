module Control_Hazard
(
input  jump,
input  branch,
input  zero,
output flush
);
	
assign flush = (jump || (branch && zero)) ? 1'b1 :1'b0;	
		
endmodule


