----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:54 02/03/2014 
-- Design Name: 
-- Module Name:    register8bit_clk - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register8bit_clk is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end register8bit_clk;

architecture Behavioral of register8bit_clk is
begin
	process(clk,reset)
	begin
		if reset ='1' then
		dataout <= "00000000";
		elsif falling_edge (clk) then
		dataout <= datain;
		end if;
	end process;
end Behavioral;

