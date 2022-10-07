# AES Encryption unit + 2 RV32i Cores
## Introduction
  In this project, I've built an encryption Co-Processor and connected it to two RISC-V cores. The encryption unit is implemented in systemverilog with Quartue enviroment.
  The CoProcessor interfaces with the processor exclusively via MMIO, and the CoProcessor doesn't have access to the core's memory.
  Project goals:
  1. Build an encryption acceleration unit that support AES-128 encryption - _done!_
  2. Modify the encription unit such that it'll support servicing two processing cores - _done!_
  The project is currently not being maintained.

## Current State
  The Project is complete!

## Requirements
  1. This projects should be compiled and worked on in the "Quartus" enviroment. Quartus 21.1 is recommended, any later version and some later versions will probably work.
  2. RISCV toolchain is needed for compiling programs to run on the CPU


## Setup and Compilation
  To compile the project, open the file Quartus/DE0_Demo/DE0_top.qpf in Quartus and perform full compilation.
  To update the program loaded to the processor, go to Processing->Update Memory Initialization File and then run the Assembler and reload the sof to the FPGA.

## Processor Devices and Interfaces
  All the cores use MMIO to interface with the following devices: CoProcessor, LEDS, Seven-Segment display
  Reading and writing to those devices is done by writing to their appropriate memory address, and only core0 can write to the LEDs and Seven-Segment display

Device/Register | Address
--- | --- 
LEDs | [0x10,0x13]
7-Seg Dispaly | [0x14,0x17]
Core Index (0/1) | [0x20,0x23]
CoProcessor | [0x24,0x5F]
CoProcessor::Control Register | [0x24,0x27]
CoProcessor::Performance Counter | [0x28,0x2B]
CoProcessor::Key | [0x2C,0x3B]
CoProcessor::Plaintext | [0x3C,0x4B]
CoProcessor::Cyphertext | [0x4C,0x5B]
CoProcessor::Lock | [0x5C,0x5F]

### CoProcessor Interface
  To use the CoProcessor, one need to first acquire it's lock. To acquire the lock, the core needs to write the value 0x1 to the lock's address.
  To check if the core acquired the lock, compare the value in the lock's address and the core index. If they are equal then the core acquired the lock.
  While a core has the lock, the other can't write to the CoProcessor, and reading from it will return 0.

  Once the lock is acquired, the accelerator can be used.
  Values need to be written to the key and plaintext fields, and it's then activated by writing 1 to the ControlRegister.
  The Coprocessor finished when ControlRegister == 0x80000000.

### The Core
  The RISC-V cores that power this project is a simple RV32i single-cycle core.
  To avoid memory conflicts, at reset, core0's RSP is set to 0 while core1's RSP is set to 512.
  The cores are powered by a 1Mhz clock.


### Memory
  The design currently has 2KB of data memory and 8KB of program memory (notice the two different address spaces). Both memories are true dual-port

  The mif file Quartus/DE0_Demo/test.mif is loaded to the program memory and is then run by the processor.

  Because the core only supports register-based memory and doesn't support RAM (it appears it once did, but it no longer), the memory moduels use a 10Mhz clock. 

### Lock
  The system has one lock which also serves as a mux to the CoProcessor.

### CoProcessor
  The AES encryption unit uses look-up tables to implement AES efficiently, and only supports encryption (not decryption).


## Expanding The Project
  Feel free to expand the project further. Some things that can be done:
  1. Using a more advanced core (with memory support/pipelined/...)
  2. Adding decryption functionality to the CoProcessor
  3. Making a more efficient/better interface between the CoProcessor and the cores.

### Debugging
  I've found debugging very difficult when using Quartus Prime Lite, so the top level object has the ability to display information from the CPU on the 7Seg display.
  The values of switches[2:9] dictates what information will be displayed on the display. Switch[9] dictates which core will feed the display. Simplified chart that details the rest of the mechasim is below.
  

Information | Switches[2:8]
--- | --- 
addr_mem_prog | 0x1
val_mem_data_write | 0x2
val_mem_prog | 0x3
addr_mem_data | 0x4
val_mem_data_read | 0x5
CoProcessor::Performance Counter | default


<!--
## OLD README

 [![Build Status](https://travis-ci.com/4a1c0/RV32i-Verilog.svg?branch=master)](https://travis-ci.com/4a1c0/RV32i-Verilog)

The Repository is organized as follows:
  * [Documentation](Documentation) (Documentation About this project): this directory contains the [Bachelor's Thesis](Documentation/TFG_GEI_Informe.pdf) and [Poster](Documentation/Poster_RISCV.pdf).
  * [Quartus](Quartus) (FPGA Implementation with Quartus software): this directory contains the projects that implement the core in an FPGA.
  * [Data](data): this directory contains memory initializations for the simulations.
  * [Diagrams](diagrams): this directory contains several diagrams of the architecture.
  * [pulp](pulp) (PULPino RamMux): this directory contains the implemntation for the memory acces of the [PULPino platform](https://github.com/pulp-platform/pulpino).
  * [riscv-gnu-toolchain](riscv-gnu-toolchain): this directory contains the files necessary to complie C programs into RISC-V RV32I code.
  * [src](src): this directory contains the source code of the core in Verilog.
  * [tb](tb): this directory contains the Verilog Testbenchs.
  * [vcd](vcd): this directory contains Vcd dumps to analyze the core internal signals.
  
 En aquest directori trobem:
   * [.vscode](.vscode): configuracions del Visual Studio Code generats automàticament.
   * [.travis.yml](.travis.yml): especifica quin fluxe ha de segir el sistema d'integració contínua per a aixecar un entorn on poder passar els tests i indcar en el build stattus si s'han passat correctament els tests. 
   * [Dockerfile](Dockerfile): defineix una imatge que inclou el disseny del nucli i l'entorn amb icarus verilog per a poder executar els tests.
   * [compile_and_run.sh](compile_and_run.sh): script escrit en bash que permet passar els tests en local o en un entorn on icarus verilog estigui disponible. -->
