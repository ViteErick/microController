module MIPS_UART #(parameter LENGTH = 32)(
	input clock, reset,
	//UART_Rx
	input rx,
	output parity,
	output [8:0]Rx_SR,
	output heard_bit_out,
	output [6:0] HEX0,
	output [6:0] HEX2,
	output [6:0] HEX3,
	//UART_Tx
	output tx,
	output reg clock_out,
	output reg clock100MHz_out
);

wire UART_Done;
wire SendTx;
wire [7:0] Message;
wire clk_100M_w;
wire reset_w;
//PLL de 100MHz
PLL_100MHz PLL_ins (.refclk(clock), .rst(~reset), .outclk_0(clk_100M_w), .locked(locked) );
//Toda la logica del MIPS
MIPS #(.LENGTH(LENGTH)) MIPS_UUT(
    .clock(clk_100M_w),
    .reset(reset),
	 .UART_Done(UART_Done),
	 .SendTx(SendTx),
	 .Message(Message)
    );



//Logica de la UART	 
UART_TxRx UART(
    .clock(clk_100M_w),
    .reset(reset),
	 .rx(rx),
	 .parity(parity),
	 .Rx_SR(Rx_SR),
	 .heard_bit_out(heard_bit_out),
	 .HEX0(HEX0),
	 .HEX2(HEX2),
	 .HEX3(HEX3),
	 .sendTx(~SendTx),
	 .sw00(Message[0]),
	 .sw01(Message[1]),
	 .sw02(Message[2]),
	 .sw03(Message[3]),
	 .sw04(Message[4]),
	 .sw05(Message[5]),
	 .sw06(Message[6]),
	 .sw07(Message[7]),
	 .tx(tx),
	 .UART_Done(UART_Done)
    );
	 
endmodule