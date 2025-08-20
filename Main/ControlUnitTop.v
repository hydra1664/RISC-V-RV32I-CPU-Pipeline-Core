`include "ALUDecoder.v"
`include "MainDecoder.v"

module Control_Unit_Top(
    input [6:0] Op, funct7,
    input [2:0] funct3,
    output wire RegWrite, ALUSrc, MemWrite, ResultSrc, Branch,
    output [1:0] ImmSrc,
    output [2:0] ALUControl,
    output wire IllegalOp  
);

    wire [1:0] ALUOp;
    wire MainDecoder_Illegal;

    // Initiating Modules
    //Main Decoder
    Main_Decoder Main_Decoder(
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .IllegalOp(MainDecoder_Illegal)  
    );

    //ALU decoder
    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

    assign IllegalOp = MainDecoder_Illegal || checkALUIllegal(ALUOp, funct3, funct7);

    // Function to check for illegal ALU operations
    function checkALUIllegal;
        input [1:0] ALUOp;
        input [2:0] funct3;
        input [6:0] funct7;
        begin
            case (ALUOp)
                2'b00: checkALUIllegal = 1'b0;  
                2'b01: checkALUIllegal = 1'b0;  
                2'b10: begin  
                    case (funct3)
                        3'b000: checkALUIllegal = (funct7 != 7'b0000000 && funct7 != 7'b0100000) ? 1'b1 : 1'b0;
                        3'b001, 3'b101: checkALUIllegal = (funct7 != 7'b0000000) ? 1'b1 : 1'b0;
                        3'b010, 3'b011, 3'b100, 3'b110, 3'b111: checkALUIllegal = 1'b0;
                        default: checkALUIllegal = 1'b1;
                    endcase
                end
                default: checkALUIllegal = 1'b0;
            endcase
        end
    endfunction

endmodule