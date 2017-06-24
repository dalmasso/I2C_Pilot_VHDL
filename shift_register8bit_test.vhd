--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:39 01/27/2014
-- Design Name:   
-- Module Name:   E:/i2c/shift_register8bit_test.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shift_register8bit
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
 
ENTITY shift_register8bit_test IS
END shift_register8bit_test;
 
ARCHITECTURE behavior OF shift_register8bit_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_register8bit
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         serialleftin : IN  std_logic;
         serialrightin : IN  std_logic;
         sel : IN  std_logic_vector(1 downto 0);
         datain : IN  std_logic_vector(7 downto 0);
         dataout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal serialleftin : std_logic := '0';
   signal serialrightin : std_logic := '0';
   signal sel : std_logic_vector(1 downto 0) := (others => '0');
   signal datain : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal dataout : std_logic_vector(7 downto 0);


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_register8bit PORT MAP (
          clk => clk,
          reset => reset,
          serialleftin => serialleftin,
          serialrightin => serialrightin,
          sel => sel,
          datain => datain,
          dataout => dataout
        );

clk <= not clk after 10 ns;
datain <= "11100010";
reset <= '1' after 460 ns, '0' after 470 ns;
sel <= sel+1 after 60 ns;
serialleftin <= not serialleftin after 20 ns;
serialrightin <= not serialrightin after 25 ns;
END;
