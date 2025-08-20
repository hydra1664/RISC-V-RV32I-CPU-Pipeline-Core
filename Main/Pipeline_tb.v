`timescale 1ns / 1ns

module tb;

    // Clock and reset signals
    reg clk = 0;
    reg rst;

    // Output signals from DUT
    wire IllegalOp;

    // Internal signals for monitoring PC and fetched instruction
    wire [31:0] current_pc;
    wire [31:0] current_instr;

    // Clock Generation
    always #5 clk = ~clk;

    // Device Under Test (DUT) instantiation
    Pipeline_top dut (
        .clk(clk),
        .rst(rst),
        .IllegalOp(IllegalOp)
    );

    // Hook internal signals for monitoring
    assign current_pc = dut.Fetch.PCD;
    assign current_instr = dut.Fetch.InstrD;

    // VCD Dump for waveform analysis
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);                      
        $dumpvars(1, clk, rst);                
        $dumpvars(1, current_pc, current_instr, IllegalOp);
        $dumpvars(1, dut);                     
        $dumpvars(1, dut.Fetch);               
        $dumpvars(1, dut.Fetch.IMEM);          
    end

    // Load instructions from hex file
    initial begin
        $display("[TB] Loading instructions from memfile.hex...");
        $readmemh("memfile.hex", dut.Fetch.IMEM.mem);
        $display("[TB] First few instructions:");
        $display("  IMEM[0] = %h", dut.Fetch.IMEM.mem[0]);
        $display("  IMEM[1] = %h", dut.Fetch.IMEM.mem[1]);
        $display("  IMEM[2] = %h", dut.Fetch.IMEM.mem[2]);
        $display("  IMEM[3] = %h", dut.Fetch.IMEM.mem[3]);
    end

    // Reset sequence
    initial begin
        rst = 1; 
        #20;
        rst = 0; 
        #20;
        rst = 1; 

    end

    // Simulation timeout and finish control
    initial begin
        #400;  
        $display("[TB] Simulation timeout reached.");
        $finish;
    end

    // Monitor pipeline progress
    initial begin
        $display("Time(ns) | Reset |    PC    |  Instruction  | IllegalOp");
        $monitor("%8t |   %b   | %08h | %08h |     %b",
                 $time, rst, current_pc, current_instr, IllegalOp);
    end

    // Trap on illegal opcode
    always @(posedge clk) begin
        if (IllegalOp) begin
            $display("[TB][ERROR] Illegal instruction at time %0t | PC = %08h",
                     $time, current_pc);
        end
    end
endmodule
