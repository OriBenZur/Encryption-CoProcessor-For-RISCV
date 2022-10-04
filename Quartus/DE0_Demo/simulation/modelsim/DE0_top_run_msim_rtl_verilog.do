transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Project\ Mendelson/AES-128-for-RISCV-CPU/src/Encryptor {C:/Project Mendelson/AES-128-for-RISCV-CPU/src/Encryptor/encryptor.sv}

