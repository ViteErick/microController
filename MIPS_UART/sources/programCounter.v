module programCounter #(parameter LENGTH = 32)(
	input clock,reset,enable,
	input [LENGTH-1:0]D,
	output reg [LENGTH-1:0]Q
	);

initial 
	begin
		Q <= 32'h00000000;
	end
//To register program counter	
always @(posedge clock, posedge reset) 
	begin
		if(reset) 
            Q <= {LENGTH{1'b0}};
        else
			if(enable)
				Q <= D;
				else
					Q <= Q;
	end

endmodule