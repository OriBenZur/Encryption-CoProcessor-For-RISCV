Set-Variable -name "c_file" -Value ".\queue_encryptor_tests\2c_enc_parallel_test.c"
riscv64-unknown-elf-gcc -Ttext=0 -march=rv32i -mabi=ilp32 -g $c_file -o test
riscv64-unknown-elf-objdump -d -S test > test.dump
riscv64-unknown-elf-gcc -Ttext=0 -march=rv32i -mabi=ilp32 $c_file -o test
riscv64-unknown-elf-objcopy -O verilog test test.hex  --verilog-data-width=4
riscv64-unknown-elf-objcopy -O binary .\test test.bin
.\srec_cat.exe .\test.bin -binary -byte_swap 4 -o test.mif -mif 32