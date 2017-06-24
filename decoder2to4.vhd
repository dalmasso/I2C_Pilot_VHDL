----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:38:02 01/27/2014 
-- Design Name: 
-- Module Name:    decoder2to4 - Behavioral 
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

entity decoder2to4 is
    Port ( datain : in  STD_LOGIC_VECTOR (1 downto 0);
           en : in  STD_LOGIC;
           y : out  STD_LOGIC_VECTOR (3 downto 0));
end decoder2to4;

architecture Behavioral of decoder2to4 is

begin
	process(datain, en)
	begin
		if en ='0' then
		y <="0000";
		else
			case datain is
			when "00" => y<="0001";
			when "01" => y<="0010";
			when "10" => y<="0100";
			when "11" => y<="1000";
			when others => y<="0000";
			end case;
		end if;
	end process;
end Behavioral;

