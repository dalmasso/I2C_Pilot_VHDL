----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:25:55 01/27/2014 
-- Design Name: 
-- Module Name:    mux2to1_8bit - Behavioral 
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

entity mux2to1_8bit is
    Port ( sel : in  STD_LOGIC;
           datain1 : in  STD_LOGIC_VECTOR (7 downto 0);
           datain2 : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end mux2to1_8bit;

architecture Behavioral of mux2to1_8bit is

begin
	process(sel,datain1,datain2)
	begin
		if sel ='0' then
		dataout <= datain1;
		else dataout <= datain2;
		end if;
	end process;

end Behavioral;

