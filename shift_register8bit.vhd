----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:56:39 01/27/2014 
-- Design Name: 
-- Module Name:    shift_register8bit - Behavioral 
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

entity shift_register8bit is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           serialleftin : in  STD_LOGIC;
           serialrightin : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end shift_register8bit;

architecture Behavioral of shift_register8bit is
signal dataout_sig : std_logic_vector (7 downto 0):="00000000";
begin

	process(clk,reset)
	begin
		if reset ='1' then
			dataout_sig <="00000000";
		elsif rising_edge (clk) then
			if sel ="00" then
				dataout_sig <= dataout_sig;
			elsif sel ="01" then
				dataout_sig <= dataout_sig(6 downto 0)&serialrightin;
			elsif sel ="10" then
				dataout_sig <=serialleftin&dataout_sig(7 downto 1);
			elsif sel ="11" then
				dataout_sig <= datain;
			end if;
		end if;
	end process;
dataout <= dataout_sig;				
end Behavioral;

