----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:58:11 01/27/2014 
-- Design Name: 
-- Module Name:    driver3state - Behavioral 
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

entity driver3state is
    Port ( datain : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           dataout : out  STD_LOGIC);
end driver3state;

architecture Behavioral of driver3state is

begin
	process(enable, datain)
	begin
		if enable ='0' then
			dataout <='Z';
		else dataout <= datain;
		end if;
	end process;
end Behavioral;

