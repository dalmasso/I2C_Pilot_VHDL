--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:50:19 02/03/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_register8bi_clk.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register8bit_clk
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
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_register8bi_clk IS
END test_register8bi_clk;
 
ARCHITECTURE behavior OF test_register8bi_clk IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT register8bit_clk
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         datain : IN  std_logic_vector(7 downto 0);
         dataout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal datain : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic_vector(7 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register8bit_clk PORT MAP (
          clk => clk,
          reset => reset,
          datain => datain,
          dataout => dataout
        );


 
clk <= not clk after 5 ns;
reset <= '1' after 25 ns, '0' after 35 ns;
datain <= datain +1 after 23 ns;

END;
