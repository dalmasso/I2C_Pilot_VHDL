--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:24:52 01/28/2014
-- Design Name:   
-- Module Name:   E:/i2c/porte_et_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: porte_et
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
 
ENTITY porte_et_test IS
END porte_et_test;
 
ARCHITECTURE behavior OF porte_et_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT porte_et
    PORT(
         sig1 : IN  std_logic;
         sig2 : IN  std_logic;
         sig_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sig1 : std_logic := '0';
   signal sig2 : std_logic := '0';

 	--Outputs
   signal sig_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: porte_et PORT MAP (
          sig1 => sig1,
          sig2 => sig2,
          sig_out => sig_out
        );

 sig1 <= not sig1 after 10 ns;
 sig2 <= not sig2 after 20 ns;

END;
