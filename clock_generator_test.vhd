--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:24:36 01/27/2014
-- Design Name:   
-- Module Name:   C:/TP_VHDL/i2c/i2c/clock_generator_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clock_generator
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
 
ENTITY clock_generator_test IS
END clock_generator_test;
 
ARCHITECTURE behavior OF clock_generator_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_generator
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         h1 : OUT  std_logic;
         h2 : OUT  std_logic;
         h3 : OUT  std_logic;
         h4 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal h1 : std_logic;
   signal h2 : std_logic;
   signal h3 : std_logic;
   signal h4 : std_logic;


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clock_generator PORT MAP (
          clk => clk,
          reset => reset,
          h1 => h1,
          h2 => h2,
          h3 => h3,
          h4 => h4
        );
  
clk <= not clk after 5 ns;
reset <= '0', '1' after 500 ns, '0' after 2020 ns;
  
END;
