----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:58:30 03/18/2014 
-- Design Name: 
-- Module Name:    demux1to2_8bits - Behavioral 
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

entity demux1to2_8bits is
    Port ( sel : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataout1 : out  STD_LOGIC_VECTOR (7 downto 0);
           dataout2 : out  STD_LOGIC_VECTOR (7 downto 0));
end demux1to2_8bits;

architecture Behavioral of demux1to2_8bits is
begin

dataout1 <= datain when sel='0' else
				"ZZZZZZZZ";

dataout2 <= datain when sel='1' else
				"ZZZZZZZZ";
end Behavioral;

