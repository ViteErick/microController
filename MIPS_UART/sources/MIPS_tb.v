module MIPS_tb ();
reg clk, reset, UART_Done;

MIPS #(.LENGTH(32)) UUT(.clock(clk), .reset(reset), .UART_Done(UART_Done));

initial
	begin
		clk = 1'b0;
		reset = 1'b1;
		UART_Done = 1'b0;
		#1270 UART_Done = 1'b1;
		#100 UART_Done = 1'b0;
		#40 UART_Done = 1'b1;
		#100 UART_Done = 1'b0;
		#40 UART_Done = 1'b1;
		#100 UART_Done = 1'b0;
		#40 UART_Done = 1'b1;
		#100 UART_Done = 1'b0;
	end
	
always
	begin
	#10 clk = ~clk;
	end
	
endmodule
