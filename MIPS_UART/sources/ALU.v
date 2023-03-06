module ALU #(parameter LENGTH = 5)(
input clk,
input [LENGTH-1:0] A,B,                  
input [2:0] ALU_Sel,
input [4:0] shamt,
output reg [LENGTH-1:0] ALU_Out
    );


//Cuales son las distintas operaciones que puede realizar la ALU	 
localparam AND					= 3'b000;
localparam OR					= 3'b001;
localparam ADD					= 3'b010;
localparam AND_2				= 3'b110;
localparam SHIFT_LEFT		= 3'b111;
//Que hara en cada operacion
    always @(posedge clk)
    begin
        case(ALU_Sel)
        AND:
           ALU_Out <= A & B;
        OR:
           ALU_Out <= A | B;
        ADD:
           ALU_Out <= A + B;
        AND_2:
           ALU_Out <= A & B;
        SHIFT_LEFT:
           ALU_Out <= B<<shamt;
        default: 
           ALU_Out <= A + B; 
        endcase
    end

endmodule