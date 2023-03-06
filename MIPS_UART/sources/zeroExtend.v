module zeroExtend (
    input clock, reset, enable,
    input [15:0]extend, //what is going to extend
    output reg [31:0]extended //extended result
    );
    
always @(posedge clock, posedge reset) 
    begin
        if(reset)
            extended <= 32'b0;
        else
            if(enable)
				//Extend it to 32 bits without taking sign in account
                extended <= {{16{1'b0}},extend[15:0]};              
            else
                extended <= extended;
    end

endmodule