----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:35 01/27/2014 
-- Design Name: 
-- Module Name:    register8bit - Behavioral 
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

entity register8bit is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end register8bit;

architecture Behavioral of register8bit is
signal dataout_sig : std_logic_vector (7 downto 0);
begin
	process(clk,reset)
	begin
		if reset ='1' then
		dataout_sig <= "00000000";
		elsif rising_edge (clk) then
			if load = '1' then
			dataout_sig <= datain;
			else dataout_sig <= dataout_sig;
			end if;
		end if;
	end process;
dataout<=dataout_sig;
end Behavioral;

