----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:41 03/17/2014 
-- Design Name: 
-- Module Name:    counter4bit_enable_seqreset - Behavioral 
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

entity counter4bit_enable_seqreset is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           seqreset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (3 downto 0));
end counter4bit_enable_seqreset;

architecture Behavioral of counter4bit_enable_seqreset is
signal dataout_sig : std_logic_vector (3 downto 0);
begin

	process(clk,reset)
	begin
		if reset ='1' then
			dataout_sig <="0000";
		elsif rising_edge(clk) then
			if seqreset = '1' then
				dataout_sig <="0000";
			elsif enable ='1' then
				dataout_sig <= dataout_sig +1;
			else dataout_sig <= dataout_sig;
			end if;
		end if;
	end process;
dataout <= dataout_sig;
end Behavioral;

