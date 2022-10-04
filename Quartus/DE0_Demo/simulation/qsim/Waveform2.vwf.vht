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
-- Generated on "09/28/2022 17:58:53"
                                                             
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
SIGNAL accel_select_o : STD_LOGIC;
SIGNAL addr_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL addr_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data_accel_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL data_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rst_n : STD_LOGIC;
SIGNAL select_in : STD_LOGIC;
SIGNAL wr_en_in : STD_LOGIC;
SIGNAL wr_en_o : STD_LOGIC;
COMPONENT encryptor
	PORT (
	accel_select_o : OUT STD_LOGIC;
	addr_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	addr_o : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	clk : IN STD_LOGIC;
	data_accel_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	rst_n : IN STD_LOGIC;
	select_in : IN STD_LOGIC;
	wr_en_in : IN STD_LOGIC;
	wr_en_o : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : encryptor
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

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 2500 ps;
	clk <= '1';
	WAIT FOR 2500 ps;
	IF (NOW >= 400000 ps) THEN WAIT; END IF;
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
END encryptor_arch;
