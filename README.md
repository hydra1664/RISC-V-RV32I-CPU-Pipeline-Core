# 5-Stage Pipelined RISC-V CPU Core

## Overview
This project implements a minimal 5-stage pipelined RISC-V CPU core (RV32I) using Verilog. The processor supports basic arithmetic, memory, and branch instructions, and is simulated using Icarus Verilog with waveforms analyzed in GTKWave. The design demonstrates core concepts of pipelined CPU architecture, including instruction flow and hazard handling.

## Task Objective
Design and simulate a minimal RISC-V RV32I CPU core using Verilog/VHDL, ensuring correct pipeline operation.

## Features
- 5 pipeline stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), Write Back (WB)
- Instruction set support: ADD, SUB, LW, SW, BEQ
- Waveform simulation using Icarus Verilog and GTKWave
- Validation with a sample assembly program (Fibonacci sequence)
- Discussion of hazards and mitigation techniques

## Pipeline Stages
1. Instruction Fetch (IF): Fetches the instruction from instruction memory using the Program Counter (PC).
2. Instruction Decode (ID): Decodes the instruction, reads registers, and prepares control signals.
3. Execute (EX): Performs arithmetic/logic operations or calculates memory addresses.
4. Memory (MEM): Handles load and store instructions.
5. Write Back (WB): Writes results back to the register file.

## Hazards and Mitigation
- Data Hazards: Managed using forwarding (where applicable).
- Control Hazards: Simple stalling or pipeline flushing for branches.
- Structural Hazards: Not present in this minimal design.

## Tools Used
- Icarus Verilog for simulation
- GTKWave for waveform visualization
- EDA Playground for online testing

## Deliverables
- Verilog source code for the CPU core
- Testbench and assembly program (Fibonacci sequence)
- Simulation waveforms (VCD files)
- Report explaining hazards and design details

## Repository Structure
├── src/ # Verilog source files
├── testbench/ # Testbench and assembly program
├── waveforms/ # Simulation output and GTKWave files
├── report/ # Documentation and hazard explanation
└── README.md # Project overview
