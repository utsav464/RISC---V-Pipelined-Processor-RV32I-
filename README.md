# 5-Stage Pipelined RISC-V CPU (RV32I)

## Overview
This project implements a 32-bit 5-stage pipelined RISC-V processor based on the RV32I instruction set architecture using Verilog HDL. The processor is designed with complete pipelining support, hazard handling, and instruction execution verification in Vivado.

The processor supports 37 RV32I base instructions and includes full datapath components such as ALU, Register File, Instruction Memory, Data Memory, Control Unit, Hazard Detection Unit, and Forwarding Unit.

---

## Features
- 32-bit RV32I RISC-V Processor
- 5-Stage Pipeline Architecture
  - Instruction Fetch (IF)
  - Instruction Decode (ID)
  - Execute (EX)
  - Memory Access (MEM)
  - Write Back (WB)
- Supports 37 RV32I Instructions
- Hazard Detection Unit
- Data Forwarding Unit
- Pipeline Flush for Control Hazards
- Separate Instruction and Data Memory
- Verilog RTL Design
- Verified using Testbench in Vivado

---

## Supported Instruction Types

### R-Type Instructions
- ADD
- SUB
- AND
- OR
- XOR
- SLL
- SRL
- SRA
- SLT
- SLTU

### I-Type Instructions
- ADDI
- ANDI
- ORI
- XORI
- SLTI
- SLTIU
- SLLI
- SRLI
- SRAI
- LW
- LH
- LB
- LHU
- LBU
- JALR

### S-Type Instructions
- SW
- SH
- SB

### B-Type Instructions
- BEQ
- BNE
- BLT
- BGE
- BLTU
- BGEU

### U-Type Instructions
- LUI
- AUIPC

### J-Type Instructions
- JAL

---

## Pipeline Architecture

```text
IF  ->  ID  ->  EX  ->  MEM  ->  WB
