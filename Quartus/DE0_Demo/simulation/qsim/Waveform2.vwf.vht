-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "09/15/2022 23:18:10"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          encryptor
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY encryptor_vhd_vec_tst IS
END encryptor_vhd_vec_tst;
ARCHITECTURE encryptor_arch OF encryptor_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL accel_select : STD_LOGIC;
SIGNAL addr : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL ctr : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL data_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rst_n : STD_LOGIC;
SIGNAL wr_en : STD_LOGIC;
COMPONENT encryptor
	PORT (
	accel_select : IN STD_LOGIC;
	addr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	clk : IN STD_LOGIC;
	ctr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	rst_n : IN STD_LOGIC;
	wr_en : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : encryptor
	PORT MAP (
-- list connections between master ports and signals
	accel_select => accel_select,
	addr => addr,
	clk => clk,
	ctr => ctr,
	data_in => data_in,
	data_out => data_out,
	rst_n => rst_n,
	wr_en => wr_en
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 2500 ps;
	clk <= '1';
	WAIT FOR 2500 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;

-- rst_n
t_prcs_rst_n: PROCESS
BEGIN
	rst_n <= '1';
	WAIT FOR 10000 ps;
	rst_n <= '0';
	WAIT FOR 10000 ps;
	rst_n <= '1';
WAIT;
END PROCESS t_prcs_rst_n;

-- accel_select
t_prcs_accel_select: PROCESS
BEGIN
	accel_select <= '0';
	WAIT FOR 30000 ps;
	accel_select <= '1';
	WAIT FOR 10000 ps;
	accel_select <= '0';
WAIT;
END PROCESS t_prcs_accel_select;
-- addr[31]
t_prcs_addr_31: PROCESS
BEGIN
	addr(31) <= '0';
WAIT;
END PROCESS t_prcs_addr_31;
-- addr[30]
t_prcs_addr_30: PROCESS
BEGIN
	addr(30) <= '0';
WAIT;
END PROCESS t_prcs_addr_30;
-- addr[29]
t_prcs_addr_29: PROCESS
BEGIN
	addr(29) <= '0';
WAIT;
END PROCESS t_prcs_addr_29;
-- addr[28]
t_prcs_addr_28: PROCESS
BEGIN
	addr(28) <= '0';
WAIT;
END PROCESS t_prcs_addr_28;
-- addr[27]
t_prcs_addr_27: PROCESS
BEGIN
	addr(27) <= '0';
WAIT;
END PROCESS t_prcs_addr_27;
-- addr[26]
t_prcs_addr_26: PROCESS
BEGIN
	addr(26) <= '0';
WAIT;
END PROCESS t_prcs_addr_26;
-- addr[25]
t_prcs_addr_25: PROCESS
BEGIN
	addr(25) <= '0';
WAIT;
END PROCESS t_prcs_addr_25;
-- addr[24]
t_prcs_addr_24: PROCESS
BEGIN
	addr(24) <= '0';
WAIT;
END PROCESS t_prcs_addr_24;
-- addr[23]
t_prcs_addr_23: PROCESS
BEGIN
	addr(23) <= '0';
WAIT;
END PROCESS t_prcs_addr_23;
-- addr[22]
t_prcs_addr_22: PROCESS
BEGIN
	addr(22) <= '0';
WAIT;
END PROCESS t_prcs_addr_22;
-- addr[21]
t_prcs_addr_21: PROCESS
BEGIN
	addr(21) <= '0';
WAIT;
END PROCESS t_prcs_addr_21;
-- addr[20]
t_prcs_addr_20: PROCESS
BEGIN
	addr(20) <= '0';
WAIT;
END PROCESS t_prcs_addr_20;
-- addr[19]
t_prcs_addr_19: PROCESS
BEGIN
	addr(19) <= '0';
WAIT;
END PROCESS t_prcs_addr_19;
-- addr[18]
t_prcs_addr_18: PROCESS
BEGIN
	addr(18) <= '0';
WAIT;
END PROCESS t_prcs_addr_18;
-- addr[17]
t_prcs_addr_17: PROCESS
BEGIN
	addr(17) <= '0';
WAIT;
END PROCESS t_prcs_addr_17;
-- addr[16]
t_prcs_addr_16: PROCESS
BEGIN
	addr(16) <= '0';
WAIT;
END PROCESS t_prcs_addr_16;
-- addr[15]
t_prcs_addr_15: PROCESS
BEGIN
	addr(15) <= '0';
WAIT;
END PROCESS t_prcs_addr_15;
-- addr[14]
t_prcs_addr_14: PROCESS
BEGIN
	addr(14) <= '0';
WAIT;
END PROCESS t_prcs_addr_14;
-- addr[13]
t_prcs_addr_13: PROCESS
BEGIN
	addr(13) <= '0';
WAIT;
END PROCESS t_prcs_addr_13;
-- addr[12]
t_prcs_addr_12: PROCESS
BEGIN
	addr(12) <= '0';
WAIT;
END PROCESS t_prcs_addr_12;
-- addr[11]
t_prcs_addr_11: PROCESS
BEGIN
	addr(11) <= '0';
WAIT;
END PROCESS t_prcs_addr_11;
-- addr[10]
t_prcs_addr_10: PROCESS
BEGIN
	addr(10) <= '0';
WAIT;
END PROCESS t_prcs_addr_10;
-- addr[9]
t_prcs_addr_9: PROCESS
BEGIN
	addr(9) <= '0';
WAIT;
END PROCESS t_prcs_addr_9;
-- addr[8]
t_prcs_addr_8: PROCESS
BEGIN
	addr(8) <= '0';
WAIT;
END PROCESS t_prcs_addr_8;
-- addr[7]
t_prcs_addr_7: PROCESS
BEGIN
	addr(7) <= '0';
WAIT;
END PROCESS t_prcs_addr_7;
-- addr[6]
t_prcs_addr_6: PROCESS
BEGIN
	addr(6) <= '0';
WAIT;
END PROCESS t_prcs_addr_6;
-- addr[5]
t_prcs_addr_5: PROCESS
BEGIN
	addr(5) <= '0';
	WAIT FOR 30000 ps;
	addr(5) <= '1';
	WAIT FOR 10000 ps;
	addr(5) <= '0';
WAIT;
END PROCESS t_prcs_addr_5;
-- addr[4]
t_prcs_addr_4: PROCESS
BEGIN
	addr(4) <= '0';
WAIT;
END PROCESS t_prcs_addr_4;
-- addr[3]
t_prcs_addr_3: PROCESS
BEGIN
	addr(3) <= '0';
WAIT;
END PROCESS t_prcs_addr_3;
-- addr[2]
t_prcs_addr_2: PROCESS
BEGIN
	addr(2) <= '0';
WAIT;
END PROCESS t_prcs_addr_2;
-- addr[1]
t_prcs_addr_1: PROCESS
BEGIN
	addr(1) <= '0';
WAIT;
END PROCESS t_prcs_addr_1;
-- addr[0]
t_prcs_addr_0: PROCESS
BEGIN
	addr(0) <= '0';
WAIT;
END PROCESS t_prcs_addr_0;

-- wr_en
t_prcs_wr_en: PROCESS
BEGIN
	wr_en <= '0';
	WAIT FOR 30000 ps;
	wr_en <= '1';
	WAIT FOR 10000 ps;
	wr_en <= '0';
WAIT;
END PROCESS t_prcs_wr_en;
-- data_in[31]
t_prcs_data_in_31: PROCESS
BEGIN
	data_in(31) <= '0';
WAIT;
END PROCESS t_prcs_data_in_31;
-- data_in[30]
t_prcs_data_in_30: PROCESS
BEGIN
	data_in(30) <= '0';
WAIT;
END PROCESS t_prcs_data_in_30;
-- data_in[29]
t_prcs_data_in_29: PROCESS
BEGIN
	data_in(29) <= '0';
WAIT;
END PROCESS t_prcs_data_in_29;
-- data_in[28]
t_prcs_data_in_28: PROCESS
BEGIN
	data_in(28) <= '0';
WAIT;
END PROCESS t_prcs_data_in_28;
-- data_in[27]
t_prcs_data_in_27: PROCESS
BEGIN
	data_in(27) <= '0';
WAIT;
END PROCESS t_prcs_data_in_27;
-- data_in[26]
t_prcs_data_in_26: PROCESS
BEGIN
	data_in(26) <= '0';
WAIT;
END PROCESS t_prcs_data_in_26;
-- data_in[25]
t_prcs_data_in_25: PROCESS
BEGIN
	data_in(25) <= '0';
WAIT;
END PROCESS t_prcs_data_in_25;
-- data_in[24]
t_prcs_data_in_24: PROCESS
BEGIN
	data_in(24) <= '0';
WAIT;
END PROCESS t_prcs_data_in_24;
-- data_in[23]
t_prcs_data_in_23: PROCESS
BEGIN
	data_in(23) <= '0';
WAIT;
END PROCESS t_prcs_data_in_23;
-- data_in[22]
t_prcs_data_in_22: PROCESS
BEGIN
	data_in(22) <= '0';
WAIT;
END PROCESS t_prcs_data_in_22;
-- data_in[21]
t_prcs_data_in_21: PROCESS
BEGIN
	data_in(21) <= '0';
WAIT;
END PROCESS t_prcs_data_in_21;
-- data_in[20]
t_prcs_data_in_20: PROCESS
BEGIN
	data_in(20) <= '0';
WAIT;
END PROCESS t_prcs_data_in_20;
-- data_in[19]
t_prcs_data_in_19: PROCESS
BEGIN
	data_in(19) <= '0';
WAIT;
END PROCESS t_prcs_data_in_19;
-- data_in[18]
t_prcs_data_in_18: PROCESS
BEGIN
	data_in(18) <= '0';
WAIT;
END PROCESS t_prcs_data_in_18;
-- data_in[17]
t_prcs_data_in_17: PROCESS
BEGIN
	data_in(17) <= '0';
WAIT;
END PROCESS t_prcs_data_in_17;
-- data_in[16]
t_prcs_data_in_16: PROCESS
BEGIN
	data_in(16) <= '0';
WAIT;
END PROCESS t_prcs_data_in_16;
-- data_in[15]
t_prcs_data_in_15: PROCESS
BEGIN
	data_in(15) <= '0';
WAIT;
END PROCESS t_prcs_data_in_15;
-- data_in[14]
t_prcs_data_in_14: PROCESS
BEGIN
	data_in(14) <= '0';
WAIT;
END PROCESS t_prcs_data_in_14;
-- data_in[13]
t_prcs_data_in_13: PROCESS
BEGIN
	data_in(13) <= '0';
WAIT;
END PROCESS t_prcs_data_in_13;
-- data_in[12]
t_prcs_data_in_12: PROCESS
BEGIN
	data_in(12) <= '0';
WAIT;
END PROCESS t_prcs_data_in_12;
-- data_in[11]
t_prcs_data_in_11: PROCESS
BEGIN
	data_in(11) <= '0';
WAIT;
END PROCESS t_prcs_data_in_11;
-- data_in[10]
t_prcs_data_in_10: PROCESS
BEGIN
	data_in(10) <= '0';
WAIT;
END PROCESS t_prcs_data_in_10;
-- data_in[9]
t_prcs_data_in_9: PROCESS
BEGIN
	data_in(9) <= '0';
WAIT;
END PROCESS t_prcs_data_in_9;
-- data_in[8]
t_prcs_data_in_8: PROCESS
BEGIN
	data_in(8) <= '0';
WAIT;
END PROCESS t_prcs_data_in_8;
-- data_in[7]
t_prcs_data_in_7: PROCESS
BEGIN
	data_in(7) <= '0';
WAIT;
END PROCESS t_prcs_data_in_7;
-- data_in[6]
t_prcs_data_in_6: PROCESS
BEGIN
	data_in(6) <= '0';
WAIT;
END PROCESS t_prcs_data_in_6;
-- data_in[5]
t_prcs_data_in_5: PROCESS
BEGIN
	data_in(5) <= '0';
WAIT;
END PROCESS t_prcs_data_in_5;
-- data_in[4]
t_prcs_data_in_4: PROCESS
BEGIN
	data_in(4) <= '0';
WAIT;
END PROCESS t_prcs_data_in_4;
-- data_in[3]
t_prcs_data_in_3: PROCESS
BEGIN
	data_in(3) <= '0';
WAIT;
END PROCESS t_prcs_data_in_3;
-- data_in[2]
t_prcs_data_in_2: PROCESS
BEGIN
	data_in(2) <= '0';
WAIT;
END PROCESS t_prcs_data_in_2;
-- data_in[1]
t_prcs_data_in_1: PROCESS
BEGIN
	data_in(1) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1;
-- data_in[0]
t_prcs_data_in_0: PROCESS
BEGIN
	data_in(0) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0;
END encryptor_arch;
