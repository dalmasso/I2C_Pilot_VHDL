--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:04:05 03/17/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_shiftleft_register10bit.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shiftleft_register10bit
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
 
ENTITY test_shiftleft_register10bit IS
END test_shiftleft_register10bit;
 
ARCHITECTURE behavior OF test_shiftleft_register10bit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shiftleft_register10bit
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         serialleftin : IN  std_logic;
         loaden : IN  std_logic;
         shiften : IN  std_logic;
         datain : IN  std_logic_vector(9 downto 0);
         dataout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal serialleftin : std_logic := '0';
   signal loaden : std_logic := '0';
   signal shiften : std_logic := '0';
   signal datain : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal dataout : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shiftleft_register10bit PORT MAP (
          clk => clk,
          reset => reset,
          serialleftin => serialleftin,
          loaden => loaden,
          shiften => shiften,
          datain => datain,
          dataout => dataout
        );

clk <= not clk after 10 ns;
datain <= "1111111111";
reset <= '1' after 360 ns, '0' after 375 ns;
shiften <='0' after 120 ns, '1' after 260 ns, '0' after 315 ns;
loaden <='0' after 50 ns, '1' after 300 ns;
serialleftin <= not serialleftin after 20 ns;

END;
