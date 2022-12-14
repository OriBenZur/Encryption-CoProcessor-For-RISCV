#! /bin/bash
riscv64-unknown-elf-gcc -Ttext=0 -march=rv32i -mabi=ilp32 test.c -o test
riscv64-unknown-elf-objdump -d test > test.dump
riscv64-unknown-elf-objcopy -O verilog test test.hex  --verilog-data-width=4