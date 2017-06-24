----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:19 03/18/2014 
-- Design Name: 
-- Module Name:    tempo_1s - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tempo_1s is
	 generic ( freqboard : integer := 100000000;
				  baud		: integer := 9600);
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           T_1s : out  STD_LOGIC);
end tempo_1s;

architecture Behavioral of tempo_1s is
constant val : integer := 100000000;--freqboard/baud;--20
signal reset_sig:std_logic;
signal reset_count : std_logic;
signal count : integer range 0 to val;
begin
		process (reset_sig,clk)
	   begin
			if reset_sig ='1' then
				count <=0;
			elsif falling_edge(clk) then
				count <= count+1;
			end if;
		end process;
		
	reset_sig <= reset or reset_count;
	reset_count <= '1' when (count=val+1) else '0';
	T_1s <='1' when (count=val)else '0';
end Behavioral;