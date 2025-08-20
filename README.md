# 5-Stage Pipelined RISC-V CPU Core

This project implements a minimal RISC-V RV32I 5-stage pipelined CPU in Verilog.  
The processor supports basic instructions, executes programs stored in instruction memory, and demonstrates correct pipeline operation using simulation.

## Repository Structure

All source code and outputs are inside the `Main/` folder:

- ALU.v  
- ALUDecoder.v  
- ControlUnitTop.v  
- DataMemory.v  
- DecodeCycle.v  
- dump.vcd (simulation waveform output)  
- ExecuteCycle.v  
- FetchCycle.v  
- HazardUnit.v  
- InstructionMemory.v  
- MainDecoder.v  
- memfile.hex (program memory initialization file)  
- MemoryCycle.v  
- MUX.v  
- out.vvp (compiled simulation output)  
- PCAdder.v  
- pipeline.gtkw (waveform configuration for GTKWave)  
- Pipeline_tb.v (testbench)  
- PipelineTop.v (top-level processor module)  
- ProgramCounter.v  
- RegisterFile.v  
- SignExtend.v  
- WritebackCycle.v  

## Features

- 5-stage pipelined CPU design: Fetch, Decode, Execute, Memory, Writeback.  
- Implements a subset of the RISC-V RV32I ISA: ADD, SUB, LW, SW, BEQ.  
- Hazard detection using `HazardUnit.v`.  
- ALU operations defined in `ALU.v` and decoded in `ALUDecoder.v`.  
- Data and instruction memories (`DataMemory.v`, `InstructionMemory.v`) with `memfile.hex`.  
- Top-level integration in `PipelineTop.v`.  
- Simulation testbench (`Pipeline_tb.v`) to verify functionality.  
- Waveform dumping (`dump.vcd`) and GTKWave config (`pipeline.gtkw`) for visualization.  

## Tools Used

- Icarus Verilog (iverilog) — for compiling and simulating.  
- GTKWave — for waveform viewing.  

## Running the Simulation

1. Navigate into the `Main/` folder:
   ```bash
   cd Main
2. Compile the CPU with Icarus Verilog:
  iverilog -o out.vvp Pipeline_tb.v 
3. Run the simulation:
  vvp out.vvp
4. View the waveform with GTKWave:
  gtkwave dump.vcd pipeline.gtkw

## Future Work

Add forwarding unit to reduce stalls.
Support for more RISC-V instructions and extensions.
Performance improvements with branch prediction.

License
This project is open-source and for educational purposes.
