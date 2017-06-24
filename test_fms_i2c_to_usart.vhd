--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:51:30 03/24/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_fms_i2c_to_usart.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm_i2c_to_usart
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_fms_i2c_to_usart IS
END test_fms_i2c_to_usart;
 
ARCHITECTURE behavior OF test_fms_i2c_to_usart IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm_i2c_to_usart
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         busy_i2c : IN  std_logic;
         busy_usart : IN  std_logic;
         T_1sec : IN  std_logic;
         data_to_write : OUT  std_logic_vector(7 downto 0);
         adress_slave : OUT  std_logic_vector(6 downto 0);
         en_i2c : OUT  std_logic;
         sel_temp_out_i2c : OUT  std_logic;
         sel_temp_in_usart : OUT  std_logic;
         load_msb_temp : OUT  std_logic;
         load_lsb_temp : OUT  std_logic;
         data_ready_usart : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal busy_i2c : std_logic := '0';
   signal busy_usart : std_logic := '0';
   signal T_1sec : std_logic := '0';

 	--Outputs
   signal data_to_write : std_logic_vector(7 downto 0);
   signal adress_slave : std_logic_vector(6 downto 0);
   signal en_i2c : std_logic;
   signal sel_temp_out_i2c : std_logic;
   signal sel_temp_in_usart : std_logic;
   signal load_msb_temp : std_logic;
   signal load_lsb_temp : std_logic;
   signal data_ready_usart : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm_i2c_to_usart PORT MAP (
          clk => clk,
          reset => reset,
          busy_i2c => busy_i2c,
          busy_usart => busy_usart,
          T_1sec => T_1sec,
          data_to_write => data_to_write,
          adress_slave => adress_slave,
          en_i2c => en_i2c,
          sel_temp_out_i2c => sel_temp_out_i2c,
          sel_temp_in_usart => sel_temp_in_usart,
          load_msb_temp => load_msb_temp,
          load_lsb_temp => load_lsb_temp,
          data_ready_usart => data_ready_usart
        );

clk <= not clk after 5 ns;
reset <= '1', '0' after 15 ns;
T_1sec <= not T_1sec after 22 ns;
busy_i2c <= not busy_i2c after 52 ns;
busy_usart <= not busy_usart after 62 ns;


END;
