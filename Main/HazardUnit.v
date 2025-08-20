module hazard_unit(
    input rst,
    input RegWriteM, RegWriteW,  
    input [4:0] RD_M, RD_W, Rs1_E, Rs2_E,
    output reg [1:0] ForwardAE, ForwardBE  
);

// Forwarding logic with priority (MEM stage has higher priority than WB)
always @(*) begin
    if (rst) begin
        ForwardAE = 2'b00;
        ForwardBE = 2'b00;
    end
    else begin
        // ForwardAE logic
        if ((RegWriteM) && (RD_M != 5'b0) && (RD_M == Rs1_E)) begin
            ForwardAE = 2'b10;  // MEM stage forwarding highest priority
        end
        else if ((RegWriteW) && (RD_W != 5'b0) && (RD_W == Rs1_E)) begin
            ForwardAE = 2'b01;  // WB stage forwarding
        end
        else begin
            ForwardAE = 2'b00;  // No forwarding
        end

        // ForwardBE logic
        if ((RegWriteM) && (RD_M != 5'b0) && (RD_M == Rs2_E)) begin
            ForwardBE = 2'b10;  // MEM stage forwarding highest priority
        end
        else if ((RegWriteW) && (RD_W != 5'b0) && (RD_W == Rs2_E)) begin
            ForwardBE = 2'b01;  // WB stage forwarding
        end
        else begin
            ForwardBE = 2'b00;  // No forwarding
        end
    end
end

endmodule