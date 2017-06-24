--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:01:29 03/18/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_demux1to2_8bits.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: demux1to2_8bits
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
 
ENTITY test_demux1to2_8bits IS
END test_demux1to2_8bits;
 
ARCHITECTURE behavior OF test_demux1to2_8bits IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT demux1to2_8bits
    PORT(
         sel : IN  std_logic;
         datain : IN  std_logic_vector(7 downto 0);
         dataout1 : OUT  std_logic_vector(7 downto 0);
         dataout2 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sel : std_logic := '0';
   signal datain : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dataout1 : std_logic_vector(7 downto 0);
   signal dataout2 : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: demux1to2_8bits PORT MAP (
          sel => sel,
          datain => datain,
          dataout1 => dataout1,
          dataout2 => dataout2
        );

sel <= not sel after 200 ns;
datain <= datain +1 after 50 ns;

END;
