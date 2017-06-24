--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:01:31 01/27/2014
-- Design Name:   
-- Module Name:   E:/i2c/driver3state_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: driver3state
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
 
ENTITY driver3state_test IS
END driver3state_test;
 
ARCHITECTURE behavior OF driver3state_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver3state
    PORT(
         datain : IN  std_logic;
         enable : IN  std_logic;
         dataout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal datain : std_logic := '0';
   signal enable : std_logic := '0';

 	--Outputs
   signal dataout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: driver3state PORT MAP (
          datain => datain,
          enable => enable,
          dataout => dataout
        );

enable <= not enable after 10 ns;
datain <= not datain after 25 ns;

END;
