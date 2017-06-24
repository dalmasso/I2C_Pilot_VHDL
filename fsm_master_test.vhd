--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:48:55 01/28/2014
-- Design Name:   
-- Module Name:   E:/i2c/fsm_master_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm_master
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fsm_master_test IS
END fsm_master_test;
 
ARCHITECTURE behavior OF fsm_master_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm_master
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         rw : IN  std_logic;
         en_i2c : IN  std_logic;
         sda : IN  std_logic;
         bit_count : IN  std_logic_vector(3 downto 0);
         en_count : OUT  std_logic;
         sr_count : OUT  std_logic;
         ld_addr : OUT  std_logic;
         ld_data_wr : OUT  std_logic;
         en_scl : OUT  std_logic;
         sel_datain : OUT  std_logic;
         busy : OUT  std_logic;
         sel_sda : OUT  std_logic_vector(1 downto 0);
         sel_shiftreg : OUT  std_logic_vector(1 downto 0);
         en_ack_master : OUT  std_logic;
         en_dec_sda : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal rw : std_logic := '0';
   signal en_i2c : std_logic := '0';
   signal sda : std_logic := '0';
   signal bit_count : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal en_count : std_logic;
   signal sr_count : std_logic;
   signal ld_addr : std_logic;
   signal ld_data_wr : std_logic;
   signal en_scl : std_logic;
   signal sel_datain : std_logic;
   signal busy : std_logic;
   signal sel_sda : std_logic_vector(1 downto 0);
   signal sel_shiftreg : std_logic_vector(1 downto 0);
   signal en_ack_master : std_logic;
   signal en_dec_sda : std_logic;
	
	--clock period definitions
	constant clk_period : time := 2.5 us;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm_master PORT MAP (
          clk => clk,
          reset => reset,
          rw => rw,
          en_i2c => en_i2c,
          sda => sda,
          bit_count => bit_count,
          en_count => en_count,
          sr_count => sr_count,
          ld_addr => ld_addr,
          ld_data_wr => ld_data_wr,
          en_scl => en_scl,
          sel_datain => sel_datain,
          busy => busy,
          sel_sda => sel_sda,
          sel_shiftreg => sel_shiftreg,
          en_ack_master => en_ack_master,
          en_dec_sda => en_dec_sda
        );

-- clock process definition
clk_process : process
begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;


--compteur
counter4bit_process: process
begin
	wait until (sr_count ='1');
	wait until (falling_edge(clk));
	bit_count <="0000";
	wait until (en_count ='1');
	for i in 1 to 8 loop
		wait until (falling_edge(clk));
		bit_count <= bit_count +1;
		report "compteur incremente";
	end loop;
end process;

-- stimulus process
stimul_proc: process
begin
	--mise à 1 du reset a t=0s jusqu'au premier
	--front descendant de clk
	reset <='1';
	wait until (falling_edge(clk));
	reset <='0';
	
	--attente de 2x2.5 us
	wait for clk_period*2;
	-- mise à 1 du signal de validation
	en_i2c <='1';
	
	--fsm se met en marche:
	--ready => start => write_addr1 => write_addr2
	--enclenche le compteur et attend valeur 1000
	wait until (bit_count="1000");
	
	--write addr2 => slave_ackl1
	sda <='0';
	en_i2c <='1';
	rw <='0';
	
	--slave_ack1 => write_data1 => write_data2
	wait until (bit_count ="1000");
	
	--write_data1 => write_data2
	wait until (bit_count ="1000");
	
	--write_data2 => slave_ack2
	en_i2c <='0';
	sda <= '1';
	rw <= '1';
	
	--start => write_addr1 => write_addr2
	wait until (bit_count ="1000");
	
	--slave_ack1 => stop
	sda <= '1';

	
	--stop => ready
	--ready => start
	en_i2c <='1';
	rw		 <='1';
	-- start => write_addr2=>read_data
	wait until (bit_count ="1000");

	--read_data1 => master_ack1	
	--master_ack1 => read_data
	rw  <='1';
	sda <='0';
	--read_data1 => master_ack1
	en_i2c <='1';
	wait until (bit_count ="1000");
	
	--master_ack1 => start
	rw <='1';
	--start ===> slave_ack1
	wait until (bit_count ="1000");
	rw <='0';
	wait until (bit_count ="1000");
	--slave_ack1 => read_data
	--read_data => master_ack2
	en_i2c <='0';
	sda<='0';
	rw<='1';
	wait until (bit_count ="1000");
	--master_ack2 => stop => ready
	wait;
	end process;
	
END;
