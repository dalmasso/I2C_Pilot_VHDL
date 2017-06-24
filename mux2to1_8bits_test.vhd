--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:32:27 01/27/2014
-- Design Name:   
-- Module Name:   E:/i2c/mux2to1_8bits_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2to1_8bit
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
 
ENTITY mux2to1_8bits_test IS
END mux2to1_8bits_test;
 
ARCHITECTURE behavior OF mux2to1_8bits_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2to1_8bit
    PORT(
         sel : IN  std_logic;
         datain1 : IN  std_logic_vector(7 downto 0);
         datain2 : IN  std_logic_vector(7 downto 0);
         dataout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal datain1 : std_logic_vector(7 downto 0) := (others => '0');
   signal datain2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2to1_8bit PORT MAP (
          sel => sel,
          datain1 => datain1,
          datain2 => datain2,
          dataout => dataout
        );

sel <= not sel after 15 ns;
datain1 <= "11111000";
datain2 <= "00000111";

END;
