--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:34:53 01/27/2014
-- Design Name:   
-- Module Name:   E:/i2c/dff_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dff
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
 
ENTITY dff_test IS
END dff_test;
 
ARCHITECTURE behavior OF dff_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dff
    PORT(
         d : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic;
         q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal d : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal q : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dff PORT MAP (
          d => d,
          reset => reset,
          clk => clk,
          q => q
        );

clk <= not clk after 10 ns;
reset <= '1' after 135 ns, '0' after 183 ns;
d <= not d after 25 ns;

END;
