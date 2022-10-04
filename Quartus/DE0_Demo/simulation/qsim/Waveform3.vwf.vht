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
-- Generated on "09/28/2022 17:16:41"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          lock
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

PACKAGE lock_data_type IS 
TYPE addr_in_31_0_type IS ARRAY (31 DOWNTO 0) OF STD_LOGIC;
TYPE addr_in_31_0_0_1_type IS ARRAY (0 TO 1) OF addr_in_31_0_type;
SUBTYPE addr_in_type IS addr_in_31_0_0_1_type;
TYPE data_in_31_0_type IS ARRAY (31 DOWNTO 0) OF STD_LOGIC;
TYPE data_in_31_0_0_1_type IS ARRAY (0 TO 1) OF data_in_31_0_type;
SUBTYPE data_in_type IS data_in_31_0_0_1_type;
TYPE data_out_31_0_type IS ARRAY (31 DOWNTO 0) OF STD_LOGIC;
TYPE data_out_31_0_0_1_type IS ARRAY (0 TO 1) OF data_out_31_0_type;
SUBTYPE data_out_type IS data_out_31_0_0_1_type;
END lock_data_type;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

library work;
use work.lock_data_type.all;

ENTITY lock_vhd_vec_tst IS
END lock_vhd_vec_tst;
ARCHITECTURE lock_arch OF lock_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL accel_select_o : STD_LOGIC;
SIGNAL addr_in : addr_in_type;
SIGNAL addr_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data_accel_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL data_in : data_in_type;
SIGNAL data_out : data_out_type;
SIGNAL rst_n : STD_LOGIC;
SIGNAL select_in : STD_LOGIC_VECTOR(0 TO 1);
SIGNAL wr_en_in : STD_LOGIC_VECTOR(0 TO 1);
SIGNAL wr_en_o : STD_LOGIC;
COMPONENT lock
	PORT (
	accel_select_o : OUT STD_LOGIC;
	addr_in : IN addr_in_type;
	addr_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	clk : IN STD_LOGIC;
	data_accel_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	data_in : IN data_in_type;
	data_out : OUT data_out_type;
	rst_n : IN STD_LOGIC;
	select_in : IN STD_LOGIC_VECTOR(0 TO 1);
	wr_en_in : IN STD_LOGIC_VECTOR(0 TO 1);
	wr_en_o : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : lock
	PORT MAP (
-- list connections between master ports and signals
	accel_select_o => accel_select_o,
	addr_in => addr_in,
	addr_o => addr_o,
	clk => clk,
	data_accel_in => data_accel_in,
	data_in => data_in,
	data_out => data_out,
	rst_n => rst_n,
	select_in => select_in,
	wr_en_in => wr_en_in,
	wr_en_o => wr_en_o
	);

-- addr_in[0][31]
t_prcs_addr_in_0_31: PROCESS
BEGIN
	addr_in(0)(31) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_31;

-- addr_in[0][30]
t_prcs_addr_in_0_30: PROCESS
BEGIN
	addr_in(0)(30) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_30;

-- addr_in[0][29]
t_prcs_addr_in_0_29: PROCESS
BEGIN
	addr_in(0)(29) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_29;

-- addr_in[0][28]
t_prcs_addr_in_0_28: PROCESS
BEGIN
	addr_in(0)(28) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_28;

-- addr_in[0][27]
t_prcs_addr_in_0_27: PROCESS
BEGIN
	addr_in(0)(27) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_27;

-- addr_in[0][26]
t_prcs_addr_in_0_26: PROCESS
BEGIN
	addr_in(0)(26) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_26;

-- addr_in[0][25]
t_prcs_addr_in_0_25: PROCESS
BEGIN
	addr_in(0)(25) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_25;

-- addr_in[0][24]
t_prcs_addr_in_0_24: PROCESS
BEGIN
	addr_in(0)(24) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_24;

-- addr_in[0][23]
t_prcs_addr_in_0_23: PROCESS
BEGIN
	addr_in(0)(23) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_23;

-- addr_in[0][22]
t_prcs_addr_in_0_22: PROCESS
BEGIN
	addr_in(0)(22) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_22;

-- addr_in[0][21]
t_prcs_addr_in_0_21: PROCESS
BEGIN
	addr_in(0)(21) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_21;

-- addr_in[0][20]
t_prcs_addr_in_0_20: PROCESS
BEGIN
	addr_in(0)(20) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_20;

-- addr_in[0][19]
t_prcs_addr_in_0_19: PROCESS
BEGIN
	addr_in(0)(19) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_19;

-- addr_in[0][18]
t_prcs_addr_in_0_18: PROCESS
BEGIN
	addr_in(0)(18) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_18;

-- addr_in[0][17]
t_prcs_addr_in_0_17: PROCESS
BEGIN
	addr_in(0)(17) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_17;

-- addr_in[0][16]
t_prcs_addr_in_0_16: PROCESS
BEGIN
	addr_in(0)(16) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_16;

-- addr_in[0][15]
t_prcs_addr_in_0_15: PROCESS
BEGIN
	addr_in(0)(15) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_15;

-- addr_in[0][14]
t_prcs_addr_in_0_14: PROCESS
BEGIN
	addr_in(0)(14) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_14;

-- addr_in[0][13]
t_prcs_addr_in_0_13: PROCESS
BEGIN
	addr_in(0)(13) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_13;

-- addr_in[0][12]
t_prcs_addr_in_0_12: PROCESS
BEGIN
	addr_in(0)(12) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_12;

-- addr_in[0][11]
t_prcs_addr_in_0_11: PROCESS
BEGIN
	addr_in(0)(11) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_11;

-- addr_in[0][10]
t_prcs_addr_in_0_10: PROCESS
BEGIN
	addr_in(0)(10) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_10;

-- addr_in[0][9]
t_prcs_addr_in_0_9: PROCESS
BEGIN
	addr_in(0)(9) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_9;

-- addr_in[0][8]
t_prcs_addr_in_0_8: PROCESS
BEGIN
	addr_in(0)(8) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_8;

-- addr_in[0][7]
t_prcs_addr_in_0_7: PROCESS
BEGIN
	addr_in(0)(7) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_7;

-- addr_in[0][6]
t_prcs_addr_in_0_6: PROCESS
BEGIN
	addr_in(0)(6) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_6;

-- addr_in[0][5]
t_prcs_addr_in_0_5: PROCESS
BEGIN
	addr_in(0)(5) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_5;

-- addr_in[0][4]
t_prcs_addr_in_0_4: PROCESS
BEGIN
	addr_in(0)(4) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_4;

-- addr_in[0][3]
t_prcs_addr_in_0_3: PROCESS
BEGIN
	addr_in(0)(3) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_3;

-- addr_in[0][2]
t_prcs_addr_in_0_2: PROCESS
BEGIN
	addr_in(0)(2) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_2;

-- addr_in[0][1]
t_prcs_addr_in_0_1: PROCESS
BEGIN
	addr_in(0)(1) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_1;

-- addr_in[0][0]
t_prcs_addr_in_0_0: PROCESS
BEGIN
	addr_in(0)(0) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_0_0;

-- addr_in[1][31]
t_prcs_addr_in_1_31: PROCESS
BEGIN
	addr_in(1)(31) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_31;

-- addr_in[1][30]
t_prcs_addr_in_1_30: PROCESS
BEGIN
	addr_in(1)(30) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_30;

-- addr_in[1][29]
t_prcs_addr_in_1_29: PROCESS
BEGIN
	addr_in(1)(29) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_29;

-- addr_in[1][28]
t_prcs_addr_in_1_28: PROCESS
BEGIN
	addr_in(1)(28) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_28;

-- addr_in[1][27]
t_prcs_addr_in_1_27: PROCESS
BEGIN
	addr_in(1)(27) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_27;

-- addr_in[1][26]
t_prcs_addr_in_1_26: PROCESS
BEGIN
	addr_in(1)(26) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_26;

-- addr_in[1][25]
t_prcs_addr_in_1_25: PROCESS
BEGIN
	addr_in(1)(25) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_25;

-- addr_in[1][24]
t_prcs_addr_in_1_24: PROCESS
BEGIN
	addr_in(1)(24) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_24;

-- addr_in[1][23]
t_prcs_addr_in_1_23: PROCESS
BEGIN
	addr_in(1)(23) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_23;

-- addr_in[1][22]
t_prcs_addr_in_1_22: PROCESS
BEGIN
	addr_in(1)(22) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_22;

-- addr_in[1][21]
t_prcs_addr_in_1_21: PROCESS
BEGIN
	addr_in(1)(21) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_21;

-- addr_in[1][20]
t_prcs_addr_in_1_20: PROCESS
BEGIN
	addr_in(1)(20) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_20;

-- addr_in[1][19]
t_prcs_addr_in_1_19: PROCESS
BEGIN
	addr_in(1)(19) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_19;

-- addr_in[1][18]
t_prcs_addr_in_1_18: PROCESS
BEGIN
	addr_in(1)(18) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_18;

-- addr_in[1][17]
t_prcs_addr_in_1_17: PROCESS
BEGIN
	addr_in(1)(17) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_17;

-- addr_in[1][16]
t_prcs_addr_in_1_16: PROCESS
BEGIN
	addr_in(1)(16) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_16;

-- addr_in[1][15]
t_prcs_addr_in_1_15: PROCESS
BEGIN
	addr_in(1)(15) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_15;

-- addr_in[1][14]
t_prcs_addr_in_1_14: PROCESS
BEGIN
	addr_in(1)(14) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_14;

-- addr_in[1][13]
t_prcs_addr_in_1_13: PROCESS
BEGIN
	addr_in(1)(13) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_13;

-- addr_in[1][12]
t_prcs_addr_in_1_12: PROCESS
BEGIN
	addr_in(1)(12) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_12;

-- addr_in[1][11]
t_prcs_addr_in_1_11: PROCESS
BEGIN
	addr_in(1)(11) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_11;

-- addr_in[1][10]
t_prcs_addr_in_1_10: PROCESS
BEGIN
	addr_in(1)(10) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_10;

-- addr_in[1][9]
t_prcs_addr_in_1_9: PROCESS
BEGIN
	addr_in(1)(9) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_9;

-- addr_in[1][8]
t_prcs_addr_in_1_8: PROCESS
BEGIN
	addr_in(1)(8) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_8;

-- addr_in[1][7]
t_prcs_addr_in_1_7: PROCESS
BEGIN
	addr_in(1)(7) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_7;

-- addr_in[1][6]
t_prcs_addr_in_1_6: PROCESS
BEGIN
	addr_in(1)(6) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_6;

-- addr_in[1][5]
t_prcs_addr_in_1_5: PROCESS
BEGIN
	addr_in(1)(5) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_5;

-- addr_in[1][4]
t_prcs_addr_in_1_4: PROCESS
BEGIN
	addr_in(1)(4) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_4;

-- addr_in[1][3]
t_prcs_addr_in_1_3: PROCESS
BEGIN
	addr_in(1)(3) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_3;

-- addr_in[1][2]
t_prcs_addr_in_1_2: PROCESS
BEGIN
	addr_in(1)(2) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_2;

-- addr_in[1][1]
t_prcs_addr_in_1_1: PROCESS
BEGIN
	addr_in(1)(1) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_1;

-- addr_in[1][0]
t_prcs_addr_in_1_0: PROCESS
BEGIN
	addr_in(1)(0) <= '0';
WAIT;
END PROCESS t_prcs_addr_in_1_0;

-- clk
t_prcs_clk: PROCESS
BEGIN
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;
-- data_accel_in[31]
t_prcs_data_accel_in_31: PROCESS
BEGIN
	data_accel_in(31) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_31;
-- data_accel_in[30]
t_prcs_data_accel_in_30: PROCESS
BEGIN
	data_accel_in(30) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_30;
-- data_accel_in[29]
t_prcs_data_accel_in_29: PROCESS
BEGIN
	data_accel_in(29) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_29;
-- data_accel_in[28]
t_prcs_data_accel_in_28: PROCESS
BEGIN
	data_accel_in(28) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_28;
-- data_accel_in[27]
t_prcs_data_accel_in_27: PROCESS
BEGIN
	data_accel_in(27) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_27;
-- data_accel_in[26]
t_prcs_data_accel_in_26: PROCESS
BEGIN
	data_accel_in(26) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_26;
-- data_accel_in[25]
t_prcs_data_accel_in_25: PROCESS
BEGIN
	data_accel_in(25) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_25;
-- data_accel_in[24]
t_prcs_data_accel_in_24: PROCESS
BEGIN
	data_accel_in(24) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_24;
-- data_accel_in[23]
t_prcs_data_accel_in_23: PROCESS
BEGIN
	data_accel_in(23) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_23;
-- data_accel_in[22]
t_prcs_data_accel_in_22: PROCESS
BEGIN
	data_accel_in(22) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_22;
-- data_accel_in[21]
t_prcs_data_accel_in_21: PROCESS
BEGIN
	data_accel_in(21) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_21;
-- data_accel_in[20]
t_prcs_data_accel_in_20: PROCESS
BEGIN
	data_accel_in(20) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_20;
-- data_accel_in[19]
t_prcs_data_accel_in_19: PROCESS
BEGIN
	data_accel_in(19) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_19;
-- data_accel_in[18]
t_prcs_data_accel_in_18: PROCESS
BEGIN
	data_accel_in(18) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_18;
-- data_accel_in[17]
t_prcs_data_accel_in_17: PROCESS
BEGIN
	data_accel_in(17) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_17;
-- data_accel_in[16]
t_prcs_data_accel_in_16: PROCESS
BEGIN
	data_accel_in(16) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_16;
-- data_accel_in[15]
t_prcs_data_accel_in_15: PROCESS
BEGIN
	data_accel_in(15) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_15;
-- data_accel_in[14]
t_prcs_data_accel_in_14: PROCESS
BEGIN
	data_accel_in(14) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_14;
-- data_accel_in[13]
t_prcs_data_accel_in_13: PROCESS
BEGIN
	data_accel_in(13) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_13;
-- data_accel_in[12]
t_prcs_data_accel_in_12: PROCESS
BEGIN
	data_accel_in(12) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_12;
-- data_accel_in[11]
t_prcs_data_accel_in_11: PROCESS
BEGIN
	data_accel_in(11) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_11;
-- data_accel_in[10]
t_prcs_data_accel_in_10: PROCESS
BEGIN
	data_accel_in(10) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_10;
-- data_accel_in[9]
t_prcs_data_accel_in_9: PROCESS
BEGIN
	data_accel_in(9) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_9;
-- data_accel_in[8]
t_prcs_data_accel_in_8: PROCESS
BEGIN
	data_accel_in(8) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_8;
-- data_accel_in[7]
t_prcs_data_accel_in_7: PROCESS
BEGIN
	data_accel_in(7) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_7;
-- data_accel_in[6]
t_prcs_data_accel_in_6: PROCESS
BEGIN
	data_accel_in(6) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_6;
-- data_accel_in[5]
t_prcs_data_accel_in_5: PROCESS
BEGIN
	data_accel_in(5) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_5;
-- data_accel_in[4]
t_prcs_data_accel_in_4: PROCESS
BEGIN
	data_accel_in(4) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_4;
-- data_accel_in[3]
t_prcs_data_accel_in_3: PROCESS
BEGIN
	data_accel_in(3) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_3;
-- data_accel_in[2]
t_prcs_data_accel_in_2: PROCESS
BEGIN
	data_accel_in(2) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_2;
-- data_accel_in[1]
t_prcs_data_accel_in_1: PROCESS
BEGIN
	data_accel_in(1) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_1;
-- data_accel_in[0]
t_prcs_data_accel_in_0: PROCESS
BEGIN
	data_accel_in(0) <= '0';
WAIT;
END PROCESS t_prcs_data_accel_in_0;

-- data_in[0][31]
t_prcs_data_in_0_31: PROCESS
BEGIN
	data_in(0)(31) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_31;

-- data_in[0][30]
t_prcs_data_in_0_30: PROCESS
BEGIN
	data_in(0)(30) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_30;

-- data_in[0][29]
t_prcs_data_in_0_29: PROCESS
BEGIN
	data_in(0)(29) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_29;

-- data_in[0][28]
t_prcs_data_in_0_28: PROCESS
BEGIN
	data_in(0)(28) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_28;

-- data_in[0][27]
t_prcs_data_in_0_27: PROCESS
BEGIN
	data_in(0)(27) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_27;

-- data_in[0][26]
t_prcs_data_in_0_26: PROCESS
BEGIN
	data_in(0)(26) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_26;

-- data_in[0][25]
t_prcs_data_in_0_25: PROCESS
BEGIN
	data_in(0)(25) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_25;

-- data_in[0][24]
t_prcs_data_in_0_24: PROCESS
BEGIN
	data_in(0)(24) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_24;

-- data_in[0][23]
t_prcs_data_in_0_23: PROCESS
BEGIN
	data_in(0)(23) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_23;

-- data_in[0][22]
t_prcs_data_in_0_22: PROCESS
BEGIN
	data_in(0)(22) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_22;

-- data_in[0][21]
t_prcs_data_in_0_21: PROCESS
BEGIN
	data_in(0)(21) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_21;

-- data_in[0][20]
t_prcs_data_in_0_20: PROCESS
BEGIN
	data_in(0)(20) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_20;

-- data_in[0][19]
t_prcs_data_in_0_19: PROCESS
BEGIN
	data_in(0)(19) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_19;

-- data_in[0][18]
t_prcs_data_in_0_18: PROCESS
BEGIN
	data_in(0)(18) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_18;

-- data_in[0][17]
t_prcs_data_in_0_17: PROCESS
BEGIN
	data_in(0)(17) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_17;

-- data_in[0][16]
t_prcs_data_in_0_16: PROCESS
BEGIN
	data_in(0)(16) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_16;

-- data_in[0][15]
t_prcs_data_in_0_15: PROCESS
BEGIN
	data_in(0)(15) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_15;

-- data_in[0][14]
t_prcs_data_in_0_14: PROCESS
BEGIN
	data_in(0)(14) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_14;

-- data_in[0][13]
t_prcs_data_in_0_13: PROCESS
BEGIN
	data_in(0)(13) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_13;

-- data_in[0][12]
t_prcs_data_in_0_12: PROCESS
BEGIN
	data_in(0)(12) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_12;

-- data_in[0][11]
t_prcs_data_in_0_11: PROCESS
BEGIN
	data_in(0)(11) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_11;

-- data_in[0][10]
t_prcs_data_in_0_10: PROCESS
BEGIN
	data_in(0)(10) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_10;

-- data_in[0][9]
t_prcs_data_in_0_9: PROCESS
BEGIN
	data_in(0)(9) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_9;

-- data_in[0][8]
t_prcs_data_in_0_8: PROCESS
BEGIN
	data_in(0)(8) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_8;

-- data_in[0][7]
t_prcs_data_in_0_7: PROCESS
BEGIN
	data_in(0)(7) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_7;

-- data_in[0][6]
t_prcs_data_in_0_6: PROCESS
BEGIN
	data_in(0)(6) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_6;

-- data_in[0][5]
t_prcs_data_in_0_5: PROCESS
BEGIN
	data_in(0)(5) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_5;

-- data_in[0][4]
t_prcs_data_in_0_4: PROCESS
BEGIN
	data_in(0)(4) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_4;

-- data_in[0][3]
t_prcs_data_in_0_3: PROCESS
BEGIN
	data_in(0)(3) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_3;

-- data_in[0][2]
t_prcs_data_in_0_2: PROCESS
BEGIN
	data_in(0)(2) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_2;

-- data_in[0][1]
t_prcs_data_in_0_1: PROCESS
BEGIN
	data_in(0)(1) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_1;

-- data_in[0][0]
t_prcs_data_in_0_0: PROCESS
BEGIN
	data_in(0)(0) <= '0';
WAIT;
END PROCESS t_prcs_data_in_0_0;

-- data_in[1][31]
t_prcs_data_in_1_31: PROCESS
BEGIN
	data_in(1)(31) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_31;

-- data_in[1][30]
t_prcs_data_in_1_30: PROCESS
BEGIN
	data_in(1)(30) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_30;

-- data_in[1][29]
t_prcs_data_in_1_29: PROCESS
BEGIN
	data_in(1)(29) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_29;

-- data_in[1][28]
t_prcs_data_in_1_28: PROCESS
BEGIN
	data_in(1)(28) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_28;

-- data_in[1][27]
t_prcs_data_in_1_27: PROCESS
BEGIN
	data_in(1)(27) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_27;

-- data_in[1][26]
t_prcs_data_in_1_26: PROCESS
BEGIN
	data_in(1)(26) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_26;

-- data_in[1][25]
t_prcs_data_in_1_25: PROCESS
BEGIN
	data_in(1)(25) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_25;

-- data_in[1][24]
t_prcs_data_in_1_24: PROCESS
BEGIN
	data_in(1)(24) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_24;

-- data_in[1][23]
t_prcs_data_in_1_23: PROCESS
BEGIN
	data_in(1)(23) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_23;

-- data_in[1][22]
t_prcs_data_in_1_22: PROCESS
BEGIN
	data_in(1)(22) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_22;

-- data_in[1][21]
t_prcs_data_in_1_21: PROCESS
BEGIN
	data_in(1)(21) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_21;

-- data_in[1][20]
t_prcs_data_in_1_20: PROCESS
BEGIN
	data_in(1)(20) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_20;

-- data_in[1][19]
t_prcs_data_in_1_19: PROCESS
BEGIN
	data_in(1)(19) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_19;

-- data_in[1][18]
t_prcs_data_in_1_18: PROCESS
BEGIN
	data_in(1)(18) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_18;

-- data_in[1][17]
t_prcs_data_in_1_17: PROCESS
BEGIN
	data_in(1)(17) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_17;

-- data_in[1][16]
t_prcs_data_in_1_16: PROCESS
BEGIN
	data_in(1)(16) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_16;

-- data_in[1][15]
t_prcs_data_in_1_15: PROCESS
BEGIN
	data_in(1)(15) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_15;

-- data_in[1][14]
t_prcs_data_in_1_14: PROCESS
BEGIN
	data_in(1)(14) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_14;

-- data_in[1][13]
t_prcs_data_in_1_13: PROCESS
BEGIN
	data_in(1)(13) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_13;

-- data_in[1][12]
t_prcs_data_in_1_12: PROCESS
BEGIN
	data_in(1)(12) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_12;

-- data_in[1][11]
t_prcs_data_in_1_11: PROCESS
BEGIN
	data_in(1)(11) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_11;

-- data_in[1][10]
t_prcs_data_in_1_10: PROCESS
BEGIN
	data_in(1)(10) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_10;

-- data_in[1][9]
t_prcs_data_in_1_9: PROCESS
BEGIN
	data_in(1)(9) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_9;

-- data_in[1][8]
t_prcs_data_in_1_8: PROCESS
BEGIN
	data_in(1)(8) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_8;

-- data_in[1][7]
t_prcs_data_in_1_7: PROCESS
BEGIN
	data_in(1)(7) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_7;

-- data_in[1][6]
t_prcs_data_in_1_6: PROCESS
BEGIN
	data_in(1)(6) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_6;

-- data_in[1][5]
t_prcs_data_in_1_5: PROCESS
BEGIN
	data_in(1)(5) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_5;

-- data_in[1][4]
t_prcs_data_in_1_4: PROCESS
BEGIN
	data_in(1)(4) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_4;

-- data_in[1][3]
t_prcs_data_in_1_3: PROCESS
BEGIN
	data_in(1)(3) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_3;

-- data_in[1][2]
t_prcs_data_in_1_2: PROCESS
BEGIN
	data_in(1)(2) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_2;

-- data_in[1][1]
t_prcs_data_in_1_1: PROCESS
BEGIN
	data_in(1)(1) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_1;

-- data_in[1][0]
t_prcs_data_in_1_0: PROCESS
BEGIN
	data_in(1)(0) <= '0';
WAIT;
END PROCESS t_prcs_data_in_1_0;

-- rst_n
t_prcs_rst_n: PROCESS
BEGIN
	rst_n <= '0';
WAIT;
END PROCESS t_prcs_rst_n;
-- select_in[1]
t_prcs_select_in_1: PROCESS
BEGIN
	select_in(1) <= '0';
WAIT;
END PROCESS t_prcs_select_in_1;
-- select_in[0]
t_prcs_select_in_0: PROCESS
BEGIN
	select_in(0) <= '0';
WAIT;
END PROCESS t_prcs_select_in_0;
-- wr_en_in[1]
t_prcs_wr_en_in_1: PROCESS
BEGIN
	wr_en_in(1) <= '0';
WAIT;
END PROCESS t_prcs_wr_en_in_1;
-- wr_en_in[0]
t_prcs_wr_en_in_0: PROCESS
BEGIN
	wr_en_in(0) <= '0';
WAIT;
END PROCESS t_prcs_wr_en_in_0;
END lock_arch;
