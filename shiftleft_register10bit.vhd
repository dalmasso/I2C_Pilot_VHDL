----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:01:01 03/17/2014 
-- Design Name: 
-- Module Name:    shiftleft_register10bit - Behavioral 
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

entity shiftleft_register10bit is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           serialleftin : in  STD_LOGIC;
           loaden : in  STD_LOGIC;
           shiften : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (9 downto 0);
           dataout : out  STD_LOGIC);
end shiftleft_register10bit;

architecture Behavioral of shiftleft_register10bit is
signal dataout_sig : std_logic_vector (9 downto 0):="0000000000";
begin

	process(clk,reset)
	begin
		if reset ='1' then
			dataout_sig <="0000000000";
		elsif rising_edge (clk) then
			if loaden='1' then
				dataout_sig<=datain;
			elsif shiften='1' then
				dataout_sig <= serialleftin & dataout_sig(9 downto 1);
			end if;
		end if;
	end process;
dataout <= dataout_sig(0);
end Behavioral;

