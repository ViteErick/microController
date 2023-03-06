module controlUnit (
    input clk, rst, UART_Done,
    input [5:0]opCode,
    //Multiplexer Selects
	 output reg SendTx,
    output reg MemtoReg,
    output reg RegDst,
    output reg IorD,
    output reg PCSrc,
    output reg [1:0] ALUSrcB,
    output reg ALUSrcA,
    //Register Enables
    output reg IRWrite,
    output reg MemWrite,
    output reg PCWrite,
    output reg RegWrite,
	 output reg TxRegWrite,
    //To ALU Decoder
    input [5:0] funct,
    // input [1:0]ALUOp,               //??
    output reg [2:0]ALUControl
    //output reg [1:0] ALUOp          //??
    );

reg [1:0]ALUOp;

reg [3:0] state;

localparam S0_FETCH    = 4'b0000;
localparam S1_DECODE   = 4'b0001;
localparam S2_MEM_ADDR = 4'b0010;
localparam S3_MEM_READ = 4'b0011;
localparam S4_MEM_WRITE_BACK = 4'b0100;
localparam S5_MEM_WRITE      = 4'b0101;
localparam S6_EXECUTE        = 4'b0110;
localparam S7_ALU_WRITE_BACK = 4'b0111;
localparam S9_ADDI_EXECUTE     = 4'b1001;
localparam S10_ADDI_WRITE_BACK = 4'b1010;
localparam S11_ANDI_EXECUTE	 = 4'b1011;
localparam S12_ANDI_WRITE_BACK = 4'b1100;
localparam S13_POUT_MEM_ADDR = 4'b1101;
localparam S14_POUT_MEM_WRITE_BACK_RXSEND = 4'b1110;
localparam S15_POUT_MEM_READ = 4'b1111;

//ALU Decoder
localparam ADD_FN  = 6'b10_0000;
localparam SUB_FN  = 6'b10_0010;
localparam AND_FN  = 6'b10_0100;
localparam OR_FN   = 6'b10_0101;
localparam SLL_FN  = 6'b00_0000;
reg [2:0] ALUFunctions_o;

localparam LW = 6'h23;
localparam SW = 6'h2b;
localparam R_Type = 6'h00;
localparam POUT = 6'h31;
localparam ADDI_INS = 6'h08;
localparam ANDI_INS = 6'h0C;

//FSM for the control unit
always @(posedge rst, posedge clk)
	begin
		if (rst) 
			state <= S0_FETCH;
		else 
		case (state)
            S0_FETCH:
                state <= S1_DECODE;
            S1_DECODE:
                if(opCode == LW | opCode == SW | opCode == POUT)       //Pseudocode if(opCode == LW or SW) 
                    state <= S2_MEM_ADDR;
                else
                    if(opCode == R_Type)    //Pseudocode 
                        state <= S6_EXECUTE;
                    else if(opCode == ADDI_INS)
                        state <= S9_ADDI_EXECUTE;
                    else
                        if(opCode == ANDI_INS)
                        state <= S11_ANDI_EXECUTE;
            S2_MEM_ADDR:
                if(opCode == LW)            //Pseudocode 
                    state <= S3_MEM_READ;
                else
                    if(opCode == SW | (opCode == POUT  & UART_Done == 1'b1))        //Pseudocode 
                        state <= S5_MEM_WRITE;
            S3_MEM_READ:
                state <= S4_MEM_WRITE_BACK;
            S4_MEM_WRITE_BACK:
                state <= S0_FETCH;
            S5_MEM_WRITE:
					if (opCode == POUT)
                state <= S13_POUT_MEM_ADDR;
					else
                state <= S0_FETCH;
            S6_EXECUTE:
                state <= S7_ALU_WRITE_BACK;
            S7_ALU_WRITE_BACK:
                state <= S0_FETCH;
            S9_ADDI_EXECUTE:
                state <= S10_ADDI_WRITE_BACK;
            S10_ADDI_WRITE_BACK:
                state <= S0_FETCH;
            S11_ANDI_EXECUTE:
                state <= S12_ANDI_WRITE_BACK;
            S12_ANDI_WRITE_BACK:
                state <= S0_FETCH;
				S13_POUT_MEM_ADDR:
                state <= S15_POUT_MEM_READ;
				S14_POUT_MEM_WRITE_BACK_RXSEND:
                state <= S0_FETCH;
				S15_POUT_MEM_READ:
					 state <= S14_POUT_MEM_WRITE_BACK_RXSEND;
            default:
                state <= S0_FETCH;
		endcase
	end

	//What is going to do at each state
always @(state)
	begin
        case(state)
				S0_FETCH: 	
					begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;     //Appear as X
                        RegDst      = 1'b0;     //Appear as X
                        IorD        = 1'b0;     //change 0
                        PCSrc       = 1'b0;     //change 0
                        ALUSrcB     = 2'b01;    //change 01
                        ALUSrcA     = 1'b0;     //change 0
                        //Register Enables
                        IRWrite     = 1'b1;     //change 1
                        MemWrite    = 1'b0;
                        PCWrite     = 1'b1;     //change 1
                        RegWrite    = 1'b0;
                        //To ALU Decoder
                        ALUOp       = 2'b00;    //change 00
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S1_DECODE:          //this State change btw documents VERIFY IT
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;     //Appear as X
                        RegDst      = 1'b0;     //Appear as X
                        IorD        = 1'b0;     //change 0
                        PCSrc       = 1'b0;     //change 0
                        ALUSrcB     = 2'b01;    //change 01
                        ALUSrcA     = 1'b0;     //change 0
                        //Register Enables
                        IRWrite     = 1'b0;     //change 1
                        MemWrite    = 1'b0;
                        PCWrite     = 1'b1;     //change 1
                        RegWrite    = 1'b0;
                        //To ALU Decoder
                        ALUOp       = 2'b00;    //change 00
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S2_MEM_ADDR: //Data flow during memory address computation
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //X
                        RegDst      = 1'b0;      //X
                        IorD        = 1'b0;      //X
                        PCSrc       = 1'b0;      //X
                        ALUSrcB     = 2'b10;     //10
                        ALUSrcA     = 1'b1;      //1
                        //Register Enables
                        IRWrite     = 1'b0;      //0
                        MemWrite    = 1'b0;      //0
                        PCWrite     = 1'b0;      //0
                        RegWrite    = 1'b0;      //0
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //00
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S3_MEM_READ:
                    begin  
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b1;      //1
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S4_MEM_WRITE_BACK:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b1;      //1
                        RegDst      = 1'b0;      //0
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b1;      //1
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S5_MEM_WRITE:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b1;      //1
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b1;      //1
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S6_EXECUTE:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //00
                        ALUSrcA     = 1'b1;      //1
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b10;     //10
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S7_ALU_WRITE_BACK:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //0
                        RegDst      = 1'b1;      //1
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b1;      //
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S9_ADDI_EXECUTE:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b10;     //10
                        ALUSrcA     = 1'b1;      //1
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //0
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S10_ADDI_WRITE_BACK:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //0
                        RegDst      = 1'b0;      //0
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b1;      //1
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
							end
                S11_ANDI_EXECUTE:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b11;     //Toma el zeroExtend_w
                        ALUSrcA     = 1'b1;      //1
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b01;     //10 para tomar AND
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
                S12_ANDI_WRITE_BACK:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //0
                        RegDst      = 1'b0;      //0
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b1;      //1
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
							end
                S13_POUT_MEM_ADDR: //Data flow during memory address computation
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //X
                        RegDst      = 1'b0;      //X
                        IorD        = 1'b0;      //X
                        PCSrc       = 1'b0;      //X
                        ALUSrcB     = 2'b10;     //10
                        ALUSrcA     = 1'b1;      //1
                        //Register Enables
                        IRWrite     = 1'b0;      //0
                        MemWrite    = 1'b0;      //0
                        PCWrite     = 1'b0;      //0
                        RegWrite    = 1'b0;      //0
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //00
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
							end
                S14_POUT_MEM_WRITE_BACK_RXSEND:
                    begin
                        //Multiplexer Selects
                        MemtoReg    = 1'b1;      //1
                        RegDst      = 1'b0;      //0
                        IorD        = 1'b0;      //
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b1;      //1
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b1;		//For UART
								TxRegWrite 	= 1'b0;		//To register Tx to UART
                    end
					S15_POUT_MEM_READ:
                    begin  
                        //Multiplexer Selects
                        MemtoReg    = 1'b0;      //
                        RegDst      = 1'b0;      //
                        IorD        = 1'b1;      //1
                        PCSrc       = 1'b0;      //
                        ALUSrcB     = 2'b00;     //
                        ALUSrcA     = 1'b0;      //
                        //Register Enables
                        IRWrite     = 1'b0;      //
                        MemWrite    = 1'b0;      //
                        PCWrite     = 1'b0;      //
                        RegWrite    = 1'b0;      //
                        //To ALU Decoder
                        ALUOp       = 2'b00;     //
								SendTx      = 1'b0;		//For UART
								TxRegWrite 	= 1'b1;		//To register Tx to UART
							end
        endcase
    end

// *** ALU Decoder ***

always @(funct) 
    begin
        if(rst)
            ALUFunctions_o <= 3'b000;       
        else
            case (funct)
                ADD_FN:
                    ALUFunctions_o <= 3'b010;
                SUB_FN:
                    ALUFunctions_o <= 3'b110;
                AND_FN:
                    ALUFunctions_o <= 3'b000;
                OR_FN:
                    ALUFunctions_o <= 3'b001;
                SLL_FN:
                    ALUFunctions_o <= 3'b111;
                default: 
                    ALUFunctions_o <= 3'b010;
            endcase
    end

always @(ALUOp) 
    begin
        case (ALUOp)
            2'b00:
                ALUControl <= 3'b010;
            2'b01:
                ALUControl <= 3'b110;
            2'b10:
                ALUControl <= ALUFunctions_o;
            2'b11:
                ALUControl <= ALUFunctions_o;
        endcase
    end
    
endmodule