module MIPS_UART_TB #(parameter LENGTH = 32)();

reg clock, reset, rx;
wire parity;
wire [8:0]Rx_SR;
wire heard_bit_out;
wire [6:0] HEX0;
wire [6:0] HEX2;
wire [6:0] HEX3;
wire tx;

MIPS_UART #(.LENGTH(32)) UUT(.clock(clock), .reset(reset), .rx(rx), .parity(parity), .Rx_SR(Rx_SR), .heard_bit_out(heard_bit_out), .HEX0(HEX0), .HEX2(HEX2), .HEX3(HEX3), .tx(tx));

initial
	begin
		clock = 1'b0;
		reset = 1'b1;
		rx = 1'b1;
	end
	
always
	begin
	#10 clock = ~clock;
	end

endmodule