--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:51:45 03/17/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_counter4bit_enable_seqreset.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter4bit_enable_seqreset
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
 
ENTITY test_counter4bit_enable_seqreset IS
END test_counter4bit_enable_seqreset;
 
ARCHITECTURE behavior OF test_counter4bit_enable_seqreset IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter4bit_enable_seqreset
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         seqreset : IN  std_logic;
         enable : IN  std_logic;
         dataout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal seqreset : std_logic := '0';
   signal enable : std_logic := '0';

 	--Outputs
   signal dataout : std_logic_vector(3 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter4bit_enable_seqreset PORT MAP (
          clk => clk,
          reset => reset,
          seqreset => seqreset,
          enable => enable,
          dataout => dataout
        );

reset <= '1' after 5 ns, '0' after 35 ns;
clk <= not clk after 10 ns;
seqreset <='0', '1' after 165 ns, '0' after 175 ns;
enable <= '1','0' after 120 ns, '1' after 140 ns ;

END;
