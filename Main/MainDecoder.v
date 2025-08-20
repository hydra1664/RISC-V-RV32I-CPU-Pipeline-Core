module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp,IllegalOp);
    input [6:0]Op;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc,ALUOp;
    output wire IllegalOp;

    // Legal RISC-V opcodes (RV32I base instruction set)
    wire is_load    = (Op == 7'b0000011);
    wire is_store   = (Op == 7'b0100011);
    wire is_branch  = (Op == 7'b1100011);
    wire is_jalr    = (Op == 7'b1100111);
    wire is_jal     = (Op == 7'b1101111);
    wire is_alui    = (Op == 7'b0010011);
    wire is_auipc   = (Op == 7'b0010111);
    wire is_lui     = (Op == 7'b0110111);
    wire is_rtype   = (Op == 7'b0110011);
    wire is_system  = (Op == 7'b1110011);

    // Illegal opcode detection
    assign IllegalOp = ~(is_load | is_store | is_branch | is_jalr | is_jal | 
                        is_alui | is_auipc | is_lui | is_rtype | is_system);

    // Control logic 
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 ) ? 1'b1 :
                                                              1'b0 ;
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
                    (Op == 7'b1100011) ? 2'b10 :    
                                         2'b00 ;
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 :
                                                            1'b0 ;
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
                                           1'b0 ;
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
                                            1'b0 ;
    assign Branch = (Op == 7'b1100011) ? 1'b1 :
                                         1'b0 ;
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
                   (Op == 7'b1100011) ? 2'b01 :
                                        2'b00 ;

endmodule