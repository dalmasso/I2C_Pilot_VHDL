--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:34:44 03/24/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_tempo1s.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tempo_1s
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
 
ENTITY test_tempo1s IS
END test_tempo1s;
 
ARCHITECTURE behavior OF test_tempo1s IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tempo_1s
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         T_1s : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal T_1s : std_logic;


BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tempo_1s PORT MAP (
          clk => clk,
          reset => reset,
          T_1s => T_1s
        );

clk <= not clk after 5 ns;
reset <= '0';

END;
