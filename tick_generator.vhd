----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:05 03/17/2014 
-- Design Name: 
-- Module Name:    tick_generator - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tick_generator is
	 generic ( freqboard : integer := 100000000;
				  baud		: integer := 9600);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tick : out  STD_LOGIC);
end tick_generator;

architecture Behavioral of tick_generator is
constant val : integer := freqboard/baud;--20
signal reset_sig:std_logic;
signal reset_count : std_logic;
signal count : integer range 0 to val;
begin
		process (reset_sig,clk)
	   begin
			if reset_sig ='1' then
				count <=0;
			elsif rising_edge(clk) then
				count <= count+1;
			end if;
		end process;
		
	reset_sig <= reset or reset_count;
	reset_count <= '1' when (count=val) else '0';
	tick <='1' when (count=val-1)else '0';


end Behavioral;

